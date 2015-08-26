class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize
  before_action :check_account
  before_action :check_timeout
  http_basic_authenticate_with :name => 'admin', :password => 'tryout' if Rails.env == "production"

  private
  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  helper_method :current_user

  def authenticate(user, raw_password)
    user &&
      user.hashed_password &&
      BCrypt::Password.new(user.hashed_password) == raw_password
  end

  def authorize
    unless current_user
      flash.alert = 'ログインしてください。'
      redirect_to :root
    end
  end

  # ログイン中であってもアカウントが無効になってないかチェックする
  def check_account
    if current_user && !current_user.active?
      session.delete(:user_id)
      flash.alert = 'アカウントが無効になりました。'
      redirect_to :root
    else
    end
  end

  TIMEOUT = 60.minutes

  # セッションのタイムアウトをチェックする
  def check_timeout
    if current_user
      if session[:last_access_time] >= TIMEOUT.ago
        session[:last_access_time] = Time.current
      else
        session.delete(:user_id)
        flash.alert = 'セッションがタイムアウトしました。'
        redirect_to :root
      end
    end
  end
end
