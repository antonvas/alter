#!/usr/bin/env bash

echo 'Loading...'

mkdir -p /app/models

if ! test -f /app/models/model_large_caption.pth
then
  curl -L https://storage.googleapis.com/sfr-vision-language-research/BLIP/models/model_large_caption.pth --output /app/models/model_large_caption.pth
fi
if ! test -f /app/models/ViT-L-14.pt
then
  curl -L https://openaipublic.azureedge.net/clip/models/b8cca3fd41ae0c99ba7e8951adf17d267cdb84cd88be6f7c2e0eca1737a03836/ViT-L-14.pt --output /app/models/ViT-L-14.pt
fi
if ! test -f /app/models/ViT-L-14_openai_artists.safetensors
then
  curl -L https://huggingface.co/pharma/ci-preprocess/resolve/main/ViT-L-14_openai_artists.safetensors --output /app/models/ViT-L-14_openai_artists.safetensors
fi
if ! test -f /app/models/ViT-L-14_openai_flavors.safetensors
then
  curl -L https://huggingface.co/pharma/ci-preprocess/resolve/main/ViT-L-14_openai_flavors.safetensors --output /app/models/ViT-L-14_openai_flavors.safetensors
fi
if ! test -f /app/models/ViT-L-14_openai_mediums.safetensors
then
  curl -L https://huggingface.co/pharma/ci-preprocess/resolve/main/ViT-L-14_openai_mediums.safetensors --output /app/models/ViT-L-14_openai_mediums.safetensors
fi
if ! test -f /app/models/ViT-L-14_openai_movements.safetensors
then
  curl -L https://huggingface.co/pharma/ci-preprocess/resolve/main/ViT-L-14_openai_movements.safetensors --output /app/models/ViT-L-14_openai_movements.safetensors
fi
if ! test -f /app/models/ViT-L-14_openai_trendings.safetensors
then
  curl -L https://huggingface.co/pharma/ci-preprocess/resolve/main/ViT-L-14_openai_trendings.safetensors --output /app/models/ViT-L-14_openai_trendings.safetensors
fi
if ! test -f /app/models/ViT-L-14_openai_negative.safetensors
then
  curl -L https://huggingface.co/pharma/ci-preprocess/resolve/main/ViT-L-14_openai_negative.safetensors --output /app/models/ViT-L-14_openai_negative.safetensors
fi


gunicorn --reload --log-level debug --bind 0.0.0.0:80 --timeout 120  --pythonpath '/app' main:app --workers 1 --worker-class eventlet