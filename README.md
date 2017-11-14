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
```bash
$ docker run -d -p 3000:80 -p 27017:27017 -p 8080:8080 \
--name cloud-platform \
-v /your-path/web-console/dist/:/projects/angular \
-v /your-path/cloud-platform:/projects/django \
ockifals/cloud-platform
```
3. Import DB Schema
```bash
$ docker exec cloud-platform 'mongorestore' '--db' 'agrihub' '/mongorestore/agrihub/'
```
4. Restart Apache2
```bash
$ docker exec cloud-platform 'service' 'apache2' 'restart'
```

# Services
* 3000 -> Single-Page Application
* 8080 -> RESTful WebService
* 27017 -> MongoDB

# User Accounts
- Admin
    - username: akundewa
    - password: admin123
- Researcher
    - please register your own
