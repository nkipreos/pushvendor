class OrderNotifier < ApplicationMailer

  def send_order_email(customer, sale_id)
    @customer = customer
    @items = Sale.find(sale_id).items
    mail(to: customer['email_address'], subject: "#{customer['first_name']} Tu Orden ya Está Siendo Procesada")
  end
end
  