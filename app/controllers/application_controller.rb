class ApplicationController < ActionController::Base
  # before_action :authenticate_customer!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # sign_up時に許可するカラム追記
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :email, :birth_date])
  end

end
