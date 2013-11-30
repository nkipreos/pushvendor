class Sale < ActiveRecord::Base
	attr_accessible :total_amount, :tax_paid, :amount_paid, :paid, :payment_type_id, :customer_id, :comments, :line_items_attributes, :items_attributes


	belongs_to :customer
	has_many :line_items
	has_many :items, :through => :line_items
	has_many :connections, :through => :customer
	has_many :payments

	accepts_nested_attributes_for :line_items, :allow_destroy => true
	accepts_nested_attributes_for :items, :allow_destroy => true

	def get_sale_items
		if self.id.blank?
			return ''
		else
			@items = Sale.find(self.id).items
			if @items.blank?
				return ''
			else
				return @items
			end
		end
	end

end
