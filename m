Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o04DIp30027327
	for <selinux@tycho.nsa.gov>; Mon, 4 Jan 2010 08:18:51 -0500
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o04DHX4d021222
	for <selinux@tycho.nsa.gov>; Mon, 4 Jan 2010 13:17:33 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id o04DIBZ9005284
	for <selinux@tycho.nsa.gov>; Mon, 4 Jan 2010 08:18:11 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id o04DIBa5005283
	for selinux@tycho.nsa.gov; Mon, 4 Jan 2010 08:18:11 -0500
Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBP6smWs026219
	for <selinux@tycho.nsa.gov>; Fri, 25 Dec 2009 01:54:53 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nBP6rV0x005761
	for <selinux@tycho.nsa.gov>; Fri, 25 Dec 2009 06:53:34 GMT
Received: from leeloo.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 6D3B918041
	for <selinux@tycho.nsa.gov>; Fri, 25 Dec 2009 17:54:39 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: select_context and ?dm
Date: Fri, 25 Dec 2009 17:54:49 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200912251754.49259.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is the select_context option of pam_selinux.so expected to work with an xdm 
type program?

Currently in Debian/Unstable if you use select_context in /etc/pam.d/kdm (for 
the KDE login program kdm) you will get a SEGV.

Obviously a SEGV is not what we expect, but is select_context expected to 
actually give the user a choice in a graphical login?  kdm will display the 
default context so it appears that there is some security framework code there 
which interfaces with SE Linux code (there doesn't appear to be SE Linux 
specific code to do this).  So it is conceivable that select_context could 
work.

I'm wondering whether I should file a bug report primarily about the SEGV or 
whether making sure that the pam.d file doesn't get the config option in 
question is the issue.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
