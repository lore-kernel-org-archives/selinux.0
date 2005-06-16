Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5GMedgA005245
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 18:40:39 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5GMVuZm025836
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 22:31:57 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id AC42761AFA
	for <selinux@tycho.nsa.gov>; Fri, 17 Jun 2005 08:31:57 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 16643-03 for <selinux@tycho.nsa.gov>;
	Fri, 17 Jun 2005 08:31:57 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 4CD2161AEB
	for <selinux@tycho.nsa.gov>; Fri, 17 Jun 2005 08:31:57 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: rpcd.te
Date: Fri, 17 Jun 2005 08:31:52 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_b3fsCS4+OAKVtcj"
Message-Id: <200506170831.55959.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_b3fsCS4+OAKVtcj
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed to compile strict policy without kerberos.te.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_b3fsCS4+OAKVtcj
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- rpcd.te.orig	2005-06-17 08:29:32.000000000 +1000
+++ rpcd.te	2005-06-17 08:30:58.000000000 +1000
@@ -132,7 +132,9 @@
 
 rpc_domain(gssd)
 can_kerberos(gssd_t)
+ifdef(`kerberos.te', `
 allow gssd_t krb5_keytab_t:file r_file_perms;
+')
 allow gssd_t urandom_device_t:chr_file { getattr read };
 r_dir_file(gssd_t, tmp_t)
 tmp_domain(gssd)

--Boundary-00=_b3fsCS4+OAKVtcj--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
