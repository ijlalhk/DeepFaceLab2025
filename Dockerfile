# Use NVIDIA's CUDA 11.8 base image with Ubuntu 22.04
FROM nvidia/cuda:11.8.0-base-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-dev \
    git wget unzip \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace/DeepFaceLab

# Copy the requirements.txt file from your local machine to the Docker image
COPY requirements.txt .

# Debugging: Check if the file exists inside the container
RUN ls -lah requirements.txt

# Install TensorFlow and essential dependencies
RUN pip3 install --upgrade pip && \
    pip3 install tensorflow==2.13.1 numpy opencv-python

# Install dependencies from requirements.txt
RUN pip3 install -r requirements.txt

# Set default shell to bash
CMD ["/bin/bash"]
