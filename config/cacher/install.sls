# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
#
#
#
allow-testing:
  file.uncomment:
    - name: /etc/apt/sources.list.d/qubes-r4.list
    - regex: ^deb\s.*qubes-os.org.*-testing
    - backup: false

installed:
  pkg.installed:
    - pkgs:
      - qubes-core-agent-networking
      - apt-cacher-ng 

systemd-disable:
  cmd.run:
    - name: systemctl disable apt-cacher-ng

systemd-mask:
  cmd.run:
    - name: systemctl mask apt-cacher-ng

/etc/apt-cacher-ng/backends_debian:
  file.prepend:
    - text: https://deb.debian.org/debian

/etc/apt-cacher-ng/acng.conf:
  file.managed:
    - source:
      - salt://cacher/acng.conf
    - user: root
    - group: root
    - makedirs: True

cp /lib/apt-cacher-ng/deb_mirrors.gz /etc/apt-cacher-ng/deb_mirrors.gz:
  cmd.run:
    - runas: root

cp /lib/apt-cacher-ng/fedora_mirrors /etc/apt-cacher-ng/fedora_mirrors:
  cmd.run:
    - runas: root
