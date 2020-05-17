FROM alpine as builder
ARG BRANCH v1.3.0

RUN apk add --no-cache \
    gperf \
    alpine-sdk \
    openssl-dev \
    git \
    cmake \
    zlib-dev

WORKDIR /tmp/_build_tdlib/

RUN git clone https://github.com/tdlib/td.git /tmp/_build_tdlib/ --branch ${BRANCH}

RUN mkdir build
WORKDIR /tmp/_build_tdlib/build/

RUN cmake -DCMAKE_BUILD_TYPE=Release ..
RUN cmake --build .
RUN make install


FROM alpine

COPY --from=builder /usr/local/lib/libtd* /usr/local/lib/

RUN apk add --no-cache \
    openssl-dev \
    git \
    cmake \
    zlib-dev
