Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7P4TRrT002970
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 00:29:27 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7P4TPuQ028740
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 04:29:26 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 0FC6D61AFB
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 14:29:25 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 26843-04 for <selinux@tycho.nsa.gov>;
	Wed, 25 Aug 2004 14:29:24 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id A9AAC61AFA
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 14:29:24 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id E682EB5889
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 14:29:22 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: admin.te
Date: Wed, 25 Aug 2004 14:29:22 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_iWBLBmht4Sbjd1p"
Message-Id: <200408251429.22399.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_iWBLBmht4Sbjd1p
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch cleans up some redundant attributes in admin.te.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_iWBLBmht4Sbjd1p
Content-Type: text/x-diff;
  charset="us-ascii";
  name="admin.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="admin.diff"

--- /usr/src/se/policy/domains/admin.te	2004-08-25 13:21:21.000000000 +1000
+++ ./domains/admin.te	2004-08-25 14:11:45.000000000 +1000
@@ -4,7 +4,7 @@
 
 # sysadm_t is the system administrator domain.
 type sysadm_t, domain, privlog, privowner, admin, userdomain, web_client_domain, privhome, etc_writer, privmodule
-ifdef(`unrestricted_admin', `,etc_writer, fs_domain, privmem, privlog, privowner, sysctl_kernel_writer, auth, auth_write, unrestricted')
+ifdef(`unrestricted_admin', `, fs_domain, privmem, sysctl_kernel_writer, auth, auth_write, unrestricted')
 ifdef(`direct_sysadm_daemon', `, priv_system_role')
 ; dnl end of sysadm_t type declaration
 

--Boundary-00=_iWBLBmht4Sbjd1p--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
