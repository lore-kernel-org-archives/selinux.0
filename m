Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h41CCCI4009444
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 08:12:12 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h41CC1Vf008262
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 12:12:01 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h41CC14D008259
	for <selinux@tycho.nsa.gov>; Thu, 1 May 2003 12:12:01 GMT
Subject: Re: Kernel Patch 2.4.20
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Brian May <bam@snoopy.apana.org.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20030501024028.GC13019@snoopy.apana.org.au>
References: <20030501024028.GC13019@snoopy.apana.org.au>
Content-Type: text/plain
Message-Id: <1051791114.1377.36.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 01 May 2003 08:11:55 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-04-30 at 22:40, Brian May wrote:
> >From Russell's kernel patch, version 2003.04.07-1.
> 
> -int init_private_file(struct file *filp, struct dentry *dentry, int mode)
> +int open_private_file(struct file *filp, struct dentry *dentry, int flags)
> 
> Is there any good reason for renaming this function?
> 
> Is the new function backword compatable with the old version?
> 
> This change breaks the UML HPPFS filesystem (whatever that is...) which
> has a number of calls to init_private_file.

When the LSM changes to init_private_file (to allocate a security
structure for the file, and add a corresponding routine for releasing
private files that also frees the security structure) were submitted for
merging into mainline 2.5, we were asked by the kernel developers to:
1) Rename the init_private_file function to force people to update any
callers to also call the function for releasing it (close_private_file).
Otherwise, a memory leak will occur since the security structure won't
be freed.
2) Change the interface to take a flags argument rather than a mode so
that callers can set O_LARGEFILE properly.  The mode is now computed
from the flags, as in dentry_open.

These changes were accepted into mainline 2.5 and then back ported to
the 2.4 LSM patch.  We updated all callers of init_private_file that are
in the mainline kernel, but naturally out-of-tree patches or modules
will need to be updated.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
