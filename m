Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7JDXfrT026852
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 09:33:41 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7JDWqpw012885
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 13:32:55 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B379261AF7
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 23:33:32 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 17786-02 for <selinux@tycho.nsa.gov>;
	Thu, 19 Aug 2004 23:33:32 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 508FA61AF6
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 23:33:32 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id DC704B57D9
	for <selinux@tycho.nsa.gov>; Thu, 19 Aug 2004 23:33:25 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: distro.tun
Date: Thu, 19 Aug 2004 23:33:25 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lwKJBaH64hYifvp"
Message-Id: <200408192333.25072.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_lwKJBaH64hYifvp
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch makes the distro tunable macros define to their same 
values.  This is useful because distributions have many files named after the 
distribution and sometimes the file needs a different label to other files in 
the same directory.

Of course we could have names like (r)edhat in file names, but I think that 
this is the most convenient solution which will cause the least confusion.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_lwKJBaH64hYifvp
Content-Type: text/x-diff;
  charset="us-ascii";
  name="distro.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="distro.diff"

--- /usr/src/se/policy/tunables/distro.tun	2004-07-31 06:03:21.000000000 +1000
+++ tunables/distro.tun	2004-08-19 17:42:49.000000000 +1000
@@ -5,10 +5,10 @@
 # appropriate ifdefs.
 
 
-dnl define(`redhat')
+dnl define(`redhat', `redhat')
 
-dnl define(`suse')
+dnl define(`suse', `suse')
 
-dnl define(`gentoo')
+dnl define(`gentoo', `gentoo')
 
-dnl define(`debian')
+dnl define(`debian', `debian')

--Boundary-00=_lwKJBaH64hYifvp--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
