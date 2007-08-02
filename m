Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72Jgl19020034
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:42:47 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72JggOD025546
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 19:42:42 GMT
Date: Thu, 2 Aug 2007 15:42:36 -0400
Message-Id: <200708021942.l72JgaaE029018@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: admin_usermanage changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix bug in reading crackdb
Use new audit interfaces
Transition to nscd to reload cache
Configure apache file ~public_html
Write to samba log file when running in domain controller mode

--- nsaserefpolicy/policy/modules/admin/usermanage.if	2007-05-29 14:10:59.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/admin/usermanage.if	2007-08-02 11:02:02.000000000 -0400
@@ -278,5 +278,5 @@
 		type crack_db_t;
 	')
 
-	allow $1 crack_db_t:file read_file_perms;
+	read_files_pattern($1,crack_db_t,crack_db_t)
 ')
--- nsaserefpolicy/policy/modules/admin/usermanage.te	2007-07-25 10:37:43.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/admin/usermanage.te	2007-08-02 11:02:02.000000000 -0400
@@ -191,7 +192,6 @@
 allow groupadd_t self:unix_stream_socket create_stream_socket_perms;
 allow groupadd_t self:unix_dgram_socket sendto;
 allow groupadd_t self:unix_stream_socket connectto;
-allow groupadd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 
 fs_getattr_xattr_fs(groupadd_t)
 fs_search_auto_mountpoints(groupadd_t)
@@ -223,6 +223,7 @@
 # Execute /usr/bin/{passwd,chfn,chsh} and /usr/sbin/{useradd,vipw}.
 corecmd_exec_bin(groupadd_t)
 
+logging_send_audit_msgs(groupadd_t)
 logging_send_syslog_msg(groupadd_t)
 
 miscfiles_read_localization(groupadd_t)
@@ -245,8 +246,13 @@
 ')
 
 optional_policy(`
+	nscd_domtrans(groupadd_t)
+')
+
+optional_policy(`
 	rpm_use_fds(groupadd_t)
 	rpm_rw_pipes(groupadd_t)
+	rpm_dontaudit_rw_tmp_files(groupadd_t)
 ')
 
 ########################################
@@ -254,7 +260,7 @@
 # Passwd local policy
 #
 
-allow passwd_t self:capability { chown dac_override fsetid setuid setgid sys_resource audit_control audit_write };
+allow passwd_t self:capability { chown dac_override fsetid setuid setgid sys_resource };
 allow passwd_t self:process ~{ ptrace setcurrent setexec setfscreate setrlimit execmem execstack execheap };
 allow passwd_t self:process { setrlimit setfscreate };
 allow passwd_t self:fd use;
@@ -264,7 +270,6 @@
 allow passwd_t self:unix_stream_socket create_stream_socket_perms;
 allow passwd_t self:unix_dgram_socket sendto;
 allow passwd_t self:unix_stream_socket connectto;
-allow passwd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 allow passwd_t self:shm create_shm_perms;
 allow passwd_t self:sem create_sem_perms;
 allow passwd_t self:msgq create_msgq_perms;
@@ -316,6 +321,7 @@
 libs_use_ld_so(passwd_t)
 libs_use_shared_libs(passwd_t)
 
+logging_send_audit_msgs(passwd_t)
 logging_send_syslog_msg(passwd_t)
 
 miscfiles_read_localization(passwd_t)
@@ -336,6 +342,7 @@
 
 optional_policy(`
 	nscd_socket_use(passwd_t)
+	nscd_domtrans(passwd_t)
 ')
 
 ########################################
@@ -426,6 +433,7 @@
 
 optional_policy(`
 	nscd_socket_use(sysadm_passwd_t)
+	nscd_domtrans(sysadm_passwd_t)
 ')
 
 ########################################
@@ -433,7 +441,7 @@
 # Useradd local policy
 #
 
-allow useradd_t self:capability { dac_override chown kill fowner fsetid setuid sys_resource audit_write };
+allow useradd_t self:capability { dac_override chown kill fowner fsetid setuid sys_resource };
 dontaudit useradd_t self:capability sys_tty_config;
 allow useradd_t self:process ~{ ptrace setcurrent setexec setfscreate setrlimit execmem execstack execheap };
 allow useradd_t self:process setfscreate;
@@ -447,7 +455,6 @@
 allow useradd_t self:unix_stream_socket create_stream_socket_perms;
 allow useradd_t self:unix_dgram_socket sendto;
 allow useradd_t self:unix_stream_socket connectto;
-allow useradd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 
 # for getting the number of groups
 kernel_read_kernel_sysctls(useradd_t)
@@ -492,6 +499,7 @@
 libs_use_ld_so(useradd_t)
 libs_use_shared_libs(useradd_t)
 
+logging_send_audit_msgs(useradd_t)
 logging_send_syslog_msg(useradd_t)
 
 miscfiles_read_localization(useradd_t)
@@ -514,11 +525,26 @@
 mta_manage_spool(useradd_t)
 
 optional_policy(`
+	apache_manage_all_content(useradd_t)
+')
+
+optional_policy(`
 	dpkg_use_fds(useradd_t)
 	dpkg_rw_pipes(useradd_t)
 ')
 
 optional_policy(`
+	nscd_domtrans(useradd_t)
+')
+
+optional_policy(`
+	tunable_policy(`samba_domain_controller',`
+		samba_append_log(useradd_t)
+	')
+')
+
+optional_policy(`
 	rpm_use_fds(useradd_t)
 	rpm_rw_pipes(useradd_t)
+	rpm_dontaudit_rw_tmp_files(useradd_t)
 ')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
