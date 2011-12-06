Spree::Variant.class_eval do 
  has_many :volume_prices, :order => :position, :dependent => :destroy
  accepts_nested_attributes_for :volume_prices, :allow_destroy => true

  # calculates the price based on quantity
  def volume_price(quantity)
    volume_prices.each do |price|
      return price.amount if price.include?(quantity)
    end
    self.price
  end

end
