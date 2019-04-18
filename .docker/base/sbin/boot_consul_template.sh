#!/bin/sh
#
#  Script to start consul-template
#
#  Copyright (C) 2018 opsgang, Martin Dobrev
#

export SERVICE_1275_NAME=${SERVICE_1275_NAME:-"${SERVICE_80_NAME}-peers"}

# Test if Consul address has been set and if not assume we run in ECS so try to
# get the IP of the host system
if test -z "$CONSUL_ADDR"; then
  PRIV_IP=`curl -sL http://169.254.169.254/latest/meta-data/local-ipv4`
  # Did we receive a response from AWS?
  if test -z "$PRIV_IP"; then
    export CONSUL_ADDR="consul:8500"
  else
    export CONSUL_ADDR="$PRIV_IP:8500"
  fi
fi

exec /usr/local/bin/consul-template \
  -consul-addr="$CONSUL_ADDR" \
  -template="/etc/consul-template/templates/nginx.env.ctmpl:/etc/nginx/nginx.env:/sbin/boot_nginx.sh" \
  -template="/etc/consul-template/templates/haproxy.conf.ctmpl:/etc/haproxy/haproxy.conf:/sbin/boot_haproxy.sh"
