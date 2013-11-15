class Item < ActiveRecord::Base
	attr_accessible :image_url, :sku, :name, :description, :price, :stock_amount, :cost_price

	has_many :line_items
end
