FROM ruby:2.4.1
COPY Gemfile .
RUN bundle install