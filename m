Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA24171
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 09:13:19 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA15507
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 14:10:06 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-195.nas-smoothtransition.com [66.95.157.195] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id OAA15503
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 14:10:06 GMT
Received: from BATMAN ([66.200.42.3])
	by mx.nas-smoothtransition.com (8.11.4/8.9.3) with ESMTP id h1PEDHK00988
	for <selinux@tycho.nsa.gov>; Tue, 25 Feb 2003 09:13:17 -0500
From: "Frank Mayer" <mayerf@tresys.com>
To: "'SE Linux'" <selinux@tycho.nsa.gov>
Subject: convention for disabled/unused policy modules
Date: Tue, 25 Feb 2003 09:13:12 -0500
Message-ID: <001501c2dcd8$0b161b40$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

As we attempt to decide which policy modules should be enabled by
default, I would like us to determine a convention for managing
disabled/unused modules.  My motivation is again maintaining backwards
compatibility with our tools.  

We currently place unused/disabled modules in
./policy/domains/program/Unused/.  This is how we manage a single view
of all modules while ensuring that unused modules are not included in
the compiled policy.  So to avoid a compatibility problem,  I'd like to
suggest the use of the "Unused" directory as a convention (easy for us!)
unless someone else also has tools for which this will also cause a
problem.

If the convention is to be something else, please give us some warning
so we can support the new scheme as well as figure out a backwards
compatibility scheme.  At a minimum I ask that we use some directory
under ./policy/domains/program as the place we put unused modules
(rather than somewhere else, or worse, renaming the files in the program
directory to avoid the .te extension).

Frank


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
