Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7NGgCnN009213
	for <selinux@tycho.nsa.gov>; Sun, 23 Aug 2009 12:42:12 -0400
Received: from ladon.golden-gryphon.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7NGhKjL025172
	for <selinux@tycho.nsa.gov>; Sun, 23 Aug 2009 16:43:21 GMT
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Cc: 515710-forwarded@bugs.debian.org, Russell Coker <russell@coker.com.au>
Subject: policycoreutils: The error message on forkpty() failure is not clear or useful.
Date: Sun, 23 Aug 2009 09:40:58 -0500
Message-ID: <87ljlavbid.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        This has been reported against the Debian BTS.

        The current error message when forkpty() fails is not clear or
 useful. (Arguably, the erro message in the child branch cold also be
 improved)  The following patch makes indicate what went wrong.  Probably
 something better than this could be devised, but this is still a lot
 better than the current code.

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

        manoj
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=515710
-- 
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
