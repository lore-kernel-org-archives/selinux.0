Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA05594
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 15:15:59 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBGKFwI22933
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 20:15:58 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id gBGKFqf22929 for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 20:15:57 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov
Subject: Re: new kernel patch
Date: Mon, 16 Dec 2002 21:15:26 +0100
References: <200212161827.NAA00650@moss-shockers.ncsc.mil>
In-Reply-To: <200212161827.NAA00650@moss-shockers.ncsc.mil>
MIME-Version: 1.0
Message-Id: <200212162115.26728.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 16 Dec 2002 19:27, Stephen D. Smalley wrote:
> When an inode is allocated, its SID is initialized to the unlabeled
> initial SID (=> system_u:object_r:unlabeled_t), and its security class
> is initialized to the file class by default.  This log message indicates
> that a devfs inode reached a permission check without first being
> initialized by inode_doinit, likely due to a race between
> selinux_inode_post_lookup and a cached lookup.  The empty permission
> set is due to an inability to map the requested permission (likely search)
> to a permission in the file class.
>
> As a short term fix, I'd suggest the attached patch.  A proper fix requires
> adjusting the inode_init call in d_instantiate and the SELinux hook
> function to properly handle filesystems that rely on genfs_contexts.

This works.  I'll add it to my kernel-patch package for Debian.

Also I've updated my kernel-patch-2.5-lsm package to include your latest 
patch.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
