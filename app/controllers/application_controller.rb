class ApplicationController < ActionController::Base
    
    helper_method :current_cart

    def current_cart
        @current_cart ||= Cart.find_by(session_token: session[:session_token])
    end

end
