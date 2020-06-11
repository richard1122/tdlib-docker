FROM alpine as builder
ARG branch=v1.6.0

RUN apk add --no-cache \
  gperf \
  alpine-sdk \
  openssl-dev \
  git \
  cmake \
  zlib-dev \
  linux-headers

WORKDIR /builder
RUN git clone https://github.com/tdlib/td.git /builder --branch ${branch} -v && \
  mkdir build && \
  cd build && \
  cmake -DCMAKE_BUILD_TYPE=Release .. && \
  cmake --build . && \
  make install

FROM alpine
COPY --from=builder /usr/local/lib/libtd* /usr/local/lib/
