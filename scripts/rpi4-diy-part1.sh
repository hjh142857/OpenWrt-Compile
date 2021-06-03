#!/bin/bash

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
mkdir package/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
mkdir package/luci-app-argon-config
git clone https://github.com/jerrykuku/luci-app-argon-config package/luci-app-argon-config

mv package/kenzo/luci-app-adguardhome package/diy/
mv package/kenzo/AdGuardHome package/diy/
mv package/OpenAppFilter/luci-app-oaf package/diy/
mv package/OpenAppFilter/oaf package/diy/
mv package/OpenAppFilter/open-app-filter package/diy/
mv package/luci-theme-argon package/diy/
rm -rf package/lean/luci-theme-argon
mv package/luci-app-argon-config package/diy/

rm -rf package/kenzo
rm -rf package/OpenAppFilter
rm -rf package/luci-theme-argon
rm -rf package/luci-app-argon-config
