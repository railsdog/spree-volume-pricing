//= require spree/backend

// spree's version only handles 'input', not 'select', and this breaks spree_volume_pricing

$(function () {
  $('#add_volume_price').click( function() {
    var target = $(this).data("target"),
      new_table_row = $(target + ' tr:visible:first');
    new_table_row.find('div.select2').remove();
    $('select.select2').select2({
      allowClear: true,
      dropdownAutoWidth: true
    });
  });

});
