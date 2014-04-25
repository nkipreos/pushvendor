module ApplicationHelper

	def raw_sales
		sales = Sale.find(:all)
		total = 0.00
		for sale in sales
			unless sale.total_amount.blank?
				total += sale.total_amount
			end
		end
		return total
	end


	def payment_total
		payments = Payment.find(:all)
		payment_total = 0.00
		for payment in payments
			payment_total += payment.amount.blank? ? 0.00 : payment.amount_after_change
		end
		return payment_total
	end


	def owed_balance
		raw_sales - payment_total
	end


	def get_todays_sale
		
	end

	def get_http(url)
    unless url.blank? || url.starts_with?("http://") || url.starts_with?("https://")
      url = "http://" + url
    end
    url
  end


end
