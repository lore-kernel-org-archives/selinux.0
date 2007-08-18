Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7I6SDww012220
	for <selinux@tycho.nsa.gov>; Sat, 18 Aug 2007 02:28:13 -0400
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7I6SC3E016482
	for <selinux@tycho.nsa.gov>; Sat, 18 Aug 2007 06:28:12 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Message-Id: <415EF526-2C14-4AF6-91A2-7AEC4692823C@sf-net.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-4-805374790
Cc: SELinux List <selinux@tycho.nsa.gov>
Subject: [refpolicy] apt and dpkg changes
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Date: Sat, 18 Aug 2007 08:28:08 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-4-805374790
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

To get a working apt/aptiude/dpkg environment under debian the  
following changes are needed


--Apple-Mail-4-805374790
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=apt.fc.patch
Content-Disposition: attachment;
	filename=apt.fc.patch

--- /usr/src/refpolicy-20070417/policy/modules/admin/apt.fc	2006-07-12 22:32:27.000000000 +0200
+++ policy/modules/admin/apt.fc	2007-06-17 09:22:44.000000000 +0200
@@ -11,3 +11,14 @@
 # package list repository
 /var/lib/apt(/.*)?			gen_context(system_u:object_r:apt_var_lib_t,s0)
 /var/lib/aptitude(/.*)?		gen_context(system_u:object_r:apt_var_lib_t,s0)
