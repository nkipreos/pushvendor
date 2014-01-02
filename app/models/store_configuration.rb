class StoreConfiguration < ActiveRecord::Base
	attr_accessible :store_name, :store_description, :email_address, :phone_number, :website_url, :address, :city, :state, :zip, :currency, :tax_rate
end
