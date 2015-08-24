class StocksController < ApplicationController
  def index
    user_id = current_user.id
    @user = User.find(user_id)
    @stocks = Stock.where(user_id: user_id).order(created_at: :desc)
  end

  def create
    stock = Stock.new(stock_params.merge({user_id: current_user.id}))
    if stock.save
    else 
      flash.alert = 'ストックできませんでした。もう一度お試しください。'
    end
    redirect_to tip_path(stock_params[:tip_id])
  end

  def destroy
    stock = Stock.find(params[:id])
    tip_id = stock.tip_id
    if stock.destroy!
      flash.notice = 'ストックを取り消しました'
    else 
      flash.alert = 'ストックできませんでした。もう一度お試しください。'
    end
    redirect_to tip_path(tip_id)
  end

  private
  def stock_params
    params.require(:stock).permit(
      :tip_id, :user_id
    )
  end
end
