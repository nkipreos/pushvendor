class Item < ActiveRecord::Base
	attr_accessible :image_url, :sku, :name, :description, :price, :stock_amount, :cost_price

	has_many :line_items

	validates :sku, :presence => true, :uniqueness => true
	validates :name, :presence => true
	validates :price, :presence => true
	validates :stock_amount, :presence => true

	default_scope :order => 'sku ASC'
end
