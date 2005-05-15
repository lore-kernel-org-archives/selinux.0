Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4F4ZZgA011701
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 00:35:36 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4F4WCsN027366
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 04:32:14 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id DFD6061AEC
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 01:46:54 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 01830-10 for <selinux@tycho.nsa.gov>;
	Sun, 15 May 2005 01:46:54 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 856C861AEB
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 01:46:54 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: postfix policy patch
Date: Sun, 15 May 2005 14:31:44 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0CthCFazEX06+eN"
Message-Id: <200505151431.48626.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_0CthCFazEX06+eN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch allows running "newaliases" on a Postfix system with the 
strict policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_0CthCFazEX06+eN
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- constraints.orig	2005-05-15 14:24:54.000000000 +1000
+++ constraints	2005-05-15 14:29:21.000000000 +1000
@@ -61,6 +61,10 @@
 ')
 ifdef(`userhelper.te', 
 	`or (t1 == userhelperdomain)')
+ifdef(`postfix.te', `
+ifdef(`direct_sysadm_daemon',
+	`or (t1 == sysadm_mail_t and t2 == system_mail_t and r2 == system_r )')
+')
 	 or (t1 == priv_system_role and r2 == system_r )
         );
 

--Boundary-00=_0CthCFazEX06+eN--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
