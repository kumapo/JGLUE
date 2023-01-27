FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-devel
# FROM nvidia/cuda:11.7.0-cudnn8-devel-ubuntu18.04

# install basic dependencies
# need rust and cargo to build binaries for tokenizer 
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends \
    sudo git wget cmake nano vim gcc g++ build-essential ca-certificates software-properties-common init rustc cargo \
    && rm -rf /var/lib/apt/lists/*

# install common python packages
ADD requirements.txt /tmp/
RUN pip install pip setuptools -U && pip install -r /tmp/requirements.txt

# RUN git clone https://github.com/nvidia/apex /apex && \
#     cd /apex && \
#     pip install -v --no-cache-dir ./

# set working directory
WORKDIR /root/user

# config and clean up
RUN ldconfig \
&& apt-get clean \
&& apt-get autoremove