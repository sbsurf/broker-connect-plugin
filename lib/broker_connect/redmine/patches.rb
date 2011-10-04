require 'dispatcher'
require 'broker_connect/redmine/patches/issues_controller_patch'
require 'broker_connect/redmine/patches/issue_model_patch'

Dispatcher.to_prepare do
  unless IssuesController.included_modules.include? BrokerConnect::IssuesControllerPatch
    IssuesController.send(:include, BrokerConnect::IssuesControllerPatch)
  end
  unless Issue.included_modules.include? BrokerConnect::IssueModelPatch
    Issue.send(:include, BrokerConnect::IssueModelPatch)
  end
end