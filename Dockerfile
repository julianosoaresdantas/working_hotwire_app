# Use a specific, stable Ruby version with Alpine Linux for a smaller image
FROM ruby:3.3.0-alpine

# Set the working directory inside the container
WORKDIR /app

# Install build dependencies, Node.js, npm, and other essential tools
# Alpine's package manager is `apk`. `build-base` includes compilers like gcc.
# `libffi-dev`, `libpq-dev`, `postgresql-dev` are for database gems.
# `tzdata` for timezone data. `nodejs` and `npm` for JavaScript assets.
# `bash`, `git`, `less`, `vim` are for easier debugging and interaction inside the container.
RUN apk add --no-cache \
    build-base \
    libffi-dev \
    libpq-dev \
    postgresql-dev \
    tzdata \
    nodejs \
    npm \
    bash \
    git \
    less \
    vim \
    && rm -rf /var/cache/apk/* # Clean up apk cache to reduce image size

# Copy Gemfile and Gemfile.lock to leverage Docker's build cache
# If these files don't change, this layer won't be rebuilt.
COPY Gemfile Gemfile.lock ./

# Install Ruby gems using Bundler
# ENV BUNDLE_FORCE_RUBY_PLATFORM=1 ensures Bundler installs platform-agnostic gems.
ENV BUNDLE_FORCE_RUBY_PLATFORM=1
RUN bundle install

# Copy the rest of the application code into the container
COPY . .

# Expose port 3000, which is the default for Rails applications
EXPOSE 3000

# Start the Rails server
# `rm -f tmp/pids/server.pid` removes a stale server PID if the container was stopped improperly.
# `rails db:migrate` runs database migrations (important for fresh deployments).
# `rails tailwindcss:build` compiles Tailwind CSS.
# `rails server -b 0.0.0.0` starts the Rails server, binding to all network interfaces.
CMD ["bash", "-c", "rm -f tmp/pids/server.pid && rails db:migrate && rails tailwindcss:build && rails server -b 0.0.0.0"]
