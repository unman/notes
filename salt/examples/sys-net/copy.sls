/rw/config/iptables.sh:
  file.managed:
  - name: /rw/config/iptables.sh
  - source: 
    - salt://sys-net/iptables.sh
  - user: root
  - group: root
  - mode: 740

/etc/NetworkManager/conf.d/30-mac-random.conf:
  file.managed:
  - name: /etc/NetworkManager/conf.d/30-mac-random.conf
  - source: 
    - salt://sys-net/30-mac-random.conf
  - user: root
  - group: root
  - mode: 740
