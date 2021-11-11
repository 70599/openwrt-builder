#!/bin/sh

for file in geoip.dat geosite.dat; do
  wget -O /tmp/$file https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/$file && mv -f /tmp/$file /usr/bin/
done
