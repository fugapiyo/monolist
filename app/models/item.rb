class Item < ActiveRecord::Base
  serialize :raw_info , Hash

  has_many :ownerships  , foreign_key: "item_id" , dependent: :destroy
  has_many :users , through: :ownerships
  
  has_many :wants, class_name: "Want", foreign_key: "item_id", dependent: :destroy
  has_many :want_users, through: :wants, source: :user
  
  has_many :haves, class_name: "Have", foreign_key: "item_id", dependent: :destroy
  has_many :have_users, through: :haves, source: :user
  
  def want(item)
    wants.create(item_id: item.id)
  end
  
  def want?(item)
    wants.include(item)
  end
  
  def unwant(item)
    wants.find_by(items_id: item.id).destroy
  end
  
  def have(item)
    haves.create(item_id: item.id)
  end
  
  def have?(item)
    haves.include(item)
  end
  
  def unhave(item)
    haves.find_by(item_id: item.id)
  end
  
end
