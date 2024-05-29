FROM alpine:3.20

ENV PYTHONUNBUFFERED=1
ENV PYTHONWARNINGS="ignore"
ENV GTAGSLABEL=pygments
ENV GTAGSCONF=/usr/local/share/gtags/gtags.conf
ENV libdir=/usr/local/lib

RUN apk add --no-cache bash bash-doc bash-completion
RUN apk add --no-cache build-base
RUN apk add --no-cache binutils
RUN apk add --no-cache ncurses-dev
RUN apk add --no-cache ctags
RUN apk add --no-cache python3 py3-pip
RUN apk add --no-cache git
RUN pip3 install  --break-system-packages --no-cache --upgrade Pygments

# # install GNU global

RUN wget https://ftp.gnu.org/pub/gnu/global/global-6.6.12.tar.gz -O global.tar.gz
RUN tar xf "global.tar.gz" && \
    cd global-6.6.12 && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    rm -r global-6.6.12 && \
    rm "global.tar.gz"

# install free pascal compiler

RUN wget http://downloads.freepascal.org/fpc/dist/3.2.2/x86_64-linux/fpc-3.2.2.x86_64-linux.tar -O fpc.tar
RUN tar xf "fpc.tar" && \
    cd fpc-3.2.2.x86_64-linux && \
    source ./install.sh && \
    cd .. && \
    rm -r fpc-3.2.2.x86_64-linux && \
    rm "fpc.tar"

WORKDIR /source
