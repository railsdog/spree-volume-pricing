class ChangeIdColumnsTypesForSpreeVolumePrices < ActiveRecord::Migration[4.2]
  def change
    change_table(:spree_volume_prices) do |t|
      t.change :variant_id, :bigint
      t.change :role_id, :bigint
      t.change :volume_price_model_id, :bigint
    end
  end
end
