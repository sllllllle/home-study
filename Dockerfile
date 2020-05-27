FROM ruby:2.5.3
RUN apt-get update -qq && apt-get install -y vim nodejs default-mysql-client
COPY . /home-study
ENV APP_HOME /home-study
WORKDIR $APP_HOME
RUN bundle install
ADD . $APP_HOME