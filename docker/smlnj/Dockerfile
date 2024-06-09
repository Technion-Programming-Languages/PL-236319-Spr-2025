FROM ubuntu:20.04

ENV SML_VERSION=110.99.5

RUN apt update \
	&& apt install -y rlwrap wget build-essential git \
	&& apt clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/share/smlnj

RUN wget http://smlnj.cs.uchicago.edu/dist/working/${SML_VERSION}/config.tgz \
	&& tar -xzf config.tgz \
	&& rm config.tgz \
	&& config/install.sh \
    && cp bin/sml /usr/bin/smlnj

RUN ln -s /usr/share/smlnj/bin/.heap/sml.amd64-linux /usr/share/smlnj/bin/.heap/smlnj
COPY sml /bin/sml
RUN chmod +x /bin/sml

WORKDIR /root/source
