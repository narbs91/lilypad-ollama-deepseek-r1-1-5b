# Lilypad DeepSeek R1 1.5B

This is a Lilypad module for the DeepSeek R1 1.5B model.

## Requirements

- Lilypad CLI
- Docker

## Setup

1. Clone the repository
2. Build the Docker image

```bash
docker buildx build --platform linux/amd64 -t lilypad-ollama-deepseek-r1-1-5b:latest .
```

3. Tag the image
```bash
docker tag lilypad-ollama-deepseek-r1-1-5b:latest <your-dockerhub-username>/lilypad-ollama-deepseek-r1-1-5b:latest
```

4. Push the image to Docker Hub
```bash
docker push <your-dockerhub-username>/lilypad-ollama-deepseek-r1-1-5b:latest
```

## Usage

Test locally with Docker:

```bash
docker run lilypad-ollama-deepseek-r1-1-5b:latest "Tell me about black holes" 
```
Run on the Lilypad Network using the following command:

```bash
lilypad run narbs91/lilypad-ollama-deepseek-r1-1-5b:latest --web3-private-key <your-private-key> --prompt "What is bitcoin?"
```