include:
  - cacher.clone

qvm-present-id:
  qvm.present:
    - name: cacher
    - template: template-cacher
    - label: gray

qvm-prefs-id:
  qvm.prefs:
    - name: cacher
    - netvm: tor
    - memory: 300
    - maxmem: 800
    - vcpus: 2
    - provides-network: true

qvm-features-id:
  qvm.features:
    - name: cacher
    - disable:
      - service.cups
      - service.cups-browsed
      - service.tinyproxy

'qvm-volume extend cacher:private 20G' :
  cmd.run
