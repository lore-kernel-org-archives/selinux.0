Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA15734
	for <selinux@tycho.nsa.gov>; Thu, 23 Jan 2003 11:28:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA08091
	for <selinux@tycho.nsa.gov>; Thu, 23 Jan 2003 16:25:53 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id QAA08084
	for <selinux@tycho.nsa.gov>; Thu, 23 Jan 2003 16:25:52 GMT
Message-Id: <200301231636.LAA03814@moss-shockers.ncsc.mil>
Date: Thu, 23 Jan 2003 11:36:13 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: process share permission
To: selinux@tycho.nsa.gov, mayerf@tresys.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Is there a short answer of what process "share" permission controls?
> Nothing obvious in any reports.  Thanks Frank 

It is mentioned in the module technical report.  It is checked when a
process SID would change (due to an execve or execve_secure) and the
process shares state with its parent due to the prior use of clone(2)
to create the process.  See the man page for clone for detailed
information about what can be shared.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
