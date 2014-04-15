class Sale < ActiveRecord::Base
	attr_accessible :amount, :tax, :discount, :total_amount, :tax_paid, :amount_paid, :paid, :payment_type_id, :customer_id, :comments, :line_items_attributes, :items_attributes


	belongs_to :customer
	has_many :line_items
	has_many :items, :through => :line_items
	has_many :connections, :through => :customer
	has_many :payments

	accepts_nested_attributes_for :line_items, :allow_destroy => true
	accepts_nested_attributes_for :items, :allow_destroy => true
	accepts_nested_attributes_for :payments, :allow_destroy => true

	def remaining_balance
		if self.total_amount.blank?
			balance = 0.00
		else
			balance = self.total_amount - paid_total
		end

		if balance < 0
			return 0
		else
			return balance
		end
	end

	def get_discounted_amount
		self.total_amount * self.discount
	end

	def paid_total
		paid_total = 0.00
		unless self.payments.blank?
			for payment in self.payments
				paid_total += payment.amount.blank? ? 0.00 : payment.amount
			end
		end
		return paid_total
	end


end
