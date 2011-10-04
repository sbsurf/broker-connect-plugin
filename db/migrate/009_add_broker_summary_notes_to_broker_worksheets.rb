class AddBrokerSummaryNotesToBrokerWorksheets < ActiveRecord::Migration
  def self.up
    change_column :broker_worksheets, :broker_summary_notes, :text, :limit => 1024
  end

  def self.down
    change_column :broker_worksheets, :broker_summary_notes, :string
  end
end
