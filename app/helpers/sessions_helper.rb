module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    session_id = session[:user_id]
    cookie_id = cookies.signed[:user_id]
    if session_id
      @current_user ||= User.find_by id: session_id
    elsif cookie_id
      user = User.find_by id: cookie_id
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    current_user.present?
  end

  def remember user
    user.remember
    permanent = cookies.permanent
    permanent.signed[:user_id] = user.id
    permanent[:remember_token] = user.remember_token
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def log_out
    forget current_user
    session.delete :user_id
    @current_user = nil
  end
end