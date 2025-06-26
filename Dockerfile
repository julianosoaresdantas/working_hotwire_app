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