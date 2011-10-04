class BrokerWorksheet < ActiveRecord::Base
  belongs_to :issue
  belongs_to :loan
  belongs_to :broker
  belongs_to :loan_resolution_specialist, :foreign_key => :loan_resolution_specialist_id
  belongs_to :contact_relationship_type
  belongs_to :occupancy_type
  belongs_to :broker_contact_response_type

  class << self
    def broker_worksheets_with_open_issues_for_broker broker
      broker_worksheets = broker_worksheets_for_broker broker
      broker_worksheets.delete_if { |broker_worksheet| broker_worksheet.issue.status.is_closed? }
    end

    def broker_worksheets_for_broker broker
      BrokerWorksheet.find(:all, :conditions => {:broker_id => broker[:id]})
    end
  end
end