#!/bin/bash
health=False
BIND_ADDRESS=8080
health_check(){
    echo "Health check of go-app:"
    echo http://localhost:$BIND_ADDRESS/health
    curl -I http://localhost:$BIND_ADDRESS/health
}
cleanup(){
    echo -e "\nCtrl+C detected. Stopping container..:"
    docker stop go-app
    echo "Container stopped. Exiting script..."
}
build(){
    docker build -t esky-go-app-image .
}
run(){
    docker run --rm -d -p $BIND_ADDRESS:$BIND_ADDRESS -e BIND_ADDRESS=:$BIND_ADDRESS --name go-app go-app-image
    docker logs go-app
}
options=$(getopt -o p:c --long healthcheck,port:  -- "$@")
[ $? -eq 0 ] || {
    echo "Incorrect options provided"
    exit 1
}

eval set -- "$options"
while true; do
    case "$1" in
    -c | --healthcheck)
        health=True
        ;;
    -p | --port)
        shift;
        BIND_ADDRESS="$1"
        ;;
    --)
        shift
        break
        ;;
    esac
    shift
done

build
run

if [ $health == True ]; then
    health_check
fi

while true;
do
    trap cleanup EXIT
done