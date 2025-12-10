prepare () {
    modprobes=(
        "80211-reg.conf"
    )

    for modprobe in "${modprobes[@]}"; do
        cp /etc/modprobe.d/$modprobe $TARGET/etc/modprobe.d/$modprobe
    done
}

package () {
    :
}
