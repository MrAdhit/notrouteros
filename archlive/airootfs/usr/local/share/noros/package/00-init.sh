prepare () {
    cp -a /usr/local/share/noros/chroot/. $TARGET/

    cp /etc/os-release $TARGET/etc/os-release
}

package () {
    chsh -s /bin/zsh
    
    hostnamectl set-hostname $(cat /etc/hostname)
}
