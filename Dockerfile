FROM docker.io/ubuntu:14.04

# add mongodb user and group first to make sure their IDs get assigned consistently
RUN groupadd -r mongodb && useradd -r -g mongodb mongodb

# install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apache2 \
        supervisor \
        git \
        vim \
        python-pip \
    && rm -rf /var/lib/apt/lists/*

# install MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 \
    --recv 0C49F3730359A14518585931BC711F9BA15703C6
RUN echo "deb [ arch=amd64 ] http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.4 multiverse" | \
    tee /etc/apt/sources.list.d/mongodb-org-3.4.list
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        mongodb-org \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/supervisor
RUN mkdir -p /data/db /data/configdb \
	&& chown -R mongodb:mongodb /data/db /data/configdb
VOLUME /data/db

# import db_schema
COPY db_schema /mongorestore
# RUN mongorestore --db agrihub /mongorestore/agrihub/

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80 8080 27017
CMD ["/usr/bin/supervisord"]
