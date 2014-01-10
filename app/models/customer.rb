class Customer < ActiveRecord::Base
	attr_accessible :first_name, :last_name, :phone_number, :email_address, :address, :city, :state, :zip

	has_many :sales
end
