FROM ruby:3.0.3-alpine3.15
RUN apk add --update build-base tzdata nodejs npm postgresql-dev
RUN gem install rails -v '6.1.4'
RUN npm install --global yarn
RUN yarn install --check-files
WORKDIR /app
ADD Gemfile Gemfile.lock /app/
RUN bundle install

EXPOSE 3000
## docker-compose run --no-deps turnero-web rails new . --force --database=postgresql --api
# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
