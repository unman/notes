/var/www/apache2/salted:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - recurse:
      - user
      - group
      - mode
    - makedirs: True
    - force: True
    - backupname: /root/salted.bak
