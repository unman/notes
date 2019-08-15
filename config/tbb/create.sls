include:
  - tbb.clone

qvm-present-id:
  qvm.present:
    - name: tbb-dvm
    - template: template-tbb
    - label: red

qvm-prefs-id:
  qvm.prefs:
    - name: tbb-dvm
    - netvm: tor
    - memory: 300
    - maxmem: 800
    - vcpus: 2
    - template_for_dispvms: True


qvm-features-id:
  qvm.features:
    - name: tbb-dvm
    - disable:
      - service.cups
      - service.cups-browsed
    - appemenus-dispvm: True

tbb:
  qvm.present:
    - name: tbb
    - class: DispVM
    - template: tbb-dvm
    - label: red
