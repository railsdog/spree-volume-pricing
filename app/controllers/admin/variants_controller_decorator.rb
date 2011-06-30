Admin::VariantsController.class_eval do
  update.before do
    params[:variant][:volume_prices_attributes] ||= {}
  end

  respond_override :update => {:html => {
    :succes => lambda { redirect_to(@variant.is_master ? volume_prices_admin_product_variant_url(@variant.product, @variant) : collection_url) },
    :failure => lambda { redirect_to(@variant.is_master ? volume_prices_admin_product_variant_url(@variant.product, @variant) : collection_url)  } } }

  def load_resource_instance 
    parent
    Variant.find(params[:id]) 
  end

  def volume_prices
    @product = @variant.product
  end
end
