# syntax=docker/dockerfile:1
# check=error=true

# Use a base image with Ruby and a slim OS
FROM ruby:3.2.2-slim-buster

# Set the working directory inside the container
WORKDIR /app

# Install necessary system dependencies for Rails and PostgreSQL
# nodejs is needed for JavaScript bundling (e.g., esbuild, importmap)
# default-jdk might be needed for some JS runtimes or gems (e.g., if using JRuby or specific JS tools)
# build-essential for compiling native extensions of gems
# libpq-dev for PostgreSQL client libraries
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    # default-jdk \  <-- REMOVE THIS LINE OR COMMENT IT OUT
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Copy Gemfile and Gemfile.lock first to leverage Docker cache
# This means if only your app code changes, bundle install won't re-run
COPY Gemfile Gemfile.lock ./

# Install RubyGems dependencies
# --jobs $(nproc) uses all available CPU cores for faster installation
# --without development test excludes dev/test gems from production image
RUN bundle install --jobs $(nproc) --without development test

# Copy the rest of the application code
COPY . .

# Precompile assets for production
# This step is crucial for Rails applications in production
RUN bundle exec rails assets:precompile

# Expose the port where the Rails application will run
EXPOSE 3000

# Set the default command to run when the container starts
# This starts the Puma web server, binding to all network interfaces (0.0.0.0)
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
