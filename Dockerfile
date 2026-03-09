FROM runpod/worker-comfyui:5.5.1-base

USER root

# install git only if the base image does not already include it
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# custom nodes
RUN git clone https://github.com/evanspearman/ComfyMath /comfyui/custom_nodes/ComfyMath

# startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
