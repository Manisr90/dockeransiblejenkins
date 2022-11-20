#!/bin/bash
sed "s/tagversion/$1/g" pods.yml > skan-pod.yml
