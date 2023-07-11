require_relative "../../lib/middleware/standardJsonResponse"
include ResponseStandardMiddleware

class MoviesController < ApplicationController

  before_action :pagination_params, only: %i[index]

  def index
    page, size = ResponseStandardMiddleware::ControllerPagination.buildPaginationParams(params)

    @movies = Movie.all.page(page).per(size)

    render json: ResponseStandardMiddleware::ControllerPagination.buildPaginatedResponse(@movies)
  end

  def recommendations
    favorite_movies = User.find(params[:user_id]).favorites
    @recommendations = RecommendationEngine.new(favorite_movies).recommendations
    render json: @recommendations
  end

  def user_rented_movies
    @rented = User.find(params[:user_id]).rented
    render json: @rented
  end

  def rent
    user = User.find(params[:user_id])
    movie = Movie.find(params[:id])
    movie.available_copies -= 1
    movie.save
    user.rented << movie
    render json: movie
  end

  private
    def pagination_params
      params.permit(:page, :size)
    end
end
