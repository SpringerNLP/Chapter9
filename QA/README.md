# Chapter 9 - Attention and Memory Augmented Networks
To help the reader familiarize themselves with the attention and memory networks, we will apply the concepts of this chapter to the question answering task with the bAbI dataset.

## Running the Docker Image
The docker images for this case study are located on dockerhub. Running the commands below will automatically download and start a jupyter notebook.

Run the Docker image on a GPU-enabled host: 
```
docker run --runtime=nvidia -p 8888:8888 --rm springernlp/chapter_9qa:latest
```

## Building the Docker image
```
docker build -t chapter_qa:latest .
```
