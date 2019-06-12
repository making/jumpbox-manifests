#!/bin/bash

eval "$(sed 's/create-env/delete-env/' deploy-jumpbox.sh)"
