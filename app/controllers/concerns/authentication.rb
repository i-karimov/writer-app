module Authentication
  extend ActiveSupport::Concern

  included do
    private

    def current_user
      @current_user = User.find_by(id: session[:user_id]) if session[:user_id].present?
    end

    def user_signed_in?
      current_user.present?
    end

    def sign_in(user)
      session[:user_id] = user.id
    end

    def sign_out
      session.delete :user_id
    end

    def ensure_unsigned_in
      return unless user_signed_in?

      flash[:warning] = 'You are signed in'
      redirect_to posts_path
    end

    def require_authentication
      return if user_signed_in?

      flash[:warning] = 'You are not signed in yet'
      redirect_to new_session_path
    end

    helper_method :current_user, :user_signed_in?
  end
end
