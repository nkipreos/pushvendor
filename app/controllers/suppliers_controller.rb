class SuppliersController < ApplicationController

  def index
    @suppliers = Supplier.paginate(:page => params[:page], :per_page => 20).order(id: :desc)
  end

  def new
    @supplier = Supplier.new
  end

  def get_suppliers
    
  end

end