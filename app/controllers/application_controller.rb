class ApplicationController < ActionController::Base
  # アクション前にconfigure_permitted_parametersメソッドを実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    recipe_bookmarks_path(@customer)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected
  # sign_up時に許可するカラム追記
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :birth_date])
  end

end
