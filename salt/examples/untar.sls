tarfile.tar.xz:
  module.run:
  - name:archive.tar
  - tarfile: /home/user/tarfile.tar.xz
  - options: -x -f
  - runas: user
  - dest: /home/user
