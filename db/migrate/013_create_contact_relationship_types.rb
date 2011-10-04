class CreateContactRelationshipTypes < ActiveRecord::Migration
 def self.up
    create_table :contact_relationship_types do |t|
      t.string :name, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_relationship_types
  end
end