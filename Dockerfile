FROM ruby:2.7.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client npm
WORKDIR /app
COPY package.json yarn.lock /app/
RUN npm install -g yarn
RUN yarn install
COPY Gemfile Gemfile.lock /app/
RUN bundle install

ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true
ENV RAILS_LOG_TO_STDOUT=true

COPY . /app

EXPOSE 3000
