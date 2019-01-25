#!/bin/bash

#  Bash script for calculating the winning lottery number using earthquake
#  data from IRIS (Incorporated Research Institutions for Seismology).
#
#  Usage:
#         ./draw_lottery_iris.sh iris_id
#   e.g.  ./draw_lottery_iris.sh 10998811
#
#  The script works as follows:
#  - get the request from the IRIS server for the relevant event
#  - trim newlines from the response
#  - strip the response to just the numeric digits
#  - get the SHA256 hash of the digit string in binary
#  - cast the binary hash to a hexdump (only keeping the first line)
#  - truncate the hash to its first 10 characters

EVENT_ID=$1

curl -s "http://service.iris.edu/fdsnws/event/1/query?eventid=$EVENT_ID&format=text" \
 | tr -d '\n' \
 | awk '{gsub(/[^0-9]/,"")}1' \
 | openssl dgst -sha256 -binary \
 | xxd -p | head -n 1 \
 | cut -c -10
