class AddDiscountTypeColumn < SpreeExtension::Migration[4.2]
  def change
    add_column :spree_volume_prices, :discount_type, :string
  end
end
