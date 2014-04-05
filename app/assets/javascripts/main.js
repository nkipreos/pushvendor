$(document).ready(function(){

	$(document).on("keypress", '.item_search_input', function(){
	  $('.item_search').click();
	});

	$(document).on("keypress", '.customer_search_input', function(){
	  $('.customer_search').click();
	});

	$(document).on("click", '.close_custom_modal', function(){
		$('#customItem').modal('hide');
	});


	$(document).on("change", "#line_item_price", function(){
		$.ajax({
	        type: "POST",
	        url: '/sales/', //sumbits it to the given url of the form
	        data: valuesToSubmit,
	        dataType: "JSON" 
	    }).success(function(data){
	          alert('changed');
	    });
	});


});
