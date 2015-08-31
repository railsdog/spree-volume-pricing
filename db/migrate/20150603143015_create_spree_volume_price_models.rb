class CreateSpreeVolumePriceModels < ActiveRecord::Migration
  def change
    create_table :spree_volume_price_models do |t|
      t.string :name
      t.timestamps
    end

    create_table :spree_variants_volume_price_models do |t|
      t.belongs_to :volume_price_model
      t.belongs_to :variant
    end

    add_reference :spree_volume_prices, :volume_price_model

    add_index :spree_variants_volume_price_models, :volume_price_model_id, name: 'volume_price_model_id'
    add_index :spree_variants_volume_price_models, :variant_id, name: 'variant_id'
  end
end
