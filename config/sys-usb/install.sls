# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

/etc/apt/sources.list:
  file.replace:
    - pattern: 'https:'
    - repl: 'http://HTTPS/'
    - flags: [ 'IGNORECASE', 'MULTILINE' ]

/etc/apt/sources.list.d/qubes-r4.list:
  file.replace:
    - pattern: 'https:'
    - repl: 'http://HTTPS/'
    - flags: [ 'IGNORECASE', 'MULTILINE' ]

allow-testing:
  file.uncomment:
    - name: /etc/apt/sources.list.d/qubes-r4.list
    - regex: ^deb\s.*qubes-os.org.*-testing
    - backup: false

installed:
  pkg.installed:
    - pkgs:
      - qubes-input-proxy-sender
      - qubes-usb-proxy
