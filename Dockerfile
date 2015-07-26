# See https://intercityup.com/blog/how-i-build-a-docker-image-for-my-rails-app.html
# See https://intercityup.com/blog/deploy-rails-app-including-database-configuration-env-vars-assets-using-docker.html

FROM phusion/passenger-ruby22
#FROM 78lab/base

MAINTAINER djlee "djlee@78lab.com"

# Set the timezone.
RUN sudo echo "Asia/Seoul" > /etc/timezone
RUN sudo dpkg-reconfigure -f noninteractive tzdata


# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]


# Add nginx conf
ADD nginx_gzip.conf /etc/nginx/conf.d/nginx_gzip.conf

# === 5 === 
# Run Bundle in a cache efficient way 
WORKDIR /tmp 
ADD ./my_app/Gemfile /tmp/ 
ADD ./my_app/Gemfile.lock /tmp/ 
RUN bundle install

ADD ./foobar/Gemfile /tmp/ 
ADD ./foobar/Gemfile.lock /tmp/ 
RUN bundle install


