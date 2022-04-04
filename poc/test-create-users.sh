#!/usr/bin/env bash

rm -rf keys
mkdir keys
ssh-keygen -N "" -t ed25519 -f keys/client -C "service-gateway-client"
ssh-keygen -N "" -t ed25519 -f keys/admin -C "service-gateway-admin"

docker exec service-gateway add-client.sh client1 "$(cat keys/client.pub)"
docker exec service-gateway add-admin.sh admin1 "$(cat keys/admin.pub)"
