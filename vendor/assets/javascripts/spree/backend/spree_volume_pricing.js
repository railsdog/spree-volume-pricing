// spree's version only handles 'input', not 'select', and this breaks spree_volume_pricing

$(function () {
  $('.new_volume_price_row.add_fields').off('click').on('click', function() {
    var target = $(this).data("target");
    var new_table_row = $(target + ' tr:visible:last').clone();
    var new_id = new Date().getTime();
    new_table_row.find("input,select").each(function () {
      var el = $(this);
      el.val("");
      el.attr("id", el.attr("id").replace(/\d+/, new_id))
      el.attr("name", el.attr("name").replace(/\d+/, new_id))
    });
    // When cloning a new row, set the href of all icons to be an empty "#"
    // This is so that clicking on them does not perform the actions for the
    // duplicated row
    new_table_row.find("a").each(function () {
      var el = $(this);
      el.attr('href', '#');
    });
    $(target).prepend(new_table_row);
  });

});