Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6B7xUrT026674
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 03:59:30 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6B7x7NZ003613
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 07:59:08 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 835E261C9D
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 17:59:26 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 16597-06 for <selinux@tycho.nsa.gov>;
	Sun, 11 Jul 2004 17:59:26 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1304F61BD2
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 17:59:26 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 9C9A7B5A98
	for <selinux@tycho.nsa.gov>; Sun, 11 Jul 2004 17:59:23 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: initrc.te
Date: Sun, 11 Jul 2004 17:59:23 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bNP8AngdbSAQv7q"
Message-Id: <200407111759.23107.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_bNP8AngdbSAQv7q
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch moves all the Red Hat specific stuff to one place, causes files the 
administrator creates under the root directory to have type etc_runtime_t 
(for /halt) and does not permit stat'ing device nodes of types that are used 
for files.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_bNP8AngdbSAQv7q
Content-Type: text/x-diff;
  charset="us-ascii";
  name="initrc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="initrc.diff"

diff -ru /usr/src/se/policy/domains/program/initrc.te ./domains/program/initrc.te
--- /usr/src/se/policy/domains/program/initrc.te	2004-07-11 17:37:09.000000000 +1000
+++ ./domains/program/initrc.te	2004-07-11 17:17:07.000000000 +1000
@@ -176,8 +176,8 @@
 allow initrc_t device_t:lnk_file read;
 
 # Stat any file.
-allow initrc_t file_type:file_class_set getattr;
-allow initrc_t file_type:dir { search getattr };
+allow initrc_t file_type:notdevfile_class_set getattr;
+allow initrc_t file_type:dir { search getattr };
 
 # Read and write console and ttys.
 allow initrc_t devtty_t:chr_file rw_file_perms;
@@ -195,6 +195,20 @@
 # Redhat systems typically create this file at boot time.
 allow initrc_t boot_t:lnk_file rw_file_perms;
 file_type_auto_trans(initrc_t, boot_t, boot_runtime_t, file)
+
+#
+# readahead asks for these
+#
+allow initrc_t etc_aliases_t:file { getattr read };
+allow initrc_t system_cron_spool_t:file { getattr read };
+allow initrc_t var_lib_nfs_t:file { getattr read };
+
+# for /halt /.autofsck and other flag files
+file_type_auto_trans({ initrc_t sysadm_t }, root_t, etc_runtime_t, file)
+
+# Access /var/lib/rpm.
+allow initrc_t var_lib_rpm_t:dir rw_dir_perms;
+allow initrc_t var_lib_rpm_t:file create_file_perms;
 ')
 
 allow initrc_t system_map_t:{ file lnk_file } r_file_perms;
@@ -218,15 +232,6 @@
 allow initrc_t sound_device_t:chr_file { setattr ioctl read write };
 ifdef(`sound.te', `allow initrc_t sound_file_t:file { setattr write };')
 
-ifdef(`rpm.te', `
-# for /halt /.autofsck and other flag files
-file_type_auto_trans(initrc_t, root_t, etc_runtime_t, file)
-
-# Access /var/lib/rpm.
-allow initrc_t var_lib_rpm_t:dir rw_dir_perms;
-allow initrc_t var_lib_rpm_t:file create_file_perms;
-')
-
 ifdef(`apmd.te',
 `# Access /dev/apm_bios.
 allow initrc_t apm_bios_t:chr_file { setattr getattr };')
@@ -287,7 +292,6 @@
 ')
 
 # for lsof in shutdown scripts
-allow initrc_t security_t:dir getattr;
 allow initrc_t krb5_conf_t:file read;
 dontaudit initrc_t krb5_conf_t:file write;
 #
@@ -303,13 +307,7 @@
 unconfined_domain(initrc_t) 
 ')
 #
-# readahead asks for these
-#
-allow initrc_t etc_aliases_t:file { getattr read };
-allow initrc_t system_cron_spool_t:file { getattr read };
-allow initrc_t var_lib_nfs_t:file { getattr read };
-#
 # initrc script does a cat /selinux/enforce
 #
-allow initrc_t security_t:dir { search };
+allow initrc_t security_t:dir { getattr search };
 allow initrc_t security_t:file { getattr read };

--Boundary-00=_bNP8AngdbSAQv7q--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
