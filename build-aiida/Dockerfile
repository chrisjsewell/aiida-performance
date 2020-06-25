
FROM phusion/baseimage:0.11 AS build-image
# Ubuntu 18.04 LTS image that correctly manages daemon processes
# see: https://github.com/phusion/baseimage-docker
LABEL maintainer="AiiDA Team"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Fix locales.
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
# without this tzlocal complains
ENV TZ Europe/Zurich

# install linux packages
ARG PYTHON_VERSION="3.7"
ENV DEBIAN_FRONTEND=noninteractive
RUN /sbin/install_clean \
    python${PYTHON_VERSION} \
    python${PYTHON_VERSION}-dev \
    python${PYTHON_VERSION}-distutils \
    python${PYTHON_VERSION}-venv \
    build-essential \
    ssh \
    locales \
    netcat \
    sudo \
    git \
    time \
    vim
    # bzip2 \
    # zip \
    # unzip \

# add user (no password) and setup owned folders
ENV NB_USER="aiida"
RUN useradd -m -s /bin/bash ${NB_USER}
RUN mkdir -p /home/${NB_USER}/ && \
    mkdir -p /home/${NB_USER}/.aiida && \
    mkdir -p /home/${NB_USER}/outputs && \
    chown ${NB_USER}:${NB_USER} /home/${NB_USER}/ && \
    chown ${NB_USER}:${NB_USER} /home/${NB_USER}/.aiida && \
    chown ${NB_USER}:${NB_USER} /home/${NB_USER}/outputs && \
    echo 'eval "$(_VERDI_COMPLETE=source verdi)"' >> /home/${NB_USER}/.bashrc

# intialise virtual env
RUN python${PYTHON_VERSION} -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install -U pip==20.1.1
COPY requirements.txt .
RUN pip install -U -r requirements.txt

# install python packages
ARG GIT_BRANCH="v1.2.1"
RUN git clone --branch ${GIT_BRANCH} https://github.com/aiidateam/aiida-core "/home/${NB_USER}/aiida-core"
RUN pip install -r "/home/${NB_USER}/aiida-core/requirements/requirements-py-${PYTHON_VERSION}.txt"
RUN pip install --no-deps -e "/home/${NB_USER}/aiida-core"
ENV AIIDA_PKG="/home/${NB_USER}/aiida-core/aiida"

# set working directory
USER ${NB_USER}
WORKDIR "/home/${NB_USER}/"
RUN reentry scan

# must start in root to run init
USER root
