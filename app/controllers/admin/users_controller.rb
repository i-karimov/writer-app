module Admin
  class UsersController < ApplicationController
    before_action :require_authentication
    before_action :set_user!, only: %i[edit update destroy]

    def index
      respond_to do |format|
        format.html do
          @q = User.ransack(params[:search])
          @users = @q.result.includes([:region]).page(params[:page])
        end

        # format.zip { respond_with_zipped_users }
      end
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
      if current_user == @user
        flash[:warning] = "As an admin, you can't delete you account."
      else
        @user.destroy
        flash[:success] = 'User was successfully deleted.'
      end

      redirect_to admin_users_path
    end

    private

    #   def respond_with_zipped_users
    #     compressed_filestream = Zip::OutputStream.write_buffer do |zos|
    #       User.find_each do |user|
    #         zos.put_next_entry "user_#{user.id}.xlsx"
    #         zos.print render_to_string(
    #           layout: false,
    #           handlers: [:axlsx],
    #           formats: [:xlsx],
    #           locals: { user: }
    #         )
    #       end
    #     end

    #     compressed_filestream.rewind
    #     send_data compressed_filestream.read, filename: 'users.zip'
    #   end
    # end

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
  end
end
