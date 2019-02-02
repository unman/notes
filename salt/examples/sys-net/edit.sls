/rw/config/qubes-firewall-user-script:
  file.append:
    - text:
      - /rw/config/iptables.sh

/rw/config/rc.local:
  file.append:
    - text:
      - /rw/config/iptables.sh

/rw/config/qubes-bind-dirs.d:
  file.directory

/rw/config/qubes-bind-dirs.d/50_user.conf:
  file.append:
    - text:
      - binds+=( '/etc/NetworkManager/conf.d/30-mac-random.conf' )
