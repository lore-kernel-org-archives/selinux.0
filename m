Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA14704
	for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2003 11:05:28 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA20703
	for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2003 16:02:41 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id QAA20699
	for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2003 16:02:40 GMT
Received: from moss-shockers.ncsc.mil (moss-shockers [144.51.25.21])
	by epoch.ncsc.mil (8.9.3/8.9.3) with SMTP id LAA07374
	for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2003 11:05:25 -0500 (EST)
Message-Id: <200301161612.LAA18313@moss-shockers.ncsc.mil>
Date: Thu, 16 Jan 2003 11:12:55 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Updated Release
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


The updated release (2003011510) has been imported and merged into
the sourceforge selinux CVS tree under the 'nsa' module.  As usual,
you can check out a copy via:

cvs -d:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux \
-z3 co nsa

> The SELinux web site <http://www.nsa.gov/selinux/> including the mail
> list archive has been updated. The site includes a new release of the
> LSM-based SELinux prototype. The base 2.5 kernel version has been
> updated to 2.5.58.  The base 2.4 kernel version remains at 2.4.20, but
> the LSM patch and the SELinux module for 2.4 have changed since the last
> release.  New contributed policy analysis and policy management tools
> have been added to the provided tools and utilities. Hooks for xattr
> operations were added to 2.4.  Inode security initialization has been
> reworked using the d_instantiate hook.  The nfsd private file bug in 2.4
> has been fixed and the task_kill bug in 2.5 has been fixed.  Configuring
> the SELinux Policy, a technical report included in the documentation,
> has been updated to reflect recent changes.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
