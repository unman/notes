/home/user/test:
  file.managed:
    {% if grains['os_family']|lower == 'debian' %}
    - source:
      - salt://testfile
    {% elif grains['os_family']|lower == 'redhat' %}
    - source:
      - salt://testfile2
    {% else %}
    - source:
      - salt://testfile3
    {% endif %}
    - user: user
    - group: user
    - mode: 640
