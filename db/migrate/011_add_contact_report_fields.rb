class AddContactReportFields < ActiveRecord::Migration
  def self.up
    add_column :broker_worksheets, :no_door_answer, :boolean, :default => false, :null => false
    add_column :broker_worksheets, :ineligible, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :broker_worksheets, :no_door_answer
    remove_column :broker_worksheets, :ineligible
  end
end