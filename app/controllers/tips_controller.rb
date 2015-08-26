class TipsController < ApplicationController
  before_action :set_tip_tags_to_gon, only: [:edit]
  before_action :set_available_tags_to_gon, only: [:new, :edit]

  def index
    @tips = Tip.order(created_at: :desc)
  end

  def mine 
    @tips = current_user.tips.order(created_at: :desc)
    render 'index'
  end

  def show
    @tip = Tip.find(params[:id])
    @stock = @tip.stocks.find_by(tip_id: params[:id])
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
    @tip = current_user.tips.find(params[:id])
    if @tip.blank?
      flash.alert = '他ユーザーの記事は変更できません。'
      redirect_to tip_url(@tip) and return
    end
  end

  def create
    @tip = current_user.tips.new(tip_params)
    if @tip.save
      flash.notice = '記事を作成しました。'
      redirect_to tip_url(@tip) and return
    else
      render action: 'new'
    end
  end

  def update
    @tip = current_user.tips.find(params[:id])
    if @tip.blank?
      flash.alert = '他ユーザーの記事は変更できません。'
      redirect_to tip_url(@tip) and return
    end
    @tip.assign_attributes(tip_params)
    if @tip.save
      flash.notice = '記事を更新しました。'
      redirect_to tip_url(@tip) and return
    else
      render action: 'edit'
    end
  end

  def destroy
    @tip = current_user.tips.find(params[:id])
    if @tip.blank?
      flash.alert = '他ユーザーの記事は削除できません。'
      redirect_to tip_url(@tip) and return
    end
    @tip.destroy!
    flash.notice = '記事を削除しました。'
    redirect_to :root
  end

  private
  def tip_params
    params.require(:tip).permit(:title, :content, :tag_list)
  end

  def set_tip_tags_to_gon
    @tip = Tip.find(params[:id])
    gon.tip_tags = @tip.tag_list
  end

  def set_available_tags_to_gon
    gon.available_tags = Tip.tags_on(:tags).pluck(:name)
  end
end
