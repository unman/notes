include:
  - build.template-fedora-30-minimal

qvm-clone-id:
  qvm.clone:
    - require:
      - sls: build.template-fedora-30-minimal 
    - name: template-builder
    - source: fedora-30-minimal
