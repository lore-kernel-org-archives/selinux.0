Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1DE1iRb027244
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 09:01:44 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1DE0GQk009872
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 14:00:16 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id i1DE0EYo009803
	for <selinux@tycho.nsa.gov>; Fri, 13 Feb 2004 14:00:16 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 9C42B61C56
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 01:01:09 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 14186-06 for <selinux@tycho.nsa.gov>;
	Sat, 14 Feb 2004 01:01:09 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 325FE61BE8
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 01:01:09 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id E862BB5870
	for <selinux@tycho.nsa.gov>; Sat, 14 Feb 2004 01:01:07 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
Subject: Fwd: MLS Kconfig Patch
Date: Sat, 14 Feb 2004 01:01:07 +1100
To: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jiNLAczUMpE0SAu"
Message-Id: <200402140101.07306.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_jiNLAczUMpE0SAu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

As the policy does not properly support MLS and every distribution is 
compiling the user-space code without MLS support it seems that this patch is 
a good idea.

----------  Forwarded Message  ----------

Subject: MLS Kconfig Patch
Date: Sat, 14 Feb 2004 00:58
From: Dan Weber <dan@mirrorlynx.com>
To: russell@coker.com.au

Ok here is the patch for mls's kconfig.  Basically this will force the user
 to allow broken drivers before they can use it.  For the mainstream it will
 cut it off and you can simply unpatch it when ready.

-------------------------------------------------------



-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_jiNLAczUMpE0SAu
Content-Type: text/plain;
  charset="us-ascii";
  name=" "
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="selinux-kconfig-mls.patch"

--- security/selinux/Kconfig	2004-02-13 08:49:21.000000000 -0500
+++ security/selinux/Kconfig-2	2004-02-13 08:50:10.000000000 -0500
@@ -39,7 +39,7 @@
=20
 config SECURITY_SELINUX_MLS
 	bool "NSA SELinux MLS policy (EXPERIMENTAL)"
-	depends on SECURITY_SELINUX && EXPERIMENTAL
+	depends on SECURITY_SELINUX && EXPERIMENTAL && BROKEN
 	default n
 	help
 	  This enables the NSA SELinux Multi-Level Security (MLS) policy in

--Boundary-00=_jiNLAczUMpE0SAu--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
