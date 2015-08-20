class UsersController < ApplicationController
  def index 
    render action: 'index'
  end

  def show
    user_id = session[:user_id]
    @user = User.find(user_id)
    render action: 'show'
  end

  def new
    @user = User.new
    render action: 'new'
  end

  def edit
    user_id = session[:user_id]
    @user = User.find(user_id)
    render action: 'edit'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to :root
    else 
      render action: 'new'
    end
  end

  def update
    @user = User.find(session[:user_id])
    @user.assign_attributes(user_params)
    if @user.save
      flash.notice = 'アカウントを更新しました。'
      redirect_to user_url
    else 
      render action: 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :email, :password, :name, :start_date, :end_date
    )
  end

end
