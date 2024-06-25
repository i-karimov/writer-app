Rails.application.routes.draw do
  resources :posts, only: [:index]

  root 'pages#index'
end
