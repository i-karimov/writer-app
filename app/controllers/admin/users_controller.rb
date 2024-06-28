module Admin
  class UsersController < ApplicationController
    before_action :require_authentication
    before_action :set_user!, only: %i[edit update destroy]
    before_action :authorize_user!
    after_action :verify_authorized

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)

      if @user.save
        flash[:success] = 'User was successfully created.'
        redirect_to admin_users_path
      else
        render :new
      end
    end

    def index
      @q = User.ransack(params[:search])
      @users = @q.result.includes([:region]).page(params[:page])
    end

    def edit; end

    def update
      if @user.update(user_params)
        flash[:success] = 'User was successfully updated.'
        redirect_to admin_users_path
      else
        render :edit
      end
    end

    def destroy
      @user.destroy
      flash[:success] = 'User was successfully deleted.'

      redirect_to admin_users_path
    end

    private

    def set_user!
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :middle_name,
        :email,
        :password,
        :password_confirmation,
        :region_id,
        :role
      )
    end

    def authorize_user!
      authorize [:admin, @user || User]
    end
  end
end
