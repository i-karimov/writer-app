FROM ruby:3.3.0-alpine

ARG PACKAGES="vim openssl-dev postgresql-dev imagemagick build-base vips-dev curl libstdc++ yarn nodejs less tzdata git postgresql-client bash screen gcompat su-exec sudo"
ARG RAILS_ROOT=/rails_app

RUN apk update \
    && apk upgrade \
    && apk add --update --no-cache $PACKAGES

RUN mkdir $RAILS_ROOT
WORKDIR $RAILS_ROOT

RUN gem install bundler:2.3.7

COPY Gemfile Gemfile.lock  ./
RUN bundle install --jobs 5

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . .

ENV PATH=$RAILS_ROOT/bin:${PATH}

EXPOSE 3000

CMD bundle exec rails s -b '0.0.0.0' -p 3000