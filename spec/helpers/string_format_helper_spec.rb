require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe StringFormatHelper do
  include StringFormatHelper

  it "should expand loss mitigation codes" do

    descriptions = ["Deed in Lieu",
        "Deed in Lieu",
        "HAFA Deed in Lieu",
        "HAFA Short Sale",
        "Hamp Modification",
        "Hamp Modification",
        "Informal Repayment Plan",
        "Paid In Full",
        "Repayment Plan",
        "Short Sale",
        "Short Sale",
        "None"
    ]

    ["DIL",
     "DIL2",
     "HAFD",
     "HAFS",
     "HAMP",
     "HMPUE",
     "IRP",
     "PAYOFF",
     "RPP",
     "SPO",
     "SS",
      nil].each_with_index do |code, index|
      loss_mitigation_path_in_words(code).
          should eql(descriptions[index])
    end
  end

  it "should expand loss mitigation status codes" do

    descriptions = [ 'Active',
      'Suspended',
      'Suspended',
      'None'
    ]

    ['A',
     'R',
     'S',
     nil
    ].each_with_index do |status, index|
      loss_mitigation_path_status_in_words(status).should eql(descriptions[index])
    end
  end

end