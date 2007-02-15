Subject: Re: SELinux and LFS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: vin@netwosix.org
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <1171571029.4569.18.camel@desk.netwosix.org>
References: <1171474739.27788.17.camel@desk.netwosix.org>
	 <1171566731.32574.55.camel@moss-spartans.epoch.ncsc.mil>
	 <1171567396.3579.4.camel@desk.netwosix.org>
	 <1171567885.32574.72.camel@moss-spartans.epoch.ncsc.mil>
	 <1171569528.4569.9.camel@desk.netwosix.org>
	 <1171569824.32574.91.camel@moss-spartans.epoch.ncsc.mil>
	 <1171571029.4569.18.camel@desk.netwosix.org>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 15:34:52 -0500
Message-Id: <1171571692.32574.119.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-15 at 21:23 +0100, Vincenzo Ciaglia wrote:
> Il giorno gio, 15/02/2007 alle 15.03 -0500, Stephen Smalley ha scritto:
> 
> > You actually wanted to grep for "SELinux" (capitalization) or grep -i,
> > but that's ok.  Although I thought Eric was going to kill or at least
> > silence by default many of those messages.
> 
> Here we are:
> 
> # dmesg | grep -i selinux
> SELinux:  Initializing.
> SELinux:  Starting in permissive mode
> selinux_register_security:  Registering secondary module capability
> SELinux:  Completing initialization.
> SELinux:  Setting up existing superblocks.
> SELinux: initialized (dev hda1, type ext3), uses xattr
> SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
> SELinux: initialized (dev selinuxfs, type selinuxfs), uses
> genfs_contexts
> SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
> SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses
> genfs_contexts
> SELinux: initialized (dev devpts, type devpts), uses transition SIDs
> SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
> SELinux: initialized (dev inotifyfs, type inotifyfs), uses
> genfs_contexts
> SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
> SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
> SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
> SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
> SELinux: initialized (dev proc, type proc), uses genfs_contexts
> SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
> SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
> SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
> SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
> SELinux: initialized (dev hdb1, type ext3), uses xattr
> 
> > Good.  Of course, since it is permissive, it isn't enforcing anything
> > yet, just logging what would be denied.  Did you label your filesystems
> > yet?
> 
> Yes:
> 
> # cd /etc/selinux/refpolicy/src/policy/
> # make relabel
> Relabeling filesystem types: ext2 ext3 xfs jfs
> /sbin/setfiles /etc/selinux/netwosix/contexts/files/file_contexts / /usr
> /sbin/setfiles:  labeling files under /
> matchpathcon_filespec_eval:  hash table stats: 2571 elements, 2559/65536
> buckets used, longest chain length 2
> /sbin/setfiles:  labeling files under /usr
> matchpathcon_filespec_eval:  hash table stats: 81537 elements,
> 20107/65536 buckets used, longest chain length 10
> /sbin/setfiles:  Done.
> #
> 
> So i rebooted and when i try to "sysadm_r" i get this:
> # newrole -r sysadm_r
> Couldn't get default type.
> # 

Targeted policy doesn't support user roles; it only confines specific
programs, primarily focused on system services.  Strict policy is what
you want if you need user roles.  In the future, we hope to reduce the
divergence between them so that you can have a targeted system with some
limited user roles.

> But i still haven't read anything about this. Now i'm too happy that
> selinux is enabled and it's working ... after many weeks of patch+patch
> +hack+hack on the new netwosix system :)
> 
> Thank you,
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
