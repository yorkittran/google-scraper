class ApplicationController < ActionController::Base
  layout :layout
  before_action :configure_permitted_parameters, if: :devise_controller?

private

  def layout
    devise_controller? ? 'devise' : 'application'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
