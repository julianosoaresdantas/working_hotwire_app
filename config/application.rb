<<<<<<< HEAD
require_relative "boot"

require "rails/all"
# Add this line explicitly to ensure Active Storage engine is loaded
require "active_storage/engine"
=======
# working_hotwire_app/config/application.rb

require_relative "boot"

require "rails/all"
>>>>>>> 2d32fe77661cbb6d5c2f23a40816540019075e13

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WorkingHotwireApp
  class Application < Rails::Application
<<<<<<< HEAD
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.1

    # Please, add for configuration here for Rails 8.0

    # For hotwire-rails to work properly
    config.assets.css_compressor = nil
=======
    # ... (keep existing config.load_defaults 8.0 etc.)

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])
>>>>>>> 2d32fe77661cbb6d5c2f23a40816540019075e13

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
