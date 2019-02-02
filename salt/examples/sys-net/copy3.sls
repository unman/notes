/rw/config/iptables.sh:
  file.managed:
  - name: /rw/config/iptables.sh
  - source: 
    - salt://sys-net/iptables.sh
  - user: root
  - group: root
  - mode: 740

{% if grains['id']|lower == 'sys-net-test' %}
/etc/NetworkManager/conf.d/30-mac-random.conf:
  file.managed:
  - name: /etc/NetworkManager/conf.d/30-mac-random.conf2
  - source: 
    - salt://sys-net/30-mac-random.conf
  - user: root
  - group: root
  - mode: 740
{% endif %}
