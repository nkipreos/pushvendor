class AddSentFlagToSale < ActiveRecord::Migration
  def change
    add_column :sales, :sent, :boolean, :default => false
  end
end
