class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def check_login
    if session[:username] && session[:password] #WebinarUser.authenticate(@webinar_user.username, @webinar_user.password) != nil
      return true
    else
      flash[:notice] = "Please login first"
      redirect_to(:controller => "webinar", :action => "login")
      return false
    end
  end
  
end
