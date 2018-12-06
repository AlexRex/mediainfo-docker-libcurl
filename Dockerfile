FROM alpine
RUN apk add --no-cache \
  --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
  libmediainfo \
  libzen \
  zlib
RUN apk add --no-cache \
  --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
  --virtual .build-deps \
  zlib-dev \
  gcc \
  g++ \
  libgcc \
  curl \
  make \
  curl-dev

RUN curl -sSL https://mediaarea.net/download/binary/mediainfo/18.08.1/MediaInfo_CLI_18.08.1_GNU_FromSource.tar.gz | tar -xz \
  && cd MediaInfo_CLI_GNU_FromSource \
  && ./CLI_Compile.sh --with-libcurl \
  && cd MediaInfo/Project/GNU/CLI \
  && make install clean \
  && cd / \
  && rm -rf MediaInfo_CLI_GNU_FromSource \
  && apk del .build-deps

CMD         ["--help"]
ENTRYPOINT  ["mediainfo"]
