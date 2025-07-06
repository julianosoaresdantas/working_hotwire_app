<<<<<<< HEAD
# syntax=docker/dockerfile:1
# check=error=true

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t working_hotwire_app .
# docker run -d -p 80:80 -e RAILS_MASTER_KEY=<value from config/master.key> --name working_hotwire_app working_hotwire_app

# For a containerized dev environment, see Dev Containers: https://guides.rubyonrails.org/getting_started_with_devcontainer.html

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.3.0
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Rails app lives here
WORKDIR /rails

# Install base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 sqlite3 && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# Throw-away build stage to reduce size of final image
FROM base AS build

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Copy application code
COPY . .

# Precompiling assets for production without requiring secret RAILS_MASTER_KEY
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile




# Final stage for app image
FROM base

# Copy built artifacts: gems, application
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Run and own only the runtime files as a non-root user for security
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER 1000:1000

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start server via Thruster by default, this can be overwritten at runtime
EXPOSE 80
CMD ["./bin/thrust", "./bin/rails", "server"]
=======
# Stage 1: Base image with OS dependencies and user setup
FROM ruby:3.3.0-slim AS base
WORKDIR /rails
# Install essential packages for building gems and runtime dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    build-essential \
    pkg-config \
    libssl-dev \
    libvips \
    libsqlite3-0 \
    nodejs \
    npm \
    node-gyp \
    imagemagick \
    git \
    make \
    tini \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* # Clear apt cache to reduce image size
# Create a dedicated user for the Rails application
RUN groupadd --system --gid 1000 rails && \
    useradd --system --uid 1000 --gid rails --shell /bin/bash --create-home rails
RUN chown -R rails:rails /rails

# Stage 2: Build - install Ruby gems
FROM base AS build
WORKDIR /rails

# --- CRITICAL FIX: Use COPY --chown to set ownership directly ---
COPY --chown=rails:rails Gemfile ./
COPY --chown=rails:rails Gemfile.lock ./

# --- DIAGNOSTIC: Check permissions after COPY --chown (should now be rails) ---
RUN echo "--- Permissions after COPY --chown (should be rails) ---"
RUN ls -la Gemfile Gemfile.lock

# --- NEW FIX: Ensure /usr/local/bundle directory is created and owned by 'rails' before bundle install ---
RUN mkdir -p /usr/local/bundle && \
    chown -R rails:rails /usr/local/bundle

# Now, switch to the 'rails' user for bundle install
USER rails

# Explicitly set BUNDLE_PATH for the bundle install command
RUN bundle config set path '/usr/local/bundle' && \
    bundle install --jobs=$(nproc) --retry=3

# --- DIAGNOSTIC: Check if gems are actually in /usr/local/bundle after bundle install ---
RUN echo "--- Listing /usr/local/bundle contents in BUILD stage after bundle install ---"
RUN ls -la /usr/local/bundle
RUN echo "--- Listing /usr/local/bundle/ruby/3.3.0/gems/ contents in BUILD stage ---"
RUN ls -la /usr/local/bundle/ruby/3.3.0/gems/ || true

USER root # Switch back to root

# Stage 3: Deploy - create the final, slim runtime image
FROM base AS deploy
WORKDIR /rails

# Copy the entire /usr/local/bundle directory from the build stage.
COPY --from=build /usr/local/bundle /usr/local/bundle

# Set the PATH to include the exact directory where the `rails` executable is located
ENV PATH="/usr/local/bundle/ruby/3.3.0/bin:$PATH"

# Ensure Bundler knows where the Gemfile.
ENV BUNDLE_GEMFILE="/rails/Gemfile"

# Copy your entire application code into the /rails directory in the container
COPY . .

# <<< ESTA É A LINHA CRÍTICA MOVIDA E CONFIRMADA >>>
RUN chmod +x bin/*

# Set the user for running the application
USER rails

EXPOSE 3000

# Use tini as an entrypoint for proper signal handling (good practice for Rails)
ENTRYPOINT ["/usr/bin/tini", "--", "bundle", "exec"]
# NOVO CMD: Inicia o servidor Rails. As migrações serão feitas manualmente (se necessário).
CMD ["rails", "server", "-b", "0.0.0.0"]
>>>>>>> 2d32fe77661cbb6d5c2f23a40816540019075e13
