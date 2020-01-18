FROM alpine:latest

ADD . /photon

WORKDIR /photon

RUN   apk update \
  &&   apk upgrade \ 
  &&   apk add ca-certificates wget \
  &&   update-ca-certificates \
  &&   apk add curl wget bash openssl openjdk8

RUN wget https://github.com/komoot/photon/releases/download/0.3.2/photon-0.3.2.jar

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.0.tar.gz -O elasticsearch-5.6.0.tar.gz

RUN tar -xf  elasticsearch-5.6*.tar.gz -C /usr/local/ \
    && mv /usr/local/elasticsearch-5.6* /usr/local/elasticsearch \
    && mkdir /usr/local/elasticsearch/logs \
    && mkdir /usr/local/elasticsearch/data \
    && echo '-Xms512m' > /usr/local/elasticsearch/config/jvm.options \
    && echo '-Xmx512m' >> /usr/local/elasticsearch/config/jvm.options \
    && adduser -D -u 1000 -h /usr/local/elasticsearch elasticsearch \
    && chown -R elasticsearch /usr/local/elasticsearch

USER elasticsearch

CMD ["/usr/local/elasticsearch/bin/elasticsearch",
 "-Ecluster.name=es-cluster",
  "-Enode.name=${HOSTNAME}",
   "-Epath.data=/usr/local/elasticsearch/data",
    "-Epath.logs=/usr/local/elasticsearch/logs",
     "-Enetwork.host=0.0.0.0",
      "-Ediscovery.zen.ping.unicast.hosts=es-master"]

EXPOSE 2322

ENV JAVA_OPTS=""

ENV PHOTON_OPTS=""

USER root

# Set the entrypoint
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
