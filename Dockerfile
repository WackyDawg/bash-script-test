# Use an official Ubuntu base image
FROM ubuntu:20.04

# Set environment variables
ENV GITHUB_USERNAME="WackyDawg"
ENV GITHUB_REPO="wpgarlic"
ENV REMOTE_URL="https://github.com/$GITHUB_USERNAME/$GITHUB_REPO.git"

# Set non-interactive mode to avoid prompt during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies (Python, Git, and other required tools)
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv git && \
    apt-get clean

# Set the working directory inside the container
WORKDIR /app

# Step 1: Clone the GitHub repository
RUN git clone "$REMOTE_URL" && \
    cd "$GITHUB_REPO"

# Step 2: Create and activate the virtual environment
RUN python3 -m venv venv

# Step 3: Install Python requirements inside the virtual environment
#COPY requirements.txt ./
RUN . venv/bin/activate && \
    pip install --quiet --upgrade pip && \
    pip install --quiet -r requirements.txt

# Step 4: Copy the rest of the application files into the container
COPY . .

# Expose port for the local server
EXPOSE 4000

# Start the local server in the background and run the fuzzing command
CMD python3 -m http.server 4000 --bind 0.0.0.0 & \
    python fuzz_object.py plugin responsive-vector-maps --version 6.4.0 && \
    kill $!
