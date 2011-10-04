class ChangeBrokerWorksheetLoanIdDatatype < ActiveRecord::Migration
  def self.up
    change_column :broker_worksheets, :loan_id, :bigint
  end
  def self.down
    change_column :broker_worksheets, :loan_id, :int
  end
end