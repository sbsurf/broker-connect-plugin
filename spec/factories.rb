#if (not FactoryGirl.registered?("issue"))
  require File.expand_path(File.dirname(__FILE__) + '/../../redmine_loan_core/spec/factories')
#end

#if (not FactoryGirl.registered?("issue_status"))
  Factory.define :issue_status do |is|
    is.name "Open"
  end
#end

Factory.define :broker do |b|
  b.name "Some Broker"
end

Factory.define :broker_worksheet do |b|
end

Factory.define :loan_resolution_specialist do |p|
  p.name Faker::Name::name
  p.phone Faker::PhoneNumber::phone_number
  p.email Faker::Internet::email
end