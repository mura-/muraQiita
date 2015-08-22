class TopsController < ApplicationController
  def index
    if session[:user_id]
      redirect_to tips_url
    else 
      @form = LoginForm.new
      render 'index'
    end
  end
end
