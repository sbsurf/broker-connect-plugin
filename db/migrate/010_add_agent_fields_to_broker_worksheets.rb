class AddAgentFieldsToBrokerWorksheets < ActiveRecord::Migration
  def self.up
    add_column :broker_worksheets, :agent_name, :string
    add_column :broker_worksheets, :agent_email, :string
    add_column :broker_worksheets, :agent_phone, :string
  end

  def self.down
    remove_column :broker_worksheets, :agent_name
    remove_column :broker_worksheets, :agent_email
    remove_column :broker_worksheets, :agent_phone
  end
end
