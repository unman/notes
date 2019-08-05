qvm-present-id:
  qvm.present:
    - name: cacher
    - template: template-cacher
    - label: gray

/etc/qubes-rpc/policy/qubes.UpdatesProxy:
  file.prepend:
    - text: $type:TemplateVM $default allow,target=cacher
