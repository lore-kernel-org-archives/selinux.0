Subject: Re: libselinux mountpoint changing patch.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>,
        Lennart Poettering
 <lennart@poettering.net>,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <4DC01640.9000206@redhat.com>
References: <4DC01640.9000206@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 03 May 2011 11:33:20 -0400
Message-ID: <1304436800.1587.20.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2011-05-03 at 10:50 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> The Fedora Distribution is looking to standardize kernel subsystem file
> systems to be mounted under /sys/fs. They would like us to move /selinux
> to /sys/fs/selinux.  This patch changes libselinux in the following ways:
> 
> 1.  load_policy will first check if /sys/fs/selinux exists and mount the
> selinuxfs at this location, if it does not exists it will fall back to
> mounting the file system at /selinux (if it exists).
> 
> 2.  The init functions of selinux will now check if /sys/fs/selinux is
> mounted, if it is and has an SELinuxfs mounted on it, the code will then
> check if the selinuxfs is mounted rw, if it is, libselinux will set the
> mountpoint, if it is readonly, libselinux will return no mountpoint.  If
> /sys/fs/selinux does not exists, the same check will be done for
> /selinux and finally for an entry in /proc/mounts.
> 
> NOTE:  We added the check for RO, to allow tools like mock to be able to
> tell a chroot that SELinux is disabled while enforcing it outside the
> chroot.
> 
> 
> # getenforce
> Enabled
> # mount -t selinuxfs -o remount,ro selinuxfs /var/chroot/selinux

Just to clarify, the right commands to use are:
mount --bind /selinux /var/chroot/selinux
mount -o remount,ro /var/chroot/selinux

Do not use:
mount -t selinuxfs -o ro selinuxfs /var/chroot/selinux
as this will in fact change the flags on /selinux as well.  Surprise!
Result of there only being a single instance (superblock) of selinuxfs,
although you can have multiple vfsmounts of it.

> # chroot /var/chroot
> # getenforce
> Disabled
> 
> 3. In order to make this work, I needed to stop enabled from checking if
> /proc/filesystem for entries if selinux_mnt did not exist.  Now enabeled
> checks if selinux_mnt has been discovered otherwise it will report
> selinux disabled.

Looks reasonable, minor comments below.

Can we really not get all the necessary information from a single call
(as opposed to having to call both statfs() and statvfs())?  Isn't
statvfs() implemented on Linux by calling the statfs system call?

I'd suggest adding a #define OLDSELINUXMNT "/selinux" to policy.h and
using OLDSELINUXMNT in init.c and load_policy.c rather than sprinkling
"/selinux" around multiple places.   Wouldn't hurt to #define SELINUXFS
"selinuxfs" as well and replacing all occurrences in init.c and
load_policy.c.

As check_mountpoint() sets selinux_mnt, I'd pick a more descriptive
name.  Actually, could you perhaps fold the logic into set_selinuxmnt()?
That would mean the validation would happen when set_selinuxmnt() gets
called by load_policy, which isn't strictly necessary but does no harm.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
