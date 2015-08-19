class TopsController < ApplicationController
  def index
    if session[:user_id]
      redirect_to users_url(id: session[:user_id])
    else 
      @form = LoginForm.new
      render 'index'
    end
  end
end
