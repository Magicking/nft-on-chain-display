#!/bin/bash

. .env

# Constants
API_URL="https://polygon-mainnet.infura.io/v3/${API_KEY}"
TMP_IMG_FILE1="./img1.svg"
TMP_IMG_FILE2="./img2.svg"
IMG_FILE_FORMAT="/tmp/img-%s.svg"
INTERVAL=4

# Request payload
REQUEST_DATA='{
  "jsonrpc": "2.0",
  "method": "eth_call",
  "params": [
    {
      "from": "0x0000000000000000000000000000000000000000",
      "to": "0xccdaf00c1782f3af7f841990941366274570c354",
      "data": "0xc87b56dd0000000000000000000000000000000000000000000000000000000000000005"
    },
    "latest"
  ],
  "id": 1
}'

toggle=1
while true; do
  # Choose the image file to update
  TMP_IMG_FILE=$([ "$toggle" -eq "1" ] && echo "$TMP_IMG_FILE1" || echo "$TMP_IMG_FILE2")

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

  # Toggle between image file names
  toggle=$((1-toggle))

  # Sleep for the specified interval
  sleep "${INTERVAL}"
done
