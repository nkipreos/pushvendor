class Expense < ActiveRecord::Base
  belongs_to :money_source
  belongs_to :supplier
end
