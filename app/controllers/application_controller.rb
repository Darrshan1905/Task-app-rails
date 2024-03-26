class ApplicationController < ActionController::Base
    helper_method :current_user, :authenticate

    private

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def authenticate
        redirect_to login_path, alert: "Must login before proceeding" if current_user.nil?
    end
end
