FROM elasticsearch:5.2.1-alpine

ADD . /photon

WORKDIR /photon

RUN   apk update \
  &&   apk add ca-certificates wget \
  &&   update-ca-certificates

RUN wget https://github.com/komoot/photon/releases/download/0.3.0/photon-0.3.0.jar

#RUN wget -O - http://download1.graphhopper.com/public/photon-db-latest.tar.bz2 | bzip2 -cd | tar x
#CMD java -jar photon-0.3.0.jar -nominatim-import -host $NOMINATIM_ADDR -port $NOMINATIM_PORT

EXPOSE 2322

ENV JAVA_OPTS=""

ENV PHOTON_OPTS=""

# Set the entrypoint
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
