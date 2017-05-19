class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  rescue_from ActionController::RoutingError, with: :not_found
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  protected
    def not_found
      redirect_to root_path, alert: "Page not found"
    end

     def not_authorized
      redirect_to root_path, alert: "You have no permission"
    end
end
