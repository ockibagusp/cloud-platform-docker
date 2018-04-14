# cloud-platform-docker
Docker container-base Cloud-Platform

# Preparation
## Cloud-Platform (WebService)

1. Clone repository from Bitbucket

```bash
$ git clone https://github.com/OckiFals/cloud-platform-docker.git
```

## Web-Console (Single-Page Application)

1. Clone repository from Bitbucket

```bash
$ git clone https://ockifals@bitbucket.org/ockifals/web-console.git
```

2. Change directory to cloned repo

```bash
$ cd /your-path/web-console
```

3. Install dependencies

```bash
$ npm install
```

4. Build

```bash
$ npm run prod-build
```

Build location: `/your-path/web-console/dist`

# Instruction

## Build and run using Dockerfile

1. Build Image

```bash
$ docker build -t ockifals/cloud-platform .
```

2. Run image

* production mode

```bash
$ docker run -d -p 3000:80 -p 27017:27017 -p 8080:8080 --name [container-name] -v /your-path/web-console/dist:/projects/angular -v /your-path/cloud-platform:/projects/django ockifals/cloud-platform
```

* development mode

    comes with ability to reload code without restarting container

```bash
$ docker run -d -e "ENV=DEV" -p 3000:80 -p 27017:27017 -p 8000:8000 --name [container-name] -v /your-path/web-console/dist:/projects/angular -v /your-path/cloud-platform:/projects/django ockifals/cloud-platform
```
    
3. Import DB Schema

```bash
$ docker exec [container-name] 'mongorestore' '--db' 'agrihub' '/mongorestore/agrihub/'
``` 

4. Run django-dev-server (*in development mode)

```bash
docker exec [container-name] '/djangodevserver.sh'
```

## Build and run using docker-compose.yml
⚠️ remember to change docker-compose.yml before building an image

* change __'your-path'__ to path you use to clone repo __*cloud-platform*__ and __*web-console*__

* run in production mode (*default)

    set __'ENV'__ to __'PROD'__ in docker-compose.yml
    
* run in development mode

    comes with ability to reload code without restarting container.

    set __'ENV'__ to __'DEV'__ in docker-compose.yml

1. Build image and run new container

```bash
$ docker-compose up -d
```

2. Import DB Schema

```bash
$ docker-compose exec cloud-platform 'mongorestore' '--db' 'agrihub' '/mongorestore/agrihub/'
``` 

3. Run django-dev-server (*in development mode)

```bash
docker-compose exec cloud-platform '/djangodevserver.sh'
```

# Services
* 3000 -> Single-Page Application
* 8080 -> RESTful WebService (production mode)
* 8000 -> RESTful WebService (development mode)
* 27017 -> MongoDB

# User Accounts
- Admin
    - username: akundewa
    - password: admin123
- Researcher
    - please register your own
