date > /home/user/dated:
  cmd.run:
    - unless: 'date +%A |grep Monday'
