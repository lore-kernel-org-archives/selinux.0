Subject: Re: We need libselinux to lie...
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Chad Sellers <csellers@tresys.com>
In-Reply-To: <4C20EDA0.6050907@redhat.com>
References: <4C20EDA0.6050907@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 22 Jun 2010 15:32:52 -0400
Message-ID: <1277235172.28715.122.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-06-22 at 13:06 -0400, Daniel J Walsh wrote:
> When building packages within mock/livecd.
> 
> We really want the processes running within the chroot to not do SELinux
> stuff.
> 
> We want libselinux to tell them that SELinux is disabled.
> 
> For example if we install selinux-policy package within a mock chroot or
> livecd we do not want it to try to load_policy.  Other rpms try chcon or
> restorecon in post installs.  These are get turned off if the tools
> think SELinux is disabled.  We are not doing this for security reasons.

I understand not wanting to load policy.  Not so sure that you want to
suppress all labeling during the rpm installation though.

> We have been hacking this out, but replaceing $CHROOT/proc/filesystem
> with a version that does not include filesystem, but we have found this
> to require large privs for mock. (mount -o bind /tmp/filesystem
> $CHROOT/proc/filesystem; requires mock_t to read /dev/loop which is
> labeled fixed_disk_device_t)

I don't quite understand this.  Why can't you simply do:
mount -o bind /dev/null /proc/filesystems
if you just want an empty /proc/filesystems?

Or you could just create an empty file and do the same.  Why
is /dev/loop involved?

> We have considered playing tricks with libselinux.so but those seem a
> little dangerous.

$ cat libnoselinux.c
int is_selinux_enabled(void)
{
	return 0;
}
$ gcc -fPIC -c libnoselinux.c 
$ ld -shared -soname libnoselinux.so -o libnoselinux.so -lc libnoselinux.o
$ LD_PRELOAD=./libnoselinux.so sestatus
SELinux status:                 disabled

> Eric has come up with an idea of adding a field to
> $CHROOT/etc/selinux/config to tell is_selinux_enabled() to return false.
> 
> SPECIAL_ENABLED=force_off
> 
> Then mock could just set this flag in the config file and all apps would
> think SELinux is disabled.
> 
> Does this seem reasonable?

Doesn't seem necessary.  Harmless though as long as it can only by set
via admin-controlled config.  What we do not want is an environment
variable or the like, whereby an untrusted caller could turn off SELinux
permission checking in passwd by making it appear that SELinux was
disabled.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
