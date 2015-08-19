class SessionsController < ApplicationController
  def new 
    if session[:user_id]
      redirect_to :root
    else
      @form = LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = LoginForm.new(params[:login_form])
    if @form.email.present?
      user = User.find_by(email_for_index: @form.email.downcase)
      if authenticate(user, @form.password)
        session[:user_id] = user.id
        redirect_to :root
      else
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

  private
  def authenticate(user, raw_password)
    user &&
      user.hashed_password &&
      BCrypt::Password.new(user.hashed_password) == raw_password
  end
end
