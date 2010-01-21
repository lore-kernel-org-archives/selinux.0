Subject: Re: Policy is not managed or store cannot be accessed
From: Stephen Smalley <sds@tycho.nsa.gov>
To: AlannY <m@alanny.ru>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20100121122816.GB13907@alanny-pc.lcl.starlink.ru>
References: <20100120202135.GA6124@alanny-pc.lcl.starlink.ru>
	 <1264020386.24133.182.camel@moss-pluto.epoch.ncsc.mil>
	 <20100121122816.GB13907@alanny-pc.lcl.starlink.ru>
Content-Type: text/plain
Date: Thu, 21 Jan 2010 08:29:07 -0500
Message-Id: <1264080547.11002.28.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-01-21 at 15:28 +0300, AlannY wrote:
> On Wed, Jan 20, 2010 at 03:46:26PM -0500, Stephen Smalley wrote:
> > Hmmm...did you label your filesystems?
> > What does sestatus -v show?
> 
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   permissive
> Mode from config file:          permissive
> Policy version:                 24
> Policy from config file:        refpolicy
> 
> Process contexts:
> Current context:                root:staff_r:insmod_t
> Init context:                   system_u:system_r:kernel_t

So /sbin/init never transitioned from kernel_t to init_t and thus none
of your processes are in the right security context.

In order for this to happen, one of two things is required:
1) Your /sbin/init program needs the selinux patch to load policy and
then re-exec itself into the right security context, or
2) Your initramfs init script needs to load policy (e.g. chroot
$NEWROOT /usr/sbin/load_policy -i) before running the real init program.

#1 was the original approach in Fedora; #2 is the current approach in
Fedora and Ubuntu.

> /sbin/agetty                    system_u:system_r:kernel_t
> 
> File contexts:
> Controlling term:               system_u:object_r:ramfs_t

This is interesting - why is your tty on a ramfs image?

> /etc/passwd                     system_u:object_r:etc_t
> /etc/shadow                     system_u:object_r:shadow_t
> /bin/bash                       system_u:object_r:shell_exec_t
> /bin/login                      system_u:object_r:login_exec_t
> /bin/sh                         system_u:object_r:bin_t -> system_u:object_r:shell_exec_t
> /sbin/agetty                    system_u:object_r:getty_exec_t
> /sbin/init                      system_u:object_r:init_exec_t
> /lib/libc.so.6                  system_u:object_r:lib_t -> system_u:object_r:lib_t
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
