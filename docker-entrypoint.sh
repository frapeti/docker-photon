#!/bin/bash

if [ "$PHOTON_MODE" != "CREATE" ] && [ "$PHOTON_MODE" != "RESTORE" ]; then
    # Default to CREATE
    PHOTON_MODE="CREATE"
fi


if [ "$PHOTON_MODE" != "CREATE" ] ; then

  cp -r /usr/local/elasticsearch/* $ELASTICSEARCH_PATH/
  mkdir -p $ELASTICSEARCH_PATH/logs
  mkdir -p $ELASTICSEARCH_PATH/data
  echo '-Xms512m' > $ELASTICSEARCH_PATH/config/jvm.options
  echo '-Xmx512m' >> $ELASTICSEARCH_PATH/config/jvm.options
  adduser -D -u 1000 -h $ELASTICSEARCH_PATH elasticsearch
  chown -R elasticsearch $ELASTICSEARCH_PATH

	java $JAVA_OPTS -jar photon-0.3.2.jar \
	-nominatim-import -host $PHOTON_ADDR \
	-user nominatim -password password1234 \
	-port $PHOTON_PORT -languages es,en $PHOTON_OPTS
else
	java $JAVA_OPTS -jar photon-0.3.2.jar $PHOTON_OPTS
fi


