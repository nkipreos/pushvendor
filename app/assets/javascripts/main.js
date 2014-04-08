$(document).ready(function(){

	$(document).on("keypress", '.item_search_input', function(){
	  $('.item_search').click();
	});

	$(document).on("keypress", '.customer_search_input', function(){
	  $('.customer_search').click();
	});

	$(document).on("change", "#sale_comments_comments", function(){
		$('.sale_comments').click();
	});


	$(document).on("change", "#line_item_price", function(){
		$.ajax({
      type: "POST",
      url: '/sales/override_price', //sumbits it to the given url of the form
      data: {override_price: { price: $(this).val(), line_item_sku: $(this).parent().parent().find('.line_item_sku').val(), sale_id: $(document).find('.sale_id').html() }},
      dataType: "script",
      success: function() {
      	console.log('price updated');
      }
    });
  	// alert('price');
	});

	$(document).on("change", "#sale_discount", function(){
		$.ajax({
      type: "POST",
      url: '/sales/sale_discount', //sumbits it to the given url of the form
      data: {sale_discount: { discount: $(this).val(), sale_id: $(document).find('.sale_id').html() }},
      dataType: "script",
      success: function() {
      	console.log('sale discounted');
      }
    });
  	// alert('price');
	});


	// Jquery form validations
	$(".form_custom_item").validate({
		rules: {
			"custom_item[name]": {required: true },
			"custom_item[price]": {required: true, number: true},
			"custom_item[stock_amount]": {required: true, number: true}
		}
	});

	$(".edit_sale").validate({
		rules: {
			"line_item[price]": {required: true, number: true }
		}
	});

});
