class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def authorize_user(user_id)
    session[:user_id] = user_id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def reject_user
    redirect_to root_path, alert: 'Ай-ай-ай! Вам сюда нельзя!'
  end
end
