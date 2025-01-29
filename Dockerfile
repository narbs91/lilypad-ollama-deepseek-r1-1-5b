# Use the existing ollama Dockerfile as the base
FROM ollama/ollama

# Set the working directory
WORKDIR /app

# Update and install necessary packages
RUN apt-get update && apt-get install -y wget curl

# Run ollama in the background so we can embed the model
RUN nohup bash -c "ollama serve &" && \
    until curl -s http://127.0.0.1:11434 > /dev/null; do \
        echo "Waiting for ollama to start..."; \
        sleep 5; \
    done && \
    ollama pull deepseek-r1:1.5b

EXPOSE 11434

# Set the environment variable for the ollama host
ENV OLLAMA_HOST=0.0.0.0

# Create a single outputs directory and set permissions
RUN mkdir -p /app/outputs && chmod 777 /app/outputs

# Set outputs directory as a volume
VOLUME /app/outputs

# Copy a script to start ollama and handle input
COPY run_deepseek.sh /app/run_deepseek.sh
RUN chmod +x /app/run_deepseek.sh

# Set the entrypoint to the script
ENTRYPOINT ["/app/run_deepseek.sh"]