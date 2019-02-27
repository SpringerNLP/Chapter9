FROM nvidia/cuda:10.0-base-ubuntu16.04

# Install some basic utilities
RUN apt-get update && apt-get install -y \
    curl \
    gcc \
    ca-certificates \
    sudo \
    git \
    bzip2 \
    libx11-6 \
    && rm -rf /var/lib/apt/lists/*

# Create a working directory
RUN mkdir /workspace
WORKDIR /workspace

# Create a non-root user and switch to it
RUN adduser --disabled-password --gecos '' --shell /bin/bash user \
    && chown -R user:user /workspace
RUN echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-user
USER user

# All users can use /home/user as their home directory
ENV HOME=/home/user
RUN chmod 777 /home/user

# Install Miniconda
RUN curl -so ~/miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-4.5.11-Linux-x86_64.sh \
    && chmod +x ~/miniconda.sh \
    && ~/miniconda.sh -b -p ~/miniconda \
    && rm ~/miniconda.sh
ENV PATH=/home/user/miniconda/bin:$PATH
ENV CONDA_AUTO_UPDATE_CONDA=false

# Create a Python 3.6 environment
RUN /home/user/miniconda/bin/conda install conda-build \
    && /home/user/miniconda/bin/conda create -y --name py36 python=3.6.5 \
    && /home/user/miniconda/bin/conda clean -ya
ENV CONDA_DEFAULT_ENV=py36
ENV CONDA_PREFIX=/home/user/miniconda/envs/$CONDA_DEFAULT_ENV
ENV PATH=$CONDA_PREFIX/bin:$PATH

# CUDA 10.0-specific steps
RUN conda install -y -c pytorch \
    cuda100=1.0 \
    magma-cuda100=2.4.0 \
    "pytorch=1.0.0=py3.6_cuda10.0.130_cudnn7.4.1_1" \
    torchvision=0.2.1 \
    && conda clean -ya

# Install Torchnet, a high-level framework for PyTorch
RUN pip install torchnet==0.0.4

# Install Requests, a Python library for making HTTP requests
RUN conda install -y requests=2.19.1 \
    && conda clean -ya

# Install jupyter and additional packages
RUN conda install -y jupyter matplotlib scikit-learn tqdm pandas cython cffi

# Install fairseq
RUN sudo apt-get update && sudo apt-get install -y --reinstall build-essential
# RUN git clone https://github.com/pytorch/fairseq.git
# COPY gru.py rnn.py simple_lstm.py fairseq/fairseq/models/
# RUN cd fairseq && pip install --editable .

# Install spacy with English and French models
RUN pip install -U spacy \
    && python -m spacy download en \
    && python -m spacy download fr

# Install torchtext
RUN pip install torchtext

# Set the locale
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Copy data to container
COPY ./ /workspace/

# Set the default command to python3
CMD ["jupyter", "notebook", "--ip=0.0.0.0"]

