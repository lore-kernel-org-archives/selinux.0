Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6VGOCrT003410
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 12:24:12 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i6VGNeHs007117
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 16:23:40 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 31 Jul 2004 16:24:11 -0000
Date: Sat, 31 Jul 2004 17:35:15 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: temporary hack to use udev in selinux
Message-ID: <20040731163515.GR3378@lkcl.net>
References: <Xine.LNX.4.44.0407291305360.16390-100000@dhcp83-76.boston.redhat.com> <20040729200502.GF9950@lkcl.net> <1091131752.21971.191.camel@moss-spartans.epoch.ncsc.mil> <200407311143.19746.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200407311143.19746.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jul 31, 2004 at 11:43:19AM +1000, Russell Coker wrote:

> On Fri, 30 Jul 2004 06:09, Stephen Smalley <sds@epoch.ncsc.mil> wrote:

> > The patch allows for getxattr/setxattr, but still doesn't address the
> > issue of SELinux treating different instances of tmpfs in different
> > ways.  That why we need mount option support.  It may be sufficient to
> > just extend fscontext= semantics (set superblock security context)
> > beyond xattr-supporting filesystems, so that we can assign a different
> > superblock security context to each instance and then set up type
> > transition rules appropriately, using fs_use_trans in all cases for the
> > initial labeling.
> 
> This shouldn't even need kernel code.  As long as the default type is not 
> overly permissive the mount program can relabel the root directory of a tmpfs 
> file system after mounting it.

 i feel a disconnect in my understanding coming on.

 just to clarify what i believe stephen is saying:

 stephen i believe is concerned that tmpfs_t, because it is used for
 two different purposes, is used for filesystems both shmfs and tmpfs,
 and, prior to this patch, nobody cared because they never used one
 of those [tmpfs].

 so, one was useless, and so permissions have been restricted on
 tmpfs_t and the use of tmpfs_t.

 now, suddenly, tmpfs_t gets automatically assigned to something which
 is useful, and people might be tempted to increase the permissions
 of tmpfs_t, incidentally adding extra permissions where shmfs is used
 (and rightly restricted).

 what _you_ are saying, russell, is that instead of increasing the
 permissions on the usage of tmpfs_t, is to mount a tmpfs mountpoint,
 then run setfiles on its contents prior to use, such that it will
 never be necessary to increase the permissions of tmpfs_t?

 because tmpfs_t is going to be temporary, you _have_ to do a setfiles
 (or a restorecon on each individual file) _anyway_.

 yes?

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
