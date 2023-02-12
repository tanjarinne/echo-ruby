FROM ruby:3.1-alpine

WORKDIR /app
ADD . ./

RUN set -ex ;\
  bundle config set --local deployment 'true' ;\
  bundle install

CMD ["bundle", "exec", "ruby", "bin/start"]
