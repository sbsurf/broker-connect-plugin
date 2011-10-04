module BrokerConnect
  module IssuesControllerPatch
    def self.included(base)
      base.send(:include, ClassMethods)
      base.send(:include, InstanceMethods)
    
      base.class_eval do
        unloadable

        before_filter :find_broker_worksheet, :only => [:show, :edit]
      end
    end
  
    module ClassMethods
    end
  
    module InstanceMethods
      def find_broker_worksheet
        @broker_worksheet = BrokerWorksheet.find_by_issue_id(@issue[:id])
      end
    end
  end
end