Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6VDJ3rT002880
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 09:19:03 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6VDIxlX005735
	for <selinux@tycho.nsa.gov>; Sat, 31 Jul 2004 13:19:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: temporary hack to use udev in selinux
Date: Sat, 31 Jul 2004 11:43:19 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <Xine.LNX.4.44.0407291305360.16390-100000@dhcp83-76.boston.redhat.com> <20040729200502.GF9950@lkcl.net> <1091131752.21971.191.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1091131752.21971.191.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407311143.19746.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 30 Jul 2004 06:09, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Thu, 2004-07-29 at 16:05, Luke Kenneth Casson Leighton wrote:
> > On Thu, Jul 29, 2004 at 01:22:56PM -0400, Stephen Smalley wrote:
> > > For
> > > tmpfs, we want to allow individual inode labeling and
> > > getxattr/setxattr/setfscreatecon,
> >
> >  patch done that.  for dirs, files, symlinks and "special" inodes,
> > whatever _they_ are.
>
> The patch allows for getxattr/setxattr, but still doesn't address the
> issue of SELinux treating different instances of tmpfs in different
> ways.  That why we need mount option support.  It may be sufficient to
> just extend fscontext= semantics (set superblock security context)
> beyond xattr-supporting filesystems, so that we can assign a different
> superblock security context to each instance and then set up type
> transition rules appropriately, using fs_use_trans in all cases for the
> initial labeling.

This shouldn't even need kernel code.  As long as the default type is not 
overly permissive the mount program can relabel the root directory of a tmpfs 
file system after mounting it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
