Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA11516
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 16:45:34 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA10113
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 21:43:17 GMT
Received: from mozart.fwsystems.com (mozart.fwsystems.com [63.101.67.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA10107
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 21:43:16 GMT
Date: Tue, 3 Dec 2002 16:45:30 -0500
From: forrest whitcher <fw@fwsystems.com>
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
Subject: Re: Kernel Oops from afsd under the selinux kernel
Message-Id: <20021203164530.48a2f1dd.fw@fwsystems.com>
In-Reply-To: <200212032008.PAA26482@moss-shockers.ncsc.mil>
References: <200212032008.PAA26482@moss-shockers.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks!

removing the #ifndef _SELINUX_KERNEL_PATCH_ -- #endif ca line 650++ indeed 
solves it -- is this adding significant overhead? .. should I patch afsd
to call alloc_inode() so the test isn't being added to all calls?

forrest


On Tue, 3 Dec 2002 15:08:28 -0500 (EST) (unchecked - local sync NTPstrat4)
"Stephen D. Smalley" <sds@epoch.ncsc.mil> did inscribe thusly:

> 
> > I'm getting the following Oops running on a redhat 7.1 system with the
> > LSM/selinux patches. kernel 2.4.19. The system runs well in enforcing
> > mode (however this test is in non-enforcing mode because I can't really 
> > do the policy changes until I have a working afsd.
> 
> You might try the attached patch to see if it helps.  The AFS code might
> bypass alloc_inode() when allocating inodes, in which case the inode
> would not have an allocated security structure upon entry to inode_doinit.
> 
> --
> Stephen Smalley, NSA
> sds@epoch.ncsc.mil
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
