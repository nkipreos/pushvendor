class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
    	t.string :sku
    	t.string :name
    	t.text :description
    	t.decimal :price, :precision => 8, :scale => 2
    	t.integer :stock_amount
      t.decimal :cost_price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
