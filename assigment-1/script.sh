#!/bin/bash

#variables:
zipped_logs='./logs.tar.bz2'
logs_dir=./logs
log_file=./logs/logs.log

help() (
   echo "Usage: $0 [Options]"
   echo
   echo "Script:"
   echo "    This script allows you to parse HTTP server logs"
   echo "    By default it shows number of request per unique ip address."
   echo "    You can also restrict parsing of logs only to provided user agent using --user-agent option"
   echo "    or group requests count by method for each ip address using --method option."
   echo
   echo "Options:"
   echo "    --user-agent user-agent  Show entries with specified user-agent."
   echo "    --method                 Group entries per method for unique IP address."
   echo "    --help | -h              Prints this message."
   echo "Examples:"
   echo "// Display IP addresses and requests count:"
   echo "$0"
   echo "   ADDRESS           REQUESTS"
   echo "   10.61.190.251     73"
   echo "   10.221.134.57     67"
   echo "   10.243.143.36     65"
   echo "   10.205.194.30     60"
   echo "   10.208.93.162     58"
   echo
   echo "// Display IP adrresses, methods and requests count per IP/method: "
   echo "$0 --method"
   echo "   ADDRESS           METHOD     REQUESTS"
   echo "   10.167.144.35     GET        10679"
   echo "   10.77.167.84      GET        10506"
   echo "   10.77.167.208     GET        10438"
   echo "// Display IP addresses and requests count per IP only from givern user-agent."
   echo "$0 --user-agent Mozilla"
   echo "   ADDRESS           REQUESTS"
   echo "   10.167.144.35     10679"
   echo "   10.77.167.84      10506"
   echo "   10.77.167.208     10438"
   echo "   10.21.35.251      1243"
)

parse() (
   grep $1 $log_file | awk '{gsub(/"/, "");print $14,$6}' | sort | sort | uniq -c | sort -rn | awk 'BEGIN {printf "%-17s %-10s %s \n", "ADDRESS","METHOD", "REQUESTS"} {printf ("%-17s %-10s %s\n", $2,$3,$1)}'
)
extract() {
   tar -xf $zipped_logs
}
remove() {
   rm -r $logs_dir
}

options=$(getopt -o h --long help,method:,user-agent: -- "$@")
[ $? -eq 0 ] || {
   echo "Incorrect options provided"
   exit 1
}

eval set -- "$options"
while true; do
   case "$1" in
   -h | --help)
      help
      exit 0
      ;;
   --method)
      extract
      echo $2
      parse $2
      remove
      exit 0
      ;;
   --user-agent)
      extract
      parse $2
      remove
      exit 0
      ;;
   *)
      extract
      parse
      remove
      exit 0
      ;;
   --)
      shift
      break
      ;;
   esac
   shift
done
