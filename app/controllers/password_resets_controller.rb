class PasswordResetsController < ApplicationController
  before_action :find_user, :valid_user,
    :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "reset.email_send"
      redirect_to root_url
    else
      flash.now[:danger] = t "reset.email_err"
      render :new
    end
  end

  def edit
  end

  def update
    if user_params[:password].empty?
      @user.errors.add(:password, t("reset.empty"))
      call
    elsif @user.update_attributes user_params
      log_in @user
      @user.update_attributes reset_digest: nil
      flash[:success] = t("reset.succ")
      redirect_to @user
    else
      call
    end
  end

  private

  def call
    render :edit
  end

  def user_params
    params.require :user .permit :password, :password_confirmation
  end

  def find_user
    @user = User.find_by email: params[:email]
    return if @user
    render file: Rails.root.join("public", "404.html.erb"),
      layout: false, status: 404
  end

  def valid_user
    redirect_to root_url unless @user && @user.activated? &&
      @user.authenticated?(:reset, params[:id])
  end

  def check_expiration
    if @user.password_reset_expired?
      redirect_to new_password_reset_url
      flash[:danger] = t "reset.expried"
    end
  end
end
