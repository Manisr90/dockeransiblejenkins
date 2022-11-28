#!/bin/bash
export pomversion=$1
DOCKER_TAG=${pomversion}
aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 312617587281.dkr.ecr.eu-west-2.amazonaws.com
docker build -t srmecr:${DOCKER_TAG} .
docker tag srmecr:${DOCKER_TAG} 312617587281.dkr.ecr.eu-west-2.amazonaws.com/srnew:${DOCKER_TAG}
docker push 312617587281.dkr.ecr.eu-west-2.amazonaws.com/srnew:${DOCKER_TAG}
#helm upgrade -f ./deploy/JavaTest/values.yaml --kube-context=testcluster --namespace default --install javatest --set image.repository=230601024369.dkr.ecr.ap-south-1.amazonaws.com/demo,image.tag=${DOCKER_TAG},timestamp=`date +t%s` ./deploy/JavaTest --debug --wait
