Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7PDZdLa023802
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 09:35:39 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7PDZcfF021116
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 13:35:38 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h7PDZcHd021113 for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 13:35:38 GMT
Subject: Re: 2.6.0-test4 is released
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200308231644.20214.russell@coker.com.au>
References: <200308231644.20214.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1061818529.28086.407.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 25 Aug 2003 09:35:29 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2003-08-23 at 02:44, Russell Coker wrote:
> All the patches from 2.6.0-test3-selinux1.patch.gz apart from the patch for 
> security/selinux/selinuxfs.c have been included in test4.  Steve, was the 
> selinuxfs.c made obsolete by other patches or was it an omission?

The patch to selinuxfs.c was obsoleted by the reworking of the inode
security initialization code.  It is no longer necessary to keep a
private kernel mount of selinuxfs, although there is no harm in doing
so.

2.6.0-test4 doesn't require any of the diffs currently on the NSA site,
although new patches for other issues have already been sent our way.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
