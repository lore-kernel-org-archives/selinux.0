Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TK9qrT022170
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 16:09:52 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6TK9LbB016955
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 20:09:21 GMT
Subject: Re: temporary hack to use udev in selinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: James Morris <jmorris@redhat.com>, Joshua Brindle <method@gentoo.org>,
   SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040729200502.GF9950@lkcl.net>
References: 
	 <Xine.LNX.4.44.0407291305360.16390-100000@dhcp83-76.boston.redhat.com>
	 <1091121776.21971.132.camel@moss-spartans.epoch.ncsc.mil>
	 <20040729200502.GF9950@lkcl.net>
Content-Type: text/plain
Message-Id: <1091131752.21971.191.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 29 Jul 2004 16:09:12 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-07-29 at 16:05, Luke Kenneth Casson Leighton wrote:
> On Thu, Jul 29, 2004 at 01:22:56PM -0400, Stephen Smalley wrote:
> > For
> > tmpfs, we want to allow individual inode labeling and
> > getxattr/setxattr/setfscreatecon, 
> 
>  patch done that.  for dirs, files, symlinks and "special" inodes, whatever
>  _they_ are.

The patch allows for getxattr/setxattr, but still doesn't address the
issue of SELinux treating different instances of tmpfs in different
ways.  That why we need mount option support.  It may be sufficient to
just extend fscontext= semantics (set superblock security context)
beyond xattr-supporting filesystems, so that we can assign a different
superblock security context to each instance and then set up type
transition rules appropriately, using fs_use_trans in all cases for the
initial labeling.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
