Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0FHjj1x010819
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 12:46:42 -0500
Received: from tarius.tycho.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0FHOY3b001234
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 17:24:34 GMT
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0FHNcB0009247
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 12:23:38 -0500
Received: from tarius.tycho.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0FHOR3b001187
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 17:24:27 GMT
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0FHNKdm009083
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 12:23:20 -0500
Received: from tarius.tycho.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0FHO6dE003410
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 17:24:06 GMT
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0FHN1Lo008858
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 12:23:01 -0500
Received: from tarius.tycho.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0FHNmdE003241
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 17:23:48 GMT
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0FHKNQG007281
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 12:22:40 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0FGiPdE026038
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 16:44:25 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l0FGiOc1004704
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 11:44:24 -0500
Message-ID: <45ABAF3A.7030905@redhat.com>
Date: Mon, 15 Jan 2007 11:43:38 -0500
From: Karl MacMillan <kmacmill@redhat.com>
MIME-Version: 1.0
To: "Tom 'spot' Callaway" <tcallawa@redhat.com>
CC: fedora-selinux-list@redhat.com, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: sparc64 kernel won't boot with selinux enabled
References: <1168811532.31988.42.camel@localhost.localdomain>
In-Reply-To: <1168811532.31988.42.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Tom 'spot' Callaway wrote:
> I'm working on Aurora, which is a rebuild of Fedora Core for SPARC.
> Lately, I've been testing with selinux enabled on the targeted policy,
> but I haven't gotten very far. When I try to boot on a sparc64, I get
> the following (copied by hand, apologies for any typos, I tried to be
> accurate):
> 

[CC'ing selinux list]

> EXT3-fs: mounted filesystem with ordered data mode.
> audit(1168807648.026:2): enforcing=1 old_enforcing=0 auid=4294967295
> security:  3 users, 6 roles, 1584 types, 172 bools, 1 sens, 1024 cats
> security:  59 classes, 49650 rules
> security:  class dccp_socket not defined in policy
> security:  permission dccp_recv in class node not defined in policy
> security:  permission dccp_send in class node not defined in policy
> security:  permission dccp_recv in class netif not defined in policy
> security:  permission dccp_send in class netif not defined in policy

Seems that there is a mismatch between your policy and the kernel.

> SELinux:  Completing initialization
> SELinux:  Setting up existing superblocks.
> SELinux: initialized (dev dm-0, type ext3), uses xattr
> SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
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
> audit(1168807652.930:3): policy loaded auid=4294967295
> audit(1168807653.174:4): avc:  denied  { execmem } for  pid=1
> comm="init" scontext=system_u:system_r:kernel_t:s0
> tcontext=system_u:system_r:kernel_t:s0 tclass=process
> 
> ...And there it sits, as init is denied. :)
> 

Init requiring execmem is surprising to say the least - it certainly 
doesn't on i386. Are you seeing a lot of execmem denials in the logs? I 
don't really know what is going on, but there is likely a kernel or 
compiler / toolchain issue causing overly broad execmem requests.

As a work around you can do (after booting into permissive):

setsebool -P allow_execmem=1

The next reboot will allow this globally and you may get farther in 
permissive. You can also change this default in the policy packages.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
