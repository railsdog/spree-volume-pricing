Spree::LineItem.class_eval do
  # pattern grabbed from: http://stackoverflow.com/questions/4470108/

  # the idea here is compatibility with spree_sale_products
  # trying to create a 'calculation stack' wherein the best valid price is
  # chosen for the product. This is mainly for compatibility with spree_sale_products
  #
  # Assumption here is that the volume price currency is the same as the product currency
  old_copy_price = instance_method(:copy_price)
  define_method(:copy_price) do
    old_copy_price.bind(self).call
    return unless variant

    if variant
      if changed? && changes.keys.include?('quantity')
        vprice = variant.volume_price(quantity, order.user)
        if price.present? && vprice <= variant.price
          self.price = vprice and return
        end
      end

      self.price = variant.price if price.nil?
    end

    self.price = variant.price if price.nil?
  end
end
