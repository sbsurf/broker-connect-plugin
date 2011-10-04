class AddContactResultsToBrokerWorksheets < ActiveRecord::Migration
  def self.up
    add_column :broker_worksheets, :occupancy, :string
    add_column :broker_worksheets, :first_contact_attempted_on, :date
    add_column :broker_worksheets, :contact_on, :date
    add_column :broker_worksheets, :contact_relationship, :string
    add_column :broker_worksheets, :desired_modification_path, :string
    add_column :broker_worksheets, :broker_summary_notes, :string
  end

  def self.down
    remove_column :broker_worksheets, :occupancy
    remove_column :broker_worksheets, :first_contact_attempted_on
    remove_column :broker_worksheets, :contact_on
    remove_column :broker_worksheets, :contact_relationship
    remove_column :broker_worksheets, :desired_modification_path
    remove_column :broker_worksheets, :broker_summary_notes
  end
end
