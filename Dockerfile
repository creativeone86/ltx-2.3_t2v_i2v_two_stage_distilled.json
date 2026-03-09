# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
# Unknown-registry nodes: clone directly from GitHub when aux_id is provided
RUN git clone https://github.com/evanspearman/ComfyMath /comfyui/custom_nodes/ComfyMath
# Could not resolve the following unknown-registry custom nodes (no aux_id provided):
# - LTXVImgToVideoConditionOnly (no aux_id available in workflow metadata)
# - GemmaAPITextEncode (no aux_id available in workflow metadata)
# - LTXVImgToVideoConditionOnly (duplicate entry, no aux_id)
# - GemmaAPITextEncode (duplicate entry, no aux_id)

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2.3/resolve/main/ltx-2.3-22b-dev.safetensors --relative-path models/vae --filename ltx-2.3-22b-dev.safetensors
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2.3/resolve/main/ltx-2.3-22b-distilled-lora-384.safetensors --relative-path models/loras --filename ltxv/ltx2/ltx-2.3-22b-distilled-lora-384.safetensors
# The repository contains a file named gemma_3_12B_it.safetensors (HuggingFace Comfy-Org/ltx-2).
# The requested filename in the workflow is comfy_gemma_3_12B_it.safetensors (different).
# We'll download the actual file and rename it during download to the requested filename.
RUN comfy model download --url https://huggingface.co/Comfy-Org/ltx-2/resolve/main/split_files/text_encoders/gemma_3_12B_it.safetensors --relative-path models/text_encoders --filename comfy_gemma_3_12B_it.safetensors
RUN comfy model download --url https://huggingface.co/Lightricks/LTX-2.3/resolve/main/ltx-2.3-spatial-upscaler-x2-1.0.safetensors --relative-path models/upscale_models --filename ltx-2.3-spatial-upscaler-x2-1.0.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
