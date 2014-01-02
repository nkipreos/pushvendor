class DashboardController < ApplicationController
  def index
  	@recent_sales = Sale.find(:all, :limit => 10, :order => 'id DESC')
  end
end
