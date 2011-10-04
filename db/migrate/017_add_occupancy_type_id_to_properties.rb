class AddOccupancyTypeIdToProperties < ActiveRecord::Migration
  def self.up
    add_column :properties, :occupancy_type_id, :integer
    add_column :property_versions, :occupancy_type_id, :integer
  end

  def self.down
    remove_column :properties, :occupancy_type_id
    remove_column :property_versions, :occupancy_type_id
  end
end
