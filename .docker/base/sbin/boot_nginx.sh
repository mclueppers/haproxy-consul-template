#!/bin/sh
#
#  Script to gracefully restart nginx
#
#  Copyright (C) 2018 opsgang, Martin Dobrev
#

test -f /etc/nginx/nginx.env && source /etc/nginx/nginx.env

if test -n "${ENABLE_TRAFFIC_MIRRORING}"; then
  case "${ENABLE_TRAFFIC_MIRRORING}" in
    true|TRUE|yes|YES|y|Y|1)
      pidof -s nginx > /dev/null \
        && /usr/sbin/nginx -s reload \
        || sv start nginx
      ;;
    *)
      sv stop nginx
      pidof -s nginx > /dev/null && killall -9 nginx > /dev/null || exit 0
      ;;
  esac
else
  sv stop nginx
  pidof -s nginx > /dev/null && killall -9 nginx > /dev/null || exit 0
fi
