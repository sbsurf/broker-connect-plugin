class AddFieldsToForeclosures < ActiveRecord::Migration
  def self.up
    add_column :foreclosures, :next_action_description, :string
    add_column :foreclosures, :sale_completed_on, :date
    add_column :foreclosures, :sale_scheduled_on, :date
    add_column :foreclosures, :default_on, :date
  end

  def self.down
    remove_column :foreclosures, :next_action_description
    remove_column :foreclosures, :sale_completed_on
    remove_column :foreclosures, :sale_scheduled_on
    remove_column :foreclosures, :default_on
  end
end
