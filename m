Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h2OG8Mx6003400
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 11:08:22 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h2OG4plY028676
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 16:04:51 GMT
Received: from facesaver.epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h2OG4oKX028673
	for <selinux@tycho.nsa.gov>; Mon, 24 Mar 2003 16:04:50 GMT
Message-Id: <200303241615.LAA20568@moss-shockers.ncsc.mil>
Date: Mon, 24 Mar 2003 11:15:55 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: Important fix for init.te
To: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> This is probably not the best solution however, the kernel thread probably 
> should not run as init_t.  But until I work out how to fix this giving UDP 
> access to init_t is necessary.

The kernel thread calls reparent_to_init, so it is then assigned the
SID of init.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
