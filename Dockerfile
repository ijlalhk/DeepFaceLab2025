# Use NVIDIA's CUDA image with runtime libraries
FROM nvidia/cuda:11.8.0-runtime-ubuntu22.04

# Set environment variables for TensorFlow and CUDA
ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV PATH="/usr/local/cuda/bin:${PATH}"
ENV LD_LIBRARY_PATH="/usr/local/cuda/lib64:${LD_LIBRARY_PATH}"

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-pip python3-dev \
    git wget unzip \
    libcudnn8=8.6.* \
    libcudnn8-dev=8.6.* \
    && rm -rf /var/lib/apt/lists/*

# Set working directory inside the container
WORKDIR /DeepFaceLab

# ✅ Only copy the requirements file to install dependencies
COPY requirements.txt /DeepFaceLab/requirements.txt

# Install Python dependencies
RUN pip3 install --upgrade pip && \
    pip3 install tensorflow==2.13.1 numpy opencv-python && \
    pip3 install -r requirements.txt

# Install system dependencies for OpenCV and ffmpeg
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    ffmpeg && \
    rm -rf /var/lib/apt/lists/*




# Set default shell to bash
CMD ["/bin/bash"]
