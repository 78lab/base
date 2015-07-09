# See https://intercityup.com/blog/how-i-build-a-docker-image-for-my-rails-app.html
# See https://intercityup.com/blog/deploy-rails-app-including-database-configuration-env-vars-assets-using-docker.html

FROM phusion/passenger-ruby22
#FROM 78lab/base

MAINTAINER djlee "djlee@78lab.com"

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# === 5 === 
# Run Bundle in a cache efficient way 
WORKDIR /tmp 
ADD ./my_app/Gemfile /tmp/ 
ADD ./my_app/Gemfile.lock /tmp/ 
RUN bundle install

ADD ./foobar/Gemfile /tmp/ 
ADD ./foobar/Gemfile.lock /tmp/ 
RUN bundle install


