require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IssuesController do
  fixtures :loan_resolution_specialists

  before(:all) do
    @bw = BrokerWorksheet.new({:loan_resolution_specialist_id => loan_resolution_specialists(:maria_felix).id,
                               :cash_offered => 150}).save
  end

  describe "POST 'update_broker_sidebar'" do
    it "updates resolution specialist" do
      bw = BrokerWorksheet.find(@bw.id)

      post :update_broker_sidebar,
           :broker_worksheet => {:id => bw[:id],
                                 :loan_resolution_specialist_id => loan_resolution_specialists(:evan_tuchman).id}

      bw = BrokerWorksheet.find(@bw.id)

      bw.loan_resolution_specialist_id.should eql loan_resolution_specialists(:evan_tuchman).id

    end
  end
end