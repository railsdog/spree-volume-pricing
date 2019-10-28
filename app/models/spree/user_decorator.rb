module Spree::UserDecorator
  def resolve_role
    if self.has_spree_role? Spree::Config.volume_pricing_role.to_sym
      return Spree::Role.find_by name: Spree::Config.volume_pricing_role
    else
      return Spree::Role.find_by name: 'user'
    end
  end
end

Spree.user_class.prepend Spree::UserDecorator
