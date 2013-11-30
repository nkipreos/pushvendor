class LineItem < ActiveRecord::Base
	belongs_to :sale
  belongs_to :item

  attr_accessible :item_id, :quantity, :price, :sale_id
  
end
