#!/bin/bash

bosh -d jumpbox deploy jumpbox.yml \
  -l versions.yml \
  -o ops-files/jq.yml \
  -o ops-files/openjdk.yml \
  -o ops-files/mysql-client.yml \
  -o ops-files/psql.yml \
  -o ops-files/awscli.yml \
  -o ops-files/cf-cli.yml \
  -o ops-files/git.yml \
  -o ops-files/login-banner.yml \
  -o ops-files/pre-start.yml \
  --no-redact \
  $@
