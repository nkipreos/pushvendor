class Contact < ActiveRecord::Base
	attr_accessible :phone_number, :email_address, :address, :city, :state, :zip
end
