Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA15695
	for <selinux@tycho.nsa.gov>; Sun, 29 Sep 2002 19:05:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA05578
	for <selinux@tycho.nsa.gov>; Sun, 29 Sep 2002 23:03:35 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA05574
	for <selinux@tycho.nsa.gov>; Sun, 29 Sep 2002 23:03:33 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 7F99492465
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 09:05:03 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 9A23BA4DD
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 01:03:08 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: missed a bit from the last message
Date: Mon, 30 Sep 2002 01:02:48 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_OO28H09MENZB0U8BMVSC"
Message-Id: <200209300102.48526.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_OO28H09MENZB0U8BMVSC
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

Here's a line that was missed from my last message.  Needed to allow games to 
read .Xauthority with the new policy.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_OO28H09MENZB0U8BMVSC
Content-Type: text/x-diff;
  charset="us-ascii";
  name="1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="1"

diff -ru /usr/share/selinux/policy/default/macros/program/x_client_macros.te /usr/share/selinux/policy/current/macros/program/x_client_macros.te
--- /usr/share/selinux/policy/default/macros/program/x_client_macros.te	2002-09-30 00:15:28.000000000 +0200
+++ /usr/share/selinux/policy/current/macros/program/x_client_macros.te	2002-09-30 01:00:28.000000000 +0200
@@ -39,6 +39,8 @@
 # Use this type for files created in /tmp.
 file_type_auto_trans($1_$2_t, tmp_t, $1_$2_rw_t)
 
+allow $1_$2_t $1_home_xauth_t:file { getattr read };
+
 # Allow the user domain to relabel to or create files with this type
 # to provide the domain with write access to particular files.
 allow $1_t $1_$2_rw_t:{ dir file lnk_file } { relabelfrom relabelto };

--------------Boundary-00=_OO28H09MENZB0U8BMVSC--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
