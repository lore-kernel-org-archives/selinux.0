Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBA5YPMA026076
	for <selinux@tycho.nsa.gov>; Sat, 10 Dec 2005 00:34:25 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBA5QFno006539
	for <selinux@tycho.nsa.gov>; Sat, 10 Dec 2005 05:26:15 GMT
Message-ID: <439A671E.8040804@redhat.com>
Date: Sat, 10 Dec 2005 00:26:54 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Updated policy
Content-Type: multipart/mixed;
 boundary="------------020300070602030803070606"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020300070602030803070606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added booleans to turn on httpd connecting to mysql/postgres as well as 
relay.

nis_signal_ypbind requires you to be able to read pidfile.

mount command wants access to tty. needs to be able to search rpc_pipefs 
in Fedora.


-- 



--------------020300070602030803070606
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/Makefile serefpolicy-2.1.2/Makefile
--- nsaserefpolicy/Makefile	2005-12-09 23:35:04.000000000 -0500
+++ serefpolicy-2.1.2/Makefile	2005-12-10 00:10:25.000000000 -0500
@@ -92,7 +92,7 @@
 
 # enable MLS if requested.
 ifneq ($(findstring -mls,$(TYPE)),)
-	override M4PARAM += -D enable_mls
+	override M4PARAM += -D enable_mls -D separate_secadm
 	override CHECKPOLICY += -M
 	override CHECKMODULE += -M
 endif
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/global_tunables serefpolicy-2.1.2/policy/global_tunables
--- nsaserefpolicy/policy/global_tunables	2005-12-02 17:53:25.000000000 -0500
+++ serefpolicy-2.1.2/policy/global_tunables	2005-12-10 00:14:31.000000000 -0500
@@ -68,6 +68,12 @@
 ## Allow http daemon to tcp connect 
 gen_tunable(httpd_can_network_connect,false)
 
+## allow httpd to connect to mysql/posgresql 
+gen_tunable(httpd_can_network_connect_db, false)
+
+## allow httpd to connect to mysql/posgresql 
+gen_tunable(httpd_can_network_relay, false)
+
 ## Allow httpd cgi support
 gen_tunable(httpd_enable_cgi,false)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.te serefpolicy-2.1.2/policy/modules/services/apache.te
--- nsaserefpolicy/policy/modules/services/apache.te	2005-12-09 23:35:05.000000000 -0500
+++ serefpolicy-2.1.2/policy/modules/services/apache.te	2005-12-10 00:10:25.000000000 -0500
@@ -226,14 +226,6 @@
 corenet_udp_bind_all_nodes(httpd_t)
 corenet_tcp_bind_http_port(httpd_t)
 corenet_tcp_bind_http_cache_port(httpd_t)
-# allow httpd to connect to mysql/posgresql 
-corenet_tcp_connect_postgresql_port(httpd_t)
-corenet_tcp_connect_mysqld_port(httpd_t)
-# allow httpd to work as a relay
-corenet_tcp_connect_gopher_port(httpd_t)
-corenet_tcp_connect_ftp_port(httpd_t)
-corenet_tcp_connect_http_port(httpd_t)
-corenet_tcp_connect_http_cache_port(httpd_t)
 
 dev_read_sysfs(httpd_t)
 dev_read_rand(httpd_t)
@@ -304,6 +296,21 @@
 	miscfiles_manage_public_files(httpd_t)
 ') 
 
+# allow httpd to connect to mysql/posgresql 
+tunable_policy(`httpd_can_network_connect_db',`
+	corenet_tcp_connect_postgresql_port(httpd_t)
+	corenet_tcp_connect_mysqld_port(httpd_t)
+')
+
+# allow httpd to connect to mysql/posgresql 
+tunable_policy(`httpd_can_network_relay',`
+	# allow httpd to work as a relay
+	corenet_tcp_connect_gopher_port(httpd_t)
+	corenet_tcp_connect_ftp_port(httpd_t)
+	corenet_tcp_connect_http_port(httpd_t)
+	corenet_tcp_connect_http_cache_port(httpd_t)
+')
+
 tunable_policy(`httpd_can_network_connect',`
 	allow httpd_t self:tcp_socket create_socket_perms;
 	allow httpd_t self:udp_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/nis.if serefpolicy-2.1.2/policy/modules/services/nis.if
--- nsaserefpolicy/policy/modules/services/nis.if	2005-12-06 19:49:50.000000000 -0500
+++ serefpolicy-2.1.2/policy/modules/services/nis.if	2005-12-10 00:10:25.000000000 -0500
@@ -150,8 +150,10 @@
 interface(`nis_signal_ypbind',`
 	gen_require(`
 		type ypbind_t;
+		type ypbind_var_run_t;
 	')
 
+	allow $1 ypbind_var_run_t:file read;
 	allow $1 ypbind_t:process signal;
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.1.2/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2005-12-09 23:35:08.000000000 -0500
+++ serefpolicy-2.1.2/policy/modules/system/mount.te	2005-12-10 00:10:25.000000000 -0500
@@ -47,6 +47,7 @@
 fs_use_tmpfs_chr_dev(mount_t)
 
 term_use_console(mount_t)
+term_use_generic_pty(mount_t)
 
 # required for mount.smbfs
 corecmd_exec_sbin(mount_t)
@@ -94,9 +95,7 @@
 
 optional_policy(`portmap',`
 	# for nfs
-	#allow portmap_t mount_t:udp_socket { sendto recvfrom };
-	#allow mount_t portmap_t:udp_socket { sendto recvfrom };
-	#allow mount_t rpc_pipefs_t:dir search;
+	allow mount_t rpc_pipefs_t:dir search;
 	corenet_tcp_sendrecv_all_if(mount_t)
 	corenet_raw_sendrecv_all_if(mount_t)
 	corenet_udp_sendrecv_all_if(mount_t)

--------------020300070602030803070606--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
