# Use an official base image that includes bash, curl, and tar.
# Alpine Linux is a good choice for a lightweight container.
FROM alpine:latest

# Install curl and tar if not already included in the base image
RUN apk --no-cache add curl tar

# Define an environment variable for the default URL and TARGET_PATH
# These can be overridden at docker run command
ENV URL=http://example.com/myfile.tar
ENV TARGET_PATH=/data

# Create the target directory
RUN mkdir -p ${TARGET_PATH}

# Copy the script into the container
COPY download_and_extract.sh /usr/local/bin/download_and_extract.sh

# Ensure the script is executable
RUN chmod +x /usr/local/bin/download_and_extract.sh

# Set the working directory to the target path
WORKDIR ${TARGET_PATH}

# Run the script with URL and TARGET_PATH as parameters
# This CMD can be overridden with different parameters at runtime
CMD ["/bin/sh", "-c", "/usr/local/bin/download_and_extract.sh ${URL} ${TARGET_PATH}"]
