Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i19F9iRb004121
	for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2004 10:09:44 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i19F9hOi022970
	for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2004 15:09:43 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i19F9gWW022967 for <selinux@tycho.nsa.gov>; Mon, 9 Feb 2004 15:09:42 GMT
Subject: Re: XFS security namespace
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1076088280.5286.10.camel@chris.pebenito.net>
References: <1076088280.5286.10.camel@chris.pebenito.net>
Content-Type: text/plain
Message-Id: <1076339377.3523.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 09 Feb 2004 10:09:37 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-02-06 at 12:24, Chris PeBenito wrote:
> All that needs to be changed in the policy is to add a fs_use_xattr
> entry for XFS, and then adjust the Makefile relabel target to relabel
> XFS filesystems.  I have attached a patch against the NSA policy in
> sourceforge CVS to do this.  (note the extra space in the 'make relabel'
> awk command is intentional, otherwise it matches selinuxfs too)

Thanks, this is good news.  I've merged this patch into our tree.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
