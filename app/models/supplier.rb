class Supplier < ActiveRecord::Base
  has_many :expenses
  validates_uniqueness_of :tax_id
end
