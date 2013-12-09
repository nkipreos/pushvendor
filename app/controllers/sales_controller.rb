class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  def index
    @sales = Sale.paginate(:page => params[:page], :per_page => 20)
  end

  # def show
  # end

  def new
    @sale = Sale.create
    redirect_to :controller => 'sales', :action => 'edit', :id => @sale.id
  end

  def edit
    @sale = Sale.find(params[:id])
    @sale.line_items.build
    # @sale.items.build
    @popular_items = Item.all(:limit => 5)
  end

  # def create
  #   @sale = Sale.new(sale_params)

  #   respond_to do |format|
  #     if @sale.save
  #       format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
  #       format.json { render action: 'show', status: :created, location: @sale }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @sale.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end


  def update

    params[:sale_id] = @sale.id

    respond_to do |format|
      if @sale.update(sale_params)
        for line_item in @sale.line_items
          update_line_item_totals(line_item)
        end
        update_totals
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
  def create_line_item
    existing_line_item = LineItem.where("item_id = ? AND sale_id = ?", params[:item_id], params[:sale_id]).first
    
    if existing_line_item.blank?
      line_item = LineItem.new(:item_id => params[:item_id], :sale_id => params[:sale_id], :quantity => params[:quantity])
      line_item.price = line_item.item.price
      line_item.save

      update_line_item_totals(line_item)
    else
      existing_line_item.quantity += 1
      existing_line_item.save

      update_line_item_totals(existing_line_item)
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

    line_item = LineItem.where(:sale_id => params[:sale_id], :item_id => params[:item_id]).first
    line_item.quantity -= 1
    line_item.save

    update_line_item_totals(line_item)

    update_totals

    respond_to do |format|
      format.js
    end
  end

  # Add one Item
  def add_item
    @sale = Sale.find(params[:sale_id])

    line_item = LineItem.where(:sale_id => params[:sale_id], :item_id => params[:item_id]).first
    line_item.quantity += 1
    line_item.price = line_item.item.price
    line_item.save

    update_line_item_totals(line_item)

    update_totals

    respond_to do |format|
      format.js
    end
  end


  # update Total For Line Items
  def update_line_item_totals(line_item)
    line_item.total_price = line_item.price * line_item.quantity
    line_item.save
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

    @sale.amount = 0.00

    for line_item in @sale.line_items
      @sale.amount += line_item.total_price
    end

    @sale.tax = @sale.amount * tax_amount
    total_amount = @sale.amount + (@sale.amount * tax_amount)

    if @sale.discount.blank?
      @sale.total_amount = total_amount
    else
      discount_amount = total_amount * @sale.discount
      @sale.total_amount = total_amount - discount_amount
    end

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
