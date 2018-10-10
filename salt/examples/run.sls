date > /home/user/dated:
  cmd.run:
    - onlyif: 'date +%A |grep Monday'
