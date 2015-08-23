class TipsController < ApplicationController
  def index
    @tips = Tip.order(created_at: :desc)
  end

  def mine 
    @tips = Tip.where(user_id: session[:user_id]).order(created_at: :desc)
    render 'index'
  end

  def show
    @tip = Tip.find(params[:id])
    @stock = Stock.find_by(user_id: current_user.id, tip_id: params[:id])
    if @stock.blank?
      @stock = Stock.new(tip_id: params[:id])
    end
    @comments = @tip.comments
    @comment = Comment.new(tip_id: params[:id])
  end

  def new
    @tip = Tip.new
  end

  def edit
    @tip = Tip.find(params[:id])
    if current_user.id != @tip.user_id 
      flash.alert = '他ユーザーの記事は変更できません。'
      redirect_to tip_url(@tip) and return
    end
  end

  def create
    @tip = Tip.new(tip_params)
    @tip.user_id = current_user.id 
    if @tip.save
      flash.notice = '記事を作成しました。'
      redirect_to tip_url(@tip)
    else
      render action: 'new'
    end
  end

  def update
    @tip = Tip.find(params[:id])
    if current_user.id != @tip.user_id 
      flash.alert = '他ユーザーの記事は変更できません。'
      redirect_to tip_url(@tip) and return
    end
    @tip.assign_attributes(tip_params)
    if @tip.save
      flash.notice = '記事を更新しました。'
      redirect_to tip_url(@tip)
    else
      render action: 'edit'
    end
  end

  def destroy
    tip = Tip.find(params[:id])
    if current_user.id != tip.user_id 
      flash.alert = '他ユーザーの記事は変更できません。'
      redirect_to tip_url(tip) and return
    end
    tip.destroy!
    flash.notice = '記事を削除しました。'
    redirect_to :root
  end

  private
  def tip_params
    params.require(:tip).permit( :title, :content)
  end

end
