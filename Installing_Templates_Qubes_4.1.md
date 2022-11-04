# Installing Templates in Qubes 4.1

## Problem 
Qubes 4.1 has limited the size of dom0 to 20G by default.  
This means that when installing some templates, the install will fail with the message
`error an extra X required`.  
The problem is that when installing a template from an rpm package, the template is first unpacked in parts in `/var/lib/qubes/vm-templates/TEMPLATE_NAME`, and then rebuilt from those parts.

There are 2 solutions, depending on whether you want to permanently increase the size of dom0.

### 1. Resize dom0 permanently

```
sudo lvresize --size 40G /dev/qubes_dom0/root
sudo resize2fs /dev/mapper/qubes_dom0-root
```

### 2. Add more space to dom0 temporarily
The process here is to create a new thin_pool, and mount it in dom0 where the package will be unpacked.  

For example, if you want to install a large Parrot template, the package will be unpacked in `/var/lib/qubes/vm-templates/parrot`.

Create a new logical volume you can use - for example, one called `extra_space`.
We'll make it 20G in size.  
```
sudo lvcreate -n extra_space -V 20G --thinpool vm-pool qubes_dom0
```

Format the volume:  
`sudo mkfs.ext4 /dev/qubes_dom0/extra_space`  
Mount it where needed, and make sure permissions are correct:  
```
sudo mount /dev/qubes_dom0/extra_space /var/lib/qubes/vm-templates/parrot
sudo chown -R root:qubes /var/lib/qubes/vm-templates/parrot
```

When you have finished the install you can unmount the volume.  
You can leave the volume there, and mount it again if you need it for another template.
