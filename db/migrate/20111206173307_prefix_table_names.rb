class PrefixTableNames < ActiveRecord::Migration
  def change
    rename_table :volume_prices, :spree_volume_prices
  end
end

