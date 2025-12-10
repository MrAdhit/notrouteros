prepare () {
    :
}

package () {
    systemctl enable update-issue.service
    systemctl enable update-issue.timer
}
