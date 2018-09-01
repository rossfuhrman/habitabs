source 'https://rubygems.org'
ruby '2.4.1'

gem 'rails', '5.1.6'

gem 'pg', '~> 0.20'

gem 'devise'

gem 'wicked'

# Use SCSS for stylesheets
gem 'sass', '3.4.25' # pinned to keep on a later version of foundation-rails - didn't really help
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'#, '~> 4.0.0'

gem 'foundation-icons-sass-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem "jquery-ui-rails"

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'foundation-rails', '5.5.3.2'

gem 'acts_as_list' #added so we can sort the habits

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

group :development do
  gem 'rack-mini-profiler'
  gem 'pry-rails'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.5.0'
  gem 'rspec-collection_matchers'
  gem 'rake', '< 11.0' #rspec-rails needs to be updated, but until then, pin the rake version
  gem 'factory_girl_rails', '~> 4.2.1'
  #There were install issues with these two gems when moving to ruby 2.2.1.
  #gem 'guard-rspec'
  #gem 'spork-rails', github: 'sporkrb/spork-rails'
  gem 'simplecov', :require => false, :group => :test
end

group :test do
  gem 'faker', '~> 1.1.2'
  gem 'capybara', '~> 2.8.0'
  gem 'database_cleaner', '~> 1.0.1'
  gem 'launchy', '~> 2.3.0'
  gem 'capybara-webkit'
end

group :production do
  gem 'newrelic_rpm'
end
