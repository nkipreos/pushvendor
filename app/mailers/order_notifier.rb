class OrderNotifier < ApplicationMailer
   default :from => 'pedidos@tulonga.cl'

   # send a signup email to the user, pass in the user object that   contains the user's email address
  def send_order_email(customer)
    @customer = customer
#    @mail = customer.last_name
# logger.debug "usuario a enviar email_order_notifier: #{@customer.inspect}"
#logger.debug "usuario a enviar email_order_notifier: #{customer.email_address.inspect}"
   # mail to: customer.select(:email_address), subject: "Thanks for signing up for our amazing app" 
  mail(to: @customer.email_address, subject: 'Tu orden ya esta siendo procesada')
  end
end
