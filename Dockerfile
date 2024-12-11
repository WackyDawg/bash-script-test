# Use an official lightweight Linux image as the base image
FROM alpine:latest

# Set working directory inside the container
WORKDIR /app

# Copy the Bash script into the container
COPY test.sh /app/test.sh

# Make the script executable
RUN chmod +x /app/test.sh

# Install required dependencies (e.g., Git)
RUN apk add --no-cache git

# Set the entrypoint to execute the Bash script
ENTRYPOINT ["/bin/sh", "/app/test.sh"]
