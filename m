Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6B7xerT026691
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 03:59:40 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6B7xHNZ003616
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 07:59:18 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B595461C9D
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 17:59:36 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 16818-06 for <selinux@tycho.nsa.gov>;
	Sun, 11 Jul 2004 17:59:36 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 3E70661BD2
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 17:59:36 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 8DE56B5A98
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 17:59:34 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policy patch
Date: Sun, 11 Jul 2004 17:59:34 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_mNP8A5nYOIgRlh9"
Message-Id: <200407111759.34090.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_mNP8A5nYOIgRlh9
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

file_type_auto_trans(sysadm_t, user_home_dir_t, user_home_t)

I remove the above from domains/admin.te because it's granted to privhome by 
macros/user_macros.te and sysadm_t has the privhome attribute.

checkpolicy_t should not be creating lnk_file, sock_file, or fifo_file objects 
of type policy_config_t, and if there are sock_file or fifo_file objects of 
type policy_src_t then it should not be reading them.

system_crond_t should not be trying to access device nodes of types that are 
for files.

I still don't think that dmesg_t is appropriate for running dmesg from the 
administrator shell.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_mNP8A5nYOIgRlh9
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /usr/src/se/policy/domains/admin.te ./domains/admin.te
--- /usr/src/se/policy/domains/admin.te	2004-05-30 16:26:57.000000000 +1000
+++ ./domains/admin.te	2004-07-08 19:20:25.000000000 +1000
@@ -31,4 +31,3 @@
 
 # Add/remove user home directories
 file_type_auto_trans(sysadm_t, home_root_t, user_home_dir_t, dir)
-file_type_auto_trans(sysadm_t, user_home_dir_t, user_home_t)
diff -ru /usr/src/se/policy/domains/program/checkpolicy.te ./domains/program/checkpolicy.te
--- /usr/src/se/policy/domains/program/checkpolicy.te	2004-06-03 14:11:05.000000000 +1000
+++ ./domains/program/checkpolicy.te	2004-07-09 11:17:36.000000000 +1000
@@ -23,7 +23,7 @@
 
 # able to create and modify binary policy files
 allow checkpolicy_t policy_config_t:dir rw_dir_perms;
-allow checkpolicy_t policy_config_t:notdevfile_class_set create_file_perms;
+allow checkpolicy_t policy_config_t:file create_file_perms;
 
 ###########################
 # constrain what checkpolicy can use as source files
@@ -31,7 +31,7 @@
 
 # only allow read of policy source files
 allow checkpolicy_t policy_src_t:dir r_dir_perms;
-allow checkpolicy_t policy_src_t:notdevfile_class_set r_file_perms;
+allow checkpolicy_t policy_src_t:{ file lnk_file } r_file_perms;
 
 # allow test policies to be created in src directories
 file_type_auto_trans(checkpolicy_t, policy_src_t, policy_config_t, file)
diff -ru /usr/src/se/policy/domains/program/crond.te ./domains/program/crond.te
--- /usr/src/se/policy/domains/program/crond.te	2004-07-11 17:37:09.000000000 +1000
+++ ./domains/program/crond.te	2004-07-09 07:17:19.000000000 +1000
@@ -61,7 +61,7 @@
 allow crond_t cron_spool_t:file r_file_perms;
 
 # Read /etc/security/default_contexts.
-r_dir_file( crond_t, default_context_t)
+r_dir_file(crond_t, default_context_t)
 
 allow crond_t etc_t:file { getattr read };
 allow crond_t etc_t:lnk_file read;
@@ -147,7 +147,8 @@
 ')
 
 # Stat any file and search any directory for find.
-allow system_crond_t file_type:file_class_set getattr;
+allow system_crond_t file_type:notdevfile_class_set getattr;
+allow system_crond_t device_type:{ chr_file blk_file } getattr;
 allow system_crond_t file_type:dir { read search getattr };
 
 # Create temporary files.
diff -ru /usr/src/se/policy/domains/program/dmesg.te ./domains/program/dmesg.te
--- /usr/src/se/policy/domains/program/dmesg.te	2004-06-17 15:10:38.000000000 +1000
+++ ./domains/program/dmesg.te	2004-07-04 18:17:42.000000000 +1000
@@ -9,7 +9,10 @@
 #
 # dmesg_exec_t is the type of the dmesg executable.
 #
-daemon_base_domain(dmesg)
+# while sysadm_t has the sys_admin capability there is no point in using
+# dmesg_t when run from sysadm_t, so we use nosysadm.
+#
+daemon_base_domain(dmesg, , `nosysadm')
 
 #
 # Rules used for dmesg

--Boundary-00=_mNP8A5nYOIgRlh9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
