include:
  - sys-usb.clone


remove:
  qvm.absent:
    - name: sys-usb

remove2:
  qvm.absent:
    - name: sys-usb-dvm

qvm-present-id:
  qvm.present:
    - name: sys-usb-dvm
    - template: template-sys-usb
    - label: red

qvm-prefs-id:
  qvm.prefs:
    - name: sys-usb-dvm
    - netvm: none
    - memory: 300
    - vcpus: 2
    - virt_mode: hvm
    - autostart: False
    - template_for_dispvms: True
    - include_in_backups: false

sys-usb:
  qvm.present:
    - name: sys-usb
    - template: sys-usb-dvm
    - class: DispVM
    - label: red

sys-usb-prefs:
  qvm.prefs:
    - name: sys-usb
    - autostart: false
    - include_in_backups: false
    - pcidevs: ['00:1d.0']
    - pci_strictreset: False

qvm-features-id:
  qvm.features:
    - name: sys-usb
    - disable:
      - service.cups
      - service.cups-browsed
      - service.meminfo-writer
      - service.cups-browsed
      - service.qubes-updates-proxy

update_file:
  file.prepend:
    - name: /etc/qubes-rpc/policy/qubes.InputMouse
    - text: sys-usb dom0 allow,user=root

update_file_keyboard:
  file.prepend:
    - name: /etc/qubes-rpc/policy/qubes.InputKeyboard
    - text: sys-usb dom0 allow,user=root 
