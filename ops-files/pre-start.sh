#!/bin/bash
set -euo pipefail

cat <<'EOF' > /etc/profile.d/00-openjdk.sh
export JAVA_HOME=/var/vcap/packages/java
export PATH=${PATH}:${JAVA_HOME}/bin
EOF
cat <<'EOF' > /etc/profile.d/00-jq.sh
export PATH=${PATH}:/var/vcap/packages/toolbelt-jq/bin
EOF
cat <<'EOF' > /etc/profile.d/00-mysql-client.sh
export PATH=${PATH}:/var/vcap/packages/toolbelt-mysql-client/bin
EOF
cat <<'EOF' > /etc/profile.d/00-psql.sh
export PATH=${PATH}:/var/vcap/packages/toolbelt-psql/bin
EOF
cat <<'EOF' > /etc/profile.d/00-awscli.sh
export PATH=${PATH}:/var/vcap/packages/awscli/bin
EOF
cat <<'EOF' > /etc/profile.d/00-cf-cli.sh
export PATH=${PATH}:/var/vcap/packages/cf-cli-6-linux/bin
EOF
cat <<'EOF' > /etc/profile.d/00-git-server.sh
export PATH=${PATH}:/var/vcap/packages/git/bin
EOF

########## Install CLI from internet
export INSTALLATION=/etc/installation
mkdir -p ${INSTALLATION}/bin ${INSTALLATION}/rec        
cat <<'EOF' > /etc/profile.d/00-installation.sh
export INSTALLATION=/etc/installation
export PATH=${PATH}:${INSTALLATION}/bin
EOF

BOSH_VERSION=5.5.1
if [ ! -f ${INSTALLATION}/rec/bosh-${BOSH_VERSION} ];then
  wget -O- https://github.com/cloudfoundry/bosh-cli/releases/download/v${BOSH_VERSION}/bosh-cli-${BOSH_VERSION}-linux-amd64 > /tmp/bosh
  mv /tmp/bosh ${INSTALLATION}/bin/bosh
  chmod +x ${INSTALLATION}/bin/bosh
  touch ${INSTALLATION}/rec/bosh-${BOSH_VERSION}
fi

KUBECTL_VERSION=v1.14.3
if [ ! -f ${INSTALLATION}/rec/kubectl-${KUBECTL_VERSION} ];then
  wget -O- https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl > /tmp/kubectl
  mv /tmp/kubectl ${INSTALLATION}/bin/kubectl
  chmod +x ${INSTALLATION}/bin/kubectl
  touch ${INSTALLATION}/rec/kubectl-${KUBECTL_VERSION}
fi

YTT_VERSION=v0.11.0
if [ ! -f ${INSTALLATION}/rec/ytt-${YTT_VERSION} ];then
  wget -O- https://github.com/k14s/ytt/releases/download/${YTT_VERSION}/ytt-linux-amd64 > /tmp/ytt
  mv /tmp/ytt ${INSTALLATION}/bin/ytt
  chmod +x ${INSTALLATION}/bin/ytt
  touch ${INSTALLATION}/rec/ytt-${YTT_VERSION}
fi

KBLD_VERSION=v0.7.0
if [ ! -f ${INSTALLATION}/rec/kbld-${KBLD_VERSION} ];then
  wget -O- https://github.com/k14s/kbld/releases/download/${KBLD_VERSION}/kbld-linux-amd64 > /tmp/kbld
  mv /tmp/kbld ${INSTALLATION}/bin/kbld
  chmod +x ${INSTALLATION}/bin/kbld
  touch ${INSTALLATION}/rec/kbld-${KBLD_VERSION}
fi

KAPP_VERSION=v0.7.0
if [ ! -f ${INSTALLATION}/rec/kapp-${KAPP_VERSION} ];then
  wget -O- https://github.com/k14s/kapp/releases/download/${KAPP_VERSION}/kapp-linux-amd64 > /tmp/kapp
  mv /tmp/kapp ${INSTALLATION}/bin/kapp
  chmod +x ${INSTALLATION}/bin/kapp
  touch ${INSTALLATION}/rec/kapp-${KAPP_VERSION}
fi

KWT_VERSION=v0.0.5
if [ ! -f ${INSTALLATION}/rec/kwt-${KWT_VERSION} ];then
  wget -O- https://github.com/k14s/kwt/releases/download/${KWT_VERSION}/kwt-linux-amd64 > /tmp/kwt
  mv /tmp/kwt ${INSTALLATION}/bin/kwt
  chmod +x ${INSTALLATION}/bin/kwt
  touch ${INSTALLATION}/rec/kwt-${KWT_VERSION}
fi