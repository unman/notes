# -*- coding: utf-8 -*-
# vim: set syntax=yaml ts=2 sw=2 sts=2 et :

##
# qvm.template-fedora-30-minimal
# ======================
#
# Installs 'fedora-30-minimal' template.
#
# Execute:
#   qubesctl state.sls qvm.template-fedora-30-minimal dom0
##

template-fedora-30-minimal:
  pkg.installed:
    - name:     qubes-template-fedora-30-minimal
    - fromrepo: qubes-templates-itl
