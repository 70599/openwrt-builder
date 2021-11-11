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

# change default shell to fish
sed -i 's|/bin/ash|/usr/bin/fish|g' package/base-files/files/etc/passwd

# switch kernel version from 5.4 to 5.10
sed -i 's|5.4|5.10|g' target/linux/x86/Makefile
sed -i 's|5.4|5.10|g' target/linux/rockchip/Makefile
