class SuppliersController < ApplicationController

  def index
    @suppliers = Supplier.paginate(:page => params[:page], :per_page => 20).order(id: :desc)
  end

  def new
    @supplier = Supplier.new
  end

  def get_suppliers
    
  end

  def create
    @supplier = Supplier.new(supplier_params)
    respond_to do |format|
      if @supplier.save
        format.html { redirect_to @supplier, notice: 'Expense was successfully created.' }
        format.json { render action: 'index', status: :created, location: @supplier }
      else
        format.html { render action: 'new' }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def supplier_params
    params.require(:supplier).permit(:company_name, :name, :lastname, :tax_id, :address, :phone, :activity, :email)
  end

end