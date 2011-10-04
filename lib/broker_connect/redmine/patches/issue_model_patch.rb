module BrokerConnect
  module IssueModelPatch
    def self.included(base)
      base.class_eval do
        unloadable
        
        has_one :broker_worksheet
        accepts_nested_attributes_for :broker_worksheet
      end
    end
  end
end