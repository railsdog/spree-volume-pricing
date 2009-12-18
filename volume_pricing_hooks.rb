class VolumePricingHooks < Spree::ThemeSupport::HookListener

  insert_after :admin_product_tabs, :partial => "admin/shared/vp_product_tab"

  insert_after :admin_variant_edit_form, :partial => "admin/variants/edit_fields"

end
