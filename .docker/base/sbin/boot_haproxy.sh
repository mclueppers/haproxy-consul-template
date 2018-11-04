#!/bin/sh
#
#  Script to gracefully restart HAproxy
#
#  Copyright (C) 2018 opsgang, Martin Dobrev
#

haproxy -f /etc/haproxy/haproxy.conf -sf `pidof -s haproxy`
