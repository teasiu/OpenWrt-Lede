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
wget https://raw.githubusercontent.com/teasiu/OpenWrt-Newifi_D2/main/uhttpd -O package/network/services/uhttpd/files/uhttpd.config
wget https://github.com/ButterAndButterfly/GithubHost/releases/download/v1/host.txt -O package/base-files/files/etc/githubhosts
bash -c "cat >> package/network/services/dnsmasq/files/dnsmasq.conf" << EOF
enable-tftp
tftp-root=/www/tftp
dhcp-boot=undionly.kpxe
dhcp-match=set:efi-x86_64,option:client-arch,7
dhcp-boot=tag:efi-x86_64,uefi/snponly.efi
dhcp-hostsfile=/etc/githubhosts
EOF
#sed -i 's@coolsnowwolf/packages@P3TERX/packages@' feeds.conf.default

#sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default

#sed -i '$a src-git helloworld https://github.com/P3TERX/helloworld' feeds.conf.default
