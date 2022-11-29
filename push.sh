#!/bin/bash
export readPomVersion.version=$1
DOCKER_TAG=${readPomVersion.version}
aws ecr get-login-password --region eu-west-2 | docker login --username AWS --password-stdin 312617587281.dkr.ecr.eu-west-2.amazonaws.com
docker build -t 312617587281.dkr.ecr.eu-west-2.amazonaws.com/srmecr:${DOCKER_TAG} . 
#docker tag srmecr:${DOCKER_TAG} 312617587281.dkr.ecr.eu-west-2.amazonaws.com/srmecr:${DOCKER_TAG} 
docker push 312617587281.dkr.ecr.eu-west-2.amazonaws.com/srmecr:${DOCKER_TAG}
helm upgrade --kube-context=arn:aws:eks:eu-west-2:312617587281:cluster/kubesrm --namespace default --install demohelm --set image.repository=312617587281.dkr.ecr.eu-west-2.amazonaws.com/srmecr,image.tag=${DOCKER_TAG},timestamp=`date +t%s` /root/srhelm --debug --wait

