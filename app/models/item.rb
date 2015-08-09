class Item < ActiveRecord::Base
  serialize :raw_info , Hash

  has_many :ownerships  , foreign_key: "item_id" , dependent: :destroy
  has_many :users , through: :ownerships
  
  has_many :wants, class_name: "Want", foreign_key: "item_id", dependent: :destroy
  has_many :want_users, through: :wants, source: :user
  
  has_many :haves, class_name: "Have", foreign_key: "item_id", dependent: :destroy
  has_many :have_users, through: :haves, source: :user

  # Want/Haveランキング情報を降順ソートしてHashで返却する
  def self.ranking(rank_mode, array_max)
    # JOIN用のテーブル名シンボルを動的生成
    join_table_name = "#{rank_mode.downcase}_users".to_sym
    
    # item_idとcountの配列を取得
    rank_array = Item.joins(join_table_name).group('ownerships.item_id').count
    # カウント数をベースに昇順ソートし、item_idのみの配列に変換
    rank_array_sorted = rank_array.sort_by{|key,val| -val}.map{|ary| ary[0]}
    
    # idからitemオブジェクトの配列を生成
    max = array_max - 1
    rank_item_array = rank_array_sorted[0..max].map do |id|
      Item.find_by(id: id)
    end
    
    rank_item_array
  end

end
