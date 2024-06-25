Rails.application.routes.draw do
  resources :posts, only: %i[index new]

  root 'pages#index'
end
