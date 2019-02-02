/rw/config/qubes-firewall-user-script:
  file.managed:
    - mode: 755
    - replace: False

/rw/config/rc.local:
  file.managed:
    - mode: 755
    - replace: False
