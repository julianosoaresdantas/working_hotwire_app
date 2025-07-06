# config/environments/development.rb

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

<<<<<<< HEAD
  # In the development environment your application's code is reloaded any time
  # it changes. This ensures that you don't have to restart the server for changes to take effect.
  config.enable_reloading = true

  # Do not eager load code on boot. This avoids loading your whole application just to run a
  # single test.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
=======
  # Required for Cloud Shell to handle HTTPS proxying correctly for trusted proxies
  config.action_dispatch.trusted_proxies = [/.*\.cloudshell\.dev$/]

  # Allows Rails to correctly verify authenticity token when behind Cloud Shell's HTTPS proxy
  # The Proc.new { |host| host =~ /.*\.cloudshell\.dev$/ } matches any subdomain of cloudshell.dev
  config.action_controller.default_protect_from_forgery = {
    with: :exception,
    prepend: false,
    hosts: [Proc.new { |host| host =~ /.*\.cloudshell\.dev$/ }]
  }

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make changes.
  config.cache_classes = false

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
    config.action_controller.enable_fragment_cache_logging = true

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
>>>>>>> 2d32fe77661cbb6d5c2f23a40816540019075e13

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

<<<<<<< HEAD
  # Raise exceptions for unpermitted parameters in development.
  config.action_controller.action_on_unpermitted_parameters = :raise

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load
=======
  # REMOVIDO/COMENTADO: config.action_controller.unpermitted_parameters = :raise
  # Esta linha está causando "Invalid option key" no Rails 8.0.2
  # Note: This line was already commented out or removed in your previous file content,
  # so it remains absent here to avoid the "Invalid option key" you encountered earlier.
>>>>>>> 2d32fe77661cbb6d5c2f23a40816540019075e13

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

<<<<<<< HEAD
  # Debug error pages in the browser
  config.web_console.whitelisted_ips = %w[ 127.0.0.1 ::1 ]

=======
>>>>>>> 2d32fe77661cbb6d5c2f23a40816540019075e13
  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

<<<<<<< HEAD
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
=======
  # Uncomment if you are using a more complex backtrace logger.
  # config.active_record.migration_error = :page_load

  # Highlight fractional seconds in server logs.
  config.active_support.use_concurrent_time_precision = true

  # Enable the bullet gem for N+1 query detection.
  # If you're using `bullet`, uncomment these lines.
  # config.after_initialize do
  #   Bullet.enable = true
  #   Bullet.alert = true
  #   Bullet.bullet_logger = true
  #   Bullet.console = true
  #   Bullet.growl = false
  #   Bullet.rails_logger = true
  #   Bullet.add_footer = true
  # end

  # >>> SOLUÇÃO PERMANENTE PARA BLOQUEIO DE HOSTS NO CLOUD SHELL <<<
  # Permite qualquer subdomínio do cloudshell.dev, resolvendo o problema de portas dinâmicas.
  config.hosts << /.*\.cloudshell\.dev\z/
end
>>>>>>> 2d32fe77661cbb6d5c2f23a40816540019075e13
