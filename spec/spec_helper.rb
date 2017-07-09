# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require 'simplecov'
SimpleCov.start

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.extend ControllerMacros, :type => :controller
  config.include LoginMacros, :type => :feature
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

Capybara::Webkit.configure do |config|
    # Enable debug mode. Prints a log of everything the driver is doing.
#  config.debug = true

# # By default, requests to outside domains (anything besides localhost) will
# # result in a warning. Several methods allow you to change this behavior.

# # Silently return an empty 200 response for any requests to unknown URLs.
# config.block_unknown_urls

# # Allow pages to make requests to any URL without issuing a warning.
# config.allow_unknown_urls

# # Allow a specific domain without issuing a warning.
# config.allow_url("example.com")

# # Allow a specific URL and path without issuing a warning.
# config.allow_url("example.com/some/path")

# # Wildcards are allowed in URL expressions.
# config.allow_url("*.example.com")

# # Silently return an empty 200 response for any requests to the given URL.
# config.block_url("example.com")

# # Timeout if requests take longer than 5 seconds
# config.timeout = 5

# # Don't raise errors when SSL certificates can't be validated
# config.ignore_ssl_errors

# # Don't load images
# config.skip_image_loading

# # Use a proxy
# config.use_proxy(
#   host: "example.com",
#   port: 1234,
#   user: "proxy",
#   pass: "secret"
# )

  # Raise JavaScript errors as exceptions
  config.raise_javascript_errors = true
end

Capybara.javascript_driver = :webkit
