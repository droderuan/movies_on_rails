class AddFieldsRental < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :total, :float
    add_column :rentals, :returned_at, :timestamp
    add_column :rentals, :expires_at, :timestamp
  end
end
