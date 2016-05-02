class SuppliersController < ApplicationController

  skip_before_filter :authenticate_user!, only: :get_suppliers
  protect_from_forgery with: :null_session, only: :get_suppliers

  def index
    @suppliers = Supplier.paginate(:page => params[:page], :per_page => 20).order(id: :desc)
  end

  def new
    @supplier = Supplier.new
  end

  def get_suppliers
    suppliers = Supplier.where('company_name like ?', "%#{params[:company_name]}%")
    render json: suppliers
  end

  def create
    @supplier = Supplier.new(supplier_params)
    respond_to do |format|
      if @supplier.save
        format.html { redirect_to '/suppliers', notice: 'Supplier was successfully created.' }
        format.json { render action: 'index', status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

  private

  def supplier_params
    params.require(:supplier).permit(:company_name, :name, :lastname, :tax_id, :address, :phone, :activity, :email)
  end

end