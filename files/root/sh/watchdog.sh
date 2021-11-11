#!/bin/sh

[ `ps | grep -c xray/dns` -eq 1 ] && /etc/init.d/xdns restart
