Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA08221
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 18:12:44 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA06200
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 23:12:38 GMT
Received: from saturn.cs.uml.edu (saturn.cs.uml.edu [129.63.8.2])
	by jazzband.ncsc.mil  with ESMTP id XAA06196
	for <selinux@tycho.nsa.gov>; Thu, 29 Mar 2001 23:12:38 GMT
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103292312.f2TNCRC368500@saturn.cs.uml.edu>
Subject: Re: A New Virus
To: JBrindle@snu.edu (Joshua Brindle)
Date: Thu, 29 Mar 2001 18:12:27 -0500 (EST)
Cc: william.r.kutz@lmco.com, selinux@tycho.nsa.gov
In-Reply-To: <sac2fc61.090@my.snu.edu> from "Joshua Brindle" at Mar 29, 2001 09:11:46 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> It seems to me that for this virus to be able to infect linux
> executables from within windows you must have a umsdos partition.
...
> I wouldn't really call it much of a linux virus since the only
> way it circumvents filesystem permissions and access controls
> is to run from within windows. 

Why does everybody keep forgetting the network?

You can get an NFS client and server for Windows. You can get
an SMB client and server for Linux. There, all home directories
infected. If root runs anything off NFS, well, Linux is toast.

Don't bother me with a discussion about why NFS is evil.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
