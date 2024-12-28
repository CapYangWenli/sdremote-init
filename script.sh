#!/bin/bash
# Scipt has three models to download. by default, it will all f them. if you want to download only one, 
# pass an arguemnt with model indes. 1 for real dream, 2 for 2dm, 3 for cyber pony. you can combine them as well.

# Remote scipt executoin:
# source <(curl -s https://github.com/CapYangWenli/sdremote-init/blob/main/script.sh)


REAL_DREAM_URL="https://huggingface.co/luisrguerra/real-dream-xl-pony-releases/resolve/main/pony-13-real-dream.safetensors"
TDM_URL="https://civitai.com/api/download/models/933040?type=Model&format=SafeTensor&size=pruned&fp=fp16"
CYBER_PONY_URL="https://civitai.com/api/download/models/953264?token=0aa9c7d223a015d4b4ff08ffb006421f"

# Define the download path
DOWNLOAD_PATH="/workspace/stable-diffusion-webui/models/Stable-diffusion"
WOKSPACE_PATH="/workspace"

download_model() {
    local url=$1
    local model_name=$2
    echo "Downloading $model_name to $DOWNLOAD_PATH..."
    curl -o "$DOWNLOAD_PATH/$model_name" $url
    echo "$model_name downloaded to $DOWNLOAD_PATH."
}

# Check if arguments are passed
if [ $# -eq 0 ]; then
    # No arguments, download all models
    download_model $REAL_DREAM_URL "real_dream_model"
    download_model $TDM_URL "2dm_model"
    download_model $CYBER_PONY_URL "cyber_pony_model"
else
    # Download specified models
    for arg in "$@"; do
        case $arg in
            *1*)
                download_model $REAL_DREAM_URL "real_dream_model"
                ;;
            *2*)
                download_model $TDM_URL "2dm_model"
                ;;
            *3*)
                download_model $CYBER_PONY_URL "cyber_pony_model"
                ;;
            *f*)
                # Delete workspace
                rm -rf $WOKSPACE_PATH
            *)
                echo "Invalid argument: $arg. Valid arguments are 1, 2, 3."
                ;;
        esac
    done
fi