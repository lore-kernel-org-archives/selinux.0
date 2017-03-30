Message-Id: <1490886323.3458882.928743312.12DA81DD@webmail.messagingengine.com>
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <1490881474.18002.3.camel@tycho.nsa.gov>
Subject: Re: label for /proc directory (before mounting)
Date: Thu, 30 Mar 2017 11:05:23 -0400
References: <1490821242.510644.927878696.6DEBD3A9@webmail.messagingengine.com>
 <1490881474.18002.3.camel@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Mar 30, 2017, at 09:44 AM, Stephen Smalley wrote:

> You shouldn't hardcode security contexts, ever.  Why can't one just fix
> the Fedora policy?  Do we still even need the <<none>> entries for
> /proc in file_contexts in Fedora policy, given that restorecon is now
> smart enough to skip any filesystem that lacks seclabel in
> /proc/mounts? Android doesn't use <<none>> in its file_contexts at all.

Right.  The other "API mountpoints" (/dev, /sys) seem to use the same type as their
genfscon.  Here's a paste - note the lack of `security.selinux` on `/proc`:

```
# ostree ls -X fedora-atomic:fedora-atomic/25/x86_64/docker-host
d00755 0 0      0 { [(b'security.selinux', b'system_u:object_r:root_t:s0')] } /
l00777 0 0      0 { [(b'security.selinux', b'system_u:object_r:bin_t:s0')] } /bin -> usr/bin
l00777 0 0      0 { [(b'security.selinux', b'system_u:object_r:home_root_t:s0')] } /home -> var/home
l00777 0 0      0 { [(b'security.selinux', b'system_u:object_r:lib_t:s0')] } /lib -> usr/lib
l00777 0 0      0 { [(b'security.selinux', b'system_u:object_r:lib_t:s0')] } /lib64 -> usr/lib64
l00777 0 0      0 { [(b'security.selinux', b'system_u:object_r:mnt_t:s0')] } /media -> run/media
l00777 0 0      0 { [(b'security.selinux', b'system_u:object_r:mnt_t:s0')] } /mnt -> var/mnt
l00777 0 0      0 { [(b'security.selinux', b'system_u:object_r:usr_t:s0')] } /opt -> var/opt
l00777 0 0      0 { [(b'security.selinux', b'system_u:object_r:usr_t:s0')] } /ostree -> sysroot/ostree
l00777 0 0      0 { [(b'security.selinux', b'system_u:object_r:admin_home_t:s0')] } /root -> var/roothome
l00777 0 0      0 { [(b'security.selinux', b'system_u:object_r:bin_t:s0')] } /sbin -> usr/sbin
l00777 0 0      0 { [(b'security.selinux', b'system_u:object_r:var_t:s0')] } /srv -> var/srv
l00777 0 0      0 { [(b'security.selinux', b'system_u:object_r:tmp_t:s0')] } /tmp -> sysroot/tmp
d00555 0 0      0 { [(b'security.selinux', b'system_u:object_r:boot_t:s0')] } /boot
d00755 0 0      0 { [(b'security.selinux', b'system_u:object_r:device_t:s0')] } /dev
d00755 0 0      0 { @a(ayay) [] } /proc
d00755 0 0      0 { [(b'security.selinux', b'system_u:object_r:var_run_t:s0')] } /run
d00755 0 0      0 { [(b'security.selinux', b'system_u:object_r:sysfs_t:s0')] } /sys
d00755 0 0      0 { [(b'security.selinux', b'system_u:object_r:default_t:s0')] } /sysroot
d00755 0 0      0 { [(b'security.selinux', b'system_u:object_r:usr_t:s0')] } /usr
d00755 0 0      0 { [(b'security.selinux', b'system_u:object_r:var_t:s0')] } /var
#
 ```

> As to what type it should have, I would try to keep it in whatever type
> it is presently being assigned in Fedora during an install to avoid
> breakage.  Not sure offhand what that is.

Atomic Host *is* Fedora too[1] - so the terminology is more around a yum-based
install vs an rpm-ostree based install.

This aspect is where ostree is (IMO) better - we do SELinux labeling in
the ostree commit on the server side, and that's replicated *exactly*
to clients.  Whereas for yum-based installs, both RPM and Anaconda are involved
in labeling with fuzzy boundaries between them.

Anyways, the answer (at least for the CentOS yum-based Vagrant box):

(for x in 'run' 'mount /dev/VolGroup00/LogVol00 /' 'getxattrs /proc'; do echo $x; done) | guestfish --ro -a /srv/tmp/centos-VAGRANTSLASH-7
_vagrant_box_image_1608.02.img                                                                                                                                                                
[0] = {
  attrname: security.selinux
  attrval: system_u:object_r:root_t:s0\x00
}

Presumably during Anaconda, RPM is finding no label, makes the directory
anyways, and it's just inheriting the root_t context.

> There is a more general problem here though, in that we don't presently
> have an unambiguous way to specify a different security context for a
> mountpoint directory vs a mounted directory in file_contexts.  That's
> been previously noted as an issue in Android.  Probably requires some
> new syntax in file_contexts to distinguish.

Right.  I agree that we should try to fix the Fedora policy to
remove the <<none>> if we're confident the tools aren't going to
start traversing into a mounted /proc.  That said I'm likely
to carry a hack for this in ostree to avoid waiting for it - I changed
the code now in the PR to use the same label as `/mnt`, since I'm
not aware of a way to ask for "something that will give me proc_t".

[1] https://getfedora.org/
