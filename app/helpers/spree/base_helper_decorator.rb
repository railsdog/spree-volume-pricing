Spree::BaseHelper.class_eval do 
  def display_volume_price(variant, quantity = 1)
    Spree::Money.new(variant.volume_price(quantity), { currency: Spree::Config[:currency] }).to_html
  end

  def display_volume_price_earning_percent(variant, quantity = 1)
    variant.volume_price_earning_percent(quantity).round.to_s
  end

  def display_volume_price_earning_amount(variant, quantity = 1)
    Spree::Money.new(variant.volume_price_earning_amount(quantity), { currency: Spree::Config[:currency] }).to_html
  end
end