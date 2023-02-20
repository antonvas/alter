#!/usr/bin/env bash

echo 'Loading...'

mkdir -p /app/models

declare -A models
models=(
  ["model_large_caption.pth"]="https://storage.googleapis.com/sfr-vision-language-research/BLIP/models/"
  ["ViT-L-14.pt"]="https://openaipublic.azureedge.net/clip/models/b8cca3fd41ae0c99ba7e8951adf17d267cdb84cd88be6f7c2e0eca1737a03836/"
  ["ViT-L-14_openai_artists.safetensors"]="https://huggingface.co/pharma/ci-preprocess/resolve/main/"
  ["ViT-L-14_openai_flavors.safetensors"]="https://huggingface.co/pharma/ci-preprocess/resolve/main/"
  ["ViT-L-14_openai_mediums.safetensors"]="https://huggingface.co/pharma/ci-preprocess/resolve/main/"
  ["ViT-L-14_openai_movements.safetensors"]="https://huggingface.co/pharma/ci-preprocess/resolve/main/"
  ["ViT-L-14_openai_trendings.safetensors"]="https://huggingface.co/pharma/ci-preprocess/resolve/main/"
  ["ViT-L-14_openai_negative.safetensors"]="https://huggingface.co/pharma/ci-preprocess/resolve/main/"
)

for file in "${!models[@]}"; do
  if ! test -f /app/models/$file
  then
    curl -L ${models[$file]}$file --output /app/models/$file
  fi
done


gunicorn --reload --log-level debug --bind 0.0.0.0:80 --timeout 120  --pythonpath '/app' main:app --workers 1 --worker-class eventlet