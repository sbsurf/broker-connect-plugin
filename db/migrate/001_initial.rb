class Initial < ActiveRecord::Migration
  def self.up
    create_table :broker_worksheets do |t|
      t.integer :issue_id, :null => false

      t.integer :loan_id, :null => false

  

    
      t.timestamps
    end
  end

  def self.down
    drop_table :broker_worksheets
  end
end
