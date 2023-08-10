# Assigment 3 - part one

## Description

The task was to create container with Nginx, that on path `/greet` will proxy request to dockerized app from second assigment.

The [default.conf](./default.conf) file contains Nginx configuration.
The nginx listen on port `80` and proxy the requests on path `greet` to port `8080` of [assigment-2](../assigment-2/) app.
Additionally the nginx server listen on port `9001` and returns on path `/health` status code and text message `I'm healthy`.

Part two of this assigment is available in [main repo README file](../README.md).
