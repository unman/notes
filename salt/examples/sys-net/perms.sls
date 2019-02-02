/rw/config/qubes-firewall-user-script2:
  file.managed:
    - name: /rw/config/qubes-firewall-user-script
    - mode: 755
    - replace: False

/rw/config/rc.local2:
  file.managed:
    - name: /rw/config/rc.local
    - mode: 755
    - replace: False
