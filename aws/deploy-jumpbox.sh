#!/bin/bash

export PUBLIC_IP=$(terraform output external_ip)
export INTERNAL_CIDR=$(terraform output internal_cidr)
export INTERNAL_GW=$(terraform output internal_gw)
export INTERNALIP=$(terraform output jumpbox_internal_ip)
export SECURITY_GROUP_NAME=$(terraform output jumpbox_security_group)
export DEFAULT_SECURITY_GROUP=$(terraform output jumpbox_security_group)
export REGION=$(terraform output region)
export AVAILABILITY_ZONE=$(terraform output az)
export SUBNET_ID=$(terraform output subnet_id)
export VPC_ID=$(terraform output vpc_id)
export ACCESS_KEY_ID=$(terraform output jumpbox_iam_user_access_key)
export SECRET_ACCESS_KEY=$(terraform output jumpbox_iam_user_secret_key)
export DEFAULT_KEY_NAME=$(terraform output default_key_name)
export PRIVATE_KEY=$(terraform output private_key)

export JUMPBOX_DEPLOYMENT=../jumpbox-deployment
export OPS_FILES=../ops-files


bosh create-env ${JUMPBOX_DEPLOYMENT}/jumpbox.yml \
  -o ${JUMPBOX_DEPLOYMENT}/aws/cpi.yml \
  --vars-store jumpbox-creds.yml \
  -l ../versions.yml \
  -v external_ip=${PUBLIC_IP} \
  -v az=${AVAILABILITY_ZONE} \
  -v subnet_id=${SUBNET_ID} \
  -v access_key_id=${ACCESS_KEY_ID} \
  -v secret_access_key=${SECRET_ACCESS_KEY} \
  -v default_key_name=${DEFAULT_KEY_NAME} \
  -v default_security_groups="[${DEFAULT_SECURITY_GROUP}]" \
  -v region=${REGION} \
  --var-file private_key=<(cat <<EOF
${PRIVATE_KEY}
EOF
) \
  -v internal_cidr=${INTERNAL_CIDR} \
  -v internal_gw=${INTERNAL_GW} \
  -v internal_ip=${INTERNALIP} \
  -o ${OPS_FILES}/persistent-disk.yml \
  -o ${OPS_FILES}/openjdk.yml \
  -o ${OPS_FILES}/jq.yml \
  -o ${OPS_FILES}/openjdk.yml \
  -o ${OPS_FILES}/cf-cli.yml \
  -o ${OPS_FILES}/uaac.yml \
  -o ${OPS_FILES}/git.yml \
  -o ${OPS_FILES}/login-banner.yml \
  -o ${OPS_FILES}/persistence-home.yml \
  -o ${OPS_FILES}/pre-start.yml \
  --var-file=pre-start-script=${OPS_FILES}/pre-start.sh \
  -o <(cat <<EOF
- type: replace
  path: /disk_pools/name=disks/cloud_properties?/type
  value: standard
- type: replace
  path: /resource_pools/0/cloud_properties/instance_type
  value: t2.micro
- type: replace
  path: /resource_pools/0/cloud_properties/spot_bid_price?
  value: 0.0050
- type: replace
  path: /resource_pools/name=vms/cloud_properties/ephemeral_disk
  value: 
    size: 20_000
    type: standard
EOF) \
  --state jumpbox-state.json \
  $@