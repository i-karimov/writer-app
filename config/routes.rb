Rails.application.routes.draw do
  resources :posts, only: %i[index new create]

  root 'pages#index'
end
