#!/bin/bash
sed "s/v1.$BUILD_ID/$1/g" pods.yml > skan-pod.yml
