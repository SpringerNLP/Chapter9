# Chapter 9 - Attention and Memory Augmented Networks
This case study explores the basics of attention as applied to English to French Neural Machine Translation. The same dataset that we created in [Chapter 7](https://github.com/SpringerNLP/Chapter7) is used here (we repeat the preprocessing a second time since we use a separate Docker image).

## Requirements
Without GPU (CPU only):
* [Docker](https://docs.docker.com/install/) 

If using a GPU: 
* [Nvidia docker2](https://github.com/nvidia/nvidia-docker/wiki/Installation-(version-2.0)#installing-version-20)

## Running the Docker Image
The docker images for this case study are located on dockerhub. Running the commands below will automatically download and start a jupyter notebook.

Run the Docker image for CPU only computation:
```
docker run -p 8888:8888 --rm springernlp/chapter_9nmt:latest
```

Run the Docker image with GPU access: 
```
docker run --runtime=nvidia -p 8888:8888 --rm springernlp/chapter_9nmt:latest
```

## Building the Docker image
```
docker build -t chapter_9nmt:latest .
```
