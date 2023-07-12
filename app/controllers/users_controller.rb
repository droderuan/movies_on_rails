require_relative "../../lib/middleware/standardJsonResponse"
include ResponseStandardMiddleware

class UsersController < ApplicationController
  before_action :pagination_params, only: %i[ index ]

  def index
    page, size = ControllerPagination.buildPaginationParams(params)

    @users = User.all.page(page).per(size)

    render json: ControllerPagination.buildPaginatedResponse(@users),
    except: [:created_at, :updated_at]
  end

  def rented
    page, size = ControllerPagination.buildPaginationParams(params)

    @rented = User.find(params[:id]).rentals.page(page).per(size)
    render json: ControllerPagination.buildPaginatedResponse(@rented)
  end

  def favorites
    @user = User.where(id: params[:id]).first
    render json: @user,
    include: {
      favorite_movies: {
        include: [:movie],
        except: [:user_id, :movie_id]
      }
    },
    except: [:created_at, :updated_at]
  end

  private

  def pagination_params
    params.permit(:page, :size,)
  end
end
