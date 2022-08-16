# Using apt-cacher-ng as a caching proxy in Qubes.

## Why?
The standard tinyproxy is just a proxy. This ,means that as soon as you start to use more than a few templates you are wasting bandwidth (and time) in repeatedly downloading the same packages.  
Using a caching proxy saves on both.

## How?
apt-cacher-ng is a caching proxy with support for Debian based distros out of the box, as well as Arch.
It can be configured to support Fedora, Suse, Gentoo, and \*BSD

###  INSTALL 
Create a new Debian based template -  
`qvm-clone debian-11-minimal template-cacher`

In template-cacher install the software, by running as root:  
```
apt-get install qubes-core-agent-networking apt-cacher-ng 
systemctl mask apt-cacher-ng 
```
Shut down template-cacher.

### Create and configure the proxy

Create a qube and give it plenty of space on the private volume:
```
qvm-create cacher -t template-cacher -l red 
qvm-volume resize cacher:private 40G
```

Start the proxy, and configure bind-dirs to store significant material on the private volume:  
Create a file at /rw/config/qubes-bind-dirs.d/50_user.conf:
```
binds+=( '/var/cache/apt-cacher-ng' )
binds+=( '/var/log/apt-cacher-ng' )
binds+=( '/etc/apt-cacher-ng' )
```

Use /rw/config/rc.local to start the apt-cacher-ng service.  
Add these lines:  
```
systemctl unmask apt-cacher-ng
systemctl start apt-cacher-ng
/sbin/iptables -I INPUT -p tcp --dport 8082 -j ACCEPT
```

Restart cacher.

In /etc/apt-cacher-ng/acng.conf:
edit the `Port:` line to say `Port:8082`

Restart service:  
`systemctl restart apt-cacher-ng`


### Using the proxy
You can use the proxy simply be editing the qrexec policy.
Create a new policy in dom0 /etc/qubes/policy/30-user.policy:
`qubes.UpdatesProxy * @type:TemplateVM  @default  allow target=cacher`

Now all templates will attempt to use the caching proxy instead of the default proxy running on sys-net.


### Configuring templates.
Some templates use HTTPS links to repositories. These need special treatment.

There are two methods:  
1. 
Create new file in /etc/apt-cacher-ng/backends_qubes:
https://yum.qubes-os.org/

Edit /etc/apt-cacher-ng/acng.conf:
Remap-qubes: http://fake.qubes ; file:backends_qubes

Then in /etc/yum/yum.repos.d, change the repository URL to
http://fake.qubes/......

Now the qube will use HTTP to the proxy which will use TLS to pick up the
packages and cache any responses.

2.
Change the repository definition FROM:
https://yum.qubes-os.org/
TO:
http://HTTPS///yum.qubes-os.org/

This will use HTTP to the proxy - the proxy will use TLS to pick up the packages and
cache any responses.  
This is the recommended approach.

You can make this change in the template by running:  
`sed -i s^https://^http://HTTPS///^ REPO_DEFINITION`  
e.g. `sed -i s^https://^http://HTTPS///^ /etc/apt/sources.list`

You must make the change in *every defined repository that you want to use*. If you do not then you will see an error message:
```
Failed to fetch ....
Invalid response from proxy: HTTP/1.0 403 CONNECT denied (ask the admin to allow HTTPS tunnels)
```


## Other configuration.

### Grouping repositories
apt-cacher-ng has a mechanism for mapping calls to different repositories on to the same cache.
This is called `mapping` and is described in the excellent [manual](https://www.unix-ag.uni-kl.de/~block/acng/html/index.html).
There are some predefined mapping lists that you can use.  
If you check the caches at `/var/cache/apt-cacher-ng` you may see that there are entries for individual repositories. You can edit the mapping files to include them.
Ideally you want **all** the packages downloaded from **any** Debian repository to be served from the same cache.

### Fedora
Fedora templates need some special treatment, because the default repository definitions use metalinks.
You can either change this to use a BASEURL definition, or to make the metalinks return HTTP repos instead of HTTPS links.

You can do this by changing (e.g) `metalink= https://......basearch` to `metalink=http://HTTPS///.....basearch&protocolo=http`. This will make the metalink only return http repositories.

There is a mirrors list in /usr/lib/apt-cacher-ng/
Copy fedora_mirrors to /etc/apt-cacher-ng

Edit /etc/apt-cacher-ng/acng.conf, to use the mapped data:  
`Remap-fedora: file:fedora_mirrors`

If requests fail because the file type is not allowed, create a pattern for
volatile data:
`VfilePatternEx: .*metalink?repo=fedora*`

All this is covered in the manual.


### Troubleshooting

You can exclude templates from using the proxy by setting a policy line *before* the one that points to cacher in /etc/qubes/policy/30-user.policy.
The new line should point named templates to the default system proxy, like this:
```
qubes.UpdatesProxy * fedora-36         @default  allow target=sys-net
qubes.UpdatesProxy * @type:TemplateVM  @default  allow target=cacher
```

Access logs are available on cacher at `/var/log/apt-cacher-ng`.

You can see the cached data in /var/cache/apt-cacher-ng.

There is also a dashboard available on the caching proxy at http://localhost:8082, which contains useful information about how much data is cached and how often used.

Read the [manual](https://www.unix-ag.uni-kl.de/~block/acng/html/index.html).


### Updates over Tor or VPN
Set the netvm for the cacher qube to a Tor or VPN proxy.


# The simple way:
Follow the instructions at https://qubes.3isec.org/tasks.html to install qubes-task.  
Select the cacher package and install it.  
The caching proxy will be created, and configured.
All existing templates will be configured to use the proxy.
