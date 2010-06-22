Message-ID: <4C212435.9070806@redhat.com>
Date: Tue, 22 Jun 2010 16:59:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Chad Sellers <csellers@tresys.com>
Subject: Re: We need libselinux to lie...
References: <4C20EDA0.6050907@redhat.com> <1277235172.28715.122.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1277235172.28715.122.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 06/22/2010 03:32 PM, Stephen Smalley wrote:
> On Tue, 2010-06-22 at 13:06 -0400, Daniel J Walsh wrote:
>> When building packages within mock/livecd.
>>
>> We really want the processes running within the chroot to not do SELinux
>> stuff.
>>
>> We want libselinux to tell them that SELinux is disabled.
>>
>> For example if we install selinux-policy package within a mock chroot or
>> livecd we do not want it to try to load_policy.  Other rpms try chcon or
>> restorecon in post installs.  These are get turned off if the tools
>> think SELinux is disabled.  We are not doing this for security reasons.
> 
> I understand not wanting to load policy.  Not so sure that you want to
> suppress all labeling during the rpm installation though.
> 
>> We have been hacking this out, but replaceing $CHROOT/proc/filesystem
>> with a version that does not include filesystem, but we have found this
>> to require large privs for mock. (mount -o bind /tmp/filesystem
>> $CHROOT/proc/filesystem; requires mock_t to read /dev/loop which is
>> labeled fixed_disk_device_t)
> 
> I don't quite understand this.  Why can't you simply do:
> mount -o bind /dev/null /proc/filesystems
> if you just want an empty /proc/filesystems?
> 
> Or you could just create an empty file and do the same.  Why
> is /dev/loop involved?
> 

grep -v selinuxfs /proc/filesystems  > /tmp/filesystems
strace -o /tmp/out mount -o bind /tmp/filesystems /mnt/dan
 grep loop /tmp/out
stat("/dev/loop", 0x7fff70495750)       = -1 ENOENT (No such file or
directory)
open("/dev/loop0", O_RDONLY)            = 3
open("/dev/loop0", O_RDWR)              = 4
mount("/dev/loop0", "/mnt/dan", 0x7fb82aa32474, MS_MGC_VAL|MS_BIND,
NULL) = 0
write(5, "/dev/loop0 /mnt/dan none rw,bind"..., 37) = 37

We tried this in mock, and we ended up needing

allow mock_t fixed_disk_device_t:file read;

/dev/null does not use /dev/loop but might cause other scripts to blow up.


>> We have considered playing tricks with libselinux.so but those seem a
>> little dangerous.
> 
> $ cat libnoselinux.c
> int is_selinux_enabled(void)
> {
> 	return 0;
> }
> $ gcc -fPIC -c libnoselinux.c 
> $ ld -shared -soname libnoselinux.so -o libnoselinux.so -lc libnoselinux.o
> $ LD_PRELOAD=./libnoselinux.so sestatus
> SELinux status:                 disabled
> 
We considered this also, shipping libselinux_disabled.so with libselinux
and then playing this trick.  Which is fine with me.  We had concerns
about possibly polluting rpmbuild, into adding a requires
libselinux_disabled.so


>> Eric has come up with an idea of adding a field to
>> $CHROOT/etc/selinux/config to tell is_selinux_enabled() to return false.
>>
>> SPECIAL_ENABLED=force_off
>>
>> Then mock could just set this flag in the config file and all apps would
>> think SELinux is disabled.
>>
>> Does this seem reasonable?
> 
> Doesn't seem necessary.  Harmless though as long as it can only by set
> via admin-controlled config.  What we do not want is an environment
> variable or the like, whereby an untrusted caller could turn off SELinux
> permission checking in passwd by making it appear that SELinux was
> disabled.
> 

I could go with either solution.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
