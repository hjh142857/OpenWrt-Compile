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

# 设置LAN IP为192.168.0.100
# sed -i 's/192.168.1.1/192.168.0.1/g' package/base-files/files/bin/config_generate

# 设置LAN网关为192.168.0.1
# sed -i "/\$ipad/a\\\t\t\t\tset network.\$1.gateway='192.168.0.1'" package/base-files/files/bin/config_generate

# 设置主机名
# sed -i 's/OpenWrt/Hostname/g' package/base-files/files/bin/config_generate

# 修改XXR+ Server默认同时监听IPv4/IPv6成只监听IPv6
sed -i 's/\"server\": \"0.0.0.0\",/\"server\": [\"[::0]\"],/g' package/feeds/helloworld/luci-app-ssr-plus/root/etc/init.d/shadowsocksr
sed -i '/server_ipv6/d' package/feeds/helloworld/luci-app-ssr-plus/root/etc/init.d/shadowsocksr

# 添加wr330/wr1200js交换机选项卡
# 参考https://github.com/coolsnowwolf/lede/issues/6536
# ------------------------------------------------------------------------
# file1: target/linux/ramips/mt7621/base-files/etc/board.d/02_network
# 	youhua,wr1200js)
# 		ucidef_add_switch "switch0" \
# 			"0:wan" "1:lan:1" "2:lan:2" "3:lan:3" "4:lan:4" "6@eth0"
# 		;;
# 
# 	youhua,wr1200js)
# 		lan_mac=$(cat /sys/class/net/eth0/address)
# 		wan_mac=$(mtd_get_mac_binary factory 0xe006)
# 		;;
# ------------------------------------------------------------------------
# file2: target/linux/ramips/dts/mt7621_youhua_wr1200js.dts
# &gmac0 {}改为
# &ethernet {
# 	compatible = "mediatek,ralink-mt7621-eth";
# 	mediatek,switch = <&gsw>;
# 	mtd-mac-address = <&factory 0xe000>;
# };
# &switch0 {}改为
# &switch0 {
# 	/delete-property/ compatible;
# 	phy-mode = "rgmii";
# };
# 
# 添加&gsw{}
# &gsw {
# 	compatible = "mediatek,ralink-mt7621-gsw";
# };
# ------------------------------------------------------------------------
sed -i '/asiarf,ap7621-001/i\\tyouhua,wr1200js)' target/linux/ramips/mt7621/base-files/etc/board.d/02_network
sed -i '/asiarf,ap7621-001/i\\t\tucidef_add_switch "switch0" \\' target/linux/ramips/mt7621/base-files/etc/board.d/02_network
sed -i '/asiarf,ap7621-001/i\\t\t\t"0:wan" "1:lan:1" "2:lan:2" "3:lan:3" "4:lan:4" "6@eth0"' target/linux/ramips/mt7621/base-files/etc/board.d/02_network
sed -i '/asiarf,ap7621-001/i\\t\t;;' target/linux/ramips/mt7621/base-files/etc/board.d/02_network
sed -i '/newifi-d2/i\\tyouhua,wr1200js|\\' target/linux/ramips/mt7621/base-files/etc/board.d/02_network
curl https://raw.githubusercontent.com/hjh142857/OpenWrt-Compile/main/mt7621_youhua_wr1200js.dts > target/linux/ramips/dts/mt7621_youhua_wr1200js.dts
