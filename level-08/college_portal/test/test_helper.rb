ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/minitest'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  # Make the Capybara DSL available in all integration tests
  include Capybara::DSL
  # Make `assert_*` methods behave like Minitest assertions
  include Capybara::Minitest::Assertions

  include Warden::Test::Helpers
  
  setup do
    user = User.new(email: 'test_user@test.com', password: 'abc123')
    user.save!
    login_as(user, :scope => :user)
  end

  # Reset sessions and driver between tests
  teardown do
    Capybara.reset_sessions!
    Capybara.use_default_driver
    logout(:user)
  end

  private
    def login_as_admin
      logout(:user)
      user = User.new(email: 'admin_user@test.com', password: 'abc123', admin: true)
      user.save!
      login_as(user, :scope => :user)
      yield
      logout(:user)
    end

    def logout_and_visit(path)
      logout(:user)
      visit path
      assert_equal current_path, new_user_session_path
      assert page.has_content?('You need to sign in or sign up before continuing.')
    end
end
