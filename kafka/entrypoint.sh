#!/bin/bash

if [ ! -f /usr/local/share/kafka/config/server.properties ]
then
	cp -R /usr/local/share/kafka/config.sample/* /usr/local/share/kafka/config/

	if [[ $BROKER_ID ]]
	then
		sed -i -e "s/broker.id=0/broker.id=$BROKER_ID/" /usr/local/share/kafka/config/server.properties
	fi

	if [[ $LISTENERS ]]
	then
		sed -i "/#listeners=PLAINTEXT/alisteners=$LISTENERS" /usr/local/share/kafka/config/server.properties
	fi

	if [[ $ADVERTISED_LISTENERS ]]
	then
		sed -i "/#advertised.listeners=PLAINTEXT/aadvertised.listeners=$ADVERTISED_LISTENERS" /usr/local/share/kafka/config/server.properties
	fi

	if [[ $ZOOKEEPER_SERVERS ]]
	then
		sed -i -e "s/localhost:2181/$ZOOKEEPER_SERVERS/" /usr/local/share/kafka/config/server.properties
	fi

	if [[ $JMX_REMOTE_RMI_PORT ]]
	then
		sed -i "/export KAFKA_HEAP_OPTS=/a\    export JMX_PORT=\"$JMX_REMOTE_RMI_PORT\"" /usr/local/share/kafka/bin/kafka-server-start.sh
		sed -i -e 's/^.*KAFKA_JMX_OPTS="-Dcom.sun.management.jmxremot.*$/  KAFKA_JMX_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false  -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.rmi.port='"$JMX_REMOTE_RMI_PORT"' -Djava.rmi.server.hostname='"$JMX_REMOTE_RMI_SERVER_HOSTNAME"' -Dcom.sun.management.jmxremote.local.only=false "/' /usr/local/share/kafka/bin/kafka-run-class.sh
		sed -i -e "s/localhost:2181/$ZOOKEEPER_SERVERS/" /usr/local/share/kafka/config/server.properties
	fi
fi

# tail -f / dev / null

kafka-server-start.sh /usr/local/share/kafka/config/server.properties