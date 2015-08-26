class StocksController < ApplicationController
  def index
    @stocks = current_user.stocks.order(created_at: :desc)
  end

  def create
    stock = current_user.stocks.new(stock_params)
    if stock.save
      flash.notice = 'ストックしました。'
    else
      flash.alert = 'ストックできませんでした。もう一度お試しください。'
    end
    redirect_to tip_path(stock_params[:tip_id])
  end

  def destroy
    stock = current_user.stocks.find(params[:id])
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
    params.require(:stock).permit(:tip_id, :user_id)
  end
end
