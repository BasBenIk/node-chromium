FROM node:10-alpine

MAINTAINER Bas van Baalen "https://github.com/BasBenIk"

RUN \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk --no-cache  update \
  && apk add --no-cache --virtual .build-deps \
  gifsicle pngquant optipng libjpeg-turbo-utils \
  udev ttf-opensans bash chromium \
  && rm -rf /var/cache/apk/* /tmp/*

# This line is to tell karma-chrome-launcher where
# chromium was downloaded and installed to.
ENV CHROME_BIN /usr/bin/chromium-browser

# Tell Puppeteer to skip installing Chrome.
# We'll be using the installed package instead.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Telling node-sass which pre-built binary to fetch.
# This way we don't need rebuilding node-sass each time!
ENV SASS_BINARY_NAME=linux-x64-67
ENV LIGHTHOUSE_CHROMIUM_PATH /usr/bin/chromium-browser
