class SessionsController < ApplicationController
  before_action :ensure_unsigned_in, only: %i[new create]
  before_action :require_authentication, only: :destroy

  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      sign_in(user)
      flash[:success] = "Welcome to App, #{user.first_name}!"
      redirect_to posts_path
    else
      flash[:warning] = 'Wrong credentials'
      redirect_to new_session_path
    end
  end

  def destroy
    sign_out
    redirect_to new_session_path
  end
end
