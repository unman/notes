btrfs - does not start after install
ACPI  - does not start after install
HVM
memory 4000


Change Computer to Standard PC
Display 1024x768x16
FAT32 on /dev/sda

Setup copy files
Install Bootloader - MBR/VBR

Reboot
Wizard
Workstation
Typical Settings
Part of workgroup

Reboot

Boots with "New Hardware Wizard" - "Other PCI device"
Freezes
Try with Manual configuration:
NO DEVICE SHOWN

Set netvm=none
Install succesful - in setup all good.
Same "Other PCI device" but set up completes, with "no driver found"
Boots in to working system.
The "Other PCI device " has PCI/VEN 5853&DEV_0001
This is "Xen Platform Device" -  a device for high-speed communication between the guest and the host.  If PV drivers are installed the device is no longer unknown. 
Display/Window is resizeable.

Add netvm
Reboot -
`ipconfig` shows correct IP.gateway but wrong mask.
(Try ping - qube hangs - **Dont do this**)
Set Mask to 255.0.0.0
Reboot -
Good

Installed Firefox
UPgraded to 52.9 - FF will not start.
Revert to ROS version.

