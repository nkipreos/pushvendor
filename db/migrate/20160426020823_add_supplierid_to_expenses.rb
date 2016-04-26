class AddSupplieridToExpenses < ActiveRecord::Migration
  def change
    add_reference :expenses, :supplier, index: true, foreign_key: true
  end
end
