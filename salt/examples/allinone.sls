include:
  - clone

qvm-present-id:
  qvm.present:
    - name: tbb
    - template: browser
    - label: purple

qvm-prefs-id:
  qvm.prefs:
    - name: tbb
    - netvm: sys-firewall

qvm-features-id:
  qvm.features:
    - name: tbb
    - disable:
      - service.cups
      - service.cupsd
