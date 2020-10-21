# use base image.
FROM sloopstash/amazonlinux:v1

# switch work directory.
WORKDIR /tmp

# install oracle java development kit.
COPY jdk-8u131-linux-x64.rpm ./
RUN set -x \
  && rpm -Uvh jdk-8u131-linux-x64.rpm \
  && rm -rf jdk-8u131-linux-x64.rpm

# create user named elasticsearch.
RUN set -x \
  && useradd -m -s /bin/bash -d /usr/local/lib/elasticsearch elasticsearch

# install elasticsearch.
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

# switch work directory.
WORKDIR /
