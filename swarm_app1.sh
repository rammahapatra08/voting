#! bin/bash

# Create network
docker network create -d overlay frontend
docker network create -d overlay backend 

## Create services


## Vote --replicas 2
docker service create --name vote --replicas 1 --port 80:80 --network frontend bretfisher/examplevotingapp_vote

## redis
docker service create --name redis --replics 1 --network frontend redis:3.2

## db
docker service create --name db --replicas 1 --network backend --mount type=volume,source=db-data,target=/var/lib/postgresql/data postgres:9.4

## worker
docker service create --name worker --replicas 1 --network backend --network frontend bretfisher/examplevotingapp_worker:java

## result
docker service create --name result --replicas 1 --network backend -p 80:50001 bretfisher/examplevotingapp_result
