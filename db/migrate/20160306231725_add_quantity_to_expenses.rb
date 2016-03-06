class AddQuantityToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :quantity, :decimal, :precision => 10, :scale => 3
  end
end
