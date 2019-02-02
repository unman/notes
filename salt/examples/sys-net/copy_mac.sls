/rw/bind-dirs/etc/NetworkManager/conf.d/30-mac-random.conf:
  file.managed:
  - name: /rw/bind-dirs/etc/NetworkManager/conf.d/30-mac-random.conf
  - source: 
    - salt://sys-net/30-mac-random.conf
  - makedirs: True
  - user: root
  - group: root
  - mode: 740
