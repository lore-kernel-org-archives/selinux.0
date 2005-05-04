Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j44AicgA002926
	for <selinux@tycho.nsa.gov>; Wed, 4 May 2005 06:44:38 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j44AhHWY005483
	for <selinux@tycho.nsa.gov>; Wed, 4 May 2005 10:43:18 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 9004F61ADF
	for <selinux@tycho.nsa.gov>; Wed,  4 May 2005 18:44:56 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 12519-03 for <selinux@tycho.nsa.gov>;
	Wed, 4 May 2005 18:44:56 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 29F9461ADD
	for <selinux@tycho.nsa.gov>; Wed,  4 May 2005 18:44:56 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
Subject: postfix policy patch
Date: Wed, 4 May 2005 20:43:01 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4cKeC6NKqVi1q6j"
Message-Id: <200505042043.04355.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_4cKeC6NKqVi1q6j
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Against latest Fedora strict policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_4cKeC6NKqVi1q6j
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/postfix.te.orig	2005-05-04 20:34:06.000000000 +1000
+++ domains/program/postfix.te	2005-05-04 20:34:48.000000000 +1000
@@ -180,6 +180,7 @@
 # for OpenSSL certificates
 r_dir_file(postfix_smtpd_t,usr_t)
 allow postfix_smtpd_t etc_aliases_t:file r_file_perms;
+allow postfix_smtpd_t self:file { getattr read };
 
 # for prng_exch
 allow postfix_smtpd_t postfix_spool_t:file rw_file_perms;

--Boundary-00=_4cKeC6NKqVi1q6j--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
