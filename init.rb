require 'redmine'
require 'broker_connect/redmine/patches'
require 'broker_connect/redmine/hooks'


ActionController::Base.helper StringFormatHelper
ActionController::Base.helper DelinquencyOrReoHelper
ActionController::Base.helper AttachmentsHelper


Redmine::Plugin.register :redmine_broker_connect do
  name 'Redmine Broker Connect plugin'
  author 'Yuri Rivkind'
  description 'This is a plugin to provide broker/agents a loan/property/borrower view and questionnaire'
  version '1.0.0'

  requires_redmine :version_or_higher => '0.9.0'
  requires_redmine_plugin :redmine_extended_core, :version_or_higher => '1.0.7'
  requires_redmine_plugin :redmine_extended_tracker, :version_or_higher => '0.0.3'
  requires_redmine_plugin :redmine_loan_core, :version_or_higher => '0.0.8'

  project_module :broker_connect do
    permission :update_issue_status, :issues => [:update_status]
  end

  register_view_delegate :broker_worksheet

  register_column_filter :agent_name, {:display => {:type => :text, :order => 1170,
                                                    :query => {
                                                        :db_table => BrokerWorksheet.table_name,
                                                        :db_field => :agent_name}},
                                       :groupable => true,
                                       :conditional => lambda { |project| project.andand.module_enabled?('broker_connect') },
                                       :association => [:broker_worksheet],
                                       :association_path => 'issue.andand.broker_worksheet.andand.agent_name'
  }

  register_column_filter :agent_phone, {:display => {:type => :text, :order => 1180,
                                                     :query => {
                                                         :db_table => BrokerWorksheet.table_name,
                                                         :db_field => :agent_phone}},
                                        :groupable => true,
                                        :conditional => lambda { |project| project.andand.module_enabled?('broker_connect') },
                                        :association => [:broker_worksheet],
                                        :association_path => 'issue.andand.broker_worksheet.andand.agent_phone'
  }

  register_column_filter :agent_email, {:display => {:type => :text, :order => 1190,
                                                     :query => {
                                                         :db_table => BrokerWorksheet.table_name,
                                                         :db_field => :agent_email}},
                                        :groupable => true,
                                        :conditional => lambda { |project| project.andand.module_enabled?('broker_connect') },
                                        :association => [:broker_worksheet],
                                        :association_path => 'issue.andand.broker_worksheet.andand.agent_email'
  }

  register_column_filter :lead_created_on, {:display => {:type => :date, :order => 1200,
                                                         :query => {
                                                             :db_table => BrokerWorksheet.table_name,
                                                             :db_field => :lead_created_on}},
                                            :groupable => true,
                                            :conditional => lambda { |project| project.andand.module_enabled?('broker_connect') },
                                            :association => [:broker_worksheet],
                                            :association_path => 'issue.andand.broker_worksheet.andand.lead_created_on'
  }

  register_column_filter :occupancy_type, {:display => {:type => :list, :order => 1210,
                                                        :values => OccupancyType.find(:all,
                                                                                      :order => :name).collect { |occupancy_type| [occupancy_type.name] },
                                                        :query => {
                                                            :db_table => OccupancyType.table_name,
                                                            :db_field => :name}},
                                           :groupable => true,
                                           :conditional => lambda { |project| project.andand.module_enabled?('broker_connect') },
                                           :association => [{:broker_worksheet => [:occupancy_type]}],
                                           :association_path => 'issue.andand.broker_worksheet.andand.occupancy_type.andand.name'
  }

  register_column_filter :first_contact_attempted_on, {:display => {:type => :date, :order => 1220,
                                                                    :query => {
                                                                        :db_table => BrokerWorksheet.table_name,
                                                                        :db_field => :first_contact_attempted_on}},
                                                       :groupable => true,
                                                       :conditional => lambda { |project| project.andand.module_enabled?('broker_connect') },
                                                       :association => [:broker_worksheet],
                                                       :association_path => 'issue.andand.broker_worksheet.andand.first_contact_attempted_on'
  }

  register_column_filter :contact_on, {:display => {:type => :date, :order => 1230,
                                                    :query => {
                                                        :db_table => BrokerWorksheet.table_name,
                                                        :db_field => :contact_on}},
                                       :groupable => true,
                                       :conditional => lambda { |project| project.andand.module_enabled?('broker_connect') },
                                       :association => [:broker_worksheet],
                                       :association_path => 'issue.andand.broker_worksheet.andand.contact_on'
  }

  register_column_filter :contact_relationship_type, {:display => {:type => :list, :order => 1240,
                                                                   :values => ContactRelationshipType.find(:all,
                                                                                                           :order => :name).collect { |contact_relationship_type| [contact_relationship_type.name] },
                                                                   :query => {
                                                                       :db_table => ContactRelationshipType.table_name,
                                                                       :db_field => :name}},
                                                      :groupable => true,
                                                      :conditional => lambda { |project| project.andand.module_enabled?('broker_connect') },
                                                      :association => [{:broker_worksheet => [:contact_relationship_type]}],
                                                      :association_path => 'issue.andand.broker_worksheet.andand.contact_relationship_type.andand.name'
  }

  register_column_filter :broker_contact_response_type, {:display => {:type => :list, :order => 1250,
                                                                      :values => BrokerContactResponseType.find(:all,
                                                                                                                :order => :name).collect { |broker_contact_response_type| [broker_contact_response_type.name] },
                                                                      :query => {
                                                                          :db_table => BrokerContactResponseType.table_name,
                                                                          :db_field => :name}},
                                                         :groupable => true,
                                                         :conditional => lambda { |project| project.andand.module_enabled?('broker_connect') },
                                                         :association => [{:broker_worksheet => [:broker_contact_response_type]}],
                                                         :association_path => 'issue.andand.broker_worksheet.andand.broker_contact_response_type.andand.name'
  }

  register_column_filter :cash_offered, {:display => {:type => :integer, :order => 1260,
                                                      :query => {
                                                          :db_table => BrokerWorksheet.table_name,
                                                          :db_field => :cash_offered}},
                                         :groupable => true,
                                         :conditional => lambda { |project| project.andand.module_enabled?('broker_connect') },
                                         :association => [:broker_worksheet],
                                         :association_path => 'issue.andand.broker_worksheet.andand.cash_offered'
  }

  register_column_filter :broker_summary_notes, {:display => {:type => :text, :order => 1270,
                                                              :query => {
                                                                  :db_table => BrokerWorksheet.table_name,
                                                                  :db_field => :broker_summary_notes}},
                                                 :groupable => true,
                                                 :conditional => lambda { |project| project.andand.module_enabled?('broker_connect') },
                                                 :association => [:broker_worksheet],
                                                 :association_path => 'issue.andand.broker_worksheet.andand.broker_summary_notes',
                                                 :export_only => true
  }

  register_column_filter :loan_resolution_specialist, {:display => {:type => :list, :order => 1280,
                                                                    :values => LoanResolutionSpecialist.find(:all,
                                                                                                             :order => :name).collect { |specialist| [specialist.name] },
                                                                    :query => {
                                                                        :db_table => LoanResolutionSpecialist.table_name,
                                                                        :db_field => :name}},
                                                       :groupable => true,
                                                       :conditional => lambda { |project| project.andand.module_enabled?('broker_connect') },
                                                       :association => [{:broker_worksheet => [:loan_resolution_specialist]}],
                                                       :association_path => 'issue.andand.broker_worksheet.andand.loan_resolution_specialist.andand.name'
  }

end
