#!/bin/bash

# Install jupyter lab extensions
jupyter labextension install --minimize False @jupyterlab/toc # This won't be needed when SageMaker Studio gets updated to jupyterlab>=3.0
pip install jupyterlab-spellchecker
pip install lckr-jupyterlab-variableinspector

# Install autoshutdown extension
wget -qO .autoshutdown.sh https://raw.githubusercontent.com/aws-samples/sagemaker-studio-lifecycle-config-examples/main/scripts/install-autoshutdown-extension/on-jupyter-server-start.sh
source .autoshutdown.sh
