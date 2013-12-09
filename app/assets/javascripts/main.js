$(document).ready(function(){

	$('.item_search_input').on("keypress", function(){
	  $('.item_search').click();
	});

	$('#sale_discount').on("change", function(){
	  $('.sale_submit').click();
	});	

	$('.price_control').on("change", function(){
	  $('.sale_submit').click();
	});	


});
