include:
  - sys-usb.clone

remove:
  qvm.absent:
    - names: 
      - sys-usb
      - sys-usb-dock
      - sys-usb-left
      - sys-usb-dvm

sys-usb-dvm:
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

{% set usbs = ['sys-usb','sys-usb-dock','sys-usb-left'] %}
{% for usb in usbs %}
{{usb}}:
  qvm.present:
    - name: 
      - {{usb}}
    - template: sys-usb-dvm
    - class: DispVM
    - label: red

{{usb}}-prefs:
  qvm.prefs:
    - name: {{usb}}
    - autostart: false
    - include_in_backups: false
    - pci_strictreset: False
    {% if usb == 'sys-usb' %}
    - pcidevs: [ '00:1a.0' ]
    {% elif usb == 'sys-usb-left' %}
    - pcidevs: [ '00:14.0' ]
    {% elif usb == 'sys-usb-dock' %}
    - pcidevs: [ '00:1d.0' ]
    {% endif %}

{{usb}}-features:
  qvm.features:
    - name: {{usb}}
    - disable:
      - service.cups
      - service.cups-browsed
      - service.meminfo-writer
      - service.cups-browsed
      - service.qubes-updates-proxy

{% endfor%}

update_file:
  file.prepend:
    - names:
        - /etc/qubes-rpc/policy/qubes.InputMouse
        - /etc/qubes-rpc/policy/qubes.InputKeyboard
    - text: sys-usb dom0 allow,user=root
    - text: sys-usb-dock dom0 allow,user=root

