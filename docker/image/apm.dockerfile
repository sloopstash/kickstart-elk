# Docker image to use.
FROM sloopstash/amazonlinux:v1

# Switch work directory.
WORKDIR /tmp

# Install APM.
COPY apm-server-6.8.2-linux-x86_64.tar.gz ./
RUN set -x \
  && tar xvzf apm-server-6.8.2-linux-x86_64.tar.gz > /dev/null \
  && mkdir /usr/local/lib/apm \
  && cp -r apm-server-6.8.2-linux-x86_64/* /usr/local/lib/apm/ \
  && rm -rf apm-server-6.8.2-linux-x86_64.tar.gz apm-server-6.8.2-linux-x86_64
RUN set -x \
  && mkdir /opt/apm \
  && mkdir /opt/apm/data \
  && mkdir /opt/apm/log \
  && mkdir /opt/apm/system \
  && touch /opt/apm/system/process.pid

# Switch work directory.
WORKDIR /
