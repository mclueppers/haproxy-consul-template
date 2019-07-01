#!/bin/sh
#
#  Script to gracefully restart HAproxy
#
#  Copyright (C) 2018 opsgang, Martin Dobrev
#

HAPROXY_OPTS="-f /etc/haproxy/haproxy.conf -p /run/haproxy/haproxy.pid"

if [[ -S /run/haproxy/haproxy.sock -a $(pidof haproxy) ]]; then
  echo "show servers state" | nc -U /run/haproxy/haproxy.sock > /run/haproxy/haproxy.state
	HAPROXY_OPTS="${HAPROXY_OPTS} -x /run/haproxy/haproxy.sock"
fi

if [[ -f /run/haproxy/haproxy.pid ]]; then
  local old_pid=$(cat /run/haproxy/haproxy.pid)
  HAPROXY_OPTS="${HAPROXY_OPTS} -sf ${old_pid}"
else
  pidof haproxy && HAPROXY_OPTS="${HAPROXY_OPTS} -sf $(pidof haproxy)"
fi

echo "HA-Proxy started with the following options: ${HAPROXY_OPTS}"

haproxy ${HAPROXY_OPTS} || exit 0
