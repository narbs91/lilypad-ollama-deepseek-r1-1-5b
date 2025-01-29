#!/bin/bash

# Create output directory if it doesn't exist
mkdir -p outputs

# Start the ollama server in the background.
nohup bash -c "ollama serve &" >&2

until curl -s http://127.0.0.1:11434 > /dev/null; do
    echo "Waiting for ollama to start..." >&2
    sleep 1
done

# Generate the response
response=$(ollama run deepseek-r1:1.5b "$1")

# Get Unix timestamp for 'created' field
created=$(date +%s)

# Create JSON structure following OpenAI format
json_output="{
    \"id\": \"cmpl-$(openssl rand -hex 12)\",
    \"object\": \"text_completion\",
    \"created\": $created,
    \"model\": \"deepseek-r1:1.5b\",
    \"choices\": [{
        \"text\": \"$response\",
        \"index\": 0,
        \"logprobs\": null,
        \"finish_reason\": \"stop\"
    }],
    \"usage\": {
        \"prompt_tokens\": null,
        \"completion_tokens\": null,
        \"total_tokens\": null
    }
}"

echo "$json_output"

# Write JSON to file
echo "$json_output" > "outputs/response.json"

# Print confirmation message
echo "Response saved to outputs/response.json"

exit 0