# Use an official lightweight Linux image as the base image
FROM alpine:latest

# Set working directory inside the container
WORKDIR /app

# Copy the Bash script into the container
COPY test.sh /app/test.sh

# Install required dependencies (curl and jq)
RUN apk add --no-cache curl jq

# Make the script executable
RUN chmod +x /app/test.sh

# Set the entrypoint to execute the Bash script
ENTRYPOINT ["/bin/sh", "/app/test.sh"]
