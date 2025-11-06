source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.4.5"

gem "rails", "~> 7.2", ">= 7.2.0"

gem "sprockets-rails"

gem "pg", "~> 1.1"

gem "puma", "~> 6.0", ">= 6.6.1"

gem "importmap-rails"

gem "turbo-rails"

gem "stimulus-rails"

gem "tailwindcss-rails"

gem "jbuilder"

gem "redis", "~> 5.0"

gem 'dotenv-rails', '~> 2.8', '>= 2.8.1'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "bootsnap", require: false

gem 'devise', '~> 4.9', '>= 4.9.2'

gem "sassc-rails"

# CORS support
gem 'rack-cors', '~> 2.0'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  # provides integration between factory_bot and rails 5.0 or newer
  gem 'factory_bot_rails', '~> 6.2'
  # rspec-rails is a testing framework for Rails 5+.
  gem 'rspec-rails', '~> 6.0', '>= 6.0.1'
end

# Engine local (experimental)
gem "sysadmin_core", path: "engines/sysadmin_core"

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Automatic Ruby code style checking tool.
  gem 'rubocop'
end

group :test do
  gem "capybara"
  # Strategies for cleaning databases. Can be used to ensure a clean slate for testing.
  gem 'database_cleaner', '~> 2.0', '>= 2.0.2'
  # Easily generate fake data
  gem 'faker', '~> 3.1', '>= 3.1.1'
  # Selenium is a browser automation tool for automated testing of webapps and more
  gem 'selenium-webdriver', '~> 4.11', '>= 4.11.1'
  # Shoulda Matchers provides RSpec- and Minitest-compatible one-liners to test common Rails functionality
  gem 'shoulda-matchers', '~> 5.3'
  # Easy download and use of browser drivers.
  gem 'webdrivers', '~> 5.2'
end
