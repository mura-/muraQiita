class SessionsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :check_account
  skip_before_action :check_timeout

  def create
    @form = LoginForm.new(params[:login_form])
    if @form.email.present?
      user = User.find_by(email_for_index: @form.email.downcase)
      if authenticate(user, @form.password)
        session[:user_id] = user.id
        session[:last_access_time] = Time.current
        flash.notice = 'ログインしました。'
        redirect_to :root
      else
        flash.alert = 'ログインできませんでした。正しいメールアドレスとパスワードを入力してください。'
        render action: 'new'
      end
    else
      render action: 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to :root
  end

  def callback
    auth = request.env['omniauth.auth']
    user = User.find_by_provider_and_uid(auth['provider'], auth['uid']) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    session[:last_access_time] = Time.current
    redirect_to :root
  end
end
