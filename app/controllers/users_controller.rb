class UsersController < ApplicationController
  before_action :ensure_unsigned_in, only: %i[new create]
  before_action :require_authentication, only: %i[edit update]
  before_action :set_user!, only: %i[edit update]

  def new
    @user = User.new(role: :regular)
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your profile has been updated successfully'
      redirect_to posts_path
    else
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)

      flash[:success] = "Welcome to App, #{@user.first_name}!"
      redirect_to posts_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :middle_name, :last_name, :password, :password_confirmation)
  end

  def set_user!
    @user = User.find(params[:id])
  end
end
