class CreateBrokers < ActiveRecord::Migration
 def self.up
    create_table :brokers do |t|
      t.string :name, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :brokers
  end
end
