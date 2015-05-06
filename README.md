### rspec_testing_app

# Test app built to learn testing with RSpec

Basic contacts app setup to facilitate learning RSpec testing.

## App configuration

* Ruby 		2.1.2
* Rails 		4.2.0
* PostgreSQL 	9.4.1

# RSpec configuration

# In Gemfile:

- group :test do
  - gem 'rspec-rails'
  - gem 'factory_girl_rails'
  - gem 'faker'
  - gem 'capybara'
  - gem 'guard-rspec'
  - gem 'launchy'
- end

