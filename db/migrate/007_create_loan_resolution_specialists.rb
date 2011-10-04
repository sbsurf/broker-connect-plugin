class CreateLoanResolutionSpecialists < ActiveRecord::Migration
 def self.up
    create_table :loan_resolution_specialists do |t|
      t.string :name, :null => false
      t.string :phone, :null => false
      t.string :email, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :loan_resolution_specialists
  end
end
