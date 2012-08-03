Spree::LineItem.class_eval do
  # pattern grabbed from: http://stackoverflow.com/questions/4470108/

  # the idea here is compatibility with spree_sale_products
  # trying to create a 'calculation stack' wherein the best valid price is
  # chosen for the product. This is mainly for compatibility with spree_volume_pricing

  old_copy_price = instance_method(:copy_price)
  define_method(:copy_price) do
    new_price = old_copy_price.bind(self).()

    if variant and changed? and changes.keys.include? 'quantity'
      vprice = self.variant.volume_price self.quantity
      self.price = vprice if (!new_price.nil? and vprice < new_price) or vprice < self.price
    else
      if new_price.nil?
        self.price = self.variant.price
      else
        self.price = new_price
      end
    end
  end
end

