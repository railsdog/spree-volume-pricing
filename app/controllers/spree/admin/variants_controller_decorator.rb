Spree::Admin::VariantsController.class_eval do
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
