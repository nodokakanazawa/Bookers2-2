class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_current_user
  @current_user=User.find_by(id: session[:user_id])
  end

  def authenticate_user
	  if @current_user == nil
  		redirect_to new_user_session_path
	  end
  end


  def after_sign_in_path_for(resources)
    if user_signed_in?
      flash.now[:notice]="you are already signed in!"
      user_path(current_user)
    else
      flash[:notice]="Welcome! You have signed up successfully."
      redirect_to new_user_session_path
    end
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
