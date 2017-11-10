FROM docker.io/ubuntu:14.04

RUN apt-get update

# RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/supervisor
# COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80 8080 27017
CMD ["/usr/bin/supervisord"]
