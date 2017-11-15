FROM docker.io/ubuntu:14.04

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r agrihub && useradd -r --create-home -g agrihub agrihub
RUN groupadd -r mongodb && useradd -r -g mongodb mongodb

# install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        apache2 \
        libapache2-mod-wsgi \
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

COPY apache2.conf /etc/apache2/sites-enabled/000-default.conf

# prepare projects directory
WORKDIR /projects
RUN pip install virtualenv  \
    && virtualenv venv \
    && mkdir -p angular django \
    && cp /var/www/html/index.html angular \
    && chown -R www-data:www-data angular
COPY django /projects/django

# install django dependencies
WORKDIR /projects
RUN . venv/bin/activate \
    && pip install -r django/requirements.txt

# enabling mod_rewrite
RUN a2enmod rewrite \
    && service apache2 restart

# import db_schema
COPY db_schema /mongorestore

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80 8080 27017
USER agrihub

CMD ["/usr/bin/supervisord"]
