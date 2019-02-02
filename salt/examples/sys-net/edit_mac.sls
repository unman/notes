/rw/config/qubes-bind-dirs.d:
  file.directory

/rw/config/qubes-bind-dirs.d/50_user.conf:
  file.append:
    - text:
      - binds+=( '/etc/NetworkManager/conf.d/30-mac-random.conf' )
