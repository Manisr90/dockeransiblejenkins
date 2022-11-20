#!/bin/bash
sed "s/BUILD_ID/$1/g" pods.yml > skan-pod.yml
