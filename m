Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i68BSTrT012184
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 07:28:29 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i68BS75G028617
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 11:28:08 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 45F3B61BD2
	for <selinux@tycho.nsa.gov>; Thu,  8 Jul 2004 21:28:25 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 16874-03 for <selinux@tycho.nsa.gov>;
	Thu, 8 Jul 2004 21:28:24 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id C747861BB4
	for <selinux@tycho.nsa.gov>; Thu,  8 Jul 2004 21:28:24 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 7C005B59B3
	for <selinux@tycho.nsa.gov>; Thu,  8 Jul 2004 21:28:23 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: /halt and /.autofsck
Date: Thu, 8 Jul 2004 21:28:22 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_W/S7AnsAvDA0Wkn"
Message-Id: <200407082128.22954.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_W/S7AnsAvDA0Wkn
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch makes initrc_t use type etc_runtime_t for /halt 
and /.autofsck flag files.

It also removes the cyrus lines which don't belong in initrc.te and which will 
be implemented properly when we solve the postgresql problem.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_W/S7AnsAvDA0Wkn
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /usr/src/se/policy/domains/program/initrc.te ./domains/program/initrc.te
--- /usr/src/se/policy/domains/program/initrc.te	2004-07-08 13:09:33.000000000 +1000
+++ ./domains/program/initrc.te	2004-07-08 21:23:50.000000000 +1000
@@ -90,10 +90,6 @@
 ')
 allow initrc_t self:passwd rootok;
 
-ifdef(`cyrus.te', `
-allow initrc_su_t cyrus_var_lib_t:dir { search };
-')
-
 # read /lib/modules
 allow initrc_t modules_object_t:dir { search read };
 
@@ -209,10 +205,6 @@
 allow initrc_t rhgb_t:unix_stream_socket { read write };
 ')
 
-# Unlink /halt.
-allow initrc_t root_t:dir { search write remove_name };
-allow initrc_t root_t:file { unlink write };
-
 ifdef(`gpm.te', `allow initrc_t gpmctl_t:sock_file setattr;')
 
 allow initrc_t var_spool_t:file rw_file_perms;
@@ -227,6 +219,9 @@
 ifdef(`sound.te', `allow initrc_t sound_file_t:file { setattr write };')
 
 ifdef(`rpm.te', `
+# for /halt /.autofsck and other flag files
+file_type_auto_trans(initrc_t, root_t, etc_runtime_t, file)
+
 # Access /var/lib/rpm.
 allow initrc_t var_lib_rpm_t:dir rw_dir_perms;
 allow initrc_t var_lib_rpm_t:file create_file_perms;
@@ -241,11 +236,6 @@
 allow initrc_t printconf_t:dir r_dir_perms;
 allow initrc_t printconf_t:file r_file_perms;')
 
-# Create and delete /.autofsck
-allow initrc_t root_t:dir { search write add_name };
-allow initrc_t root_t:file { create setattr unlink getattr };
-allow initrc_t default_t:file { unlink getattr };
-
 # Read user home directories.
 allow initrc_t { home_root_t home_type }:dir r_dir_perms;
 allow initrc_t home_type:file r_file_perms;
diff -ru /usr/src/se/policy/file_contexts/program/rpm.fc ./file_contexts/program/rpm.fc
--- /usr/src/se/policy/file_contexts/program/rpm.fc	2004-06-18 10:47:58.000000000 +1000
+++ ./file_contexts/program/rpm.fc	2004-07-08 21:22:42.000000000 +1000
@@ -13,6 +13,7 @@
 /usr/lib(64)?/rpm/rpmk	-- 	system_u:object_r:bin_t
 /usr/lib(64)?/rpm/rpmv	-- 	system_u:object_r:bin_t
 /var/log/rpmpkgs.*	--	system_u:object_r:rpm_log_t
+/var/log/yum.log	--	system_u:object_r:rpm_log_t
 /usr/share/system-config-network(/netconfig)?/[^/]+.py -- system_u:object_r:bin_t
 /etc/sysconfig/networking/profiles/.*/resolv.conf -- system_u:object_r:net_conf_t
 /etc/sysconfig/network-scripts/.*resolv.conf -- system_u:object_r:net_conf_t
@@ -56,3 +55,5 @@
 /sbin/yast2			--	system_u:object_r:rpm_exec_t
 /var/lib/YaST2(/.*)?			system_u:object_r:rpm_var_lib_t
 
+/halt			--	system_u:object_r:etc_runtime_t
+/\.autofsck		--	system_u:object_r:etc_runtime_t

--Boundary-00=_W/S7AnsAvDA0Wkn--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
