$(document).ready(function(){


	$('.add_line_item').click(function(){
		row = $('.sale_line_items').find('.row').length;

		$('.sale_line_items').append("<div class='row'><div class='col-sm-2'><label>Sku</label><input class='form-control' id='sale_items_attributes_" + row + "_sku' name='sale[items_attributes][" + row + "][sku]' placeholder='SKU' type='text' /></div><div class='col-sm-3'><label>Item</label><input class='form-control' id='sale_items_attributes_" + row + "_name' name='sale[items_attributes][" + row + "][name]' placeholder='Item' type='text' /></div><div class='col-sm-3'><label>Description</label><input class='form-control' id='sale_items_attributes_" + row + "_description' name='sale[items_attributes][" + row + "][description]' placeholder='Description' type='text' /></div><div class='col-sm-2'><label>Price</label><input class='form-control' id='sale_items_attributes_" + row + "_price' name='sale[items_attributes][" + row + "][price]' placeholder='Price' type='text' /></div><div class='col-sm-2'><label>Quantity</label><input class='form-control' id='sale_items_attributes_" + row + "_price' name='sale[items_attributes][" + row + "][price]' placeholder='Quantity' type='text' /></div></div>");
	});


});
