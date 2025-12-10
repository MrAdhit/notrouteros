prepare () {
    # Generate random IPv6 ULA (Unique Local Address)
    # Format: fdXX:XXXX:XXXX::/48 with random 40-bit Global ID
    IPV6_ULA=$(printf "fd%02x:%04x:%04x::1" \
        $((RANDOM % 256)) \
        $((RANDOM % 65536)) \
        $((RANDOM % 65536)))

    # Replace placeholder in network config
    sed -i "s|{{IPv6_ULA}}|$IPV6_ULA|g" \
        $TARGET/etc/systemd/network/00-br-lan.network
}

package () {
    systemctl enable systemd-networkd.service
}
