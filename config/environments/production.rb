# config/environments/production.rb
Rails.application.configure do
  # ... (other default settings) ...

  # Ensures that a master key has been made available in either ENV["RAILS_MASTER_KEY"]
  # or in config/master.key. This key is used to decrypt credentials.
  # config.read_encrypted_secrets = true # Older Rails versions might have this
  config.require_master_key = true # Newer Rails versions use this

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true # Ensure this is uncommented

  # Prepend all log lines with the following tags.
  # config.log_tags = [ :request_id ]

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store

  # Use a real queuing backend for Active Job (and separate queues per environment).
  # config.active_job.queue_adapter = :resque
  # config.active_job.queue_name_prefix = "working_hotwire_app_production"

  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure your email server for real deliveries.
  config.action_mailer.raise_delivery_errors = false

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for Apache and NGINX
  # config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # for NGINX

  # Mount Action Cable outside main process or remove if not using Action Cable.
  # config.action_cable.mount_path = nil
  # config.action_cable.url = "wss://example.com/cable"
  # config.action_cable.allowed_request_origins = [ "http://example.com", /http:\/\/example.*/ ]

  # Enable serving of static files from the Apache/Nginx server.
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present? # Ensure this is uncommented

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = :uglifier # Or :terser if using Webpacker/ESM
  # config.assets.css_compressor = :sassc # Or :cssnano

  # Do not fallback to assets pipeline if a precompiled asset is missing.
  config.assets.compile = false # Ensure this is false

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  # config.asset_host = "http://assets.example.com"

  # Specifies the header that your server uses for sending files.
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for Apache and NGINX
  # config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # for NGINX

  # Eager load code on boot to ensure it's ready for production.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  # Enable locale fallbacks for I18n (makes lookups for corresponding locales fall back to the array of locales specified).
  config.i18n.fallbacks = true # Ensure this is uncommented

  # Send all logs to stdout, which Docker and Render will pick up.
  config.logger = ActiveSupport::Logger.new(STDOUT)
  config.log_formatter = ::Logger::Formatter.new
  config.log_level = :info # Ensure this is :info

  # Use a different cache store in production.
  # config.cache_store = :mem_cache_store # Or :redis_store

  # Store uploaded files on the local file system (see config/storage.yml for options).
  # config.active_storage.service = :local # COMMENT THIS OUT
  # config.active_storage.service = :amazon # Uncomment and configure for S3 later

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false
end
