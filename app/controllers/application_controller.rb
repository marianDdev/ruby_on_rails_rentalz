class ApplicationController < ActionController::Base
    include Pagy::Backend
    helper_method :current_user

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end    

    def require_guest
        redirect_to '/login' unless current_user.guest?
    end 

    def require_owner
        redirect_to '/' unless current_user.owner?
    end

end
