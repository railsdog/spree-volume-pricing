# Configure simeplecov for test coverage report
require 'simplecov'
SimpleCov.start do
  add_filter '/config/'
  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Models', 'app/models'
  add_group 'Overrides', 'app/overrides'
  add_group 'Libraries', 'lib'
  add_group 'Specs', 'spec'
end

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'
require 'ffaker'
require 'shoulda-matchers'

#include spree's factories
require 'spree/testing_support/factories'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/url_helpers'

# include local factories
Dir["#{File.dirname(__FILE__)}/factories/**/*.rb"].each do |f|
  fp =  File.expand_path(f)
  require fp
end

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.include FactoryGirl::Syntax::Methods
  config.include Spree::TestingSupport::UrlHelpers
  config.include Spree::TestingSupport::ControllerRequests
end
