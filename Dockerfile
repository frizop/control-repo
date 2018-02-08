FROM ruby:2.4.1
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install
