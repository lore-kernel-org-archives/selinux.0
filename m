Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tarius.tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h33Lmrx6002896
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 16:48:53 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h33LjFOv019728
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 21:45:15 GMT
Received: from facesaver.epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h33LjFY1019725
	for <selinux@tycho.nsa.gov>; Thu, 3 Apr 2003 21:45:15 GMT
Message-Id: <200304032156.QAA14817@moss-shockers.ncsc.mil>
Date: Thu, 3 Apr 2003 16:56:26 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: latest policy patches
To: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Following the latest kernel change which results in kernel threads running as 
> kernel_t instead of init_t more policy changes are required.
> 
> I have attached a patch that makes the necessary changes for kernel_t, for the 
> modutils programs, and some minor changes for file_contexts as well.

Thanks, I've merged some of these changes into our internal tree for
the next release, but not all.  For kernel_t execute access, I'd
actually like to transition into a different domain to shed privileges
(including the existing rule for /bin/true) rather than using can_exec
to authorize direct execution.  I placed the can_network rule in rpcd.te
as you had previously proposed rather than kernel.te.  

--
Stephen Smalley, NSA



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
