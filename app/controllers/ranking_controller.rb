class RankingController < ApplicationController
  def show
    @rank_mode = params[:rank_mode].capitalize
    @items = Item.ranking(@rank_mode, 10)
  end
end
