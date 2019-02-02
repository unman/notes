/rw/config/iptables.sh:
  file.managed:
  - name: /rw/config/iptables.sh
  - source: 
    - salt://sys-net/iptables.sh
  - user: root
  - group: root
  - mode: 740
