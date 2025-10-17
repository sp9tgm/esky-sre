#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
archive_path="${script_dir}/logs.tar.bz2"
method_filter=""
user_agent_filter=""

print_help() {
   cat <<'USAGE'
Usage: script.sh [OPTIONS]

Parse HTTP logs and print the number of requests per unique IP address.

Options:
  --user-agent PATTERN   Only include requests whose user agent contains PATTERN.
  --method METHOD        Only include requests matching the HTTP METHOD (e.g. GET).
  -h, --help             Show this help message and exit.
USAGE
}

error() {
   echo "$*" >&2
   exit 1
}

while [[ $# -gt 0 ]]; do
   case "$1" in
      -h|--help)
         print_help
         exit 0
         ;;
      --user-agent)
         shift || error "Missing value for --user-agent"
         user_agent_filter="$1"
         ;;
      --method)
         shift || error "Missing value for --method"
         method_filter="$1"
         ;;
      *)
         error "Unknown option: $1"
         ;;
   esac
   shift || break
done

[[ -f "$archive_path" ]] || error "Archive not found: $archive_path"

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

tar -xjf "$archive_path" -C "$tmp_dir"

if [[ -f "$tmp_dir/logs/logs.log" ]]; then
   log_file="$tmp_dir/logs/logs.log"
else
   log_file=$(find "$tmp_dir" -type f -name 'logs.log' -print -quit)
fi

[[ -n "${log_file:-}" ]] || error "Unable to find extracted log file"

awk -v method_filter="$method_filter" \
    -v user_agent_filter="$user_agent_filter" '
function extract(field,    pattern, start, remaining, endpos) {
   pattern = field ": \""
   start = index($0, pattern)
   if (start == 0) {
      return ""
   }
   remaining = substr($0, start + length(pattern))
   endpos = index(remaining, "\"")
   if (endpos == 0) {
      return ""
   }
   return substr(remaining, 1, endpos - 1)
}
{
   method = extract("method")
   if (method_filter != "" && method != method_filter) {
      next
   }
   ua = extract("user_agent")
   if (user_agent_filter != "" && index(ua, user_agent_filter) == 0) {
      next
   }
   ip = extract("client_ip")
   if (ip != "") {
      print ip
   }
}' "$log_file" |
   sort |
   uniq -c |
   sort -rn |
   awk 'BEGIN { printf "%-17s %s\n", "ADDRESS", "REQUESTS" }
        { printf "%-17s %s\n", $2, $1 }'
