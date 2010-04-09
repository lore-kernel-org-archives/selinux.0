Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o39CIBF8012838
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2010 08:18:11 -0400
Received: from imr2.ericy.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o39CIxUl010002
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2010 12:18:59 GMT
Received: from eusaamw0712.eamcs.ericsson.se ([147.117.20.181])
	by imr2.ericy.com (8.13.1/8.13.1) with ESMTP id o39CE7eD011092
	for <selinux@tycho.nsa.gov>; Fri, 9 Apr 2010 07:22:10 -0500
From: Alan Rouse <alan.rouse@ericsson.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Fri, 9 Apr 2010 08:16:08 -0400
Subject: Cannot not open session
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F52E46493A4@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Two questions:

1. I'm working with selinux in opensuse.  With selinux in enforcing mode, su is not working.  For example, suppose root tries to su to an unprivileged user.  I'm asked if I would like to enter a security context [N].  If I say no, it responds "su: cannot not open session:  Authentication failure".   With selinux in permissive mode, it works... and no avc messages are logged.   

Any idea what I have done wrong?

2.  When I try to su to an unprivileged user, and it asks if I would like to enter a security context, suppose I say yes.  It asks for a role, and I enter 'user_r'.  then it asks for a level.  What kind of answer does it expect here?  Nothing I've tried works....

Thanks!



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
