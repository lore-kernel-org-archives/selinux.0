Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6895ErT011741
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 05:05:14 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6894r5G025025
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 09:04:54 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 373B861C9C
	for <selinux@tycho.nsa.gov>; Thu,  8 Jul 2004 19:05:11 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 09497-08 for <selinux@tycho.nsa.gov>;
	Thu, 8 Jul 2004 19:05:11 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D740B61BD2
	for <selinux@tycho.nsa.gov>; Thu,  8 Jul 2004 19:05:10 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 4F22BB59AD
	for <selinux@tycho.nsa.gov>; Thu,  8 Jul 2004 19:05:09 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: userhelper_t vs sysadm_userhelper_t
Date: Thu, 8 Jul 2004 19:05:08 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_E5Q7A6GnsYKRaNV"
Message-Id: <200407081905.08774.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_E5Q7A6GnsYKRaNV
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I think that as much as possible the policy should refer to the real 
domain/type names not aliases.  The attached patch fixes this for 
userhelper_t.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_E5Q7A6GnsYKRaNV
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /usr/src/se/policy/constraints ./constraints
--- /usr/src/se/policy/constraints	2004-05-12 05:10:28.000000000 +1000
+++ ./constraints	2004-07-08 13:30:09.000000000 +1000
@@ -39,7 +39,7 @@
          or (t1 == crond_t and t2 == user_crond_domain)
 ')
 ifdef(`userhelper.te', 
-	`or (t1 == userhelper_t)')
+	`or (t1 == sysadm_userhelper_t)')
 	 or (t1 == priv_system_role and u2 == system_u )
         );
 
@@ -49,7 +49,7 @@
          or (t1 == crond_t and t2 == user_crond_domain)
 ')
 ifdef(`userhelper.te', 
-	`or (t1 == userhelper_t)')
+	`or (t1 == sysadm_userhelper_t)')
 	 or (t1 == priv_system_role and r2 == system_r )
         );
 

--Boundary-00=_E5Q7A6GnsYKRaNV--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
