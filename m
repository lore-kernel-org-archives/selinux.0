Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8I7oerT007918
	for <selinux@tycho.nsa.gov>; Sat, 18 Sep 2004 03:50:40 -0400 (EDT)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8I7nh1H028036
	for <selinux@tycho.nsa.gov>; Sat, 18 Sep 2004 07:49:43 GMT
Subject: Re: Strange Associate bug
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1095451597.17932.332.camel@moss-spartans.epoch.ncsc.mil>
References: <414B4091.5030500@redhat.com>
	 <1095451597.17932.332.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Sat, 18 Sep 2004 03:51:47 -0400
Message-Id: <1095493907.4655.4.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-09-17 at 16:06 -0400, Stephen Smalley wrote:

> Options are:
> 1) Change the kernel code to ignore the fscreate context when the
> filesystem uses genfs_contexts, similar to the existing mount context=
> handling, or
> 2) Change mv to reset the fscreate context to NULL and retry if the file
> creation fails with EACCES, thereby falling back to the default labeling
> behavior,

What about:

2a) Change the kernel to return EOPNOTSUPP if fscreate context is non-
NULL for a genfs filesystem, and change mv to retry with NULL if the
operation fails with EOPNOTSUPP, but also print a warning.

> 3) Allow the association, as above.
> 
> Allowing the association is a bit misleading, because the file is going
> to revert to the base type ultimately, even if the incore inode happens
> to be temporarily labeled with the fscreate context.

Yeah, that sounds bad.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
