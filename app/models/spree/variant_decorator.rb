Spree::Variant.class_eval do
  has_many :volume_prices, -> { order(position: :asc) }, dependent: :destroy
  accepts_nested_attributes_for :volume_prices, allow_destroy: true,
    reject_if: proc { |volume_price|
      volume_price[:amount].blank? && volume_price[:range].blank?
    }

  # calculates the price based on quantity
  def volume_price(quantity)
    return price if volume_prices.count == 0

    volume_prices.each do |volume_price|
      next unless volume_price.include?(quantity)
      case volume_price.discount_type
      when 'price'
        return volume_price.amount
      when 'dollar'
        return price - volume_price.amount
      when 'percent'
        return price * (1 - volume_price.amount)
      end
    end

    # No price ranges matched.
    price
  end

  # return percent of earning
  def volume_price_earning_percent(quantity)
    return 0 if volume_prices.count == 0

    volume_prices.each do |volume_price|
      next unless volume_price.include?(quantity)
      case volume_price.discount_type
      when 'price'
        diff = price - volume_price.amount
        return (diff * 100 / price).round
      when 'dollar'
        return (volume_price.amount * 100 / price).round
      when 'percent'
        return (volume_price.amount * 100).round
      end
    end

    # No price ranges matched.
    0
  end

  # return amount of earning
  def volume_price_earning_amount(quantity)
    return 0 if volume_prices.count == 0

    volume_prices.each do |volume_price|
      next unless volume_price.include?(quantity)
      case volume_price.discount_type
      when 'price'
        return price - volume_price.amount
      when 'dollar'
        return volume_price.amount
      when 'percent'
        return price - (price * (1 - volume_price.amount))
      end
    end

    # No price ranges matched.
    0
  end
end
