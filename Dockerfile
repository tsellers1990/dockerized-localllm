FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential cmake git curl libopenblas-dev \
    && rm -rf /var/lib/apt/lists/*

# Set workdir
WORKDIR /app

# Clone llama.cpp
RUN git clone https://github.com/ggerganov/llama.cpp.git .
RUN make server

# Expose port
EXPOSE 8080

# Run the server
CMD ["./server", "-m", "/models/model.gguf", "--port", "8080"]
