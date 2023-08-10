
#!/bin/bash

# Call getopt to validate the provided input. 
options=$(getopt -o brg --long healthcheck,port:  -- "$@")
[ $? -eq 0 ] || { 
    echo "Incorrect options providdddddddddddddded"
    exit 1
}
eval set -- "$options"
echo "$options"
while true; do
    case "$1" in
    -b)
        COLOR=BLUE
        ;;
    -r)
        COLOR=RED
        ;;
    --port)
        echo "POOOORT"
        COLOR=GREEN
        ;;
    --healthcheck)
        shift; # The arg is next in position args
        COLOR=$1
        [[ ! $COLOR =~ BLUE|RED|GREEN ]] && {
            echo "Incorrect options provirrrrrrrrrd"
            exit 1
        }
        ;;
    --)
        shift
        break
        ;;
    esac
    shift
done

echo "Color is $COLOR"
exit 0;