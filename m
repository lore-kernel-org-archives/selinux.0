Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7U5krrT002774
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 01:46:53 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7U5k3AE011150
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 05:46:04 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id E970461AFA
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 15:46:49 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 30431-03 for <selinux@tycho.nsa.gov>;
	Mon, 30 Aug 2004 15:46:49 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8670661AF9
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 15:46:49 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 59F12B58DA
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 15:46:42 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: rpm policy
Date: Mon, 30 Aug 2004 15:46:41 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_B9rMBVdT1aLXsjG"
Message-Id: <200408301546.41790.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_B9rMBVdT1aLXsjG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

When running strict policy without unlimitedrpm the attached patch is 
necessary to permit upgrading package "dev" if someone has ever logged in at 
the console since the last relabel.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_B9rMBVdT1aLXsjG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="rpm.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rpm.diff"

--- /usr/src/se/policy/domains/program/unused/rpm.te	2004-08-30 15:44:20.000000000 +1000
+++ domains/program/unused/rpm.te	2004-08-30 15:44:13.000000000 +1000
@@ -110,6 +110,7 @@
 dontaudit rpm_t shadow_t:file { getattr read };
 allow rpm_t urandom_device_t:chr_file read;
 allow rpm_t { device_t device_type }:{ chr_file blk_file } { create_file_perms relabelfrom relabelto };
+allow rpm_t ttyfile:chr_file unlink;
 allow rpm_script_t tty_device_t:chr_file getattr;
 allow rpm_script_t devpts_t:dir { search };
 allow rpm_script_t {devpts_t devtty_t}:chr_file rw_file_perms;

--Boundary-00=_B9rMBVdT1aLXsjG--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
