installed:
  pkg.installed:
    - pkgs:
      - firefox-esr: '52.9.0*'

# Version specification is tricky.
# You can use wild cards as above.
# The Debian package to be installed would be fully specified:
# firefox-esr:52.9.0esr-1~deb9u1


# When using versions for dnf, you have to specify the epoch.
# You can ignore the check though, like this:

# installed:
#   pkg.installed:
#     - ignore_epoch: True
#     - pkgs:
#       - enigmail: '2:2.0.6'
# This will match against version 2.0.6. ignoring the epoch value


