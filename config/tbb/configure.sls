# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

/home/user/Downloads/tor-browser-linux64-8.5.4_en-US.tar.xz:
  file.managed:
    - source:
      - salt://tbb/tor-browser-linux64-8.5.4_en-US.tar.xz
    - user: user
    - group: user

tor-browser-linux64-8.5.4_en-US.tar.xz:
  module.run:
    - name: archive.tar
    - tarfile: /home/user/Downloads/tor-browser-linux64-8.5.4_en-US.tar.xz
    - options: -x -f
    - runas: user
    - dest: /home/user
