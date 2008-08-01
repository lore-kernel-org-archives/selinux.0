Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m711D8l8017317
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2008 21:13:11 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m711CvoQ018564
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2008 01:13:04 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id ACE5218268
	for <selinux@tycho.nsa.gov>; Fri,  1 Aug 2008 11:12:43 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Im0lpTWP0COG for <selinux@tycho.nsa.gov>;
	Fri,  1 Aug 2008 11:12:43 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 3E3D218267
	for <selinux@tycho.nsa.gov>; Fri,  1 Aug 2008 11:12:43 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id BEAA2200DC
	for <selinux@tycho.nsa.gov>; Fri,  1 Aug 2008 11:12:39 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: setfiles patch
Date: Fri, 1 Aug 2008 11:12:37 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200808011112.38850.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently "setfiles -p" doesn't print a new-line at the end, this is annoying 
as the output of the next command ends up starting halfway accross the 
screen.  Here is a patch.

--- policycoreutils-2.0.49.orig/setfiles/setfiles.c
+++ policycoreutils-2.0.49/setfiles/setfiles.c
@@ -1024,5 +1024,7 @@
                free(excludeArray[i].directory);
        }

+       if (progress)
+               printf("\n");
        exit(errors);
 }

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
