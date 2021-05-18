#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

echo '修改机器名称'
sed -i 's/OpenWrt/Phicomm-N1/g' package/base-files/files/bin/config_generate

# Modify default IP
sed -i 's/192.168.1.1/192.168.50.1/g' package/base-files/files/bin/config_generate

echo '修改时区'
sed -i "s/'UTC'/'CST-8'\n   set system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

# firewall custom
echo "iptables -t nat -I POSTROUTING -o eth0 -j MASQUERADE" >> package/network/config/firewall/files/firewall.user

# Add luci-app-ssr-plus
pushd package/lean
git clone --depth=1 https://github.com/fw876/helloworld
cat > helloworld/luci-app-ssr-plus/root/etc/ssrplus/black.list << EOF
services.googleapis.cn
googleapis.cn
heroku.com
githubusercontent.com 
EOF
popd

# Clone community packages to package/community
mkdir package/community
pushd package/community

#echo '网易云音乐'
#git clone  --depth=1 https://github.com/project-openwrt/luci-app-unblockneteasemusic.git 

# Add ServerChan
git clone --depth=1 https://github.com/tty228/luci-app-serverchan

# Add OpenClash
git clone --depth=1 https://github.com/vernesong/OpenClash

# Docker
git clone --depth=1 https://github.com/lisaac/luci-lib-docker
git clone --depth=1 https://github.com/lisaac/luci-app-dockerman

# Add luci-theme-argon
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon
rm -rf ../lean/luci-theme-argon

git clone --depth=1 https://github.com/kenzok8/openwrt-packages.git
rm -rf ./openwrt-packages/luci-app-ssr-plus
rm -rf ./openwrt-packages/luci-app-serverchan
rm -rf ./openwrt-packages/luci-app-openclash
rm -rf ./openwrt-packages/luci-app-jd-dailybonus
rm -rf ./openwrt-packages/luci-theme-argon_new
rm -rf ./openwrt-packages/naiveproxy
rm -rf ./openwrt-packages/tcping

git clone --depth=1 https://github.com/kenzok8/small
rm -rf ./small/v2ray-plugin
rm -rf ./small/xray-core
rm -rf ./small/xray-plugin
rm -rf ./small/shadowsocks-rust

popd

# Mod zzz-default-settings
sed -i "/commit luci/i\uci set luci.main.mediaurlbase='/luci-static/argon'" package/lean/default-settings/files/zzz-default-settings

# Openwrt version
sed -i '/DISTRIB_REVISION/d' package/lean/default-settings/files/zzz-default-settings
version=$(grep "DISTRIB_REVISION=" zzz-default-settings  | awk -F "'" '{print $2}')
echo "echo \"DISTRIB_REVISION='${version} $(TZ=UTC-8 date "+%Y.%m.%d") Compilde by mingxiaoyu'\" >> /etc/openwrt_release" >> package/lean/default-settings/files/zzz-default-settings
sed -i '/exit 0/d' package/lean/default-settings/files/zzz-default-settings
echo "exit 0" >> package/lean/default-settings/files/zzz-default-settings
