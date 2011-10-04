class AddFieldsToBrokerWorksheets < ActiveRecord::Migration
  def self.up
    add_column :broker_worksheets, :negotiator_name, :string
    add_column :broker_worksheets, :negotiator_phone, :string
    add_column :broker_worksheets, :lead_created_on, :date
    add_column :broker_worksheets, :lead_status, :string
    add_column :broker_worksheets, :cash_offered, :float
  end

  def self.down
    remove_column :broker_worksheets, :negotiator_name
    remove_column :broker_worksheets, :negotiator_phone
    remove_column :broker_worksheets, :lead_created_on
    remove_column :broker_worksheets, :lead_status
    remove_column :broker_worksheets, :cash_offered
  end
end
