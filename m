Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7BCJTOb009379
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2005 08:19:30 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7BCAKYP029550
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2005 12:10:21 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id E2D4D61AD9
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2005 22:11:09 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 13520-02-3 for <selinux@tycho.nsa.gov>;
	Thu, 11 Aug 2005 22:11:09 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 7253561B12
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2005 21:59:27 +1000 (EST)
Received: from intranet.corp.redhat.com (intranet.corp.redhat.com [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 656121B
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2005 21:59:25 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: radvd.fc
Date: Thu, 11 Aug 2005 21:59:23 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_d2z+CtvekBWN/uP"
Message-Id: <200508112159.25125.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_d2z+CtvekBWN/uP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch correctly labels the saved state file for radvd (the IPv6 
rout advisory daemon).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_d2z+CtvekBWN/uP
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- file_contexts/program/radvd.fc.orig	2005-08-11 21:57:26.000000000 +1000
+++ file_contexts/program/radvd.fc	2005-08-11 21:57:46.000000000 +1000
@@ -2,3 +2,4 @@
 /etc/radvd\.conf	--	system_u:object_r:radvd_etc_t
 /usr/sbin/radvd		--	system_u:object_r:radvd_exec_t
 /var/run/radvd\.pid	--	system_u:object_r:radvd_var_run_t
+/var/run/radvd/saved-settings -- system_u:object_r:radvd_var_run_t

--Boundary-00=_d2z+CtvekBWN/uP--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
