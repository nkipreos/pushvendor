class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

         attr_accessible :email, :username, :password, :password_confirmation, :remember_me, :can_update_users, :can_update_items, :can_update_configuration, :can_view_reports, :can_update_sale_discount, :can_remove_sales

  validates :username, :presence => true, :uniqueness => true

end
