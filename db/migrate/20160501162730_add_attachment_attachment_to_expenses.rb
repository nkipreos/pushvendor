class AddAttachmentAttachmentToExpenses < ActiveRecord::Migration
  def self.up
    change_table :expenses do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :expenses, :attachment
  end
end
