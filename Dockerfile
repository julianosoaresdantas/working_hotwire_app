# syntax=docker/dockerfile:1.4
FROM ruby:3.3.0-slim-bookworm

WORKDIR /app

# Install apt-get dependencies
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    nodejs \
    npm \
    # Add any other dependencies your app needs (e.g., imagemagick, libvips, etc.)
    && rm -rf /var/lib/apt/lists/*

# Install Yarn globally
RUN npm install -g yarn

# Copy Gemfile and Gemfile.lock, then install Ruby gems
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs "$(nproc)" --retry 3

# Copy package.json and yarn.lock, then install Node.js packages
COPY package.json yarn.lock ./
RUN yarn install --check-files # Use npm install if not using Yarn

# >>> ADD THIS LINE HERE <<<
# Copy the Rails master key file directly into the container.
# This is reliable for development. For production, consider Docker Secrets.
COPY config/master.key config/master.key

# Copy the rest of your application code
COPY . .

# Precompile assets (optional, depending on your development workflow)
# If you get asset errors in development, you might need to run this
# locally or move it to a specific stage in a multi-stage build.
# RUN bundle exec rails assets:precompile

EXPOSE 3000

# Default command to run the Rails server
CMD ["bundle", "exec", "rails", "s", "-p", "3000", "-b", "0.0.0.0"]
