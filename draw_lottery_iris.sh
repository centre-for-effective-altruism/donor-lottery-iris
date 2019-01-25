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

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "please provide exactly one argument"


EVENT_ID=$1

URL="http://service.iris.edu/fdsnws/event/1/query?eventid=$EVENT_ID&format=text"
RESPONSE_CODE=$(curl -o /dev/null -s -w "%{http_code}\n" $URL)
[ "$RESPONSE_CODE" -eq '200' ] || die "Error ($RESPONSE_CODE): check that $EVENT_ID is a valid IRIS event ID"
RESPONSE=$(curl -s $URL)
DIGITS=$(echo $RESPONSE | tr -d '\n' | awk '{gsub(/[^0-9]/,"")}1')
HASH=$(echo $DIGITS | openssl dgst -sha256 -binary | xxd -p | head -n 1 )
WINNING_NUMBER_HEX=$(echo $HASH | cut -c -10)
WINNING_NUMBER_DEC=$((16#$WINNING_NUMBER_HEX))

echo ""
echo "  URL:"
echo "  $URL"
echo ""
echo "  API Response:"
echo "    $RESPONSE"
echo ""
echo "  Winning number (ISIS event $EVENT_ID):"
echo "    digits:  $DIGITS"
echo "    hash:    $HASH"
echo "    hex:     $WINNING_NUMBER_HEX"
echo "    dec:     $WINNING_NUMBER_DEC"
echo ""
