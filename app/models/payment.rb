class Payment < ActiveRecord::Base
	attr_accessible :payment_type, :amount, :sale_id

	belongs_to :sale
end
