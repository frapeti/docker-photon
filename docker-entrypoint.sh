#!/bin/bash

if [ "$PHOTON_MODE" != "CREATE" ] && [ "$PHOTON_MODE" != "RESTORE" ]; then
    # Default to CREATE
    PHOTON_MODE="CREATE"
fi


if [ "$PHOTON_MODE" != "CREATE" ] ; then
		java $JAVA_OPTS -jar photon-0.3.2.jar $PHOTON_OPTS
else
	java $JAVA_OPTS -jar photon-0.3.2.jar \
	-nominatim-import -host $NOMINATIM_ADDR \
	-user nominatim -password password1234 \
	-port $NOMINATIM_PORT -languages es,en $PHOTON_OPTS
fi


