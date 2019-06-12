#!/bin/bash

eval "$(grep -v jumpbox-state deploy-jumpbox.sh | sed 's/create-env/int/')"
