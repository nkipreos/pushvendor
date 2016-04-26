$(document).ready(
  function(){
    $("#supplier_tax_id").blur(
      function(){
        field_value = $("#supplier_tax_id").val().replace('.','').replace('-','')
        if(field_value == ""){ return false; }
        tax_id = field_value.slice(0,-1).replace(/\B(?=(\d{3})+(?!\d))/g, ".");
        vd = field_value.slice(-1)
        $("#supplier_tax_id").val(tax_id + '-' + vd)
      }
    );
  }
);