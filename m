Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA13312
	for <selinux@tycho.nsa.gov>; Thu, 14 Mar 2002 16:07:24 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA03943
	for <selinux@tycho.nsa.gov>; Thu, 14 Mar 2002 21:06:22 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id VAA03932 for <selinux@tycho.nsa.gov>; Thu, 14 Mar 2002 21:06:20 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id C2AA992443
	for <selinux@tycho.nsa.gov>; Fri, 15 Mar 2002 08:07:19 +1100 (EST)
Received: from there (lyta [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id E851B1A005
	for <selinux@tycho.nsa.gov>; Thu, 14 Mar 2002 22:07:21 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: stat now supports SE Linux in the upstream
Date: Thu, 14 Mar 2002 22:07:19 +0100
MIME-Version: 1.0
Message-Id: <20020314210721.E851B1A005@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The latest version of stat has SE Linux support, so there's probably no need 
for the patch on the NSA site, just a reference that version 3.1 is needed.

There is a bug in displaying the context though, the following patch fixes it.


diff -ru stat-3.1/stat.c stat-3.1.patched/stat.c
--- stat-3.1/stat.c ? ? Sun Mar ?3 12:58:22 2002
+++ stat-3.1.patched/stat.c ? ? Thu Mar 14 21:52:23 2002
@@?-745,7 +745,7 @@
? ? ? ? ? ? ? ? ? ? ? ? ? ?"Device: %Dh/%dd\tInode: %-10i ?Links: %-5h"
? ? ? ? ? ? ? ? ? ? ? ? ? ?" Device type: %t,%T\n"
? ? ? ? ? ? ? ? ? ? ? ? ? ?"Access: (%04a/%10.10A) ?Uid: (%5u/%8U) ? Gid: 
(%5g/%8G)\n"
- ? ? ? ? ? ? ? ? ? ? ? ? ?" ? SID: %-14S ?S_Context: %c\n"
+ ? ? ? ? ? ? ? ? ? ? ? ? ?" ? SID: %-14S ?S_Context: %C\n"
? ? ? ? ? ? ? ? ? ? ? ? ? ?"Access: %x\n"
? ? ? ? ? ? ? ? ? ? ? ? ? ?"Modify: %y\n"
? ? ? ? ? ? ? ? ? ? ? ? ? ?"Change: %z\n";
@@?-770,7 +770,7 @@
? ? ? ? ? ? ? ? ? ? ? ? ? ?" ?Size: %-10s\tBlocks: %-10b IO Block: %-6o %F\n"
? ? ? ? ? ? ? ? ? ? ? ? ? ?"Device: %Dh/%dd\tInode: %-10i ?Links: %-5h\n"
? ? ? ? ? ? ? ? ? ? ? ? ? ?"Access: (%04a/%10.10A) ?Uid: (%5u/%8U) ? Gid: 
(%5g/%8G)\n"
- ? ? ? ? ? ? ? ? ? ? ? ? ?" ? SID: %-14S ?S_Context: %c\n"
+ ? ? ? ? ? ? ? ? ? ? ? ? ?" ? SID: %-14S ?S_Context: %C\n"
? ? ? ? ? ? ? ? ? ? ? ? ? ?"Access: %x\n"
? ? ? ? ? ? ? ? ? ? ? ? ? ?"Modify: %y\n"
? ? ? ? ? ? ? ? ? ? ? ? ? ?"Change: %z\n";


PS Is the NSA web site suffering a DOS attack?  It seems unusually slow while 
all the other American sites I've tried work normally...

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
