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

CMD python main.py