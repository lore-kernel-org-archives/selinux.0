Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i72CZwrT011552
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 08:35:59 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i72CZQXV015644
	for <selinux@tycho.nsa.gov>; Mon, 2 Aug 2004 12:35:26 GMT
Subject: Re: temporary hack to use udev in selinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200407311143.19746.russell@coker.com.au>
References: 
	 <Xine.LNX.4.44.0407291305360.16390-100000@dhcp83-76.boston.redhat.com>
	 <20040729200502.GF9950@lkcl.net>
	 <1091131752.21971.191.camel@moss-spartans.epoch.ncsc.mil>
	 <200407311143.19746.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1091450087.23449.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 02 Aug 2004 08:35:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-07-30 at 21:43, Russell Coker wrote:
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

I'd like to be able to assign different security contexts to different
tmpfs superblocks, not just the root directory.  That requires a minor
change to the existing fscontext= mount option to allow applying it to
filesystems that use labeling behaviors other than xattr.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
