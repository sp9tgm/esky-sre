# Assigment 2

## Description

The task was to create a script called `script.sh` that will build and run this app in Docker container. The app should be reachable from the outside of container. Script also has additional options `--port` to specify port on which app should be available and`--healtcheck` to check if app is running.

## Running script

```bash
./script.sh OPTIONS
```

Example:

```bash
./script.sh --port 1234 --healthcheck
```

After running script will build app image, run the container. After exiting the script will be stopped.

If everything is OK, and you used the `--healthcheck` option you should see such output:

```bash
2023/08/10 10:48:04 App started. Will listen on :2137
Health check of go-app:
http://localhost:2137/health
HTTP/1.1 200 OK
Date: Thu, 10 Aug 2023 10:48:04 GMT
```
