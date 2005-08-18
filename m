Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j7ID0wOb027947
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 09:00:59 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j7ICpZ4R021822
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 12:51:37 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id BC31661AFD
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 22:51:23 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 16214-06 for <selinux@tycho.nsa.gov>;
	Thu, 18 Aug 2005 22:51:23 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 35A3261AF7
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 22:51:23 +1000 (EST)
Received: from intranet.corp.redhat.com (intranet.corp.redhat.com [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id C54E044
	for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2005 22:51:22 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: remove apostrophe
Date: Thu, 18 Aug 2005 22:51:19 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KRIBDpAh0rE+Xd2"
Message-Id: <200508182251.22526.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_KRIBDpAh0rE+Xd2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch removes some apostrophes from the comments.  This doesn't 
actually change anything (the policy is working OK in this regard at the 
moment), but will make things easier for people in the future.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_KRIBDpAh0rE+Xd2
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru policy/attrib.te policy.new/attrib.te
--- policy/attrib.te	2005-07-19 06:10:47.000000000 +1000
+++ policy.new/attrib.te	2005-08-18 22:46:30.000000000 +1000
@@ -94,7 +94,7 @@
 
 # The privowner attribute identifies every domain that can 
 # assign a different SELinux user identity to a file, or that
-# can create a file with an identity that's not the same as the
+# can create a file with an identity that is not the same as the
 # process identity.  This attribute is used in the constraints
 # configuration.
 attribute privowner;
diff -ru policy/file_contexts/program/qmail.fc policy.new/file_contexts/program/qmail.fc
--- policy/file_contexts/program/qmail.fc	2004-03-04 07:53:52.000000000 +1100
+++ policy.new/file_contexts/program/qmail.fc	2005-08-18 22:46:42.000000000 +1000
@@ -17,7 +17,7 @@
 /usr/sbin/splogger	--	system_u:object_r:qmail_splogger_exec_t
 /usr/sbin/qmail-getpw	--	system_u:object_r:qmail_exec_t
 /usr/local/bin/serialmail/.* -- system_u:object_r:qmail_serialmail_exec_t
-# qmail - djb's locations
+# qmail - djb locations
 /var/qmail/control(/.*)?	system_u:object_r:qmail_etc_t
 /var/qmail/bin		-d	system_u:object_r:bin_t
 /var/qmail/queue(/.*)?		system_u:object_r:qmail_spool_t
diff -ru policy/file_contexts/types.fc policy.new/file_contexts/types.fc
--- policy/file_contexts/types.fc	2005-07-12 04:21:45.000000000 +1000
+++ policy.new/file_contexts/types.fc	2005-08-18 22:47:24.000000000 +1000
@@ -46,9 +46,9 @@
 #
 # Ordinary user home directories.
 # HOME_ROOT expands to all valid home directory prefixes found in /etc/passwd
-# HOME_DIR expands to each user's home directory,
+# HOME_DIR expands to each users home directory,
 #                  and to HOME_ROOT/[^/]+ for each HOME_ROOT.
-# ROLE expands to each user's role when role != user_r, and to "user" otherwise.
+# ROLE expands to each users role when role != user_r, and to "user" otherwise.
 #
 HOME_ROOT		-d	system_u:object_r:home_root_t
 HOME_DIR		-d	system_u:object_r:ROLE_home_dir_t
diff -ru policy/targeted/assert.te policy.new/targeted/assert.te
--- policy/targeted/assert.te	2005-05-24 05:48:45.000000000 +1000
+++ policy.new/targeted/assert.te	2005-08-18 22:46:06.000000000 +1000
@@ -24,7 +24,7 @@
 # send SIGCHLD for child termination notifications.
 neverallow { domain -unrestricted } unconfined_t:process ~sigchld;
 
-# Confined domains must never see unconfined domain's /proc/pid entries.
+# Confined domains must never see /proc/pid entries for an unconfined domain.
 neverallow { domain -unrestricted -snmpd_t } unconfined_t:dir { getattr search };
 
 #

--Boundary-00=_KRIBDpAh0rE+Xd2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
