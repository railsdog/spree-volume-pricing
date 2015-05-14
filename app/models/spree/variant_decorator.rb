Spree::Variant.class_eval do
  has_and_belongs_to_many :volume_price_models
  has_many :volume_prices, -> { order(position: :asc) }, dependent: :destroy
  has_many :model_volume_prices,-> { order(position: :asc) }, class_name: "Spree::VolumePrice", through: :volume_price_models, source: :volume_prices
  accepts_nested_attributes_for :volume_prices, allow_destroy: true,
    reject_if: proc { |volume_price|
      volume_price[:amount].blank? && volume_price[:range].blank?
    }

  def join_volume_prices
    table = Spree::VolumePrice.arel_table
    Spree::VolumePrice.where(table[:variant_id].eq(self.id).or(table[:volume_price_model_id].in(self.volume_price_models.ids))).order(position: :asc)
  end

  # calculates the price based on quantity
  def volume_price(quantity, user=nil)
    if self.join_volume_prices.count == 0
      if !(self.product.master.join_volume_prices.count == 0) && Spree::Config.use_master_variant_volume_pricing
        self.product.master.volume_price(quantity, user)
      else
        return self.price
      end
    else
      self.join_volume_prices.each do |volume_price|
        if volume_price.spree_role
          return self.price unless user
          return self.price unless user.has_spree_role? volume_price.spree_role.name.to_sym
        end
        if volume_price.include?(quantity)
          case volume_price.discount_type
          when 'price'
            return volume_price.amount
          when 'dollar'
            return self.price - volume_price.amount
          when 'percent'
            return self.price * (1 - volume_price.amount)
          end
        end
      end
    end

    # No price ranges matched.
    price
  end

  # return percent of earning
  def volume_price_earning_percent(quantity, user=nil)
    if self.join_volume_prices.count == 0
      if !(self.product.master.join_volume_prices.count == 0) && Spree::Config.use_master_variant_volume_pricing
        self.product.master.volume_price_earning_percent(quantity, user)
      else
        return 0
      end
    else
      self.join_volume_prices.each do |volume_price|
        if volume_price.spree_role
          return 0 unless user
          return 0 unless user.has_spree_role? volume_price.spree_role.name.to_sym
        end
        if volume_price.include?(quantity)
          case volume_price.discount_type
          when 'price'
            diff = self.price - volume_price.amount
            return (diff * 100 / self.price).round
          when 'dollar'
            return (volume_price.amount * 100 / self.price).round
          when 'percent'
            return (volume_price.amount * 100).round
          end
        end
      end
    end

    # No price ranges matched.
    0
  end

  # return amount of earning
  def volume_price_earning_amount(quantity, user=nil)
    if self.join_volume_prices.count == 0
      if !(self.product.master.join_volume_prices.count == 0) && Spree::Config.use_master_variant_volume_pricing
        self.product.master.volume_price_earning_amount(quantity, user)
      else
        return 0
      end
    else
      self.join_volume_prices.each do |volume_price|
        if volume_price.spree_role
          return 0 unless user
          return 0 unless user.has_spree_role? volume_price.spree_role.name.to_sym
        end
        if volume_price.include?(quantity)
          case volume_price.discount_type
          when 'price'
            return self.price - volume_price.amount
          when 'dollar'
            return volume_price.amount
          when 'percent'
            return self.price - (self.price * (1 - volume_price.amount))
          end
        end
      end
    end

    # No price ranges matched.
    0
  end
end
