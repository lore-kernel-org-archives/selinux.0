Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6454trT020584
	for <selinux@tycho.nsa.gov>; Sun, 4 Jul 2004 01:04:56 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6454aD3014033
	for <selinux@tycho.nsa.gov>; Sun, 4 Jul 2004 05:04:37 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8592B61C14
	for <selinux@tycho.nsa.gov>; Sun,  4 Jul 2004 15:04:52 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 29955-01 for <selinux@tycho.nsa.gov>;
	Sun, 4 Jul 2004 15:04:52 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 84BEF61BD7
	for <selinux@tycho.nsa.gov>; Sun,  4 Jul 2004 15:04:51 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 5EB94B59A1
	for <selinux@tycho.nsa.gov>; Sun,  4 Jul 2004 15:04:49 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: policy patch
Date: Sun, 4 Jul 2004 15:04:48 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_w/45At4AlZOzKDG"
Message-Id: <200407041504.48924.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_w/45At4AlZOzKDG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch fixes a problem with LVM on Fedora, some annoying audit 
messages from rpm, and has some of the stuff that's needed for Postgresql (NB 
it's not enough to make Postgresql fully functional but it's a definite 
improvement over what's currently there so it's worth having).

Steve, please put this into Sourceforge.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_w/45At4AlZOzKDG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru policy-1.14/domains/program/unused/lvm.te selinux-policy-default-1.14/domains/program/unused/lvm.te
--- policy-1.14/domains/program/unused/lvm.te	2004-06-24 22:48:00.000000000 +1000
+++ selinux-policy-default-1.14/domains/program/unused/lvm.te	2004-07-02 12:59:06.000000000 +1000
@@ -93,6 +93,7 @@
 dontaudit lvm_t initctl_t:fifo_file getattr;
 dontaudit lvm_t sbin_t:file getattr;
 allow lvm_t lvm_control_t:chr_file rw_file_perms;
+allow initrc_t lvm_control_t:chr_file unlink;
 dontaudit lvm_t var_run_t:dir getattr;
 
 allow lvm_t tmpfs_t:dir getattr;
diff -ru policy-1.14/domains/program/unused/rpm.te selinux-policy-default-1.14/domains/program/unused/rpm.te
--- policy-1.14/domains/program/unused/rpm.te	2004-06-17 23:33:14.000000000 +1000
+++ selinux-policy-default-1.14/domains/program/unused/rpm.te	2004-07-02 00:50:38.000000000 +1000
@@ -93,6 +93,8 @@
 allow rpm_t sysfs_t:filesystem getattr;
 allow rpm_t tmpfs_t:filesystem getattr;
 dontaudit rpm_t domain:{ socket unix_dgram_socket udp_socket unix_stream_socket tcp_socket fifo_file rawip_socket packet_socket } getattr;
+allow rpm_t fs_type:dir getattr;
+allow rpm_t fs_type:filesystem getattr;
 
 # allow compiling and loading new policy
 create_dir_file(rpm_t, { policy_src_t policy_config_t })
diff -ru policy-1.14/file_contexts/program/postgresql.fc selinux-policy-default-1.14/file_contexts/program/postgresql.fc
--- policy-1.14/file_contexts/program/postgresql.fc	2004-06-24 22:48:00.000000000 +1000
+++ selinux-policy-default-1.14/file_contexts/program/postgresql.fc	2004-07-03 00:18:45.000000000 +1000
@@ -1,5 +1,18 @@
 # postgresql - ldap server
 /usr/lib(64)?/postgresql/bin/.* --	system_u:object_r:postgresql_exec_t
+/usr/bin/postgres	--	system_u:object_r:postgresql_exec_t
+/usr/bin/pg_dump	--	system_u:object_r:postgresql_exec_t
+/usr/bin/pg_dumpall	--	system_u:object_r:postgresql_exec_t
+/usr/bin/pg_resetxlog	--	system_u:object_r:postgresql_exec_t
+/etc/rc.d/init.d/postgresql --	system_u:object_r:postgresql_exec_t
+
+# not sure whether the following binaries need labelling
+/usr/bin/createlang	--	system_u:object_r:postgresql_exec_t
+/usr/bin/droplang	--	system_u:object_r:postgresql_exec_t
+/usr/bin/pg_encoding	--	system_u:object_r:postgresql_exec_t
+/usr/bin/pg_id		--	system_u:object_r:postgresql_exec_t
+/usr/bin/pg_restore	--	system_u:object_r:postgresql_exec_t
+
 /var/lib/postgres(/.*)?		system_u:object_r:postgresql_db_t
 /var/lib/pgsql(/.*)?		system_u:object_r:postgresql_db_t
 /var/run/postgresql(/.*)?	system_u:object_r:postgresql_var_run_t

--Boundary-00=_w/45At4AlZOzKDG--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
