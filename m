Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71AVirT006298
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 06:31:44 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i71AV952019672
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 10:31:10 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: temporary hack to use udev in selinux
Date: Sun, 1 Aug 2004 20:31:37 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <Xine.LNX.4.44.0407291305360.16390-100000@dhcp83-76.boston.redhat.com> <200407311143.19746.russell@coker.com.au> <20040731163515.GR3378@lkcl.net>
In-Reply-To: <20040731163515.GR3378@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408012031.37581.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 1 Aug 2004 02:35, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> On Sat, Jul 31, 2004 at 11:43:19AM +1000, Russell Coker wrote:
> > On Fri, 30 Jul 2004 06:09, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> > > The patch allows for getxattr/setxattr, but still doesn't address the
> > > issue of SELinux treating different instances of tmpfs in different
> > > ways.  That why we need mount option support.  It may be sufficient to
> > > just extend fscontext= semantics (set superblock security context)
> > > beyond xattr-supporting filesystems, so that we can assign a different
> > > superblock security context to each instance and then set up type
> > > transition rules appropriately, using fs_use_trans in all cases for the
> > > initial labeling.
> >
> > This shouldn't even need kernel code.  As long as the default type is not
> > overly permissive the mount program can relabel the root directory of a
> > tmpfs file system after mounting it.
>
>  stephen i believe is concerned that tmpfs_t, because it is used for
>  two different purposes, is used for filesystems both shmfs and tmpfs,
>  and, prior to this patch, nobody cared because they never used one
>  of those [tmpfs].

Yes.  So we need to have different mounts of the shmfs get different types.

>  what _you_ are saying, russell, is that instead of increasing the
>  permissions on the usage of tmpfs_t, is to mount a tmpfs mountpoint,
>  then run setfiles on its contents prior to use, such that it will
>  never be necessary to increase the permissions of tmpfs_t?

Yes.  In fact using tmp_t as the label on the root directory of /dev/shm so 
that file/directory creation gets the same labels as it does under /tmp, 
while we leave tmpfs_t with restrictive access.

>  because tmpfs_t is going to be temporary, you _have_ to do a setfiles
>  (or a restorecon on each individual file) _anyway_.

If /dev/shm is mounted before the system goes to multi-user mode then there 
will be no files under it and no need for labelling other than the root 
directory.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
