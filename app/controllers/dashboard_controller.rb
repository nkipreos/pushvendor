class DashboardController < ApplicationController
  def index
  	@recent_sales = Sale.find(:all, :limit => 10)
  end
end
