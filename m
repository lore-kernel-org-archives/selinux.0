Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h74GXQHa017677
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2003 12:33:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h74GWCFB026551
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2003 16:32:12 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h74GWBGD026548
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2003 16:32:11 GMT
Subject: Re: SELinux-2.6-PPC
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1060011891.2997.156.camel@chris.pebenito.net>
References: <1059955240.2997.75.camel@chris.pebenito.net>
	 <1060003910.4298.47.camel@moss-spartans.epoch.ncsc.mil>
	 <1060011891.2997.156.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1060014803.4298.93.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 04 Aug 2003 12:33:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-08-04 at 11:44, Chris PeBenito wrote:
> What exactly do you mean by a reduction of genfs_contexts support?  I
> didn't see any mention of this in the docs (perhaps I missed it), but I
> did notice that genfs_contexts is a lot slimmer than the old policy.  I
> do have devfs in mind, as its used in Gentoo.  

See the comments at the beginning of the genfs_contexts file in the 2.5
policy tree.  Also mentioned in the policy part of the PORTING file in
selinux-doc.  The code that attempted to reconstruct a pathname relative
to the top of the mount for auditing and for genfs_contexts had to be
dropped as part of the cleanup for mainline inclusion; you can't
reliably map an inode to a pathname in general.  For proc, we can use
the proc_dir_entry tree to generate paths within proc to identify nodes
in the policy in order to map them to security contexts.  Something
similar might be possible in devfs, but you also likely need an xattr
handler for it to support userspace management of security contexts on
device nodes.  You might want to look into udev as a replacement for
devfs for 2.6.

> As for reiser I would
> think that for it to work it would just need the appropriate xattr
> support in the kernel (and fix the policy makefile to run setfiles on it
> during a relabel).

Yes, you would need to implement an xattr handler for the security
namespace in reiser.  You can likely leverage the existing reiser xattr
patches, but you'll still need to add the handler for the security
namespace.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
