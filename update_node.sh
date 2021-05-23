#!/bin/sh
sed -i "s/^.*PKG_VERSION:.*$/PKG_VERSION:=v16.2.0/" package/feeds/packages/node/Makefile
sed -i "s/^.*PKG_HASH:.*$/PKG_HASH:=d0f93b9842afb8f23c07862e9cd48226e7104547f7b2415d250fdb752d1b35cf/" package/feeds/packages/node/Makefile
