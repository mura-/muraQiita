class UsersController < ApplicationController
  skip_before_action :authorize, :only => [:create, :new]

  def show
    user_id = current_user.id
    @user = User.find(user_id)
    @tips = Tip.where(user_id: user_id).order(created_at: :desc).limit(5)
    @stocks = Stock.where(user_id: user_id).order(created_at: :desc).limit(5)
  end

  def new
    @user = User.new
  end

  def edit
    user_id = session[:user_id]
    @user = User.find(user_id)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      session[:last_access_time] = Time.current
      redirect_to :root
    else 
    end
  end

  def update
    @user = User.find(session[:user_id])
    @user.assign_attributes(user_params)
    if @user.save
      flash.notice = 'アカウントを更新しました。'
      redirect_to user_url
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
