Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i16MuURb025851
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 17:56:30 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i16MuTOi008864
	for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 22:56:29 GMT
Received: from mailhost.unt.edu (mailhost.unt.edu [129.120.209.40])
        by jazzband.ncsc.mil  with ESMTP id i16MuSWW008861 for <selinux@tycho.nsa.gov>; Fri, 6 Feb 2004 22:56:28 GMT
Received: from iatro (localhost.localdomain [127.0.0.1])
	by mail3 (Postfix) with SMTP id C4B57684CA
	for <selinux@tycho.nsa.gov>; Fri,  6 Feb 2004 16:56:25 -0600 (CST)
Received: from eaglemail.unt.edu (imp2.private.acs.unt.edu [192.168.221.72])
	by mailhost.unt.edu (Postfix) with ESMTP id 212EE684C8
	for <selinux@tycho.nsa.gov>; Fri,  6 Feb 2004 16:56:24 -0600 (CST)
Message-ID: <1076108187.40241b9b04e46@eaglemail.unt.edu>
Date: Fri,  6 Feb 2004 16:56:27 -0600
From: Ignacio Tripodi <ignaciot@unt.edu>
To: selinux@tycho.nsa.gov
Subject: Disregard the policy question
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I found the "POLICYCOMPAT = -c" flag in Makefile and everything worked great
after enabling it.
Thanks,

Ignacio 
CoPS Lab
University of North Texas

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
