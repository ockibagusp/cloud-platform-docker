# cloud-platform-docker
Docker container-base Cloud-Platform

# Preparation
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
1. Build Image
```bash
$ docker build -t ockifals/cloud-platform .
```
2. Run image
* production mode
```bash
$ docker run -d -p 3000:80 -p 27017:27017 -p 8080:8080 \
--name cloud-platform \
-v /your-path/web-console/dist/:/projects/angular \
-v /your-path/cloud-platform:/projects/django \
ockifals/cloud-platform
```
* development mode

comes with ability to reload the code without restarting the container
```bash
$ docker run -d -e "ENV=DEV" -p 3000:80 -p 27017:27017 -p 8000:8000 \
--name cloud-platform \
-v /your-path/web-console/dist/:/projects/angular \
-v /your-path/cloud-platform:/projects/django \
ockifals/cloud-platform
```
then, run django-dev-server
```bash
docker exec cloud-platform '/djangodevserver.sh'
```
3. Import DB Schema
```bash
$ docker exec cloud-platform 'mongorestore' '--db' 'agrihub' '/mongorestore/agrihub/'
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
