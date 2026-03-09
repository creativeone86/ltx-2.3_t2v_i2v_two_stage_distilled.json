#!/usr/bin/env bash
set -e

cd /comfyui

mkdir -p /comfyui/models/vae
mkdir -p /comfyui/models/loras/ltxv/ltx2
mkdir -p /comfyui/models/text_encoders
mkdir -p /comfyui/models/upscale_models

download_if_missing() {
  local path="$1"
  shift
  if [ ! -f "$path" ]; then
    echo "Downloading missing model: $path"
    comfy model download "$@"
  else
    echo "Model already present: $path"
  fi
}

download_if_missing \
  /comfyui/models/vae/ltx-2.3-22b-dev.safetensors \
  --url https://huggingface.co/Lightricks/LTX-2.3/resolve/main/ltx-2.3-22b-dev.safetensors \
  --relative-path models/vae \
  --filename ltx-2.3-22b-dev.safetensors

download_if_missing \
  /comfyui/models/loras/ltxv/ltx2/ltx-2.3-22b-distilled-lora-384.safetensors \
  --url https://huggingface.co/Lightricks/LTX-2.3/resolve/main/ltx-2.3-22b-distilled-lora-384.safetensors \
  --relative-path models/loras \
  --filename ltxv/ltx2/ltx-2.3-22b-distilled-lora-384.safetensors

download_if_missing \
  /comfyui/models/text_encoders/comfy_gemma_3_12B_it.safetensors \
  --url https://huggingface.co/Comfy-Org/ltx-2/resolve/main/split_files/text_encoders/gemma_3_12B_it.safetensors \
  --relative-path models/text_encoders \
  --filename comfy_gemma_3_12B_it.safetensors

download_if_missing \
  /comfyui/models/upscale_models/ltx-2.3-spatial-upscaler-x2-1.0.safetensors \
  --url https://huggingface.co/Lightricks/LTX-2.3/resolve/main/ltx-2.3-spatial-upscaler-x2-1.0.safetensors \
  --relative-path models/upscale_models \
  --filename ltx-2.3-spatial-upscaler-x2-1.0.safetensors

exec python /comfyui/main.py --listen 0.0.0.0 --port 8188
