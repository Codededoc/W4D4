class UpdateBands3 < ActiveRecord::Migration[5.2]
  def change
    remove_column :bands, :band_id

    add_column :bands, :user_id, :integer, unique: true
    add_index :bands, :user_id, unique: true
  end
end
