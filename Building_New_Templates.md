Here's how to build a Parrot template - you can adapt this to cover just
about *any* case which is based on an existing template.

Parrot, like Kali, is based on Debian testing - so the first thing you
need to do is make sure you can build a bullseye template.

1. Set up the Qubes build environment, as set out here:  
https://www.qubes-os.org/doc/qubes-builder/  
If you want a configured environment there is a salt formula in https://github.com/unman/shaker  

2. In `qubes-builder`, run `./setup`  
Select 4.0  
Stable  
Git Clone Faster  
DO NOT use Pre-build Packages - select OK without having selected an option
Build only the templates  
In the Selection list choose "buster"  
In the Plugins Selection, **deselect** builder-rpm and **select** builder-debian.  
Get-sources - select "Yes"

3. Now edit the file that has been created - `builder.conf`:  
Look for the Section headed `LIST OF DIST VM'S`  
This is where you specify what VM will be built.  
Change the line under `# Enabled DISTS_VMs` that says:  
`DISTS_VM += buster+standard` TO  
`DISTS_VM += bullseye`  
Save the file

4. `make qubes-vm`

This will create a bullseye chroot, and build all the qubes packages.

5. Once you can build the bullseye packages, you can build Parrot.  
Parrot is a "flavor" of bullseye, so you specify it like this in the `builder.conf` file:  
`bullseye+parrot`

You can change the template name in the section marked `TEMPLATE CONFIGURATION`  
`TEMPLATE_LABEL` += bullseye+parrot:parrot`

Add a line:  
`TEMPLATE_FLAVOR_DIR += +parrot:$$$$TEMPLATE_SCRIPTS/parrot`

6. Almost all of the necessary work is done in the `builder-debian` directory.  
You have to identify any changes that are needed to a standard bullseye build.
You need to set the Parrot repository.
Add the Parrot signing key.
Specify what packages you want to install in the template.

Put the Parrot signing key in the `keys` directory.  
In the `template_debian` directory create a file `packages_parrot.list` and specify the packages to install - just one line will do:  
`parrot-tools-full`  
Create `template_debian/parrot`, and create a file `04_install_qubes_post.sh`  

This is the file that does the Parrot install - it runs *after* the standard `04_install_qubes.sh` script.  
You can copy an existing file and adapt it as you will.  
In this case, we want to add the parrot key, update the repository list, and then run the install. 
If you look at the file you will see that we use `chroot_cmd` to run commands in the chroot built earlier, and various helper scripts from `distribution.sh`

Because Bullseye is a *testing* distribution it may be that some updates would break the Qubes packages.
You can avoid this by marking the key packages with "hold".

7. The only other change needed is to make sure there is enough space in the template.
The templates are created in `qubes-src/linux-template-builder/prepare_image`:  
```
if [ -z "$TEMPLATE_ROOT_SIZE" ]; then
    TEMPLATE_ROOT_SIZE=10G
fi
```

You can change this, or insert a new stanza like so:  
```
if [ "$TEMPLATE_FLAVOR" == "parrot" ];then
    TEMPLATE_ROOT_SIZE=30G
fi
if [ -z "$TEMPLATE_ROOT_SIZE" ]; then
    TEMPLATE_ROOT_SIZE=10G
fi
```

8. Now everything is in place.
In `qubes-builder`, run `make template`, and new parrot template should (finally) appear in `qubes-builder/qubes-src/linux-template-builder/rpm/noarch` ready to copy in to dom0 and install.


The changes to builder-debian are in my "parrot" branch.
You can grab them like so:  
```
cd qubes-src/builder-debian
git remote add unman https://github.com/unman/qubes-builder-debian.git
git fetch unman
git checkout -b parrot unman/parrot
```

Although this is long, it takes far longer to read than to do, and the process is simple.
You can adapt this processs to build almost any flavour of template you want: any template based on an existing template.
Parrot, Kali, Mint, BlackArch.

Building a **new** template takes a little more work.














