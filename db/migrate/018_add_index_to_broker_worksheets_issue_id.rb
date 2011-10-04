class AddIndexToBrokerWorksheetsIssueId < ActiveRecord::Migration
  def self.up
    add_index :broker_worksheets, :issue_id, :name => 'by_issue'
  end

  def self.down
    remove_index :broker_worksheets, 'by_issue'
  end
end
