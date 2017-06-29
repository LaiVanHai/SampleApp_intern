class SessionsController < ApplicationController
  before_action :find_user, only: :create

  def new
  end

  def create
    user = @user
    sessions = @sessions
    if user && user.authenticate(sessions[:password])
      if user.activated?
        log_in user
        sessions[:remember_me] == "1" ? remember(user) : forget(user)
        redirect_back_or user
      else
        message = t "activation.acc_not_activ"
        flash[:warning] = message
        redirect_to root_url
      end
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
      flash[:danger] = t "login.invalid"
      redirect_to login_url
    end
  end
end
