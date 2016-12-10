class AddColorToStations < ActiveRecord::Migration[5.0]
  def change
    add_column :stations, :color, :string
  end
end
