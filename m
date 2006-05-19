Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4JEenwK006806
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 10:40:49 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4JEejk7021842
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 14:40:46 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>
Subject: fc5 policy patch
Date: Sat, 20 May 2006 00:05:07 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_YCdbEx5jJBwLKAp"
Message-Id: <200605200005.12042.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_YCdbEx5jJBwLKAp
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached is a patch against policy 2.2.38-1.fc5, the most significant thing it 
does is to get Amavis and Clamav working.

I notice that Dan has just sent a patch against the rawhide policy to the list 
with a slightly different set of Amavis changes.  Without reviewing them 
carefully it seems to me that Dan's patch won't make a default fedora-extras 
anti-virus system work.  Some of the things that are done with the 
fedora-extras packages aren't optimal in regard to SE Linux (such as the 
locations of some of the PID files and socket files).

My patch makes the anti-virus setup basically work.  Due to the complexity of 
the system there is a possibility of corner cases that I've missed, but the 
only way we will discover that is to get this policy released and have people 
try it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_YCdbEx5jJBwLKAp
Content-Type: text/x-diff;
  charset="us-ascii";
  name="rjc-fc5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rjc-fc5.patch"

diff -ru serefpolicy-2.2.38.orig/policy/modules/services/amavis.fc serefpolicy-2.2.38/policy/modules/services/amavis.fc
--- serefpolicy-2.2.38.orig/policy/modules/services/amavis.fc	2006-05-08 23:54:01.000000000 +1000
+++ serefpolicy-2.2.38/policy/modules/services/amavis.fc	2006-05-19 23:36:05.000000000 +1000
@@ -7,5 +7,7 @@
 /var/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_lib_t,s0)
 /var/lib/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_lib_t,s0)
 /var/log/amavisd\.log		--	gen_context(system_u:object_r:amavis_var_log_t,s0)
-/var/run/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_run_t,s0)
+/var/run/amavis(d)?/amavisd.lock --	gen_context(system_u:object_r:amavis_var_run_t,s0)
+/var/spool/amavisd/amavisd.sock -s	gen_context(system_u:object_r:amavis_var_run_t,s0)
 /var/virusmails(/.*)?			gen_context(system_u:object_r:amavis_quarantine_t,s0)
+/var/spool/amavisd(/.*)?		gen_context(system_u:object_r:amavis_spool_t,s0)
diff -ru serefpolicy-2.2.38.orig/policy/modules/services/amavis.if serefpolicy-2.2.38/policy/modules/services/amavis.if
--- serefpolicy-2.2.38.orig/policy/modules/services/amavis.if	2006-05-08 23:54:01.000000000 +1000
+++ serefpolicy-2.2.38/policy/modules/services/amavis.if	2006-05-19 23:37:42.000000000 +1000
@@ -47,6 +47,49 @@
 
 ########################################
 ## <summary>
