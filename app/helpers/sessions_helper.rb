module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  # a = a || b
  # a ||= b
  
  def logged_in?
    !!current_user
  end
end
