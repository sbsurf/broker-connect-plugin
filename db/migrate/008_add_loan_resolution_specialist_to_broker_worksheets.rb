class AddLoanResolutionSpecialistToBrokerWorksheets < ActiveRecord::Migration
  def self.up
    add_column :broker_worksheets, :loan_resolution_specialist_id, :integer
  end

  def self.down
    remove_column :broker_worksheets, :loan_resolution_specialist_id
  end
end
