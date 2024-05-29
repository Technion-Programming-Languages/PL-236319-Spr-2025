# syntax=docker/dockerfile:1

FROM twyair/safot-smlnj:latest AS base

FROM base AS deps

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt install -y curl \
    && curl -sL https://deb.nodesource.com/setup_20.x | bash - \
    && apt update \
    && apt install -y nodejs git python3-pip \
    && apt install -y swi-prolog

RUN pip3 install jupyter-server ipykernel

RUN npm install -g npm@latest

RUN npm install -g ijavascript
RUN ijsinstall

RUN git clone https://github.com/twyair/simple-ismlnj.git /usr/share/jupyter/kernels/smlnj

RUN pip install --force-reinstall "pyswip==0.2.10"

RUN git clone https://github.com/Whitomtit/jswipl.git /usr/share/jupyter/kernels/jswipl

FROM deps AS build

WORKDIR /root/source

COPY . .

RUN npm install --omit=dev

FROM build as final

RUN git clone https://github.com/OpenUniversity/PL-236319-Spr-2024.git repository

RUN ln -s repository/Material material
RUN ln -s repository/Material/Tutorials/imgs imgs

RUN chmod +x /root/source/start.sh 

EXPOSE 16788 16789

ENTRYPOINT [ "/root/source/start.sh" ]