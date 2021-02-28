# Docker image to use.
FROM sloopstash/amazonlinux:v1

# Switch work directory.
WORKDIR /tmp

# Install Oracle JDK.
COPY jdk-8u131-linux-x64.rpm ./
RUN set -x \
  && rpm -Uvh jdk-8u131-linux-x64.rpm \
  && rm -rf jdk-8u131-linux-x64.rpm

# Create system user for Logstash.
RUN set -x \
  && useradd -m -s /bin/bash -d /usr/local/lib/logstash logstash

# Install Logstash.
COPY logstash-6.8.2.tar.gz ./
RUN set -x \
  && tar xvzf logstash-6.8.2.tar.gz > /dev/null \
  && cp -r logstash-6.8.2/* /usr/local/lib/logstash/ \
  && chown -R logstash:logstash /usr/local/lib/logstash \
  && rm -rf logstash-6.8.2.tar.gz logstash-6.8.2
RUN set -x \
  && mkdir /opt/logstash \
  && mkdir /opt/logstash/data \
  && mkdir /opt/logstash/log \
  && mkdir /opt/logstash/system \
  && touch /opt/logstash/system/process.pid \
  && chown -R logstash:logstash /opt/logstash

# Switch work directory.
WORKDIR /
