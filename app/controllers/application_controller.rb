class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  I18n.locale = :vi

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "update_user.plz_login"
      redirect_to login_url
    end
  end
end
