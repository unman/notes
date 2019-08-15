include:
  - template-debian-10-minimal

qvm-clone-id:
  qvm.clone:
    - require:
      - sls: template-debian-10-minimal 
    - name: template-tbb
    - source: debian-10-minimal