+
+# aptitude logfile
+/var/log/aptitude		--	gen_context(system_u:object_r:apt_log_t,s0)
+
+# lock file
+/var/lock/aptitude		--	gen_context(system_u:object_r:apt_lock_t,s0)
+
+# /home
+ifdef(`strict_policy',`
+HOME_DIR/\.aptitude(/.*)?		gen_context(system_u:object_r:ROLE_home_apt_t,s0)
+')

--Apple-Mail-4-805374790
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=apt.if.patch
Content-Disposition: attachment;
	filename=apt.if.patch

--- /usr/src/refpolicy-20061212/policy/modules/admin/apt.if	2006-12-12 21:08:08.000000000 +0100
+++ policy/modules/admin/apt.if	2007-03-03 23:39:11.000000000 +0100
@@ -1,5 +1,67 @@
 ## <summary>APT advanced package toll.</summary>
 
+#######################################
+## <summary>
+##      The per role template for aptitude.
+## </summary>
+## <desc>
+##      <p>
+##      This template creates the types and rules for
+##	aptitude. This protects the configuration files
+##	for aptitude.
+##      </p>
+##      <p>
+##      This is invoked automatically for each user and
+##      generally does not need to be invoked directly
+##      by policy writers.
+##      </p>
+## </desc>
+## <param name="userdomain_prefix">
+##      <summary>
+##      The prefix of the user domain (e.g., user
+##      is the prefix for user_t).
+##      </summary>
+## </param>
+## <param name="userdomain">
+##      <summary>
+##      The user domain.
+##      </summary>
+## </param>
+## <param name="role">
+##      <summary>
+##      The role associated with the user.
+##      </summary>
+## </param>
+#
+template(`apt_per_role_template',`
+        gen_require(`
+                type apt_t, apt_exec_t, $1_home_dir_t;
+        ')
+
+	########################################
+	#
+	# Declarations
+	#
+
+        type $1_apt_t;
+        domain_type($1_apt_t)
+        domain_entry_file($1_apt_t,apt_exec_t)
+	role $3 types $1_apt_t;
+
+	type $1_home_apt_t;
+	files_type($1_home_apt_t)
+
+	########################################
+	#
+	# APT local policy
+	#
+
+	manage_dirs_pattern(apt_t,$1_home_apt_t,$1_home_apt_t)
+	manage_files_pattern(apt_t,$1_home_apt_t,$1_home_apt_t)
+
+	allow apt_t $1_home_dir_t:dir search;
+')
+
 ########################################
 ## <summary>
 ##	Execute apt programs in the apt domain.

--Apple-Mail-4-805374790
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=apt.te.patch
Content-Disposition: attachment;
	filename=apt.te.patch

--- /usr/src/refpolicy-20070629/policy/modules/admin/apt.te	2007-06-29 16:48:13.000000000 +0200
+++ policy/modules/admin/apt.te	2007-08-16 17:46:35.000000000 +0200
@@ -1,6 +1,10 @@
 
 policy_module(apt,1.2.0)
 
+gen_require(`
+	type var_log_t;
+')
+
 ########################################
 #
 # Declarations
@@ -26,6 +30,14 @@
 type apt_var_cache_t alias var_cache_apt_t;
 files_type(apt_var_cache_t)
 
+# lock file
+type apt_lock_t;
+files_lock_file(apt_lock_t)
+
+# logfile
+type apt_log_t;
+logging_log_file(apt_log_t)
+
 ########################################
 #
 # apt Local policy
@@ -41,11 +53,20 @@
 allow apt_t self:unix_stream_socket connectto;
 allow apt_t self:udp_socket { connect create_socket_perms };
 allow apt_t self:tcp_socket create_stream_socket_perms;
+allow apt_t self:netlink_route_socket { create_netlink_socket_perms rw_netlink_socket_perms };
 allow apt_t self:shm create_shm_perms;
 allow apt_t self:sem create_sem_perms;
 allow apt_t self:msgq create_msgq_perms;
 allow apt_t self:msg { send receive };
 
+# lock file access
+allow apt_t apt_lock_t:file { create_file_perms lock rw_file_perms };
+files_lock_filetrans(apt_t,apt_lock_t,file)
+
+# append to logfile
+allow apt_t var_log_t:dir search;
+append_files_pattern(apt_t,apt_log_t,apt_log_t)
+
 # Access /var/cache/apt files
 manage_files_pattern(apt_t,apt_var_cache_t,apt_var_cache_t)
 files_var_filetrans(apt_t,apt_var_cache_t,dir)
@@ -100,15 +121,21 @@
 term_list_ptys(apt_t)
 term_use_all_terms(apt_t)
 
+init_domtrans_script(apt_t)
+
 libs_use_ld_so(apt_t)
 libs_use_shared_libs(apt_t)
 libs_exec_ld_so(apt_t)
 libs_exec_lib_files(apt_t)
+libs_domtrans_ldconfig(apt_t)
 
 logging_send_syslog_msg(apt_t)
 
 miscfiles_read_localization(apt_t)
 
+modutils_domtrans_depmod(apt_t)
+modutils_domtrans_insmod(apt_t)
+
 seutil_use_newrole_fds(apt_t)
 
 sysnet_read_config(apt_t)
@@ -137,3 +164,9 @@
 	rpm_read_db(apt_t)
 	rpm_domtrans(apt_t)
 ')
+
+optional_policy(`
+	usermanage_domtrans_groupadd(apt_t)
+	usermanage_domtrans_useradd(apt_t)
+')
+

--Apple-Mail-4-805374790
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=domain.if.patch
Content-Disposition: attachment;
	filename=domain.if.patch

--- /usr/src/refpolicy-20070629/policy/modules/kernel/domain.if	2007-06-19 15:02:26.000000000 +0200
+++ /etc/selinux/my-refpolicy-strict/src/policy/policy/modules/kernel/domain.if	2007-08-14 17:13:09.000000000 +0200
@@ -61,6 +61,12 @@
 	optional_policy(`
 		rpm_use_fds($1)
 		rpm_read_pipes($1)
+
+		apt_use_fds($1)
+		apt_read_pipes($1)
+
+		dpkg_use_fds($1)
+		dpkg_read_pipes($1)
 	')
 
 	optional_policy(`

--Apple-Mail-4-805374790
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=dpkg.te.patch
Content-Disposition: attachment;
	filename=dpkg.te.patch

--- /usr/src/refpolicy-20070629/policy/modules/admin/dpkg.te	2007-06-29 16:48:13.000000000 +0200
+++ policy/modules/admin/dpkg.te	2007-08-15 14:42:07.000000000 +0200
@@ -337,3 +337,9 @@
 	usermanage_domtrans_groupadd(dpkg_script_t)
 	usermanage_domtrans_useradd(dpkg_script_t)
 ')
+
+optional_policy(`
+	# apt interaction
+	apt_use_fds(dpkg_script_t)
+	apt_rw_pipes(dpkg_script_t)
+')

--Apple-Mail-4-805374790--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
