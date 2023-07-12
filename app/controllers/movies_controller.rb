require_relative "../../lib/middleware/standardJsonResponse"
include ResponseStandardMiddleware

class MoviesController < ApplicationController

  before_action :pagination_params, only: %i[index]
  before_action :rent_params, only: %i[rent recommendations]

  TOLERANCE_DAYS = 3

  def index
    page, size = ResponseStandardMiddleware::ControllerPagination.buildPaginationParams(params)

    @movies = Movie.all.page(page).per(size)

    render json: ResponseStandardMiddleware::ControllerPagination.buildPaginatedResponse(@movies)
  end

  def recommendations
    page, size = ResponseStandardMiddleware::ControllerPagination.buildPaginationParams(params)

    favorite_movies = User.find( params[:user_id]).favorites

    @recommendations = RecommendationEngine.new(favorite_movies).recommendations.page(page).per(size)
    render json: ResponseStandardMiddleware::ControllerPagination.buildPaginatedResponse(@recommendations)
  end

  def rent
    user_id = params[:user_id]
    movie_id = params[:id]
    rent_days = params[:days]

    if Rental.where({ user_id: user_id, movie_id: movie_id }).first
      return render json: { "error": "User already rented" }, status: 400
    end

    movie = Movie.find(params[:id])

    if movie.available_copies === 0
      return render json: { "error": "No copies available" }, status: :unprocessable_entity
    end

    user = User.find(params[:user_id])
    movie.available_copies -= 1
    movie.save
    new_rent = Rental.new(
      user: user,
      movie: movie,
      expires_at:  (rent_days + TOLERANCE_DAYS).days.from_now,
      total: rent_days * movie.price_per_day
    )
    new_rent.save
    render json: "", status: 200
  end

  def return
    user_id = params[:user_id]
    movie_id = params[:id]

    rental = Rental.where({ user_id: user_id, movie_id: movie_id, returned_at: nil }).first

    if !rental
      return render json: "", status: 404
    end

    movie = Movie.find(params[:id])
    user = User.find(params[:user_id])

    movie.available_copies += 1
    movie.save
    rental.returned_at =  Time.now.utc
    rental.save
    render json: "", status: 200
  end

  private
    def pagination_params
      params.permit(:page, :size)
    end

    def rent_params
      params.require(:user_id)
    end
end
