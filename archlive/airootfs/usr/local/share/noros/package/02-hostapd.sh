prepare () {
    # Get the first wireless interface
    WIFI_INTERFACE=$(ls -1 /sys/class/net | while read iface; do
        if [ -d "/sys/class/net/$iface/wireless" ]; then
            echo "$iface"
            break
        fi
    done)

    HOSTAPD_CONF="$TARGET/etc/hostapd/wlan0ap.conf"

    if [ -z "$WIFI_INTERFACE" ]; then
        rm -f "$HOSTAPD_CONF"
    else
        sed -i "s/{{HOSTNAME}}/$(cat $TARGET/etc/hostname)/g" "$HOSTAPD_CONF"
    fi
}

package () {
    systemctl enable hostapd@wlan0ap
}
