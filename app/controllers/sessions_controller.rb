class SessionsController < ApplicationController
  before_action :find_user, only: :create

  def new
  end

  def create
    user = @user
    sessions = @sessions
    if user && user.authenticate(sessions[:password])
      log_in user
      sessions[:remember_me] == "1" ? remember(user) : forget(user)
      redirect_to user
    else
      flash[:danger] = t "login.error"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def find_user
    @sessions = params[:session]
    @user = User.find_by email: @sessions[:email].downcase
    unless @user
      flash[:danger] = t "invalid_login"
      redirect_to login_url
    end
  end
end