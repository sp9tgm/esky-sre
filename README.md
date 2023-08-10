# SRE Junior Recruitment

This repository contains solutions for recruitment tasks from  [sre-junior-assigment-2023](https://github.com/eskypl/sre-junior-assigment-2023) repository.

## Assigment 3 - part two

The second part of Assigment 3 was to prepare docker-compose file, that will launch `nginx` image prepared in part one and dockerized app from Assigment 2.

### Running the containers

To run the container go to the main repo directory and run `docker-compose` command.

```bash
docker-compose up -d
```

To check if all requirements are met run this commands:

```bash
$ curl -i localhost:8080/greet
HTTP/1.1 200 OK
Server: nginx/1.25.1
Date: Thu, 10 Aug 2023 11:19:07 GMT
Content-Type: text/plain; charset=utf-8
Content-Length: 69
Connection: keep-alive

Hello World! 2023-08-10 11:19:07.623848168 +0000 UTC m=+216.052651827
```
  
```bash
$ curl -i localhost:9001/health
HTTP/1.1 200 OK
Server: nginx/1.25.1
Date: Thu, 10 Aug 2023 11:18:19 GMT
Content-Type: application/octet-stream
Content-Length: 11
Connection: keep-alive

I'm healthy
```
