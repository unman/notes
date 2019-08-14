include:
  - template-debian-10-minimal

qvm-clone-id:
  qvm.clone:
    - require:
      - sls: template-debian-10-minimal 
    - name: template-sys-usb
    - source: debian-10-minimal
