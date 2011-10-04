require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe BrokerWorksheet do
  fixtures :loan_resolution_specialists
  fixtures :enumerations
  fixtures :brokers
  fixtures :issue_statuses

  before(:all) do
    Loan.delete_all
    Borrower.delete_all
    Tracker.delete_all
    Project.delete_all
    Issue.delete_all

    @loan = Factory(:loan)
    @tracker = Factory(:tracker)
    @project = Factory(:project)
  end
  after(:all) do
    @loan.delete
    @tracker.delete
    @project.trackers.delete_all
    @project.delete
  end
  before(:each) do
    @issue = Factory(:issue, :subject => @loan[:id], :project_id => @project[:id],
                     :tracker_id => @tracker[:id], :priority_id => enumerations(:enumerations_006).id)
  end
  after(:each) do
    BrokerWorksheet.delete_all
    @issue.delete
  end

  it "should create new broker_worksheet from loan" do
    broker_worksheet = BrokerWorksheet.new_from_loan(@issue, @loan, {:broker_worksheet => {}})

    broker_worksheet[:loan_id].should eql @loan[:id]
  end

  it "should find all worksheets with open issues for broker" do
    broker = brokers(:broker_g7)

    loan2 = Factory(:loan)
    issue_status = issue_statuses(:issue_status_closed)
    closed_issue = Factory(:issue, :subject => loan2[:id], :project_id => @project[:id],
                           :status_id => issue_status[:id],
                           :tracker_id => @tracker[:id],
                           :priority_id => enumerations(:enumerations_006).id)


    Factory(:broker_worksheet, :issue_id => @issue[:id], :loan_id => @loan[:id], :broker_id => broker.id)
    Factory(:broker_worksheet, :issue_id => closed_issue[:id], :loan_id => loan2[:id], :broker_id => broker.id)

    broker_worksheets = BrokerWorksheet.broker_worksheets_with_open_issues_for_broker broker

    broker_worksheets.size.should eql(1)
    broker_worksheets.first.issue.closed?.should eql(false)
  end

  it "should find all worksheets for broker" do
    broker = brokers(:broker_g7)
    broker2 = brokers(:broker_lion)

    loan2 = Factory(:loan)
    issue_status = issue_statuses(:issue_status_closed)
    closed_issue = Factory(:issue, :subject => loan2[:id], :project_id => @project[:id],
                           :status_id => issue_status[:id],
                           :tracker_id => @tracker[:id],
                           :priority_id => enumerations(:enumerations_006).id)

    loan3 = Factory(:loan)
    issue3 = Factory(:issue, :subject => loan2[:id], :project_id => @project[:id],
                     :status_id => issue_status[:id],
                     :tracker_id => @tracker[:id],
                     :priority_id => enumerations(:enumerations_006).id)


    Factory(:broker_worksheet, :issue_id => @issue[:id], :loan_id => @loan[:id], :broker_id => broker.id)
    Factory(:broker_worksheet, :issue_id => closed_issue[:id], :loan_id => loan2[:id], :broker_id => broker.id)
    Factory(:broker_worksheet, :issue_id => issue3[:id], :loan_id => loan3[:id], :broker_id => broker2.id)


    broker_worksheets = BrokerWorksheet.broker_worksheets_for_broker broker

    broker_worksheets.size.should eql(2)
    broker_worksheets.first.issue.closed?.should eql(false)
  end

end