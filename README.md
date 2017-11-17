# cloud-platform-docker
Docker container-base Cloud-Platform (Production)

# Preparation

Assume that you use same dir to clone the repo

## Cloud-Platform (WebService)

1. Clone repository from Bitbucket

```bash
$ git clone https://ockifals@bitbucket.org/ockifals/cloud-platform.git
```

## Web-Console (Single-Page Application)

1. Clone repository from Bitbucket

```bash
$ git clone https://ockifals@bitbucket.org/ockifals/web-console.git
```

2. Install dependencies

```bash
$ npm install
```

3. Build

```bash
$ npm run prod-build
```

Build location: `web-console/dist`

# Instruction

## Build and run using Dockerfile

1. Build Image

```bash
$ docker build -t ockifals/cloud-platform .
```

2. Run image

```bash
$ docker run -d -p 3000:80 -p 27017:27017 -p 8080:8080  --name [container-name] ockifals/cloud-platform
```
    
3. Import DB Schema

```bash
$ docker exec [container-name] 'mongorestore' '--db' 'agrihub' '/mongorestore/agrihub/'
``` 

## Build and run using docker-compose.yml

1. Build image and run new container

```bash
$ docker-compose up -d
```

2. Import DB Schema

```bash
$ docker-compose exec cloud-platform 'mongorestore' '--db' 'agrihub' '/mongorestore/agrihub/'
``` 

# Services
* 3000 -> Single-Page Application
* 8080 -> RESTful WebService (production mode)
* 8080 -> RESTful WebService (development mode)
* 27017 -> MongoDB

# User Accounts
- Admin
    - username: akundewa
    - password: admin123
- Researcher
    - please register your own
