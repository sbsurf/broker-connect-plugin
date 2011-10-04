class CreateOccupancyTypes < ActiveRecord::Migration
 def self.up
    create_table :occupancy_types do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :occupancy_types
  end
end