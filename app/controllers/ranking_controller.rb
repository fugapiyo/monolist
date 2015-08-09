class RankingController < ApplicationController
  def show
    @rank_mode = params[:rank_mode].downcase
    self.send(@rank_mode)
  end
  
  def have
    ids = Have.group(:item_id).order('count_item_id desc').limit(10).count(:item_id).keys
    @items = Item.find(ids)
  end

  def want
    ids = Want.group(:item_id).order('count_item_id desc').limit(10).count(:item_id).keys
    @items = Item.find(ids)
  end
end
