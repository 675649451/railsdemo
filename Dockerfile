# Use official Ruby 3.4.2 runtime as base image
FROM ruby:3.4.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libsqlite3-dev \
    nodejs \
    yarn

# Set working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler && bundle install

# Copy the rest of the application code
COPY . .

# Precompile assets (if needed)
#RUN bundle exec rake assets:precompile RAILS_ENV=production
RUN rails db:migrate

# Expose port 3000
EXPOSE 3000

# Configure the main process
CMD ["rails", "server", "-b", "0.0.0.0"]
