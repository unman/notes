/home/user/test:
  file.managed:
    {% if grains['os_family']|lower == 'debian' %}
    - source:
      - salt://testfile
    {% endif %}
    - user: user
    - group: user
    - mode: 640
