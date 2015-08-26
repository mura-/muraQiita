class UsersController < ApplicationController
  skip_before_action :authorize, :only => [:create, :new]

  def show
    @tips = current_user.tips.order(created_at: :desc).limit(5)
    @stocks = current_user.stocks.order(created_at: :desc).limit(5)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      session[:last_access_time] = Time.current
      redirect_to :root
    end
  end

  def update
    current_user.assign_attributes(user_params)
    if current_user.save
      flash.notice = 'アカウントを更新しました。'
      redirect_to :user
    else 
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :email, :password, :name, :start_date, :end_date
    )
  end

end
