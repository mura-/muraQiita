class TopsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :check_account
  skip_before_action :check_timeout

  def index
    if current_user
      redirect_to tips_url
    else 
      @form = LoginForm.new
      render 'index'
    end
  end
end
