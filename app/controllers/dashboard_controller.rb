class DashboardController < ApplicationController
  def index
  	@recent_sales = Sale.find(:all, :limit => 10, :order => 'id DESC')
  	@popular_items = Item.find(:all, :limit => 10, :order => 'amount_sold DESC')
  end
end
