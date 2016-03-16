class OrderNotifier < ApplicationMailer
  default from: "\"[Tulonga] Pedidos\" <pedidos@tulonga.cl>"

  def send_order_email(customer, sale_id)
    @customer = customer
    @sale = Sale.find(sale_id)
    @items = @sale.items
    @sale_items = @sale.line_items
    mail(from:"\"[Tulonga] Pedidos\" <pedidos@tulonga.cl>", to: customer['email_address'], bcc: ['pedidos@tulonga'], subject: "#{customer['first_name']} Tu Orden ya Está Siendo Procesada")
  end
end
  
