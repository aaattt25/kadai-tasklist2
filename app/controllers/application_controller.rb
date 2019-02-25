class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private
  
  def require_user_logged_in
                      # ログインがfalseなら以下の処理を実行
    unless logged_in? 
      redirect_to login_url
    end
  end
end
