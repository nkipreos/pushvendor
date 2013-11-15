class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
    	t.integer :item_id
      t.integer :quantity, :default => 1
      t.integer :price
      t.integer :sale_id

      t.timestamps
    end
  end
end
