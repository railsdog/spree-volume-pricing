Spree::LineItem.class_eval do
  # UPGRADE_CHECK this overrides an existing method on LineItem
  def copy_price
    if variant and (
      price.nil? or (
        changed? &&
        changes.keys.include?("quantity")
      )
    )
      self.price = variant.volume_price(quantity)
    end
  end
end

