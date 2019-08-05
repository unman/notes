# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

/rw/config/rc.local:
  file.append:
    - text: |
        systemctl unmask apt-cacher-ng
        systemctl start apt-cacher-ng
        /sbin/iptables -I INPUT -p tcp --dport 8082 -j ACCEPT

/rw/config/qubes-firewall-user-script:
  file.append:
    - text: /sbin/iptables -I INPUT -p tcp --dport 8082 -j ACCEPT

/rw/config/qubes-bind-dirs.d/50_user.conf:
  file.managed:
    - source:
      - salt://cacher/50_user.conf
    - user: root
    - group: root
    - makedirs: True

