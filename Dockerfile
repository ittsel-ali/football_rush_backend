FROM ruby:2.3.0
ENV BUNDLER_VERSION=2.1.4

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs sqlite3

RUN mkdir /football_rush_backend
WORKDIR /football_rush_backend

COPY Gemfile /football_rush_backend/Gemfile
COPY Gemfile.lock /football_rush_backend/Gemfile.lock

RUN gem install bundler -v 2.1.4
RUN bundle install

COPY . /football_rush_backend