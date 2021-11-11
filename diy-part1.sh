#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# udp2raw
cd $GITHUB_WORKSPACE/openwrt/package
git clone https://github.com/sensec/luci-app-udp2raw.git
git clone https://github.com/sensec/openwrt-udp2raw.git
cd luci-app-udp2raw/tools/po2lmo
make
sudo make install

# OpenClash
git clone --depth 1 https://github.com/vernesong/OpenClash.git /tmp/OpenClash
mv /tmp/OpenClash/luci-app-openclash $GITHUB_WORKSPACE/openwrt/package/
rm -rf /tmp/OpenClash
