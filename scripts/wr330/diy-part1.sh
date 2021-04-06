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
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

# DIY package
mkdir package/diy

mkdir package/kenzo
git clone https://github.com/kenzok8/openwrt-packages package/kenzo
mkdir package/OpenAppFilter
git clone https://github.com/destan19/OpenAppFilter package/OpenAppFilter

mv package/kenzo/luci-app-adguardhome package/diy/
mv package/kenzo/AdGuardHome package/diy/
mv package/kenzo/luci-app-eqos package/diy/
mv package/kenzo/luci-theme-argon_new package/diy/
mv package/OpenAppFilter/luci-app-oaf package/diy/
mv package/OpenAppFilter/oaf package/diy/
mv package/OpenAppFilter/open-app-filter package/diy/

rm -rf package/kenzo
rm -rf package/OpenAppFilter
