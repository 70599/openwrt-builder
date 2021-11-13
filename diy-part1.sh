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
echo 'src-git lienol https://github.com/Lienol/openwrt-package.git;main' >> feeds.conf.default
echo 'src-git diy1 https://github.com/xiaorouji/openwrt-passwall.git;main' >> feeds.conf.default
echo 'src-git community https://github.com/openwrt/packages' >> feeds.conf.default

# remove doubled packages
rm -rf package/lean/{luci-app-cpufreq,luci-app-verysync,verysync}

mkdir -p $GITHUB_WORKSPACE/openwrt/package/additional
pushd $GITHUB_WORKSPACE/openwrt/package/additional

# udptools
svn co https://github.com/zcy85611/Openwrt-Package/trunk/luci-udptools
svn co https://github.com/zcy85611/Openwrt-Package/trunk/udp2raw
svn co https://github.com/zcy85611/Openwrt-Package/trunk/udpspeeder-tunnel

# OpenClash
git clone --depth 1 https://github.com/vernesong/OpenClash.git /tmp/OpenClash
mv /tmp/OpenClash/luci-app-openclash ./
rm -rf /tmp/OpenClash

popd

# cpufreq
pushd feeds/luci/applications
svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-cpufreq
popd
pushd package/feeds/luci
ln -sf ../../../feeds/luci/applications/luci-app-cpufreq ./
popd
sed -i 's,1608,1800,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/cpufreq
sed -i 's,2016,2208,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/cpufreq
sed -i 's,1512,1608,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/cpufreq

# Pandownload
pushd package/lean
svn co https://github.com/immortalwrt/packages/trunk/net/pandownload-fake-server
popd

# po2lmo
git clone https://github.com/openwrt-dev/po2lmo.git
pushd po2lmo
make && sudo make install
popd
