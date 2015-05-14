class AddRoleToVolumePrice < ActiveRecord::Migration
  def change
    add_column :spree_volume_prices, :role_id, :integer
  end
end
