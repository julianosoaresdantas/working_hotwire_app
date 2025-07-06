# config/environments/development.rb

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This ensures that you don't have to restart the server for changes to take effect.
  config.enable_reloading = true

  # Do not eager load code on boot. This avoids loading your whole application just to run a
  # single test.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for unpermitted parameters in development.
  config.action_controller.action_on_unpermitted_parameters = :raise

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Debug error pages in the browser
  config.web_console.whitelisted_ips = %w[ 127.0.0.1 ::1 ]

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you are using a multi-user app that needs to be protected from CSRF attacks.
  # config.action_controller.forgery_protection_origin_check = true

  # Store uploaded files on the local file system in development.
  config.active_storage.service = :local # This is the ONLY line related to storage in this file

  # Enable serving of images, stylesheets, and JavaScript assets from an asset server.
  # config.asset_host = "http://localhost:3000"

  # Debugging for Hotwire/Turbo
  config.action_view.logger = nil # Suppresses verbose Hotwire logging in development

  # Enable Hotwire/Turbo debugging in the browser
  # config.action_view.debug_template_rendering_with_object_ids = true
end
