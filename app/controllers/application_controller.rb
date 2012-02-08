class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  private
  def current_user
    @current_user ||= user_from_session
  end

  def user_from_session
    user = User.coll.find_one(_id: session[:user_id]) if session[:user_id]
    user["_id"] if user
  end
end

