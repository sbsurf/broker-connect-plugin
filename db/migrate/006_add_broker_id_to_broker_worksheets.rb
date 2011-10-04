class AddBrokerIdToBrokerWorksheets < ActiveRecord::Migration
  def self.up
    add_column :broker_worksheets, :broker_id, :integer
  end

  def self.down
    remove_column :broker_worksheets, :broker_id
  end
end
