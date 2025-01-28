# Use NVIDIA CUDA base image
FROM nvidia/cuda:12.2.2-base-ubuntu22.04

# Set up working directory
WORKDIR /workspace

# Install dependencies
# Install dependencies including OpenBLAS for scipy/numpy
RUN apt update && apt install -y \
    python3 python3-pip git \
    libsm6 libxext6 libxrender-dev \
    ffmpeg libgl1-mesa-glx \
    build-essential cmake libopenblas-dev \
    && rm -rf /var/lib/apt/lists/*


# Copy DeepFaceLab from the local folder (Prevents GitHub cloning)
COPY . /workspace/DeepFaceLab

# Set up Python environment
WORKDIR /workspace/DeepFaceLab

# Install all dependencies (Including the updated OpenCV version)
RUN pip install --no-cache-dir -r requirements.txt

# Run interactive bash session
CMD ["/bin/bash"]