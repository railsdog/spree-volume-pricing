class PrefixVolumePricingTableNames < ActiveRecord::Migration
  def change
    rename_table :volume_prices, :spree_volume_prices unless Spree::VolumePrice.table_exists?
  end
end
