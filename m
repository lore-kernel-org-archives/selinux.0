Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9QDCSXZ011807
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 09:12:28 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9QDCMT7009112
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 13:12:24 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 17DEF61AFC
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 23:12:20 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 21742-09 for <selinux@tycho.nsa.gov>;
	Tue, 26 Oct 2004 23:12:19 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 9DAE161AF7
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 23:12:19 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id EAF7DB589C
	for <selinux@tycho.nsa.gov>; Tue, 26 Oct 2004 23:12:21 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: minor checkpolicy patch
Date: Tue, 26 Oct 2004 22:52:55 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nikfBk/jI3cY/Ci"
Message-Id: <200410262252.55431.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_nikfBk/jI3cY/Ci
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch against the CVS version fixes a couple of minor warnings.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_nikfBk/jI3cY/Ci
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /cvs-selinux/nsa/selinux-usr/checkpolicy/policy_parse.y ./policy_parse.y
--- /cvs-selinux/nsa/selinux-usr/checkpolicy/policy_parse.y	2004-10-26 22:44:57.000000000 +1000
+++ ./policy_parse.y	2004-10-26 22:49:35.000000000 +1000
@@ -21,6 +21,7 @@
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
+#include <stdlib.h>
 
 #include <sepol/policydb.h>
 #include <sepol/services.h>
diff -ru /cvs-selinux/nsa/selinux-usr/checkpolicy/users.y ./users.y
--- /cvs-selinux/nsa/selinux-usr/checkpolicy/users.y	2004-08-10 04:12:37.000000000 +1000
+++ ./users.y	2004-10-26 22:50:25.000000000 +1000
@@ -3,6 +3,7 @@
 #include <sepol/services.h>
 #include <sepol/conditional.h>
 #include <stdint.h>
+#include <stdlib.h>
 #include "queue.h"
 #include "checkpolicy.h"
 

--Boundary-00=_nikfBk/jI3cY/Ci--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
