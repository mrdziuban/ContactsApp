class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find_by_token(params[:token])
  end

  def logged_in?
    !!current_user
  end

  def authenticate
    current_user
    unless logged_in?
      render text: "You're not logged in!"
    end
  end

end