#!/bin/bash

. .env

# Constants
API_URL="https://polygon-mainnet.infura.io/v3/${API_KEY}"
TMP_IMG_FILE="./img.svg"
IMG_FILE_FORMAT="./img-%s.svg"
INTERVAL=4

# Request payload
REQUEST_DATA='{
  "jsonrpc": "2.0",
  "method": "eth_call",
  "params": [
    {
      "from": "0x0000000000000000000000000000000000000000",
      "to":   "0xccdaf00c1782f3af7f841990941366274570c354",
      "data": "0xc87b56dd0000000000000000000000000000000000000000000000000000000000000005"
    },
    "latest"
  ],
  "id": 1
}'

while true; do
  # Move the image and timestamp it
  # mv "${TMP_IMG_FILE}" "$(printf "${IMG_FILE_FORMAT}" "$(date +%s)")"

  # Fetch image data and update the image file
  curl -s "${API_URL}" \
    -X POST \
    -H "Content-Type: application/json" \
    -d "${REQUEST_DATA}" | \
  jq .result | \
  xxd -r -p | \
  cut -d, -f2 | \
  base64 -d -i | \
  jq -r .image > "${TMP_IMG_FILE}.tmp"

  # Move the temporary file
  mv "${TMP_IMG_FILE}.tmp" "${TMP_IMG_FILE}"

  # Sleep for the specified interval
  sleep "${INTERVAL}"
done
 while true; do mv /tmp/img.svg "/tmp/img-`date +%s`.svg"; curl -s https://polygon-mainnet.infura.io/v3/"${YOUR_API_KEY}" \
    -X POST \
    -H "Content-Type: application/json" \
    -d '{"jsonrpc":"2.0","method":"eth_call","params": [{"from": "0x0000000000000000000000000000000000000000","to": "0xccdaf00c1782f3af7f841990941366274570c354","data": "0xc87b56dd0000000000000000000000000000000000000000000000000000000000000005"}, "latest"],"id":1}' | jq  .result | xxd -r -p | cut -d, -f2 | base64 -d -i | jq -r .image | tee /tmp/img.svg; sleep 4;
done
