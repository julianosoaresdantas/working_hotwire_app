<<<<<<< HEAD
# test/test_helper.rb
=======
>>>>>>> 2d32fe77661cbb6d5c2f23a40816540019075e13
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

<<<<<<< HEAD
class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
=======
module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
>>>>>>> 2d32fe77661cbb6d5c2f23a40816540019075e13
end
