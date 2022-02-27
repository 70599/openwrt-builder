#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/10.10.0.1/g' package/base-files/files/bin/config_generate
sed -i 's/255.255.255.0/255.255.0.0/g' package/base-files/files/bin/config_generate

# change default shell to fish
sed -i 's|/bin/ash|/usr/bin/fish|g' package/base-files/files/etc/passwd

# switch kernel version
sed -i 's|5.10|5.15|g' target/linux/x86/Makefile
# sed -i 's|5.4|5.10|g' target/linux/rockchip/Makefile

# Add cpufreq
svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-cpufreq feeds/luci/applications/luci-app-cpufreq
pushd package/feeds/luci
ln -sf ../../../feeds/luci/applications/luci-app-cpufreq ./
sed -i 's,1608,1800,g' luci-app-cpufreq/root/etc/uci-defaults/cpufreq
sed -i 's,2016,2208,g' luci-app-cpufreq/root/etc/uci-defaults/cpufreq
sed -i 's,1512,1608,g' luci-app-cpufreq/root/etc/uci-defaults/cpufreq
popd

# Fix libssh
pushd feeds/packages/libs
rm -rf libssh
svn co https://github.com/openwrt/packages/trunk/libs/libssh
popd

# Replace docker packages
pushd feeds/packages/utils
for pkg in containerd docker docker-compose dockerd runc; do
  rm -rf $pkg
  svn co https://github.com/openwrt/packages/trunk/utils/$pkg
done
popd

./scripts/feeds update packages
./scripts/feeds install -a -p packages

# fix UPX
# https://github.com/DHDAXCW/openwrt-mix/issues/1
pushd /workdir/openwrt/staging_dir/host/bin/
[ -x ./upx ] || ln -sf `which upx` ./upx
popd
