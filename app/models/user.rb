class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         attr_accessible :email, :password, :password_confirmation, :remember_me, :can_update_users, :can_update_items, :can_update_configuration, :can_view_reports, :can_update_sale_discount, :can_remove_sales
end
