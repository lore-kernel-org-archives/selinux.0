Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA14961
	for <selinux@tycho.nsa.gov>; Wed, 4 Dec 2002 09:23:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA18587
	for <selinux@tycho.nsa.gov>; Wed, 4 Dec 2002 14:21:37 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id OAA18583
	for <selinux@tycho.nsa.gov>; Wed, 4 Dec 2002 14:21:37 GMT
Message-Id: <200212041431.JAA26974@moss-shockers.ncsc.mil>
Date: Wed, 4 Dec 2002 09:31:16 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Kernel Oops from afsd under the selinux kernel
To: fw@fwsystems.com
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Thanks!
> 
> removing the #ifndef _SELINUX_KERNEL_PATCH_ -- #endif ca line 650++ indeed 
> solves it -- is this adding significant overhead? .. should I patch afsd
> to call alloc_inode() so the test isn't being added to all calls?

No, it doesn't add significant overhead and can be merged into our tree.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
