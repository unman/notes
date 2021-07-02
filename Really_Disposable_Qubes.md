## Disposable qubes
In normal use qubes are created on, and changes written to, the disk. There is also extensive logging and signs of the qube are scattered in a number of places.
Sometimes, you want to create a qube which does not leave these traces.  
You can do this relatively simply, by creating a RAM based storage area and using it for a new storage pool.
The qube will persist until the RAM disk is deleted, or the machine is shut down.

A script like this in dom0, will create tmpfs RAM disk, create a new storage pool, and create a new qube using that pool.  
tmp_qubes.sh:  
```
#!/bin/bash
mkdir /home/user/tmp
sudo mount -t tmpfs -o size=2G new /home/user/tmp/
qvm-pool --add newer file -o revisions_to_keep=1,dir_path=/home/user/tmp/
qvm-create new -P newer -t template-debian-10-vanilla  -l purple --property netvm=tor
qvm-run new firefox-esr 
```

You can remove the qube, and some of the associated artifacts by script in dom0.  
rmtmp_qube.sh:  
```
#!/bin/bash
qvm-kill new
qvm-remove -f new
qvm-pool -r newer 
sudo umount new
rm -rf /home/user/tmp
sudo rm -rf /var/log/libvirt/libxl/new.log
sudo rm -rf /var/log/libvirt/libxl/new.log
sudo rm -rf /var/log/qubes/vm-new.log
sudo rm -rf /var/log/guid/new.log
sudo rm -rf /var/log/qrexec.new.log
sudo rm -rf /var/log/pacat.new.log
sudo rm -rf /var/log/qubesdb.new.log
```

None of this is forensically reliable, although it is better than using a standard pool. (Refer to [this issue](https://github.com/QubesOS/qubes-issues/issues/4972), particularly if you are using Xfce, and check the associated issues.)
Also, the scripts themselves will be on the disk, which may require some explanation.
