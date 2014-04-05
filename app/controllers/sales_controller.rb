class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]
  before_action :set_configurations

  def index
    @sales = Sale.paginate(:page => params[:page], :per_page => 20, :order => 'id DESC')
  end

  def new
    @sale = Sale.create
    redirect_to :controller => 'sales', :action => 'edit', :id => @sale.id
  end

  def edit
    get_popular_items
    get_popular_customers

    @sale = Sale.find(params[:id])
    @sale.line_items.build
    @sale.payments.build

    @custom_item = Item.new
    @custom_customer = Customer.new
    # @sale.items.build
  end

  def update
    get_popular_items

    params[:sale_id] = @sale.id

    respond_to do |format|
      if @sale.update(sale_params)
        
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

    authorize! :read, @sale
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url }
      format.json { head :no_content }
    end
  end

  # searched Items
  def update_line_item_options
    get_popular_items
    @available_items = Item.find(:all, :conditions => ['name ILIKE ? OR description ILIKE ? OR sku ILIKE ?', "%#{params[:search][:item_name]}%", "%#{params[:search][:item_name]}%", "%#{params[:search][:item_name]}%"], :limit => 5)

    respond_to do |format|
      format.js
    end
  end

  def update_customer_options
    get_popular_items
    @available_customers = Customer.find(:all, :conditions => ['last_name ILIKE ? OR first_name ILIKE ? OR email_address ILIKE ? OR phone_number ILIKE ?', "%#{params[:search][:customer_name]}%","%#{params[:search][:customer_name]}%", "%#{params[:search][:customer_name]}%", "%#{params[:search][:customer_name]}%"], :limit => 5)

    respond_to do |format|
      format.js
    end
  end

  def create_customer_association
    @sale = Sale.find(params[:sale_id])
    unless @sale.blank? || params[:customer_id].blank?
      @sale.customer_id = params[:customer_id]
      @sale.save
    end


    respond_to do |format|
      format.js
    end
  end

  # Add a searched Item
  def create_line_item
    get_popular_items
    existing_line_item = LineItem.where("item_id = ? AND sale_id = ?", params[:item_id], params[:sale_id]).first
    
    if existing_line_item.blank?
      line_item = LineItem.new(:item_id => params[:item_id], :sale_id => params[:sale_id], :quantity => params[:quantity])
      line_item.price = line_item.item.price
      line_item.save

      remove_item_from_stock(params[:item_id], 1)
      update_line_item_totals(line_item)
    else
      existing_line_item.quantity += 1
      existing_line_item.save

      remove_item_from_stock(params[:item_id], 1)
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
    get_popular_items
    @sale = Sale.find(params[:sale_id])

    line_item = LineItem.where(:sale_id => params[:sale_id], :item_id => params[:item_id]).first
    line_item.quantity -= 1
    if line_item.quantity <= 0
      line_item.destroy
    else
      line_item.save
      update_line_item_totals(line_item)
    end

    return_item_to_stock(params[:item_id], 1)

    update_totals

    respond_to do |format|
      format.js
    end
  end

  # Add one Item
  def add_item
    get_popular_items
    @sale = Sale.find(params[:sale_id])

    line_item = LineItem.where(:sale_id => params[:sale_id], :item_id => params[:item_id]).first
    line_item.quantity += 1
    line_item.price = line_item.item.price
    line_item.save

    remove_item_from_stock(params[:item_id], 1)
    update_line_item_totals(line_item)

    update_totals

    respond_to do |format|
      format.js
    end
  end

  def create_custom_item
    get_popular_items
    @sale = Sale.find(params[:sale_id])

    custom_item = Item.new
    custom_item.sku = "CI#{(rand(5..30) + rand(5..30)) * 11}_#{(rand(5..30) + rand(5..30)) * 11}"
    custom_item.name = params[:custom_item][:name]
    custom_item.description = params[:custom_item][:description]
    custom_item.price = params[:custom_item][:price]
    custom_item.stock_amount = params[:custom_item][:stock_amount]

    custom_item.save

    custom_line_item = LineItem.new(:item_id => custom_item.id, :sale_id => @sale.id, :quantity => custom_item.stock_amount, :price => custom_item.price )
    custom_line_item.total_price = custom_item.price * custom_item.stock_amount
    custom_line_item.save

    update_totals

    respond_to do |format|
      format.js
    end
  end

  def create_custom_customer
    get_popular_items
    @sale = Sale.find(params[:sale_id])

    custom_customer = Customer.new
    custom_customer.first_name = params[:custom_customer][:first_name]
    custom_customer.last_name = params[:custom_customer][:last_name]
    custom_customer.email_address = params[:custom_customer][:email_address]
    custom_customer.phone_number = params[:custom_customer][:phone_number]
    custom_customer.address = params[:custom_customer][:address]
    custom_customer.city = params[:custom_customer][:city]
    custom_customer.state = params[:custom_customer][:state]
    custom_customer.zip = params[:custom_customer][:zip]

    custom_customer.save

    @sale.customer_id = custom_customer.id
    @sale.save

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

  # def update_line_item_price
  #   line_item = LineItem.find(params[:line_item_id])
  # end

  def override_price
    @sale = Sale.find(params[:override_price][:sale_id])
    item = Item.where(:sku => params[:override_price][:line_item_sku] ).first
    line_item = LineItem.where(:sale_id => params[:override_price][:sale_id], :item_id => item.id).first
    line_item.price = params[:override_price][:price]
    line_item.save

    update_line_item_totals(line_item)
    update_totals

    respond_to do |format|
      format.js
    end
  end

  def sale_discount
    @sale = Sale.find(params[:sale_discount][:sale_id])

    @sale.discount = params[:sale_discount][:discount]
    @sale.save

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

    tax_amount = get_tax_rate

    @sale ||= Sale.find(params[:sale_id])

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

  def add_comment
    @sale = Sale.find(params[:sale_id])
    @sale.comments = params[:sale_comments][:comments]
    @sale.save

    respond_to do |format|
      format.js
    end
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

    def get_popular_items
      @popular_items = Item.all(:limit => 5)
    end

    def get_popular_customers
      @popular_customers = Customer.all(:limit => 5)
    end

    def remove_item_from_stock(item_id, quantity)
      item = Item.find(item_id)
      item.stock_amount = item.stock_amount - quantity
      item.save
    end

    def return_item_to_stock(item_id, quantity)
      item = Item.find(item_id)
      item.stock_amount = item.stock_amount + quantity
      item.save
    end

    def get_tax_rate
      if @configurations.tax_rate.blank?
        return 0.00
      else
        return @configurations.tax_rate.to_f * 0.01
      end
    end

end
