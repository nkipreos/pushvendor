$(document).ready(function(){

	$('.item_search_input').on("keypress", function(){
	  $('.item_search').click();
	});

	$('.customer_search_input').on("keypress", function(){
	  $('.customer_search').click();
	});

	$(document).on("change", '.sale_discount', function(){
	  $('.sale_submit').click();
	});	

	$(document).on("change", '.price_control', function(){
	  $('.sale_submit').click();
	});


});
