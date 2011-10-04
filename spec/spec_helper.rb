# Load the normal Rails helper
require File.expand_path(File.dirname(__FILE__) + '/../../../../spec/spec_helper')

# Ensure that we are using the temporary fixture path
Engines::Testing.set_fixture_path
require 'spec'
require 'spec/rails'
require 'factory_girl'
require 'faker'

require File.dirname(__FILE__) + "/factories"

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = File.dirname(__FILE__) + '/fixtures/'
end