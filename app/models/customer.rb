class Customer < ActiveRecord::Base
	attr_accessible :first_name, :last_name

	has_many :sales
	has_many :contacts

	accepts_nested_attributes_for :contacts, :allow_destroy => true
end
