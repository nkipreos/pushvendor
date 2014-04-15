module ApplicationHelper

	def get_all_sales
		sales = Sale.find(:all)
		total = 0.00
		for sale in sales
			unless sale.total_amount.blank?
				total += sale.total_amount
			end
		end
		return number_to_currency total
	end

	def get_todays_sale
		
	end

end
