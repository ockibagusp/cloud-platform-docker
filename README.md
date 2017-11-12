# cloud-platform-docker
Docker container-base Cloud-Platform

# Instruction
1. Build Image
```bash
$ docker build -t ockifals/cloud-platform .
```

1. Run image

```bash
$ docker run -d -p 3000:80 -p 27017:27017 -p 8080:8080 --name cloud-platform ockifals/cloud-platform
```

2. Import DB Schema

```bash
$ docker cloud-platform exec 'mongorestore' '--db' 'agrihub' '/mongorestore/agrihub/'
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
