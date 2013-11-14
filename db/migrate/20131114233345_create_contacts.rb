class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
    	t.string :email_address
    	t.string :phone_number
    	t.string :address
    	t.string :city
    	t.string :state
    	t.string :zip
    	t.integer :customer_id

      t.timestamps
    end
  end
end
