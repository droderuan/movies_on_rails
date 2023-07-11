class MoviesController < ApplicationController
  before_action :pagination_params, only: %i[ index ]

  def index
    @movies = Movie
      .all
      .page(params[:page] ? params[:page] : 1)
      .per(params[:size] ? params[:size] : 20)

    render json: {
      paginated: true,
      movies: @movies,
      next_page: @movies.next_page,
      prev_page: @movies.prev_page,
      last_page: @movies.last_page?,
      per_page: @movies.limit_value,
      total_pages: @movies.total_pages
    }
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
      params.permit(:page, :size,)
    end
end
