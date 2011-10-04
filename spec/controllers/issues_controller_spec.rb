require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IssuesController do
  before(:all) do
    @user = User.find_by_login("brubble") || Factory(:user, :login => "brubble", :admin => 1)
    setup_project_and_tracker_for(@user.login, 
                                  :tracker => 'broker connect', 
                                  :role => {
                                              :name => 'Broker Test Role', 
                                              :permissions => [:add_issues]})
  end
  
  after(:all) do
    cleanup_project_and_tracker
    @user.delete
  end
  
  before(:each) do
    impersonate_user(@user.login)
  end
  
  it "creates and populates broker worksheet" do
    loan = Factory(:loan)
    loan_resolution_specialist = Factory(:loan_resolution_specialist)
    
    post :create, {:issue => {:project_id => @project.id,
                              :tracker_id => @tracker.id,
                              :loan_id => loan.id,
                              :subject => loan.id,
                              :description => 'Testing Broker Connect',
                              :broker_worksheet => {:loan_resolution_specialist_id => loan_resolution_specialist.id,
                                                    :cash_offered => 150}}}

    assigns(:issue).broker_worksheet.should_not be_nil
    assigns(:issue).broker_worksheet.cash_offered.should == 150
    assigns(:issue).broker_worksheet.loan_resolution_specialist.should eql(loan_resolution_specialist)
  end
  
  it "updates broker worksheet" do
      values_to_assign = {  :first_contact_attempted_on => Date.today - 1,
                             :contact_on => Date.today,
                             :contact_relationship => 'Borrower',
                             :occupancy => 'Owner',
                             :desired_modification_path => 'Short Sale',
                             :broker_summary_notes => "Test Notes Test Notes.",
                             :agent_name => Faker::Name::name,
                             :agent_email => Faker::Internet::email,
                             :agent_phone => Faker::PhoneNumber::phone_number,
                             :no_door_answer => true,
                             :ineligible => true}
    loan = Factory(:loan)           
    issue = Factory(:issue, :project_id => @project.id, :tracker_id => @tracker.id, :subject => loan.id)
    broker_worksheet = Factory(:broker_worksheet, :issue_id => issue.id, :loan_id => loan.id)
 
    assert_each_attribute(values_to_assign, broker_worksheet, :assert_not_equal)
    
    post :update, {:id => issue.id, :issue => { :broker_worksheet => values_to_assign }}
    assert_each_attribute(values_to_assign, assigns(:issue).broker_worksheet, :assert_equal)
   end

private

   def assert_each_attribute(attribute_hash, object, comparison = :assert_equal)
     attribute_hash.each_pair do |key,value|
       self.send(comparison, object.send(key), value)
     end
   end
end