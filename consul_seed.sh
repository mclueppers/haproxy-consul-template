#!/usr/bin/env bash
################################################################################
#
#  consul_seed.sh - Script to seed Consul httprouty service
#
#  (C) 2019 - Martin Dobrev (opsgang.io)
#
################################################################################
set -x

# Configuration
CONSUL_SERVER=${1:-localhost}
SERVICE_NAME=${2:-httprouty}
SERVICE_ENV=${3:-development}

# Main script
consul kv import -http-addr=http://${CONSUL_SERVER}:8500 \
  "`cat consul_seed.json.tpl | sed -e \"s/##SERVICE_NAME##/${SERVICE_NAME}/g\" -e \"s/##SERVICE_ENV##/${SERVICE_ENV}/g\"`"
