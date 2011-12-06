Spree::Admin::VariantsController.class_eval do
  update.before :before_update

  respond_override :update => {:html => {
    :success => lambda { redirect_to(@variant.is_master ? volume_prices_admin_product_variant_url(@variant.product, @variant) : collection_url) },
    :failure => lambda { redirect_to(@variant.is_master ? volume_prices_admin_product_variant_url(@variant.product, @variant) : collection_url)  } } }

  def load_resource_instance
    parent

    if new_actions.include?(params[:action].to_sym)
      build_resource
    elsif params[:id]
      Variant.find(params[:id])
    end
  end

  def volume_prices
    @product = @variant.product
  end

  protected
  def before_update
    params[:variant][:volume_prices_attributes] ||= {}
  end
end
