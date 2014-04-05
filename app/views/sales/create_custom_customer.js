$('#customCustomer').modal('hide');
$('.modal-open').removeClass('modal-open');
$('.modal-backdrop').removeClass('modal-backdrop');
$('.sale_form_details').html("<%= escape_javascript render(:file => 'sales/_form.html.erb') %>");