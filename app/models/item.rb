class Item < ActiveRecord::Base
	has_many :line_items

	validates :sku, :presence => true, :uniqueness => true
	validates :name, :presence => true
	validates :price, :presence => true
	validates :stock_amount, :presence => true

	default_scope :order => 'sku ASC'
end
