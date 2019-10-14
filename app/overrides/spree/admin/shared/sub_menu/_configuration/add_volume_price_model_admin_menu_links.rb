Deface::Override.new(
  virtual_path:  'spree/admin/shared/configuration',
  name:          'add_volume_price_model_admin_menu_links',
  insert_bottom: "[data-hook='admin_configurations_sidebar_menu'], #admin_configurations_sidebar_menu[data-hook]",
  text:          <<-HTML
                  <%= configurations_sidebar_menu_item Spree.t('volume_price_models'), admin_volume_price_models_path if can? :admin, Spree::VolumePriceModel %>
                 HTML
)
