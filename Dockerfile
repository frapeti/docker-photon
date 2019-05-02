FROM elasticsearch:5.6.16-alpine

ADD . /photon

WORKDIR /photon

RUN   apk update \
  &&   apk add ca-certificates wget \
  &&   update-ca-certificates

RUN wget https://github.com/komoot/photon/releases/download/0.3.1/photon-0.3.1.jar

EXPOSE 2322

ENV JAVA_OPTS=""

ENV PHOTON_OPTS=""

# Set the entrypoint
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
