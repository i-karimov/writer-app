Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]
  resources :users, only: %i[new create edit update]

  namespace :admin do
    resources :users, only: %i[index edit update destroy]
  end

  resources :posts

  root 'pages#index'
end
