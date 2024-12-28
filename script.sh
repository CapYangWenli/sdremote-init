#!/bin/bash

wget -O "/workspace/stable-diffusion-webui/models/Stable-diffusion/realdreampony.safetensors" "https://huggingface.co/luisrguerra/real-dream-xl-pony-releases/resolve/main/pony-13-real-dream.safetensors"

wget -O "/workspace/stable-diffusion-webui/models/Stable-diffusion/2dm.safetensors" "https://civitai.com/api/download/models/933040?type=Model&format=SafeTensor&size=pruned&fp=fp16"
