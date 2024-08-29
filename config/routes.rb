Rails.application.routes.draw do
  resources :restaurants do
    resources :reviews, only: %i[create]
    collection do
      get :top
    end
  end
end
