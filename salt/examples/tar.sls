tarfile2.tar.xz:
  module.run:
  - name:archive.tar
  - tarfile: /home/user/tarfile2.tar.xz
  - options: -c -J -f
  - runas: user
  - sources: /home/user/usr
