# FROM ubuntu:20.04
FROM nvidia/cuda:11.2.0-base-ubuntu20.04
LABEL MAINTAINER="Jake Wall <jake@maraelephantproject.org>"
USER root
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Fix DL4006
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub

# install all os packages
RUN export DEBIAN_FRONTEND="noninteractive" && apt-get update && apt-get -y --no-install-recommends --fix-missing install \
  apt-utils \
	tzdata \
	ca-certificates \
	bzip2 \
	zip \
	g++ \
	gcc \
	libc6-dev \
	make \
	libxrender1 \
	libxext6 \
	nano \
	curl \
	htop \
	libgmp3-dev \
	libudunits2-dev \ 
	build-essential \
	&& ln -s /bin/tar /bin/gtar \
	&& /sbin/ldconfig \
	&& apt-get -y autoremove \
	&& apt-get autoclean \
	&& rm -rf /var/lib/apt/lists/* /var/log/dpkg.log

# install and update conda
RUN curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
  && bash /tmp/miniconda.sh -bfp /usr/local \
  && rm -rf /tmp/miniconda.sh \
  && conda config --system --prepend channels conda-forge  \
  && conda config --system --set auto_update_conda false  \
  && conda config --system --set show_channel_urls true  \
  #&& conda config --system --set channel_priority strict \
  && conda install --yes conda-env \
  && conda update --all -y

ENV PATH /usr/local/bin:$PATH
ENV PATH /opt/conda/bin:$PATH
ENV CUDA_DIR /usr/local/cuda

RUN conda init bash

ADD conda_env.yml conda_env.yml

RUN conda update -n base conda && conda install -y 'tini=0.18.0' && conda install mamba -n base -c conda-forge

RUN mamba env update -n base --file conda_env.yml && mamba clean --all -y

ADD r_env.R r_env.R

# Install R packages
RUN R —no-save -f r_env.R