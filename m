Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71BqtrT006563
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 07:52:56 -0400 (EDT)
Received: from smtp811.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i71Bqs0x019966
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 11:52:54 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp811.mail.ukl.yahoo.com with SMTP; 1 Aug 2004 11:52:54 -0000
Date: Sun, 1 Aug 2004 13:03:57 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: temporary hack to use udev in selinux
Message-ID: <20040801120357.GG7384@lkcl.net>
References: <Xine.LNX.4.44.0407291305360.16390-100000@dhcp83-76.boston.redhat.com> <200407311143.19746.russell@coker.com.au> <20040731163515.GR3378@lkcl.net> <200408012031.37581.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408012031.37581.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Aug 01, 2004 at 08:31:37PM +1000, Russell Coker wrote:
> On Sun, 1 Aug 2004 02:35, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > On Sat, Jul 31, 2004 at 11:43:19AM +1000, Russell Coker wrote:
> > > On Fri, 30 Jul 2004 06:09, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > > > The patch allows for getxattr/setxattr, but still doesn't address the
> > > > issue of SELinux treating different instances of tmpfs in different
> > > > ways.  That why we need mount option support.  It may be sufficient to
> > > > just extend fscontext= semantics (set superblock security context)
> > > > beyond xattr-supporting filesystems, so that we can assign a different
> > > > superblock security context to each instance and then set up type
> > > > transition rules appropriately, using fs_use_trans in all cases for the
> > > > initial labeling.
> > >
> > > This shouldn't even need kernel code.  As long as the default type is not
> > > overly permissive the mount program can relabel the root directory of a
> > > tmpfs file system after mounting it.
> >
> >  stephen i believe is concerned that tmpfs_t, because it is used for
> >  two different purposes, is used for filesystems both shmfs and tmpfs,
> >  and, prior to this patch, nobody cared because they never used one
> >  of those [tmpfs].
> 
> Yes.  So we need to have different mounts of the shmfs get different types.
> 
> >  what _you_ are saying, russell, is that instead of increasing the
> >  permissions on the usage of tmpfs_t, is to mount a tmpfs mountpoint,
> >  then run setfiles on its contents prior to use, such that it will
> >  never be necessary to increase the permissions of tmpfs_t?
> 
> Yes.  In fact using tmp_t as the label on the root directory of /dev/shm so 
> that file/directory creation gets the same labels as it does under /tmp, 
> while we leave tmpfs_t with restrictive access.
 
 eek.

 okay... *scared*.

 why, because i need this _today_ :)

 i need usb-mount, therefore i need udev, therefore i need this
 patch, therefore i need to do this now.

 okay.  so i just.. okayokay.

 i can just change, in /etc/selinux/src/fs_use, the line
 that says something like fs_trans shm .... tmpfs_t to
 say tmp_t?

 well, hey, i can always try it.

 i have had to add _stacks_ of permissions to tmpfs_t to get udev,
 initrc_t, hotplug_t and fsadm_t _and_ then some to get this to work
 (on to about the 10th reboot so far!).

 presumably i can just ":%s/tmpfs_t/tmp_t/g" with vi and, well other
 than some duplicates, expect it to... work?

 all very non-scientific and i DON'T CARE! :)

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
