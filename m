Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA01676
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 09:49:46 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBGEnkI29531
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 14:49:46 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id gBGEnjf29525 for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2002 14:49:45 GMT
Message-Id: <200212161457.JAA00518@moss-shockers.ncsc.mil>
Date: Mon, 16 Dec 2002 09:57:01 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Updated Release
To: selinux@tycho.nsa.gov, hdholm@epoch.ncsc.mil
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


The updated release (2002121210) has been imported and merged into
the sourceforge selinux CVS tree under the 'nsa' module.  As usual,
you can check out a copy via:

cvs -d:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux \
-z3 co nsa

On Fri, 12 Dec 2002, Howard Holm wrote:

> The SELinux web site <http://www.nsa.gov/selinux/> including the mail
> list archive has been updated. The site includes a new release of the
> LSM-based SELinux prototype. The base kernel versions have been updated
> to 2.4.20 and 2.5.51.  Initial SID and context for SCMP packets has been
> added.  Additional policy enhancement and patch contributions have been
> merged. The logrotate patch has been updated to 3.6.5-2. The private
> file oversight in LSM, inode_doinit bug in SELinux, and selopt compile
> problems have all been fixed.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
