class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  I18n.locale = :vi
end
