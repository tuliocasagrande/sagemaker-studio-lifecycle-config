#!/bin/bash

sudo yum -y install wget

wget -qO .install-wrapper.sh https://raw.githubusercontent.com/tuliocasagrande/sagemaker-studio-lifecycle-config/main/install-wrapper.sh
nohup bash .install-wrapper.sh &
