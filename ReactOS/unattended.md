iso has unattend.inf in /reactos

## unattend.inf
```

[Unattend]
Signature = "$ReactOS$"

; Set UnattendSetupEnabled to yes in order to get unattended setup working
; yes - unattend setup enabled
; no - unattend setup disabled
UnattendSetupEnabled = no

; Install to \Device\Harddisk0\Partition1\ReactOS
DestinationDiskNumber = 0
DestinationPartitionNumber = 1
InstallationDirectory=ReactOS

; MBRInstallType=0  skips MBR installation
; MBRInstallType=1  install MBR on floppy
; MBRInstallType=2  install MBR on hdd
MBRInstallType=2

FullName="MyName"
;OrgName="MyOrg"
ComputerName="MYCOMPUTERNAME"
;AdminPassword="MyPassword"

; TimeZone is set GMT as default
TimeZoneIndex=85

; enable this setting to disable daylight saving changes
; DisableAutoDaylightTimeSet = 1

; enable this setting to format the selected partition
; 1 - format enabled
; 0 - format disabled
FormatPartition=1

; enable this setting to automatically create a partition
; during installation
; 1 - enabled
; 0 - disabled
AutoPartition = 1

; choose default file system type
; 0 - FAT
; 1 - BtrFS
FsType = 0

; enable this setting to disable Gecko install
; yes - disabled
; no  - enabled
DisableGeckoInst = no

; set this option to automatically
; specify language in 2nd mode setup
; see hivesys.inf for available languages
LocaleID = 409

; set product option
; 0: ReactOS Server
; 1: ReactOS Workstation
ProductOption = 0

; enable this section to automatically launch programs
; after 3rd boot
;
; [GuiRunOnce]
; %SystemRoot%\system32\cmd.exe
; Enable the next line (+ the GuiRunOnce section) to enable the lautus theme
; "rundll32.exe shell32.dll,Control_RunDLL desk.cpl desk,@Appearance /Action:ActivateMSTheme /file:%SYSTEMROOT%\Resources\themes\lautus\lautus.msstyles"


; enable this section to change resolution / bpp
; setting a value to 0 or skipping it will leave it unchanged
; [Display]
; BitsPerPel = 32
; XResolution = 1440
; YResolution = 900
; VRefresh = 0
```
Mount the install image.  
Copy the contents to a directory.  
Edit the unattend.inf file  
At a minimum, set  
`UnattendSetupEnabled = yes`

Perhaps also set Name, Computer Name, and Password:
```
FullName="user"
;OrgName="MyOrg"
ComputerName="ReactOS"
AdminPassword="qubes"

; enable this section to change resolution / bpp
; setting a value to 0 or skipping it will leave it unchanged
[Display]
BitsPerPel = 32
XResolution = 1024
YResolution = 768
VRefresh = 0

```

Other options are best left alone.

Using the unattended install results in ReactOS showing the driver install on boot instead of the ReactOS logo.
