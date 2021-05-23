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

# 替换默认IP
sed -i 's#192.168.1.1#192.168.50.1#g' package/base-files/files/bin/config_generate
# 替换默认主题
sed -i 's#luci-theme-bootstrap#luci-theme-argon#g' feeds/luci/collections/luci/Makefile
#更新node版本为16.2.0
sed -i "s/^.*PKG_VERSION:.*$/PKG_VERSION:=v16.2.0/" package/feeds/packages/node/Makefile
sed -i "s/^.*PKG_HASH:.*$/PKG_HASH:=d0f93b9842afb8f23c07862e9cd48226e7104547f7b2415d250fdb752d1b35cf/" package/feeds/packages/node/Makefile
