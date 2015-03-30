# Use phusion/baseimage as base image. To make your builds
# reproducible, make sure you lock down to a specific version, not
# to `latest`! See
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# for a list of version numbers.
FROM phusion/baseimage:0.9.16

MAINTAINER Patrick Reilly <patrick@kismatic.io>

# Set correct environment variables.
ENV HOME /root

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# install add-apt-repository
RUN sudo apt-get update

# we'll need wget to fetch the key...
RUN sudo apt-get install -y \
  wget \
  unzip

# install kubernetes-ui
RUN mkdir -p /opt/kubernetes-ui
RUN cd /opt/kubernetes-ui && wget -q https://github.com/kubernetes-ui/kubernetes-ui/releases/download/v0.1-beta.3/kubernetes-ui.archive && unzip kubernetes-ui.archive
WORKDIR /opt/kubernetes-ui

# install nginx
RUN sudo apt-get install -y nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN mkdir /etc/service/nginx
ADD nginx.sh /etc/service/nginx/run
RUN chmod 700 /etc/service/nginx/run

# set up nginx default site
ADD nginx-default /etc/nginx/sites-available/default

# create symlink to kubernetes directory
RUN sudo ln -s /opt/kubernetes-ui/kubernetes-ui/www/app /mnt/kubernetes-ui

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# expose port 8001
EXPOSE 8001
