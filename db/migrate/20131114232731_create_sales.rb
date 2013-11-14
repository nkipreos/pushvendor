class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
    	t.decimal :total_amount, :precision => 8, :scale => 2
      t.decimal :tax_paid, :precision => 8, :scale => 2
      t.decimal :amount_paid, :precision => 8, :scale => 2
      t.boolean :paid
    	t.string :payment_type_id
      t.integer :customer_id
      t.text :comments

      t.timestamps
    end
  end
end
