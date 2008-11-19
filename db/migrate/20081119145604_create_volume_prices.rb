class CreateVolumePrices < ActiveRecord::Migration
  def self.up
    create_table :volume_prices do |t|
      t.references :variant
      t.string :display
      t.string :range
      t.decimal :amount, :precision => 8, :scale => 2
      t.integer :position
      t.timestamps
    end
  end

  def self.down
    drop_table :volume_prices
  end
end
