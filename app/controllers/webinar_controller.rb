class WebinarController < ApplicationController

  # make sure a user is logged in before running these actions.  actual method in application_controller.rb  
  before_filter :check_login, :only => ["index", "delete", "edit", "show"]
  
  def index 
    redirect_to "/oldwebinar/view"
  end
  
  def list
    ## that is to say, do an INNER JOIN with WebinarUsers where the WebinarUser has the username of the current, logged-in user
    @webinars = Webinar.joins(:webinar_users).where(webinar_users: {username: session[:username]})
  end
  
  def show
    Webinar.update_data
    @webinarsx = Webinar.all
  end
  
  def new
    @webinar_user = WebinarUser.new
  end
  
  def create
    @webinar_user = WebinarUser.new(params[:webinar_user])
#    if request.post?
      if @webinar_user.save
        #session[:webinar_user] = WebinarUser.authenticate(@user.username, @user.password)
        flash[:notice] = "You've successfully signed up for our webinar series"
        redirect_to "/oldwebinar"
      else
        flash[:notice] = "Signup unsuccessful"
        redirect_to :action => "new"
      end
#    end
  end
  
  def login
#    authorized_user = WebinarUser.authenticate(params[:username], params[:password])
#    if authorized_user
#      session[:username] = params[:username]
#      session[:password] = params[:password]
#      flash[:notice] = "Nice, you're in!"
#      redirect_to "/oldwebinar"
#    else
#      flash[:notice] = "Sorry bad credentials"
    end
    
    def attempt_login    
      authorized_user = WebinarUser.authenticate(params[:username], params[:password])
      if authorized_user
        session[:username] = params[:username]
        session[:password] = params[:password]
        flash[:notice] = "Nice, you're in!"
        redirect_to "/oldwebinar"
      else
        flash[:notice] = "Sorry bad credentials"
        render "login"
    end
    
    #if request.post?
    #  if session[:user] = WebinarUser.authenticate(params[:user][:username], params[:user][:password])
    #    flash[:message] = "Login successful"
    #    redirect_to_stored
    #  else
    #    flash[:warning] = "Login unsuccessful"
    #  end
    #end
  end

  def logout
    session[:username] = nil
    session[:password] = nil
    flash[:notice] = "Logged out"
    #redirect_to :action => "login"
  end

  def delete
  end

  def edit
  end

  def forgot_password
  end
end
