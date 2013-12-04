class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
    	t.decimal :amount, :precision => 8, :scale => 2
      t.decimal :total_amount, :precision => 8, :scale => 2
      t.decimal :remaining_amount
      t.decimal :discount, :precision => 6, :scale => 5
      t.decimal :tax, :precision => 6, :scale => 5
      t.integer :customer_id
      t.text :comments

      t.timestamps
    end
  end
end
