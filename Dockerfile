FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential cmake git curl libopenblas-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Clone llama.cpp
RUN git clone https://github.com/ggerganov/llama.cpp.git .

# Build with CMake (server mode)
RUN mkdir build && cd build && cmake .. -DLLAMA_BUILD_SERVER=ON && cmake --build . --config Release

# Expose API port
EXPOSE 8082

# Run server with model file
CMD ["./build/bin/server", "-m", "/models/model.gguf", "--port", "8080"]
