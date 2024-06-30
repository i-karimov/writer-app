FROM ruby:3.3.0

WORKDIR /app

RUN apt-get update && apt-get install -y \
    nodejs libvips postgresql build-essential curl \
    git libpq-dev node-gyp pkg-config

RUN gem install bundler 

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["/bin/rails", "server"]

