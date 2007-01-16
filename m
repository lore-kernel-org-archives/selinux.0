Subject: Re: sparc64 kernel won't boot with selinux enabled
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmill@redhat.com>
Cc: "Tom 'spot' Callaway" <tcallawa@redhat.com>,
        fedora-selinux-list@redhat.com,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <45ABAF3A.7030905@redhat.com>
References: <1168811532.31988.42.camel@localhost.localdomain>
	 <45ABAF3A.7030905@redhat.com>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 07:22:46 -0500
Message-Id: <1168950166.22731.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-01-15 at 11:43 -0500, Karl MacMillan wrote:
> Tom 'spot' Callaway wrote:
> > I'm working on Aurora, which is a rebuild of Fedora Core for SPARC.
> > Lately, I've been testing with selinux enabled on the targeted policy,
> > but I haven't gotten very far. When I try to boot on a sparc64, I get
> > the following (copied by hand, apologies for any typos, I tried to be
> > accurate):
> > 
> 
> [CC'ing selinux list]
> 
> > EXT3-fs: mounted filesystem with ordered data mode.
> > audit(1168807648.026:2): enforcing=1 old_enforcing=0 auid=4294967295
> > security:  3 users, 6 roles, 1584 types, 172 bools, 1 sens, 1024 cats
> > security:  59 classes, 49650 rules
> > security:  class dccp_socket not defined in policy
> > security:  permission dccp_recv in class node not defined in policy
> > security:  permission dccp_send in class node not defined in policy
> > security:  permission dccp_recv in class netif not defined in policy
> > security:  permission dccp_send in class netif not defined in policy
> 
> Seems that there is a mismatch between your policy and the kernel.
> 
> > SELinux:  Completing initialization
> > SELinux:  Setting up existing superblocks.
> > SELinux: initialized (dev dm-0, type ext3), uses xattr
> > SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
> > SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
> > SELinux: initialized (dev selinuxfs, type selinuxfs), uses
> > genfs_contexts
> > SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
> > SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses
> > genfs_contexts
> > SELinux: initialized (dev devpts, type devpts), uses transition SIDs
> > SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
> > SELinux: initialized (dev inotifyfs, type inotifyfs), uses
> > genfs_contexts
> > SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
> > SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
> > SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
> > SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
> > SELinux: initialized (dev proc, type proc), uses genfs_contexts
> > SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
> > SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
> > SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
> > audit(1168807652.930:3): policy loaded auid=4294967295
> > audit(1168807653.174:4): avc:  denied  { execmem } for  pid=1
> > comm="init" scontext=system_u:system_r:kernel_t:s0
> > tcontext=system_u:system_r:kernel_t:s0 tclass=process
> > 
> > ...And there it sits, as init is denied. :)
> > 
> 
> Init requiring execmem is surprising to say the least - it certainly 
> doesn't on i386. Are you seeing a lot of execmem denials in the logs? I 
> don't really know what is going on, but there is likely a kernel or 
> compiler / toolchain issue causing overly broad execmem requests.

Compiler / toolchain problem; we've seen the same thing in the past on
ppc32 and ia64, e.g. see
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=178747
Those were ultimately resolved by toolchain changes and rebuilt
userland, but the temporary fix was to disable the exec* checks in the
kernel for those architectures.

> 
> As a work around you can do (after booting into permissive):
> 
> setsebool -P allow_execmem=1
> 
> The next reboot will allow this globally and you may get farther in 
> permissive. You can also change this default in the policy packages.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
