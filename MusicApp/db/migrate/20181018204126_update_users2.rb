class UpdateUsers2 < ActiveRecord::Migration[5.2]
  def change
    add_index :bands, :band_id, unique: true
  end
end
