class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :lastname
      t.string :email
      t.string :address
      t.string :activity
      t.string :company_name
      t.string :tax_id
      t.string :phone

      t.timestamps null: false
    end
  end
end
