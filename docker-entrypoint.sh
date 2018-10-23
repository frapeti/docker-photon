#!/bin/bash

if [ "$PHOTON_MODE" != "CREATE" ] && [ "$PHOTON_MODE" != "RESTORE" ]; then
    # Default to CREATE
    PHOTON_MODE="CREATE"
fi


if [ "$PHOTON_MODE" != "CREATE" ] ; then
	java $JAVA_OPTS -jar photon-0.3.0.jar -nominatim-import -host $NOMINATIM_ADDR -port $NOMINATIM_PORT $PHOTON_OPTS
else
	java $JAVA_OPTS -jar photon-0.3.0.jar $PHOTON_OPTS
fi


