Rails.application.routes.draw do
  resources :posts, only: %i[index new create edit update destroy]

  root 'pages#index'
end
