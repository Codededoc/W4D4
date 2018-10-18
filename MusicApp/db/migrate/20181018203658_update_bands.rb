class UpdateBands < ActiveRecord::Migration[5.2]
  def change
    add_column :bands, :band_id, :integer, null: false
  end
end
