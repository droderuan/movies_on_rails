Rails.application.routes.draw do
  scope(:path => '/api/v1') do

    root "application#index"


    resources :movies, only: %i[index] do
      get :recommendations, on: :collection
      get :user_rented_movies, on: :collection
      get :rent, on: :member
    end
  end
end
