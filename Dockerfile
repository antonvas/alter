FROM python:3.9-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    build-essential \
    curl \
    libpng-dev \
    libjpeg-dev \
    gcc

RUN pip install --upgrade pip

RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

RUN pip install torch torchvision --extra-index-url https://download.pytorch.org/whl/cu117

COPY ./requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

RUN mkdir /app
WORKDIR /app

COPY . /app

RUN mkdir -p ./models

# RUN curl -L https://storage.googleapis.com/sfr-vision-language-research/BLIP/models/model_base_caption_capfilt_large.pth --output ./models/model_base_caption_capfilt_large.pth

# RUN curl -L https://storage.googleapis.com/sfr-vision-language-research/BLIP/models/model_large_caption.pth --output ./models/model_large_caption.pth
RUN curl -L https://openaipublic.azureedge.net/clip/models/b8cca3fd41ae0c99ba7e8951adf17d267cdb84cd88be6f7c2e0eca1737a03836/ViT-L-14.pt --output ./models/ViT-L-14.pt
# RUN curl -L https://huggingface.co/pharma/ci-preprocess/resolve/main/ViT-L-14_openai_artists.safetensors --output ./models/ViT-L-14_openai_artists.safetensors
# RUN curl -L https://huggingface.co/pharma/ci-preprocess/resolve/main/ViT-L-14_openai_flavors.safetensors --output ./models/ViT-L-14_openai_flavors.safetensors
# RUN curl -L https://huggingface.co/pharma/ci-preprocess/resolve/main/ViT-L-14_openai_mediums.safetensors --output ./models/ViT-L-14_openai_mediums.safetensors
# RUN curl -L https://huggingface.co/pharma/ci-preprocess/resolve/main/ViT-L-14_openai_movements.safetensors --output ./models/ViT-L-14_openai_movements.safetensors
# RUN curl -L https://huggingface.co/pharma/ci-preprocess/resolve/main/ViT-L-14_openai_trendings.safetensors --output ./models/ViT-L-14_openai_trendings.safetensors
# RUN curl -L https://huggingface.co/pharma/ci-preprocess/resolve/main/ViT-L-14_openai_negative.safetensors --output ./models/ViT-L-14_openai_negative.safetensors

CMD python main.py