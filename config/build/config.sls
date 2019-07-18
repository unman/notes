/home/user/.gitconfig:
  file.managed:
    - source:
      - salt://build/builder-gitconfig
    - user: user
    - group: user

/rw/config/gpg-split-domain:
  file.managed:
    - source:
      - salt://build/builder-split-gpg-config
    - user: root
    - group: root

/home/user/.rpmmacros:
  file.managed:
    - source:
      - salt://build/builder-rpmmacros
    - user: user
    - group: user

https://github.com/QubesOS/qubes-builder.git:
  git.latest:
    - name: https://github.com/QubesOS/qubes-builder.git
    - user: user
    - target: /home/user/qubes-builder
