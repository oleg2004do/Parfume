class ApplicationController < ActionController::Base
  helper_method :user_signed_in?
  helper_method :current_user

  
  def user_signed_in?
    current_user.present?  # Перевіряє чи є користувач в сесії
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    redirect_to login_path, alert: 'Please log in to continue' unless current_user
  end
end