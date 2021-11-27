#!/bin/bash

# -e  Exit immediately if a command exits with a non-zero status.
# -u  Treat unset variables as an error when substituting.
# -x  Print commands and their arguments as they are executed.
set -eux

wget -qO lcc-script.sh https://raw.githubusercontent.com/tuliocasagrande/sagemaker-studio-lifecycle-config/main/on-jupyter-server-start.sh
lcc_content=$(openssl base64 -A -in lcc-script.sh)
rm lcc-script.sh

lcc_arn=$(aws sagemaker create-studio-lifecycle-config \
    --studio-lifecycle-config-name config-1 \
    --studio-lifecycle-config-content $lcc_content \
    --studio-lifecycle-config-app-type JupyterServer \
    --query 'StudioLifecycleConfigArn' --output text)

domain_id=$(aws sagemaker list-domains --query 'Domains[0].DomainId' --output text)

aws sagemaker update-domain \
    --domain-id $domain_id \
    --default-user-settings '{
        "JupyterServerAppSettings": {
            "DefaultResourceSpec": {
                "LifecycleConfigArn": "'$lcc_arn'",
                "InstanceType": "system"
            },
            "LifecycleConfigArns": ["'$lcc_arn'"]
        }
    }'
