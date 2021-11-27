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
sed -i 's|Lienol/openwrt-luci.git;main|Lienol/openwrt-luci.git;21.02|g' feeds.conf.default

# Add a feed source
# echo 'src-git lienol https://github.com/Lienol/openwrt-package.git;main' >> feeds.conf.default
# echo 'src-git diy1 https://github.com/xiaorouji/openwrt-passwall.git;main' >> feeds.conf.default

[ -e package/additional ] || mkdir -p package/additional
pushd package/additional

# passwall
git clone https://github.com/xiaorouji/openwrt-passwall.git

# shortcut-fe
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-turboacc
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/dnsforwarder
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/dnsproxy
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/shortcut-fe


# vlmcsd
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/vlmcsd
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-vlmcsd

# zerotier
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-zerotier

# udptools
# svn co https://github.com/zcy85611/Openwrt-Package/trunk/luci-udptools
svn co https://github.com/zcy85611/Openwrt-Package/trunk/udp2raw
# svn co https://github.com/zcy85611/Openwrt-Package/trunk/udpspeeder-tunnel
git clone https://github.com/sensec/luci-app-udp2raw.git
# git clone https://github.com/sensec/openwrt-udp2raw.git

# OpenClash
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash

# Pandownload
svn co https://github.com/immortalwrt/packages/trunk/net/pandownload-fake-server

popd

# po2lmo
git clone https://github.com/openwrt-dev/po2lmo.git
pushd po2lmo
make && sudo make install
popd
