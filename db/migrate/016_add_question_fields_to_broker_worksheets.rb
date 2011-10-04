class AddQuestionFieldsToBrokerWorksheets < ActiveRecord::Migration
  def self.up
    add_column :broker_worksheets, :contact_relationship_type_id, :integer
    add_column :broker_worksheets, :occupancy_type_id, :integer
    add_column :broker_worksheets, :broker_contact_response_type_id, :integer
  end

  def self.down
    remove_column :broker_worksheets, :contact_relationship_type_id
    remove_column :broker_worksheets, :occupancy_type_id
    remove_column :broker_worksheets, :broker_contact_response_type_id
  end
end
