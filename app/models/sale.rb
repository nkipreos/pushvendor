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

	def get_sale_totals
		if self.total_amount.blank?
			balance = 0.00
		else
			balance = 0.00
			payment_total = 0.00

			if self.payments.blank?
				balance = self.total_amount
			else
				for payment in self.payments
					unless payment.amount.blank?
						payment_total += payment.amount
					end
				end

				balance = self.total_amount - payment_total
			end
		end

		if balance < 0
			return 0
		else
			return balance
		end
	end

end
