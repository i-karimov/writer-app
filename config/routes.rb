require 'sidekiq/web'

class AdminConstraint
  def matches?(request)
    user_id = request.session[:user_id]

    User.find_by(id: user_id)&.admin_role?
  end
end

Rails.application.routes.draw do
  mount Sidekiq::Web => 'jobs', constraints: AdminConstraint.new

  resource :session, only: %i[new create destroy]
  resources :users, only: %i[new create edit update]

  namespace :admin, constraints: AdminConstraint.new do
    resources :users
  end

  resources :posts

  root 'pages#index'
end
