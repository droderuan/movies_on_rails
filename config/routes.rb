Rails.application.routes.draw do
  scope(:path => '/api/v1') do

    root "application#index"

    resources :users do
      get :rented, on: :member
      get :favorites, on: :member
    end

    resources :movies, only: %i[index] do
      get :recommendations, on: :collection
      post :rent, on: :member
      post :return, on: :member
    end
  end
end
