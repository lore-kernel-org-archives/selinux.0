Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5JCX5I4002112
	for <selinux@tycho.nsa.gov>; Thu, 19 Jun 2003 08:33:05 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5JCX45e000430
	for <selinux@tycho.nsa.gov>; Thu, 19 Jun 2003 12:33:04 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h5JCX392000427 for <selinux@tycho.nsa.gov>; Thu, 19 Jun 2003 12:33:03 GMT
Subject: Re: how usable is selinux in lsm-2.5?
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andreas Schuldei <andreas@schuldei.org>,
   Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20030618212607.GB5278@schuldei.org>
References: <20030618212607.GB5278@schuldei.org>
Content-Type: text/plain
Message-Id: <1056025963.1071.27.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 19 Jun 2003 08:32:44 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-06-18 at 17:27, Andreas Schuldei wrote:
> I notice with satisfaction that lsm-2.5 with selinux configured
> in compiles fine here.

Are you referring to the lsm-2.5 BitKeeper tree from either
lsm.bkbits.net or lsm.immunix.org?  I did replace the SELinux module in
that tree with the new 2.5 SELinux, although the LSM patch in that tree
still includes various hooks that are not in mainline.  You might want
to wait until we make an updated public release of the mainline
2.5-based SELinux and use it.

> what is missing from it to be usable? Or which parts are there
> and what can one do with them?

It doesn't include the networking access controls, since those controls
need to be reimplemented using only features provided by the mainline
kernel (vs. the rejected networking fields and hooks).  It also is more
limited in its support for filesystems due to the transition to xattr
and the elimination of unsafe inode-to-path translation; if you want to
use something other than ext[23] on disk or if you want to use devfs,
you'll need to implement an xattr handler in the filesystem or some
technique for labeling it in the SELinux module.

> will the 2.4 userspace which russel and brian ship in debian
> packages work on this kernel? I understand that the proc
> interface changed. are there patches for userspace allready?

No, the SELinux API has been massively overhauled.  You can fetch
snapshots of the new userland components from
http://www.nsa.gov/selinux/lk, but it might be easier for you to wait
for an updated public release on the main download page.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
