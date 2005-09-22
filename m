Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8M8wPNs017548
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 04:58:25 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8M8ruUn020468
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 08:53:57 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id CC1A361B04
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 18:53:58 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 04904-07 for <selinux@tycho.nsa.gov>;
	Thu, 22 Sep 2005 18:53:58 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 6C64161AF3
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 18:53:58 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 995D727133
	for <selinux@tycho.nsa.gov>; Thu, 22 Sep 2005 18:53:57 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: cvs policy
Date: Thu, 22 Sep 2005 18:53:52 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_lEnMDgd82ZF4JWz"
Message-Id: <200509221853.57391.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_lEnMDgd82ZF4JWz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is necessary to compile policy with cvs support but without 
support for kerberos.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_lEnMDgd82ZF4JWz
Content-Type: text/x-diff;
  charset="us-ascii";
  name="cvs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="cvs.diff"

--- domains/program/cvs.te.orig	2005-09-22 18:52:22.000000000 +1000
+++ domains/program/cvs.te	2005-09-22 18:52:42.000000000 +1000
@@ -23,6 +23,8 @@
 allow cvs_t etc_runtime_t:file { getattr read };
 allow system_mail_t cvs_data_t:file { getattr read };
 dontaudit cvs_t devtty_t:chr_file { read write };
+ifdef(`kerberos.te', `
 # Allow kerberos to work
 allow cvs_t { krb5_keytab_t krb5_conf_t }:file r_file_perms;
 dontaudit cvs_t krb5_conf_t:file write;
+')

--Boundary-00=_lEnMDgd82ZF4JWz--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
