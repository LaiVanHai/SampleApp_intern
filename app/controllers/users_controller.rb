class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    unless @user
      render file: "#{Rails.root}/public/404.html.erb", layout: false, status: 404
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    user = @user
    if user.save
      flash[:success] = t "sign_up.wellcome"
      redirect_to user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
