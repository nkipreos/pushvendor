class Expense < ActiveRecord::Base
  belongs_to :money_source
#  has_many   :attachments
  has_attached_file :attachment 
  do_not_validate_attachment_file_type :attachment
end
