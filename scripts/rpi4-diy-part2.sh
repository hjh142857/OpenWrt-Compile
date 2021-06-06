#!/bin/bash

# 设置LAN IP为192.168.0.100
# sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/files/bin/config_generate

# 设置LAN网关为192.168.0.1
# sed -i "/\$ipad/a\\\t\t\t\tset network.\$1.gateway='192.168.0.1'" package/base-files/files/bin/config_generate

# 设置主机名
sed -i 's/OpenWrt/RaspberryPi/g' package/base-files/files/bin/config_generate

# 修改XXR+ Server默认同时监听IPv4/IPv6成只监听IPv6
sed -i 's/\"server\": \"0.0.0.0\",/\"server\": [\"[::0]\"],/g' package/feeds/helloworld/luci-app-ssr-plus/root/etc/init.d/shadowsocksr
sed -i '/server_ipv6/d' package/feeds/helloworld/luci-app-ssr-plus/root/etc/init.d/shadowsocksr

# （已提交PR并并入lede主项目）修改内核以支持32位程序
#echo "CONFIG_COMPAT=y" >> target/linux/bcm27xx/bcm2711/config-5.4

# 默认开启Wifi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 启用aarch64架构的cpufreq
sed -i 's/arm/(arm||aarch64)/g' package/lean/luci-app-cpufreq/Makefile

# 修改CPU频率显示为实时频率（默认显示最大主频）
# https://github.com/coolsnowwolf/lede/issues/6091
# vcgencmd measure_clock arm   https://www.raspberrypi.org/documentation/raspbian/applications/vcgencmd.md
sed -i '/vcgencmd/d' package/lean/autocore/files/arm/sbin/cpuinfo
sed -i "/bcm27xx/a\\\tcpu_freq=\"\$(expr \$(vcgencmd measure_clock arm | awk -F '=' '{print \$2}') / 1000000)MHz\"" package/lean/autocore/files/arm/sbin/cpuinfo
