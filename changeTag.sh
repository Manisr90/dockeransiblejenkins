#!/bin/bash
sed "s/tagVersion/$1/g" Deployment.yml > Deploy-skan-pod.yml

