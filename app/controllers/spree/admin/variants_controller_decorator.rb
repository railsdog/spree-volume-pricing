Spree::Admin::VariantsController.class_eval do
  respond_override :update => {:html => {
    :success => lambda { redirect_to(@variant.is_master ? volume_prices_admin_product_variant_url(@variant.product, @variant) : collection_url) },
    :failure => lambda { redirect_to(@variant.is_master ? volume_prices_admin_product_variant_url(@variant.product, @variant) : collection_url)  } } }

  def load_resource_instance
    parent

    if new_actions.include?(params[:action].to_sym)
      build_resource
    elsif params[:id]
      ::Spree::Variant.find(params[:id])
    end
  end

  def volume_prices
    @product = @variant.product
  end
end
