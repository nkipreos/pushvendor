class OrderNotifier < ApplicationMailer
   default :from => 'pedidos@tulonga.cl'

   # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_order_email(customer, sale_id)
    @customer = customer
    mail(to: customer['email_address'], subject: "#{customer['first_name']} Tu Orden ya Está Siendo Procesada")
  end
end
  