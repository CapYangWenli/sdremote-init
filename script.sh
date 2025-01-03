#!/bin/bash
# Script has three models to download. By default, it will download all of them. If you want to download only one,
# pass an argument with the model index: 1 for real dream, 2 for 2dm, 3 for cyber pony. You can combine them as well.

# Remote script execution:
# source <(curl -s https://raw.githubusercontent.com/CapYangWenli/sdremote-init/main/script.sh)

REAL_DREAM_URL="https://huggingface.co/luisrguerra/real-dream-xl-pony-releases/resolve/main/pony-13-real-dream.safetensors"
TDM_URL="https://civitai.com/api/download/models/933040?type=Model&format=SafeTensor&size=pruned&fp=fp16"
CYBER_PONY_URL="https://civitai.com/api/download/models/953264?token=0aa9c7d223a015d4b4ff08ffb006421f"

# Define the download path
DOWNLOAD_PATH="/workspace/stable-diffusion-webui/models/Stable-diffusion"
STYLES_PATH="/workspace/stable-diffusion-webui/styles.csv"
WOKSPACE_PATH="/workspace"

# Function to download a model
download_model() {
    local url=$1
    local model_name=$2
    echo "Downloading $model_name to $DOWNLOAD_PATH..."
    curl -L -o "$DOWNLOAD_PATH/$model_name" "$url"
    echo "$model_name downloaded to $DOWNLOAD_PATH."
}

# Function to replace styles.csv
replace_styles_csv() {
    echo "Replacing styles.csv..."
    mkdir -p "$(dirname "$STYLES_PATH")"
    cat <<EOL > $STYLES_PATH
name,prompt,negative_prompt
realdream,"score_9, score_8_up, score_7_up, score_6_up, score_5_up", "score_6, score_5, score_4, source_pony, (worst quality:1.2), (low quality:1.2), (normal quality:1.2), lowres, bad anatomy"
EOL
    echo "styles.csv replaced."
}

# Replace styles.csv
replace_styles_csv

# Check if arguments are passed
if [ $# -eq 0 ]; then
    # No arguments, download all models
    download_model $REAL_DREAM_URL "real_dream_model.safetensors"
    download_model $TDM_URL "2dm_model.safetensors"
    download_model $CYBER_PONY_URL "cyber_pony_model.safetensors"
else
    # Download specified models
    for arg in "$@"; do
        case $arg in
            *1*)
                download_model $REAL_DREAM_URL "real_dream_model.safetensors"
                ;;
            *2*)
                download_model $TDM_URL "2dm_model.safetensors"
                ;;
            *3*)
                download_model $CYBER_PONY_URL "cyber_pony_model.safetensors"
                ;;
            *f*)
                # Delete workspace
                rm -rf $WOKSPACE_PATH
                ;;
            *)
                echo "Invalid argument: $arg. Valid arguments are 1, 2, 3."
                ;;
        esac
    done
fi