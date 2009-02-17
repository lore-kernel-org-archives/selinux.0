Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1H2eOnn002237
	for <selinux@tycho.nsa.gov>; Mon, 16 Feb 2009 21:40:24 -0500
Received: from etbe.coker.com.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1H2eLmH012190
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 02:40:22 GMT
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by etbe.coker.com.au (Postfix) with ESMTP id 96FA3180D5
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 13:40:14 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 507EA20EC1
	for <selinux@tycho.nsa.gov>; Tue, 17 Feb 2009 13:40:12 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: run_init
Date: Tue, 17 Feb 2009 13:40:08 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200902171340.11057.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

One thing that has bitten me a couple of times is that I have tried to use 
run_init when I had not mounted /dev/pts.  run_init gives an error message 
about "Fork:" which doesn't help anyone in tracking down the problem (it 
seems much more likely to have a /dev/pts problem than an actual fork 
problem).

The misleading error message is currently in Debian and a quick scan of the 
source code in rawhide suggests that Fedora has it too.

I suggest the following change, but something more verbose could be useful 
too.

--- open_init_pty.c.bak 2009-02-16 21:47:28.000000000 +1100
+++ open_init_pty.c     2009-02-16 21:48:06.000000000 +1100
@@ -153,7 +153,7 @@
        }

        if (child_pid < 0) {
-               perror("Fork:");
+               perror("forkpty():");
                fflush(stdout);
                fflush(stderr);
                exit(EX_OSERR);

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
