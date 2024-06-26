class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome to App, #{user.first_name}!"
      redirect_to posts_path
    else
      flash[:warning] = 'Wrong credentials'
      redirect_to new_session_path
    end
  end

  def destroy
    session.delete :user_id
    redirect_to new_session_path
  end
end
