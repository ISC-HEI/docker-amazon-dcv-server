FROM ubuntu:24.04

# Setup mirror
ARG UBUNTU_MIRROR=ch
ARG DEBIAN_FRONTEND=noninteractive
RUN sed --in-place --regexp-extended "s/(\/\/)(archive\.ubuntu)/\1${UBUNTU_MIRROR}.\2/" /etc/apt/sources.list.d/ubuntu.sources

RUN apt-get update && apt-get install -y \
        apt-transport-https gpg \
        init sudo \
        wget curl nano vim \
        metacity xterm \
        && rm -rf /var/lib/apt/lists/*

RUN echo 'ubuntu:toto1234' | chpasswd && \
  usermod -aG sudo ubuntu && \
  echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

CMD ["/sbin/init"]

#RUN    wget -q https://d1uj6qtbmh3dt5.cloudfront.net/NICE-GPG-KEY \
#    && gpg --import NICE-GPG-KEY \
#    && rm NICE-GPG-KEY \
#    && wget -q https://d1uj6qtbmh3dt5.cloudfront.net/nice-dcv-ubuntu2404-x86_64.tgz \
#    && echo "export DIR=`tar -tf nice-dcv-ubuntu2404-x86_64.tgz | head -1`" >> /envfile \
#    && echo "export A=`tar -tf nice-dcv-ubuntu2404-x86_64.tgz | grep nice-dcv-server`" >> #/envfile \
#    && echo "export B=`tar -tf nice-dcv-ubuntu2404-x86_64.tgz | grep nice-dcv-web-#viewer`" >> /envfile \
#    && echo "export C=`tar -tf nice-dcv-ubuntu2404-x86_64.tgz | grep nice-xdcv`" >> /#envfile \
#    && echo "export D=`tar -tf nice-dcv-ubuntu2404-x86_64.tgz | grep nice-dcv-gl_`" >> /#envfile \
#    && echo "export E=`tar -tf nice-dcv-ubuntu2404-x86_64.tgz | grep nice-dcv-gltest`" >> #/envfile \
#    && echo "export F=`tar -tf nice-dcv-ubuntu2404-x86_64.tgz | grep nice-xdcv`" >> /#envfile \
#    && tar xzf nice-dcv-ubuntu2404-x86_64.tgz \
#    && apt-get update \
#    && . /envfile \
#    && apt install -y /$A \
#    && apt install -y /$B \
#    && apt install -y /$C \
#    && apt install -y /$D \
#    && apt install -y /$E \
#    && apt install -y /$F \
#    && rm -rf /var/lib/apt/lists/* /$DIR /nice-dcv-ubuntu2404-x86_64.tgz
#
#RUN    sudo usermod -aG video ubuntu
#RUN    sudo usermod -aG video dcv
#RUN    sudo systemctl enable dcvserver
#RUN    sudo systemctl enable dcvsessionlauncher
#
