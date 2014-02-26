$(document).ready(function(){

	$(document).on("keypress", '.item_search_input', function(){
	  $('.item_search').click();
	});

	$(document).on("keypress", '.customer_search_input', function(){
	  $('.customer_search').click();
	});

	// $('.sale_totals').on("change", '.sale_discount', function(){
	//   $('.sale_submit').click();
	// });	

	// $('.edit_sale').on("change", '.price_control', function(){
	//   $('.sale_submit').click();
	// });


});
