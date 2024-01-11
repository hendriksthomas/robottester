#!/bin/sh

echo "Waiting for routers to boot..."

while ! ping 172.143.177.11 -c 1; do
    sleep 0.1
done
echo "Router is up (bof pings)"

#echo "Waiting gRPC to be available..."
#
#while ! nc -z 172.143.177.11 57400; do
#    sleep 0.1
#done

echo "Waiting for postgres..."
while ! nc -z clab-pce_demo2-postgres 5432; do
    sleep 0.1
done
echo "PostgreSQL started"


robot --name GenericGRPCRobotTests robot/*.robot
cat output.xml
python push_results_to_postgres.py

exec "$@"