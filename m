Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA24908
	for <selinux@tycho.nsa.gov>; Sun, 28 Apr 2002 16:25:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA28791
	for <selinux@tycho.nsa.gov>; Sun, 28 Apr 2002 20:23:55 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id UAA28787 for <selinux@tycho.nsa.gov>; Sun, 28 Apr 2002 20:23:54 GMT
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: debian-dpkg@lists.debian.org
Subject: Debian SE Linux support
Date: Sun, 28 Apr 2002 22:25:06 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <20020428202507.3CDAB3813@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have just got Debian package installation working properly on SE Linux.  I 
can now upgrade any package on my system (even the tricky ones like "devfsd" 
and "selinux") without any action being blocked by the security system, while 
having all processes running in the correct domain, and with a quite 
restrictive policy.

This is the subject of my paper for OLS.

Unfortunately no-one else can achieve the same results at the moment because 
I will not release my hacked version of dpkg as I am waiting for the dpkg 
maintainers to decide the correct method of implementing 
hooks/triggers/whatever.

It would be really nice if we could get this feature in dpkg before someone 
ports my code to rpm (rpm already has trigger functionality which I believe 
to be adequate for this task).

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
