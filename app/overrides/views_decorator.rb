Deface::Override.new(
  virtual_path: 'spree/admin/shared/_product_tabs',
  name: 'add_volume_pricing_admin_tab',
  insert_bottom: '[data-hook="admin_product_tabs"]',
  partial: 'spree/admin/shared/vp_product_tab'
)

Deface::Override.new(
  virtual_path: 'spree/admin/variants/edit',
  name: 'add_volume_pricing_field_to_variant',
  insert_after: '[data-hook="admin_variant_edit_form"]',
  partial: 'spree/admin/variants/edit_fields'
)

Deface::Override.new(
  virtual_path:  'spree/admin/shared/sub_menu/_configuration',
  name:          'add_volume_price_model_admin_menu_links',
  insert_bottom: "[data-hook='admin_configurations_sidebar_menu']",
  text:          <<-HTML
                  <%= configurations_sidebar_menu_item Spree.t('volume_price_models'), admin_volume_price_models_path if can? :admin, Spree::VolumePriceModel %>
                 HTML
)
