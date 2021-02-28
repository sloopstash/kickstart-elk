# Docker image to use.
FROM sloopstash/amazonlinux:v1

# Switch work directory.
WORKDIR /tmp

# Install Oracle JDK.
COPY jdk-8u131-linux-x64.rpm ./
RUN set -x \
  && rpm -Uvh jdk-8u131-linux-x64.rpm \
  && rm -rf jdk-8u131-linux-x64.rpm

# Create system user for Elasticsearch.
RUN set -x \
  && useradd -m -s /bin/bash -d /usr/local/lib/elasticsearch elasticsearch

# Install Elasticsearch.
COPY elasticsearch-6.8.2.tar.gz ./
RUN set -x \
  && tar xvzf elasticsearch-6.8.2.tar.gz > /dev/null \
  && cp -r elasticsearch-6.8.2/* /usr/local/lib/elasticsearch/ \
  && chown -R elasticsearch:elasticsearch /usr/local/lib/elasticsearch \
  && rm -rf elasticsearch-6.8.2.tar.gz elasticsearch-6.8.2
RUN set -x \
  && mkdir /opt/elasticsearch \
  && mkdir /opt/elasticsearch/data \
  && mkdir /opt/elasticsearch/log \
  && mkdir /opt/elasticsearch/system \
  && touch /opt/elasticsearch/system/process.pid \
  && chown -R elasticsearch:elasticsearch /opt/elasticsearch

# Switch work directory.
WORKDIR /
