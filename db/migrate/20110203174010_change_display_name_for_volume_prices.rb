class ChangeDisplayNameForVolumePrices < SpreeExtension::Migration[4.2]
  def self.up
    rename_column :volume_prices, :display, :name
  end

  def self.down
    rename_column :volume_prices, :name, :display
  end
end
