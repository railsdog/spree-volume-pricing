class AddDiscountTypeColumn < ActiveRecord::Migration
  def change
    add_column :spree_volume_prices, :discount_type, :string
  end
end
