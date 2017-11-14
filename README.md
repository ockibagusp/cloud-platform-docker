# cloud-platform-docker
Docker container-base Cloud-Platform

# Instruction
1. Build Image
```bash
$ docker build -t ockifals/cloud-platform .
```

1. Run image

```bash
$ docker run -d -p 3000:80 -p 27017:27017 -p 8080:8080 \
--name cloud-platform \
-v /your-path/web-console/dist/:/projects/angular \
-v /your-path/cloud-platform:/projects/django \
ockifals/cloud-platform
```

2. Import DB Schema

```bash
$ docker exec cloud-platform 'mongorestore' '--db' 'agrihub' '/mongorestore/agrihub/'
```

3. Restart Apache2

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
    1. Subali
    - username: subali
    - password: admin123
    2. Sugriwa
    - username: sugriwa
    - password: admin123
