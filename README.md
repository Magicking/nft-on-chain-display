# NFT-On-Chain-Display

This repository contains two files:

1. `script.sh` - A shell script to download and update an image file from a remote API.
2. `index.html` - A simple webpage that displays the downloaded image as a dynamic background.

## Overview

The `script.sh` file fetches image data from a remote API, saves it to one of two alternating image files (`img1.svg` and `img2.svg`), and sleeps for a specified interval. The `index.html` file displays the background image from either `img1.svg` or `img2.svg` and refreshes the background image at regular intervals, creating a dynamic background effect.

## Prerequisites

To use the script, you'll need the following dependencies installed on your system:

- `curl`
- `jq`
- `xxd`

These dependencies can be installed on most systems using the package manager, such as `apt`, `yum`, or `brew`.

## Usage

1. Replace `YOUR_API_KEY` in the `.env` file with your actual API key (copied from `.env.example` file).
2. Run the `script.sh` script in the background, e.g., `./script.sh &`.
3. Serve the `index.html` file using a web server, such as `python -m http.server` or `php -S localhost:8000`.
4. Open the served `index.html` file in a web browser to see the dynamic background in action.

## Customization

You can customize the interval at which the script fetches the image data and the webpage refreshes the background image by modifying the `INTERVAL` constant in the `script.sh` file and the `setInterval` parameter in the `index.html` file.

For example, to set the interval to 10 seconds, update the `INTERVAL` constant in `script.sh` to `14` and the `setInterval` parameter in `index.html` to `14000` (milliseconds).
