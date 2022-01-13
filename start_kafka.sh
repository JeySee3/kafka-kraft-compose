#!/usr/bin/env bash

if [[ -z "$KAFKA_BROKER_ID" ]]; then
  echo 'Using default broker id'
else
  echo "Using listeners: ${KAFKA_BROKER_ID}"
  if [[ $KAFKA_BROKER_ID -eq 1 ]]; then
     sed -r -i "s@^#?node.id=.*@node.id=$KAFKA_BROKER_ID@g" "/opt/kafka/config/kraft/server.properties"
  fi
fi

if [[ -z "$KAFKA_QUORUM_VOTERS" ]]; then
  echo 'Using default KAFKA QUORUM VOTERS'
else
  echo "Using QUORUM: ${KAFKA_QUORUM_VOTERS}"
  sed -r -i "s+^#?controller.quorum.voters=.*+controller.quorum.voters=$KAFKA_QUORUM_VOTERS+g" "/opt/kafka/config/kraft/server.properties"
fi

if [[ -z "$NUM_PARTITIONS" ]]; then
  echo 'Using default NUM_PARTITIONS=1'
else
  echo "Using NUM_PARTITIONS: ${NUM_PARTITIONS}"
  sed -r -i "s+^#?num.partitions=.*+num.partitions=$NUM_PARTITIONS+g" "/opt/kafka/config/kraft/server.properties"
fi

if [[ -z "$KAFKA_LISTENERS" ]]; then
  echo 'Using default listeners'
else
  echo "Using listeners: ${KAFKA_LISTENERS}"
  sed -r -i "s@^#?listeners=.*@listeners=$KAFKA_LISTENERS@g" "/opt/kafka/config/kraft/server.properties"
fi

if [[ -z "$KAFKA_ADVERTISED_LISTENERS" ]]; then
  echo 'Using default advertised listeners'
else
  echo "Using advertised listeners: ${KAFKA_ADVERTISED_LISTENERS}"
  sed -r -i "s@^#?advertised.listeners=.*@advertised.listeners=$KAFKA_ADVERTISED_LISTENERS@g" "/opt/kafka/config/kraft/server.properties"
fi

if [[ -z "$KAFKA_LISTENER_SECURITY_PROTOCOL_MAP" ]]; then
  echo 'Using default listener security protocol map'
else
  echo "Using listener security protocol map: ${KAFKA_LISTENER_SECURITY_PROTOCOL_MAP}"
  sed -r -i "s@^#?listener.security.protocol.map=.*@listener.security.protocol.map=$KAFKA_LISTENER_SECURITY_PROTOCOL_MAP@g" "/opt/kafka/config/kraft/server.properties"
fi

if [[ -z "$KAFKA_INTER_BROKER_LISTENER_NAME" ]]; then
  echo 'Using default inter broker listener name'
else
  echo "Using inter broker listener name: ${KAFKA_INTER_BROKER_LISTENER_NAME}"
  sed -r -i "s@^#?inter.broker.listener.name=.*@inter.broker.listener.name=$KAFKA_INTER_BROKER_LISTENER_NAME@g" "/opt/kafka/config/kraft/server.properties"
fi

uuid=$RANDOM_UUID
/opt/kafka/bin/kafka-storage.sh format -t $RANDOM_UUID -c /opt/kafka/config/kraft/server.properties
/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/kraft/server.properties
