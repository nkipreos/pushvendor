class Supplier < ActiveRecord::Base
  has_many :expenses
  validates_uniqueness_of :tax_id
  before_create :strip_tax_id

  private

  def strip_tax_id
    self.tax_id = tax_id.gsub(/\D/, '')
  end
end
