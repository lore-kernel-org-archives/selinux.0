Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8TMo9rT019729
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 18:50:09 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8TMn2nY011857
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 22:49:03 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 7AC0161AFC
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 08:50:06 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 05810-02 for <selinux@tycho.nsa.gov>;
	Thu, 30 Sep 2004 08:50:06 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 17EDB61AF3
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 08:50:06 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id E9C71B58D5
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 08:50:04 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: sulogin.te
Date: Thu, 30 Sep 2004 08:50:04 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_cwzWBhvjPe7xFPs"
Message-Id: <200409300850.04208.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_cwzWBhvjPe7xFPs
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch removes a redundant line from sulogin.te.  The "auth" 
attribute grants read and getattr access to /etc/shadow.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_cwzWBhvjPe7xFPs
Content-Type: text/x-diff;
  charset="us-ascii";
  name="sulogin.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="sulogin.diff"

--- /usr/src/se/policy/domains/program/sulogin.te	2004-09-21 14:39:14.000000000 +1000
+++ domains/program/sulogin.te	2004-09-30 08:48:10.000000000 +1000
@@ -28,7 +28,6 @@
 can_setexec(sulogin_t)
 can_getsecurity(sulogin_t)
 ')
-allow sulogin_t shadow_t:file { getattr read };
 
 r_dir_file(sulogin_t, etc_t)
 

--Boundary-00=_cwzWBhvjPe7xFPs--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