+##	Create socket files under the amavis spool
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <param name="socket_type">
+##	<summary>
+##	Type for socket file
+##	</summary>
+## </param>
+#
+interface(`amavis_spool_create_socket',`
+	gen_require(`
+		type amavis_spool_t;
+	')
+
+	allow $1 amavis_spool_t:dir rw_dir_perms;
+	allow $1 $2:sock_file manage_file_perms;
+	type_transition $1 amavis_spool_t:sock_file $2;
+')
+
+########################################
+## <summary>
+##	Read amavis spool files
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`amavis_read_spool_file',`
+	gen_require(`
+		type amavis_spool_t;
+	')
+
+	allow $1 amavis_spool_t:file { getattr read };
+')
+
+########################################
+## <summary>
 ##	Read amavis lib files.
 ## </summary>
 ## <param name="domain">
diff -ru serefpolicy-2.2.38.orig/policy/modules/services/amavis.te serefpolicy-2.2.38/policy/modules/services/amavis.te
--- serefpolicy-2.2.38.orig/policy/modules/services/amavis.te	2006-05-08 23:54:02.000000000 +1000
+++ serefpolicy-2.2.38/policy/modules/services/amavis.te	2006-05-19 22:38:35.000000000 +1000
@@ -31,6 +31,9 @@
 type amavis_tmp_t;
 files_tmp_file(amavis_tmp_t)
 
+type amavis_spool_t;
+files_type(amavis_spool_t)
+
 # virus quarantine
 type amavis_quarantine_t;
 files_type(amavis_quarantine_t)
@@ -70,6 +73,12 @@
 files_var_filetrans(amavis_t,amavis_var_lib_t,{ file dir sock_file })
 files_var_lib_filetrans(amavis_t,amavis_var_lib_t,file)
 
+# Spool Files
+files_search_spool(amavis_t)
+allow amavis_t amavis_spool_t:dir manage_dir_perms;
+allow amavis_t amavis_spool_t:file manage_file_perms;
+type_transition amavis_t amavis_spool_t:sock_file amavis_var_run_t;
+
 # log files
 allow amavis_t amavis_var_log_t:file create_file_perms;
 allow amavis_t amavis_var_log_t:sock_file create_file_perms;
@@ -85,6 +94,11 @@
 # amavis tries to access /proc/self/stat, /etc/shadow and /root - perl...
 kernel_dontaudit_list_proc(amavis_t)
 
+# dontaudit terminal access
+ifdef(`targeted_policy',`
+	term_dontaudit_use_generic_ptys(amavis_t)
+')
+
 # find perl
 corecmd_exec_bin(amavis_t)
 corecmd_search_sbin(amavis_t)
diff -ru serefpolicy-2.2.38.orig/policy/modules/services/clamav.fc serefpolicy-2.2.38/policy/modules/services/clamav.fc
--- serefpolicy-2.2.38.orig/policy/modules/services/clamav.fc	2006-05-19 20:04:12.000000000 +1000
+++ serefpolicy-2.2.38/policy/modules/services/clamav.fc	2006-05-19 22:51:51.000000000 +1000
@@ -8,6 +8,7 @@
 
 /var/run/clamav(/.*)?			gen_context(system_u:object_r:clamd_var_run_t,s0)
 /var/run/clamav/clamd.ctl	-s	gen_context(system_u:object_r:clamd_sock_t,s0)
+/var/run/amavis(d)?/clamd.pid	--	gen_context(system_u:object_r:clamd_var_run_t,s0)
 /var/lib/clamav(/.*)?			gen_context(system_u:object_r:clamd_var_lib_t,s0)
 /var/log/clamav			-d	gen_context(system_u:object_r:clamd_var_log_t,s0)
 /var/log/clamav/clamav.*	--	gen_context(system_u:object_r:clamd_var_log_t,s0)
diff -ru serefpolicy-2.2.38.orig/policy/modules/services/clamav.te serefpolicy-2.2.38/policy/modules/services/clamav.te
--- serefpolicy-2.2.38.orig/policy/modules/services/clamav.te	2006-05-19 20:04:12.000000000 +1000
+++ serefpolicy-2.2.38/policy/modules/services/clamav.te	2006-05-19 23:03:22.000000000 +1000
@@ -52,6 +52,7 @@
 # clamd local policy
 #
 
+logging_send_syslog_msg(clamd_t)
 allow clamd_t self:capability { kill setgid setuid dac_override };
 allow clamd_t self:fifo_file rw_file_perms;
 allow clamd_t self:unix_stream_socket create_stream_socket_perms;
@@ -63,6 +64,13 @@
 allow clamd_t clamd_etc_t:file r_file_perms;
 allow clamd_t clamd_etc_t:lnk_file { getattr read };
 
+# Spool Files
+files_search_spool(clamd_t)
+optional_policy(`
+	amavis_spool_create_socket(clamd_t, clamd_var_run_t)
+	amavis_read_spool_file(clamd_t)
+')
+
 # socket file
 allow clamd_t clamd_sock_t:file manage_file_perms;
 allow clamd_t clamd_sock_t:sock_file manage_file_perms;
@@ -95,6 +103,11 @@
 
 kernel_dontaudit_list_proc(clamd_t)
 
+# dontaudit terminal access
+ifdef(`targeted_policy',`
+	term_dontaudit_use_generic_ptys(clamd_t)
+')
+
 corenet_tcp_sendrecv_all_if(clamd_t)
 corenet_tcp_sendrecv_all_nodes(clamd_t)
 corenet_tcp_sendrecv_all_ports(clamd_t)
diff -ru serefpolicy-2.2.38.orig/policy/modules/services/dovecot.te serefpolicy-2.2.38/policy/modules/services/dovecot.te
--- serefpolicy-2.2.38.orig/policy/modules/services/dovecot.te	2006-05-08 23:54:01.000000000 +1000
+++ serefpolicy-2.2.38/policy/modules/services/dovecot.te	2006-05-19 20:07:03.000000000 +1000
@@ -80,6 +80,7 @@
 corenet_tcp_bind_pop_port(dovecot_t)
 corenet_tcp_connect_all_ports(dovecot_t)
 corenet_tcp_connect_postgresql_port(dovecot_t)
+allow dovecot_t self:netlink_route_socket r_netlink_socket_perms;
 
 dev_read_sysfs(dovecot_t)
 dev_read_urand(dovecot_t)
diff -ru serefpolicy-2.2.38.orig/policy/modules/system/selinuxutil.te serefpolicy-2.2.38/policy/modules/system/selinuxutil.te
--- serefpolicy-2.2.38.orig/policy/modules/system/selinuxutil.te	2006-05-19 20:04:12.000000000 +1000
+++ serefpolicy-2.2.38/policy/modules/system/selinuxutil.te	2006-05-19 21:37:07.000000000 +1000
@@ -546,6 +546,8 @@
 files_read_usr_files(semanage_t)
 files_list_pids(semanage_t)
 
+miscfiles_read_localization(semanage_t)
+
 mls_file_write_down(semanage_t)
 mls_rangetrans_target(semanage_t)
 mls_file_read_up(semanage_t)
diff -ru serefpolicy-2.2.38.orig/policy/support/misc_macros.spt serefpolicy-2.2.38/policy/support/misc_macros.spt
--- serefpolicy-2.2.38.orig/policy/support/misc_macros.spt	2006-05-08 23:54:02.000000000 +1000
+++ serefpolicy-2.2.38/policy/support/misc_macros.spt	2006-05-19 20:15:07.000000000 +1000
@@ -37,7 +37,7 @@
 #
 # gen_context(context,mls_sensitivity,[mcs_categories])
 #
-define(`gen_context',`$1`'ifdef(`enable_mls',`:$2')`'ifdef(`enable_mcs',`:s0`'ifelse(`$3',,,`:$3')')') dnl
+define(`gen_context',`$1`'ifdef(`enable_mls',`:$2')`'ifdef(`enable_mcs',`:s0`'ifelse(`$3',,,`:$3')')')dnl
 
 ########################################
 #

--Boundary-00=_YCdbEx5jJBwLKAp--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
