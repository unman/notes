installed:
  pkg.installed:
    - pkgs:
      - tar
    - order: 1

tarfile.tar.xz:
  module.run:
  - name:archive.tar
  - tarfile: /home/user/tarfile.tar.xz
  - options: -x -f
  - runas: user
  - dest: /home/user
  - order: 2
