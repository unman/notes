# vim: set syntax=yaml ts=2 sw=2 sts=2 et :
#
#
#
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
