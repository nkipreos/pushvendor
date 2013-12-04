class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  def index
    @sales = Sale.all
  end

  def show
  end

  def new
    @sale = Sale.create
    redirect_to :controller => 'sales', :action => 'edit', :id => @sale.id
  end

  def edit
    @sale = Sale.find(params[:id])
    @sale.line_items.build
    # @sale.items.build

  end

  def create
    @sale = Sale.new(sale_params)

    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sale }
      else
        format.html { render action: 'new' }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end


  def update

    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url }
      format.json { head :no_content }
    end
  end

  # searched Items
  def update_line_item_options
    @available_items = Item.find(:all, :conditions => ['name ILIKE ?', "%#{params[:search][:item_name]}%"], :limit => 5)

    respond_to do |format|
      format.js
    end
  end

  # Add a searched Item
  def add_searched_item
    existing_line_item = LineItem.where("item_id = ? AND sale_id = ?", params[:item_id], params[:sale_id]).first
    
    if existing_line_item.blank?
      line_item = LineItem.new(:item_id => params[:item_id], :sale_id => params[:sale_id], :quantity => params[:quantity])
      line_item.price = 0.00
      line_item.price = line_item.quantity * line_item.item.price
      line_item.save
    else
      existing_line_item.quantity += 1
      existing_line_item.price = 0.00
      existing_line_item.price = existing_line_item.quantity * existing_line_item.item.price
      existing_line_item.save
    end

    @sale = Sale.find(params[:sale_id])

    update_totals

    respond_to do |format|
      format.js
    end
  end

  # Remove Item
  def remove_item
    @sale = Sale.find(params[:sale_id])
    update_totals

    respond_to do |format|
      format.js
    end
  end

  # Add one Item
  def add_item
    @sale = Sale.find(params[:sale_id])
    update_totals

    respond_to do |format|
      format.js
    end
  end

  # Destroy Line Item
  def destroy_line_item
    @sale = Sale.find(params[:sale_id])
    update_totals

    respond_to do |format|
      format.js
    end
  end

  # Update Sale Totals
  def update_totals
    tax_amount = 0.0825

    @sale = Sale.find(params[:sale_id])

    amount = 0.00
    for line_item in @sale.line_items
      amount += line_item.price
    end

    @sale.amount = amount
    @sale.tax = amount * tax_amount
    @sale.total_amount = amount + (amount * tax_amount)

    @sale.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params[:sale]
    end
end
