Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA00596
	for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 02:27:04 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id HAA02489
	for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 07:24:50 GMT
Received: from va.cs.wm.edu (va.cs.wm.edu [128.239.2.31])
	by jazzswing.ncsc.mil  with ESMTP id HAA02485
	for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 07:24:45 GMT
Received: from escher.cs.wm.edu (escher [128.239.26.27])
	by va.cs.wm.edu (8.11.4/8.9.1) with ESMTP id gAU7QhP23170
	for <selinux@tycho.nsa.gov>; Sat, 30 Nov 2002 02:26:43 -0500 (EST)
Received: (from hallyn@localhost)
	by escher.cs.wm.edu (8.11.6/8.9.1) id gAU7Qhl08035
	for selinux@tycho.nsa.gov; Sat, 30 Nov 2002 02:26:43 -0500
Date: Sat, 30 Nov 2002 02:26:43 -0500
From: "Serge E. Hallyn" <hallyn@cs.wm.edu>
To: selinux <selinux@tycho.nsa.gov>
Subject: policy administration
Message-ID: <20021130022643.A8018@escher.cs.wm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

For the past, er,  while, I've been working on tools for dealing 
with DTE policies.  I'd now like to start applying that to selinux
policies.  Briefly, the work spanned from the extremely mundane
(a gui policy editor) to the somewhat less mundane (presenting
graphical representations of relations in policies) to the
stuff I enjoyed more (constructing policies from modules, and
analyzing policies using other MAC systems - ie using the BLP
star-property to introduce relations on types, in a manner similar
to what TIS did in 1998 to allow automatic policy updates*).

I've been looking at the website and the mailing list, and it
doesn't seem anyone is doing anything like this just yet.  If
anyone is, please let me know.

thanks,
-serge

* - see :

@article{dte:reconfigure,
author = {Timothy Fraser and Lee Badger},
title = {Ensuring Continuity During Dynamic Security Policy Reconfiguration in DTE},
journal = {Proceedings of the IEEE Symposium on Security and Privacy},
year = 1998
}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
