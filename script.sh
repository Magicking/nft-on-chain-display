#!/bin/bash

. .env

# Constants
API_URL="https://polygon-mainnet.infura.io/v3/${API_KEY}"
TMP_IMG_FILE1="./img1.svg"
TMP_IMG_FILE2="./img2.svg"
IMG_FILE_FORMAT="/tmp/img-%s.svg"
INTERVAL=4

toggle=1
while true; do
  # Choose the image file to update
  TMP_IMG_FILE=$([ "$toggle" -eq "1" ] && echo "$TMP_IMG_FILE1" || echo "$TMP_IMG_FILE2")

  cd sl-nft-pixel-art-proto-2
  # Write image.b64uri file
  forge script --fork-url "${ALCHEMY_API_URL}" scripts/generateSVG.sol && \
  cat image.b64uri | \
  cut -d, -f2 | \
  base64 -d -i | \
  jq -r .image | \
  cut -d, -f2 | \
  base64 -d -i > "../${TMP_IMG_FILE}.tmp"

  cd ..
  # Move the temporary file
  mv "${TMP_IMG_FILE}.tmp" "${TMP_IMG_FILE}"

  # Toggle between image file names
  toggle=$((1-toggle))

  # Sleep for the specified interval
  sleep "${INTERVAL}"
done
