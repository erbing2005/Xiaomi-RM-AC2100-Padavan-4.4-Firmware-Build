#!/bin/bash

# ============================================
# 自定義配置腳本 - Padavan 固件編譯設置
# ============================================

# 基本登錄設置
user_name="admin"                                   # 管理員用戶名
user_password="admin"                               # 管理員登錄密碼

# 網絡設置
lan_ip="192.168.1"                                  # LAN IP 地址（不含最後的 .1）

# 無線網絡設置 - 2.4G
wlan_2g_cc="TW"                                     # 2.4G 國家代碼
wlan_2g_ssid="int_2.4G"                             # 2.4G 無線網絡名稱 (SSID)
wlan_2g_psk=""                                      # 2.4G WiFi 密碼（最少8位，空白為不設置）
wlan_guest_2g_ssid="int_pub_2.4G"                   # 2.4G 訪客無線網絡名稱

# 無線網絡設置 - 5G
wlan_5g_cc="DB"                                     # 5G 國家代碼
wlan_5g_ssid="int_5G"                               # 5G 無線網絡名稱 (SSID)
wlan_5g_psk=""                                      # 5G WiFi 密碼（最少8位，空白為不設置）
wlan_guest_5g_ssid="int_pub_5G"                     # 5G 訪客無線網絡名稱

# 系統設置
timezone="CCT-8"                                    # 時區設置
ntp_server1="pool.ntp.org"                          # NTP 時間服務器 1
ntp_server2="time.nist.gov"                         # NTP 時間服務器 2
version_time=$(date +%Y%m%d)                        # 固件版本號時間標記

# 默認配置文件路徑
default_file="./user/shared/defaults.h"             # 默認配置文件位置

# ============================================
# 應用配置修改
# ============================================

echo "修改用戶名"
sed -i 's/SYS_USER_ROOT		"admin"/SYS_USER_ROOT		"'$user_name'"/g' $default_file

echo "修改登陆密码"
sed -i 's/DEF_ROOT_PASSWORD	"admin"/DEF_ROOT_PASSWORD	"'$user_password'"/g' $default_file

echo "修改 LAN IP 地址"
sed -i "s/192.168.2/$lan_ip/g" $default_file

echo "修改 2.4G 國家代碼"
sed -i 's/DEF_WLAN_2G_CC	  "CN"/DEF_WLAN_2G_CC		"'$wlan_2g_cc'"/g' $default_file

echo "修改 5G 國家代碼"
sed -i 's/DEF_WLAN_5G_CC	  "US"/DEF_WLAN_5G_CC		"'$wlan_5g_cc'"/g' $default_file

echo "修改 2.4G 無線網絡名稱"
sed -i 's/DEF_WLAN_2G_SSID	BOARD_PID "_%s"/DEF_WLAN_2G_SSID	"'$wlan_2g_ssid'"/g' $default_file

echo "修改 5G 無線網絡名稱"
sed -i 's/DEF_WLAN_5G_SSID	BOARD_PID "_5G_%s"/DEF_WLAN_5G_SSID	"'$wlan_5g_ssid'"/g' $default_file

echo "修改 2.4G 訪客無線網絡名稱"
sed -i 's/DEF_WLAN_2G_GSSID	BOARD_PID "_GUEST_%s"/DEF_WLAN_2G_GSSID	"'$wlan_guest_2g_ssid'"/g' $default_file

echo "修改 5G 訪客無線網絡名稱"
sed -i 's/DEF_WLAN_5G_GSSID	BOARD_PID "_GUEST_5G_%s"/DEF_WLAN_5G_GSSID	"'$wlan_guest_5g_ssid'"/g' $default_file

echo "修改 2.4G WiFi 密碼"
sed -i 's/DEF_WLAN_2G_PSK		"1234567890"/DEF_WLAN_2G_PSK		"'$wlan_2g_psk'"/g' $default_file

echo "修改 5G WiFi 密碼"
sed -i 's/DEF_WLAN_5G_PSK		"1234567890"/DEF_WLAN_5G_PSK		"'$wlan_5g_psk'"/g' $default_file

echo "修改時區設置"
sed -i 's/DEF_TIMEZONE	 "CST-8"/DEF_TIMEZONE	"'$timezone'"/g' $default_file

echo "修改 NTP 時間服務器 1"
sed -i 's/DEF_NTP_SERVER0		"ntp1.aliyun.com"/DEF_NTP_SERVER0	"'$ntp_server1'"/g' $default_file

echo "修改 NTP 時間服務器 2"
sed -i 's/DEF_NTP_SERVER1		"time1.cloud.tencent.com"/DEF_NTP_SERVER1	"'$ntp_server2'"/g' $default_file

echo "更新固件版本號時間標記"
sed -i "s/FIRMWARE_BUILDS_REV=.*/FIRMWARE_BUILDS_REV=$version_time/g" ./versions.inc



# ============================================
# 高級配置選項（默認已註釋）
# ============================================

default_path="./user/shared"                    # 默認配置路徑

# 以下為可選的高級配置，根據需要取消註釋並修改

#echo "設置為 PPPoE 模式並寫入賬號和密碼"
#sed -i 's/{ "wan_proto", "dhcp" }/{ "wan_proto", "pppoe" }/g' $default_path/defaults.c
#sed -i 's/{ "wan_pppoe_username", "" }/{ "wan_pppoe_username", "寬帶賬號" }/g' $default_path/defaults.c
#sed -i 's/{ "wan_pppoe_passwd", "" }/{ "wan_pppoe_passwd", "寬帶密碼" }/g' $default_path/defaults.c

#echo "設置為 AP 模式"
#echo "#define BOARD_ROLE_REPEATER	1" >> ./configs/boards/RM2100/board.h

#echo "開啟 2.4G 無線橋接模式"
#sed -i 's/{ "rt_mode_x", "0" }/{ "rt_mode_x", "4" }/g' $default_path/defaults.c

#echo "開啟 5G 無線橋接模式"
#sed -i 's/{ "wl_mode_x", "0" }/{ "wl_mode_x", "4" }/g' $default_path/defaults.c
