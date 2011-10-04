module BrokerConnectPlugin
  class IssueHooks < Redmine::Hook::ViewListener
    def controller_issues_new_after_save(context = {})
      return if not context[:issue].tracker.name.downcase.eql?("broker connect")
      issue = context[:issue]
      issue.create_broker_worksheet((context[:params][:issue][:broker_worksheet] || {}).merge({
                                              :loan_id => issue.loan[:id],
                                              :broker_id => Broker.find_by_name(issue.project.name).andand[:id],
                                              :lead_created_on => issue[:created_on]}))
    end

    def controller_issues_edit_after_save(context = {})
      return if not context[:issue].tracker.name.downcase.eql?("broker connect") or context[:params].andand[:issue].andand[:broker_worksheet].nil?
      context[:issue].broker_worksheet.update_attributes(context[:params][:issue][:broker_worksheet])
    end
  end
end