#!/bin/sh

# Check if exactly 2 arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 URL TARGET_PATH"
  exit_func 1
fi

# Assigning command line arguments to variables
URL="$1"
TARGET_PATH="$2"

# Define the location and name for the downloaded file
FILENAME="$(basename "$URL")"

# Downloading the file
echo "Downloading $FILENAME from $URL..."
curl -L "$URL" -o "$FILENAME"

# Checking if the download was successful
if [ $? -eq 0 ]; then
  echo "Download completed. Extracting to $TARGET_PATH..."

  # Create target directory if it doesn't exist
  mkdir -p "$TARGET_PATH"

  # Extracting the tar file
  tar -xvf "$FILENAME" -C "$TARGET_PATH"

  # Checking if the extraction was successful
  if [ $? -eq 0 ]; then
    echo "Extraction completed successfully."
  else
    echo "An error occurred during extraction."
    exit_func 1
  fi
else
  echo "An error occurred during download."
  exit_func 1
fi

exit_func

exit_func() {
  if [ "$SLEEP" = "true"]; then
    sleep infinity
  else
    if [ -f "$1" ]; then
      exit $1
    else
      exit 0
    fi
  fi
}

