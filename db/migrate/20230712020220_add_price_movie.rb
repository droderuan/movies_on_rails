class AddPriceMovie < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :price_per_day, :float
  end
end
