Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KCLZrT003282
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 08:21:35 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KCKq4v003199
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 12:20:53 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 4D0C361AF7
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 22:21:30 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 06880-07 for <selinux@tycho.nsa.gov>;
	Fri, 20 Aug 2004 22:21:30 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id DAF9561AF6
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 22:21:29 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id B01B8B57DB
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 21:52:36 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: genhomedircon
Date: Fri, 20 Aug 2004 21:52:35 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DYeJBoeK4wfKIHy"
Message-Id: <200408202152.35564.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_DYeJBoeK4wfKIHy
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In genhomedircon version 1.16 there is some duplicated code.  The attached 
patch removes it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_DYeJBoeK4wfKIHy
Content-Type: text/x-diff;
  charset="us-ascii";
  name="genhomedircon.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="genhomedircon.diff"

--- policycoreutils-1.16.orig/scripts/genhomedircon	2004-08-12 22:38:42.000000000 +1000
+++ policycoreutils-1.16/scripts/genhomedircon	2004-08-20 21:46:10.000000000 +1000
@@ -97,12 +97,6 @@
 	else:
 		STARTING_UID=500
 
-	rc=commands.getstatusoutput("grep -h '^UID_MIN' /etc/login.defs | sed -e 's/^UID_MIN[^0-9]*//'")
-	if rc[0] == 0:
-		STARTING_UID=rc[1]
-	else:
-		STARTING_UID=500
-
 	FILECONTEXTDIR=sys.argv[1]
 	prefixes = getPrefixes()
 

--Boundary-00=_DYeJBoeK4wfKIHy--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
