class CreateBrokerContactResponseTypes < ActiveRecord::Migration
 def self.up
    create_table :broker_contact_response_types do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :broker_contact_response_types
  end
end