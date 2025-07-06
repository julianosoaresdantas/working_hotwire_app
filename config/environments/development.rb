# config/environments/development.rb
Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server any time you make code changes.
  config.enable_reloading = true

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing.
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.cache_store = :memory_store
    config.action_view.cache_store = :memory_store
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

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

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you are using a web server that supports HTTP/2 push for assets.
  # config.action_controller.asset_host = "http://localhost:3000"

  # Debug error pages with the better_errors gem.
  # config.web_console.whitelisted_ips = %w( 127.0.0.1 )

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Use an evented file watcher to detect changes in source code,
  # routes, locales, etc. This is the most efficient way to enable
  # hot-reloading for development.
  # config.file_watcher = ActiveSupport::FileUpdateChecker

  # Uncomment if you're not using a database for Active Job.
  # config.active_job.queue_adapter = :async

  # For Action Mailer previews
  # config.action_mailer.preview_path = Rails.root.join("spec/mailers/previews")
end
