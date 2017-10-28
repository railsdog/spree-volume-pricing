class Spree::VolumePrice < ActiveRecord::Base
  if Gem.loaded_specs['spree_core'].version >= Gem::Version.create('3.3.0')
    belongs_to :variant, touch: true, optional: true
    belongs_to :volume_price_model, touch: true, optional: true
    belongs_to :spree_role, class_name: 'Spree::Role', foreign_key: 'role_id', optional: true
  else
    belongs_to :variant, touch: true
    belongs_to :volume_price_model, touch: true
    belongs_to :spree_role, class_name: 'Spree::Role', foreign_key: 'role_id'
  end

  acts_as_list scope: [:variant_id, :volume_price_model_id]

  validates :amount, presence: true
  validates :discount_type,
            presence: true,
            inclusion: {
              in: %w(price dollar percent),
              message: I18n.t(:'activerecord.errors.messages.is_not_a_valid_volume_price_type', value: self)
            }
  validates :range,
            format: {
              with: /\(?[0-9]+(?:\.{2,3}[0-9]+|\+\)?)/,
              message: I18n.t(:'activerecord.errors.messages.must_be_in_format')
            }

  OPEN_ENDED = /\(?[0-9]+\+\)?/

  def include?(quantity)
    if open_ended?
      bound = /\d+/.match(range)[0].to_i
      return quantity >= bound
    else
      range.to_range === quantity
    end
  end

  # indicates whether or not the range is a true Ruby range or an open ended range with no upper bound
  def open_ended?
    OPEN_ENDED =~ range
  end
end
