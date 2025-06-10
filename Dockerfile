FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential cmake git curl libopenblas-dev \
    libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone llama.cpp source code
RUN git clone https://github.com/ggerganov/llama.cpp.git .

# Build the server binary inside the container
RUN mkdir build && cd build && cmake .. -DLLAMA_BUILD_SERVER=ON && cmake --build . --config Release

EXPOSE 8082

# Start the llama server binary built inside ./build/bin/server
CMD ["./build/bin/llama-server", "-m", "/models/model.gguf", "--port", "8082"]
