Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA00338
	for <selinux@tycho.nsa.gov>; Sun, 5 Jan 2003 14:59:54 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA22882
	for <selinux@tycho.nsa.gov>; Sun, 5 Jan 2003 19:57:14 GMT
Received: from pandora.snu.edu (pandora.snu.edu [204.126.2.1])
	by jazzswing.ncsc.mil  with SMTP id TAA22878
	for <selinux@tycho.nsa.gov>; Sun, 5 Jan 2003 19:57:13 GMT
Message-Id: <se183a46.027@atlas.snu.edu>
Date: Sun, 05 Jan 2003 13:59:08 -0600
From: "Joshua Brindle" <JBrindle@snu.edu>
To: <selinux@tycho.nsa.gov>
Subject: Trusted BSD is selinux compatible?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

anyone here used trustedbsd? 

--- From www.trustedbsd.org
Mandatory access control modules based on the framework supporting a
variety of access control models, including fixed and floating label
Biba integrity policies, the MLS confidentiality policy, Type
Enforcement, and other customized policies designed for common FreeBSD
deployment scenarios. In addition, the SELinux FLASK and Type
Enforcement implementations will be provided via an SEBSD module,
providing access to the higher level FLASK service abstraction, and
mature TE implementation
----

does this mean trusted bsd can use selinux policies? Are selinux policy
formats a pseudo standard? are there other projects like this?

Joshua Brindle
UNIX Administrator
Southern Nazarene University

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
