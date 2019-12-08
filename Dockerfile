FROM frolvlad/alpine-glibc:alpine-3.9_glibc-2.29

ENV TEXLIVE_URL http://mirror.ctan.org/systems/texlive/tlnet

RUN mkdir /tmp/install-tl-unx

WORKDIR /tmp/install-tl-unx

COPY texlive.profile .

RUN apk --no-cache add perl wget xz tar

RUN wget ${TEXLIVE_URL}/install-tl-unx.tar.gz && \
    tar --strip-components=1 -xvf install-tl-unx.tar.gz && \
    ./install-tl --repository ${TEXLIVE_URL} --profile=texlive.profile && \
    rm -rf /tmp/install-tl-unx

ENV PATH /usr/local/texlive/2019/bin/x86_64-linuxmusl:${PATH}

RUN tlmgr install algorithm2e algorithms bytefield ec fontawesome latexmk 

RUN apk del xz tar

RUN apk --no-cache add libx11 libxext libxrender libstdc++ freetype fontconfig libssl1.1 msttcorefonts-installer

WORKDIR /root
