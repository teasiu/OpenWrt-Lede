#!/bin/bash
#=============================================================
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=============================================================

# fw876/helloworld
sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
rm -rf package/lean/luci-theme-argon && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon
git clone https://github.com/teasiu/lede-other-apps.git package/lede-other-apps
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/lede-other-apps/luci-app-argon-config
wget https://github.com/ButterAndButterfly/GithubHost/releases/download/v1/host.txt -O package/base-files/files/etc/githubhosts
bash -c "cat >> package/network/services/dnsmasq/files/dnsmasq.conf" << EOF
enable-tftp
tftp-root=/www/tftp
dhcp-boot=undionly.kpxe
dhcp-match=set:efi-x86_64,option:client-arch,7
dhcp-boot=tag:efi-x86_64,uefi/snponly.efi
dhcp-hostsfile=/etc/githubhosts
EOF
bash -c "cat >> package/network/services/uhttpd/files/uhttpd.config" << EOF2
config uhttpd 'blog'
option tcp_keepalive '1'
list listen_http '0.0.0.0:8090'
option redirect_https '0'
option rfc1918_filter '0'
list index_page 'index.php'
list interpreter '.php=/usr/bin/php-cgi'
option home '/www/blog'
EOF2
#sed -i 's@coolsnowwolf/packages@P3TERX/packages@' feeds.conf.default

#sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default

#sed -i '$a src-git helloworld https://github.com/P3TERX/helloworld' feeds.conf.default
