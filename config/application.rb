# config/application.rb
require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WorkingHotwireApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1 # Or your specific Rails version

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.eager_load_paths << Rails.root.join("extras")

    # Set Time.zone default to the specified zone and make Active Record auto convert to this zone.
    # Run "bin/rails -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = "Central Time (US & Canada)"

    # Don't generate system test files.
    config.generators.system_tests = nil

    # Add this line if you want to silence the deprecation warning about to_time
    config.active_support.to_time_preserves_timezone = :zone

    # Ensure that `ActiveStorage::Engine` is loaded if you are using Active Storage
    # This line might be present or implied by `require "rails/all"` depending on Rails version
    # If you see `require "active_storage/engine"` keep it, otherwise it's usually handled by `rails/all`
    # For Rails 7.1+, `require "rails/all"` typically includes Active Storage.
  end
end
