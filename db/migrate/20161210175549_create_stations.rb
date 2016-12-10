class CreateStations < ActiveRecord::Migration[5.0]
  def change
    create_table :stations do |t|
      t.integer :map_id
      t.integer :stop_id
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
