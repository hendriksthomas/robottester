#!/bin/sh

echo "Waiting for routers to boot..."

while ! ping 172.143.177.11 -c 1; do
    sleep 0.1
done

#echo "Waiting gRPC to be available..."
#
#while ! nc -z 172.143.177.11 57400; do
#    sleep 0.1
#done

echo "Router is up (bof pings)"

robot FUNC-BASE-GRPC-02.robot
cat output.xml

exec "$@"