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
fi

# tail -f / dev / null

kafka-server-start.sh /usr/local/share/kafka/config/server.properties