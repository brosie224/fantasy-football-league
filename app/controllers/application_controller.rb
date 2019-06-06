class ApplicationController < ActionController::Base
    protect_from_forgery

    helper_method :current_user

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  
    def require_login
      if !current_user
        redirect_to login_path
        flash[:notice] = "You must be logged in to perform this action."
      end
    end

    def admin_only
      if current_user.email != "barosengarten@gmail.com"
        redirect_to user_path(@current_user)
        flash[:notice] = "You must be an admin to perform this action."
      end
    end

end
