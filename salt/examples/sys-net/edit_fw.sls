/rw/config/qubes-firewall-user-script:
  file.append:
    - text:
      - /rw/config/iptables.sh

/rw/config/rc.local:
  file.append:
    - text:
      - /rw/config/iptables.sh
