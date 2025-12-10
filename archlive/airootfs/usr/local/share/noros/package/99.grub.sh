prepare () {
    :
}

package () {
    if [[ -d /sys/firmware/efi ]]; then
        echo "Installing GRUB for UEFI..."
        grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
    else
        echo "Installing GRUB for BIOS..."

        local root_part=$(findmnt -n -o SOURCE /)
        local disk=$(lsblk -no PKNAME "$root_part" | head -1)

        grub-install --target=i386-pc "/dev/$disk"
    fi
    
    echo "Generating GRUB configuration..."
    grub-mkconfig -o /boot/grub/grub.cfg
    
    echo "GRUB installation complete"
}
