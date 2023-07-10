# Start with the official Ruby 3.0 image
FROM ruby:3.0.5

# Install the necessary libraries
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

# Create a directory for the application and use it
RUN mkdir /promptspot
WORKDIR /promptspot

# Add the Gemfile and install the Gems
ADD Gemfile /promptspot/Gemfile
ADD Gemfile.lock /promptspot/Gemfile.lock
RUN bundle install

# Add the rest of the application
ADD . /promptspot

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose the port
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
