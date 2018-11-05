/home/user/test:
  file.managed:
    - source:
      - salt://testfile
    - user: user
    - group: user
    - mode: 640
