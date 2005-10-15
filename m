Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9GMOuNs022970
	for <selinux@tycho.nsa.gov>; Sun, 16 Oct 2005 18:24:57 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9GMMbdD024978
	for <selinux@tycho.nsa.gov>; Sun, 16 Oct 2005 22:22:38 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id A0D4061B01
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 08:22:29 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 07815-01-2 for <selinux@tycho.nsa.gov>;
	Mon, 17 Oct 2005 08:22:29 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D416561B00
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 08:22:27 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id CA83E62
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 08:22:08 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: range transitions in MCS
Date: Sat, 15 Oct 2005 20:32:58 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_frNUDtVdj2yxryb"
Message-Id: <200510152033.03582.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_frNUDtVdj2yxryb
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Currently in the MCS policy in rawhide restarting a daemon changes it's MLS 
context from "s0" to "s0:c0.c255".  This is obviously not what we want.

I suggest the attached patch to fix this.

The daemon policies cups.te, udev.te, and xdm.te need to be modified to 
include this attribute.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_frNUDtVdj2yxryb
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- macros/global_macros.te.orig	2005-10-15 20:13:46.000000000 +1000
+++ macros/global_macros.te	2005-10-15 20:30:20.000000000 +1000
@@ -324,11 +324,22 @@
 } else {
 ') dnl transitionbool
 domain_auto_trans(initrc_t, $1_exec_t, $1_t)
+
+# transition MLS range to "s0" when executing daemon.
+ifelse(index(`$2',`no_daemon_range_trans'), -1, `
+range_transition initrc_t $1_exec_t s0;
+')dnl no_daemon_range_trans
+
 allow initrc_t $1_t:process { noatsecure siginh rlimitinh };
 ifdef(`direct_sysadm_daemon', `
 ifelse(`$3', `nosysadm', `', `
 domain_auto_trans(sysadm_t, $1_exec_t, $1_t)
 allow sysadm_t $1_t:process { noatsecure siginh rlimitinh };
+
+# transition MLS range to "s0" when executing daemon.
+ifelse(index(`$2',`no_daemon_range_trans'), -1, `
+range_transition sysadm_t $1_exec_t s0;
+')dnl no_daemon_range_trans
 ')dnl end direct_sysadm_daemon
 ')dnl end nosysadm
 ifelse(index(`$2', `transitionbool'), -1, `', `
--- attrib.te.orig	2005-10-15 20:20:10.000000000 +1000
+++ attrib.te	2005-10-15 20:30:29.000000000 +1000
@@ -494,6 +494,10 @@
 # For labeling of domains whos transition can be disabled
 attribute transitionbool;
 
+# For labelling daemons that should not have a range transition to "s0"
+# included in the daemon_base_domain macro
+attribute no_daemon_range_trans;
+
 # For labeling of file_context domains which users can change files to rather
 # then the default file context.  These file_context can survive a relabeling
 # of the file system.

--Boundary-00=_frNUDtVdj2yxryb--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
