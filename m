Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9D5ubNs020882
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 01:56:38 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9D5su5H004187
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 05:54:57 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id EF86361B05
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 15:54:51 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 19053-01 for <selinux@tycho.nsa.gov>;
	Thu, 13 Oct 2005 15:54:51 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 7095261B01
	for <selinux@tycho.nsa.gov>; Thu, 13 Oct 2005 15:54:51 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>
Subject: MLS policy patch
Date: Thu, 13 Oct 2005 15:54:42 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qafTDcZQNDH+zLK"
Message-Id: <200510131554.50248.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_qafTDcZQNDH+zLK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch fixes a couple of minor bugs in Dan's MLS policy package.  

Also ethereal.te needs to be moved to the unused directory to reduce the 
references to undefined types in the file_contexts.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_qafTDcZQNDH+zLK
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru policy.bak/domains/program/mount.te policy/domains/program/mount.te
--- policy.bak/domains/program/mount.te	2005-10-12 06:00:09.000000000 +1000
+++ policy/domains/program/mount.te	2005-10-13 15:38:14.000000000 +1000
@@ -87,5 +87,4 @@
 
 allow kernel_t mount_t:tcp_socket { read write };
 allow mount_t self:capability { setgid setuid };
-allow user_t mount_t:tcp_socket write;
 allow mount_t proc_t:lnk_file read;
diff -ru policy.bak/domains/program/unused/dcc.te policy/domains/program/unused/dcc.te
--- policy.bak/domains/program/unused/dcc.te	2005-10-12 06:00:09.000000000 +1000
+++ policy/domains/program/unused/dcc.te	2005-10-13 15:39:43.000000000 +1000
@@ -200,9 +200,8 @@
 can_exec_any(dcc_script_t)
 dcc_common(dcc_script)
 
-# Allow calling the script from an init script (initrt_t) or from
-# rc.local (staff_t)
-domain_auto_trans({ initrc_t staff_t }, dcc_script_exec_t, dcc_script_t)
+# Allow calling the script from an init script (initrt_t)
+domain_auto_trans(initrc_t, dcc_script_exec_t, dcc_script_t)
 
 # Start up the daemon process.  These scripts run 'su' to change to
 # the dcc user (even though the default dcc user is root).
diff -ru policy.bak/macros/user_macros.te policy/macros/user_macros.te
--- policy.bak/macros/user_macros.te	2005-10-12 06:00:09.000000000 +1000
+++ policy/macros/user_macros.te	2005-10-13 15:38:21.000000000 +1000
@@ -226,7 +226,6 @@
 
 allow $1_t self:dir search;
 allow $1_t self:file { getattr read };
-allow secadm_t self:fifo_file rw_file_perms;
 
 allow $1_t self:lnk_file read;
 allow $1_t self:unix_stream_socket create_socket_perms;

--Boundary-00=_qafTDcZQNDH+zLK--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
