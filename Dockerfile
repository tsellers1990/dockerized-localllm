FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential cmake git curl libopenblas-dev \
    libcurl4-openssl-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone llama.cpp
RUN git clone https://github.com/ggerganov/llama.cpp.git .

# Build with CMake (server mode)
RUN mkdir build && cd build && cmake .. -DLLAMA_BUILD_SERVER=ON && cmake --build . --config Release

EXPOSE 8082

CMD ["./build/bin/server", "-m", "/models/model.gguf", "--port", "8080"]
