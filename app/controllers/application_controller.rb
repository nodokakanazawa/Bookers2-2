class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, only: [:index, :show,:edit, :update]
  before_action :is_matching_login_user, only:[:edit ,:update]

  def after_sign_in_path_for(resources)
      flash[:notice]="Welcome! You have signed up successfully."
      user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    flash[:notice]="Signed out successfully."
    root_path
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end





end
