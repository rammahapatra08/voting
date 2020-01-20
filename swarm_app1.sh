#! bin/bash

# Create network
docker network create -d overlay frontend
docker network create -d overlay backend 

## Create services


## Vote --replicas 2
docker service create --name vote bretfisher/examplevotingapp_vote --replicas 1 --port 80:80 --network frontend

## redis
docker service create --name redis redis:3.2 --replicas 1 --network frontend

## db
docker service create --name db postgres:9.4 --replicas 1 --network backend --mount type=volume,source=db-data,target=/var/lib/postgresql/data

## worker
docker service create --name worker bretfisher/examplevotingapp_worker:java --replicas 1 --network frontend --network frontend

## result
docker service create --name result bretfisher/examplevotingapp_result --replicas 1 --network backend -p 5001:80
