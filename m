Subject: Re: We need libselinux to lie...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <4C212435.9070806@redhat.com>
References: <4C20EDA0.6050907@redhat.com>
	 <1277235172.28715.122.camel@moss-pluto.epoch.ncsc.mil>
	 <4C212435.9070806@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 23 Jun 2010 08:46:39 -0400
Message-ID: <1277297199.1362.36.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-06-22 at 16:59 -0400, Daniel J Walsh wrote:
> On 06/22/2010 03:32 PM, Stephen Smalley wrote:
> > On Tue, 2010-06-22 at 13:06 -0400, Daniel J Walsh wrote:
> >> When building packages within mock/livecd.
> >>
> >> We really want the processes running within the chroot to not do SELinux
> >> stuff.
> >>
> >> We want libselinux to tell them that SELinux is disabled.
> >>
> >> For example if we install selinux-policy package within a mock chroot or
> >> livecd we do not want it to try to load_policy.  Other rpms try chcon or
> >> restorecon in post installs.  These are get turned off if the tools
> >> think SELinux is disabled.  We are not doing this for security reasons.
> > 
> > I understand not wanting to load policy.  Not so sure that you want to
> > suppress all labeling during the rpm installation though.
> > 
> >> We have been hacking this out, but replaceing $CHROOT/proc/filesystem
> >> with a version that does not include filesystem, but we have found this
> >> to require large privs for mock. (mount -o bind /tmp/filesystem
> >> $CHROOT/proc/filesystem; requires mock_t to read /dev/loop which is
> >> labeled fixed_disk_device_t)
> > 
> > I don't quite understand this.  Why can't you simply do:
> > mount -o bind /dev/null /proc/filesystems
> > if you just want an empty /proc/filesystems?
> > 
> > Or you could just create an empty file and do the same.  Why
> > is /dev/loop involved?
> > 
> 
> grep -v selinuxfs /proc/filesystems  > /tmp/filesystems
> strace -o /tmp/out mount -o bind /tmp/filesystems /mnt/dan
>  grep loop /tmp/out
> stat("/dev/loop", 0x7fff70495750)       = -1 ENOENT (No such file or
> directory)
> open("/dev/loop0", O_RDONLY)            = 3
> open("/dev/loop0", O_RDWR)              = 4
> mount("/dev/loop0", "/mnt/dan", 0x7fb82aa32474, MS_MGC_VAL|MS_BIND,
> NULL) = 0
> write(5, "/dev/loop0 /mnt/dan none rw,bind"..., 37) = 37

I did this:
# grep -v selinuxfs /proc/filesystems  > /tmp/filesystems
# strace -o /tmp/out mount -o bind /tmp/filesystems /proc/filesystems

and then I see the following in /tmp/out (no references to /dev/loop at
all):
...
stat("/tmp/filesystems", {st_mode=S_IFREG|0644, st_size=377, ...}) = 0
readlink("/tmp", 0x7fffa6a6af60, 4096)  = -1 EINVAL (Invalid argument)
readlink("/tmp/filesystems", 0x7fffa6a6af60, 4096) = -1 EINVAL (Invalid
argument
)
...
mount("/tmp/filesystems", "/proc/filesystems", 0x7f569c52fdd0,
MS_MGC_VAL|MS_BIND, NULL) = 0
...

It never even tries to access /dev/loop, nor is there any reason for it
to do so for a bind mount.

There must be something different about your setup and/or mount program.
cat /proc/mounts
rpm -q -f `which mount`

> We tried this in mock, and we ended up needing
> 
> allow mock_t fixed_disk_device_t:file read;

I'm inclined to think that /dev/loop ought to be labeled differently
anyway.

> /dev/null does not use /dev/loop but might cause other scripts to blow up.

I'd be surprised - any dependency on the host's /proc/filesystems file
is going to be unsafe since it need not match the target's kernel at
all.

> 
> >> We have considered playing tricks with libselinux.so but those seem a
> >> little dangerous.
> > 
> > $ cat libnoselinux.c
> > int is_selinux_enabled(void)
> > {
> > 	return 0;
> > }
> > $ gcc -fPIC -c libnoselinux.c 
> > $ ld -shared -soname libnoselinux.so -o libnoselinux.so -lc libnoselinux.o
> > $ LD_PRELOAD=./libnoselinux.so sestatus
> > SELinux status:                 disabled
> > 
> We considered this also, shipping libselinux_disabled.so with libselinux
> and then playing this trick.  Which is fine with me.  We had concerns
> about possibly polluting rpmbuild, into adding a requires
> libselinux_disabled.so

A little bird told me that rpm dependency filtering can solve that
problem.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
