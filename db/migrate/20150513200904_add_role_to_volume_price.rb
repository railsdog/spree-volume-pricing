class AddRoleToVolumePrice < SpreeExtension::Migration[4.2]
  def change
    add_column :spree_volume_prices, :role_id, :integer
  end
end
