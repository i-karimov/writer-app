Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]
  resources :users, only: %i[new create]
  resources :posts

  root 'pages#index'
end
