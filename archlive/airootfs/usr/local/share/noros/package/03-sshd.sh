prepare () {
    :
}

package () {
    touch "/root/.ssh/authorized_keys"
    systemctl enable sshd.service
}
