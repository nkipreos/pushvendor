class Sale < ActiveRecord::Base
	attr_accessible :total_amount, :tax_paid, :amount_paid, :paid, :payment_type_id, :customer_id, :comments, :line_items_attributes

	belongs_to :customer
	has_many :line_items

	accepts_nested_attributes_for :line_items, :allow_destroy => true
end
