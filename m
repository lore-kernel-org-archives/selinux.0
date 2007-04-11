Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3BLGcoG015966
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 17:16:38 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3BLGbT2024856
	for <selinux@tycho.nsa.gov>; Wed, 11 Apr 2007 21:16:37 GMT
Message-ID: <461D5033.3000308@redhat.com>
Date: Wed, 11 Apr 2007 17:16:35 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Application diff
Content-Type: multipart/mixed;
 boundary="------------090702030207000802070602"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090702030207000802070602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch defines applications that are executed by users.

So that we can handle FDs properly. 



--------------090702030207000802070602
Content-Type: text/x-patch;
 name="application.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="application.diff"

--- nsaserefpolicy/policy/modules/admin/acct.te	2007-03-26 10:39:08.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/admin/acct.te	2007-04-11 16:04:22.000000000 -0400
@@ -9,6 +9,7 @@
 type acct_t;
 type acct_exec_t;
 init_system_domain(acct_t,acct_exec_t)
+application_executable_file(acct_exec_t)
 
 type acct_data_t;
 logging_log_file(acct_data_t)
--- nsaserefpolicy/policy/modules/admin/consoletype.te	2007-02-19 11:32:54.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/admin/consoletype.te	2007-04-11 16:04:22.000000000 -0400
@@ -16,6 +21,7 @@
 ifdef(`targeted_policy',`',`
 	init_system_domain(consoletype_t,consoletype_exec_t)
 ')
+application_executable_file(consoletype_exec_t)
 
 ########################################
 #
--- nsaserefpolicy/policy/modules/admin/dmesg.te	2006-11-16 17:15:26.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/admin/dmesg.te	2007-04-11 16:04:22.000000000 -0400
@@ -10,6 +10,7 @@
 	type dmesg_t;
 	type dmesg_exec_t;
 	init_system_domain(dmesg_t,dmesg_exec_t)
+	application_executable_file(dmesg_exec_t)
 	role system_r types dmesg_t;
 ')
 
--- nsaserefpolicy/policy/modules/admin/netutils.te	2007-03-26 16:24:13.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/admin/netutils.te	2007-04-11 16:22:25.000000000 -0400
@@ -31,6 +31,7 @@
 type traceroute_t;
 type traceroute_exec_t;
 init_system_domain(traceroute_t,traceroute_exec_t)
+application_executable_file(traceroute_exec_t)
 role system_r types traceroute_t;
 
 ########################################
--- nsaserefpolicy/policy/modules/admin/rpm.te	2007-02-19 11:32:54.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/admin/rpm.te	2007-04-11 16:04:22.000000000 -0400
@@ -9,6 +9,8 @@
 type rpm_t;
 type rpm_exec_t;
 init_system_domain(rpm_t,rpm_exec_t)
+application_executable_file(rpm_exec_t)
+
 domain_obj_id_change_exemption(rpm_t)
 domain_role_change_exemption(rpm_t)
 domain_system_change_exemption(rpm_t)
--- nsaserefpolicy/policy/modules/services/cvs.te	2007-03-26 16:24:12.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/cvs.te	2007-04-11 16:04:22.000000000 -0400
@@ -16,6 +16,7 @@
 type cvs_t;
 type cvs_exec_t;
 inetd_tcp_service_domain(cvs_t,cvs_exec_t)
+application_executable_file(cvs_exec_t)
 role system_r types cvs_t;
 
 type cvs_data_t; # customizable
--- nsaserefpolicy/policy/modules/services/mta.te	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/services/mta.te	2007-04-11 16:04:22.000000000 -0400
@@ -27,6 +27,7 @@
 
 type sendmail_exec_t;
 files_type(sendmail_exec_t)
+application_executable_file(sendmail_exec_t)
 
 mta_base_mail_template(system)
 role system_r types system_mail_t;
--- nsaserefpolicy/policy/modules/services/procmail.te	2007-03-26 10:39:05.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/procmail.te	2007-04-11 16:04:22.000000000 -0400
@@ -10,6 +10,7 @@
 type procmail_exec_t;
 domain_type(procmail_t)
 domain_entry_file(procmail_t,procmail_exec_t)
+application_executable_file(procmail_exec_t)
 role system_r types procmail_t;
 
 type procmail_tmp_t;
--- nsaserefpolicy/policy/modules/services/rsync.te	2007-03-26 16:24:12.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/rsync.te	2007-04-11 16:04:22.000000000 -0400
@@ -17,6 +17,7 @@
 type rsync_t;
 type rsync_exec_t;
 init_daemon_domain(rsync_t,rsync_exec_t)
+application_executable_file(rsync_exec_t)
 role system_r types rsync_t;
 
 type rsync_data_t;
--- nsaserefpolicy/policy/modules/services/spamassassin.te	2007-03-26 16:24:12.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/spamassassin.te	2007-04-11 16:04:22.000000000 -0400
@@ -26,7 +24,7 @@
 
 # spamassassin client executable
 type spamc_exec_t;
-corecmd_executable_file(spamc_exec_t)
+application_executable_file(spamc_exec_t)
 
 type spamd_t;
 type spamd_exec_t;
@@ -46,7 +44,7 @@
 files_pid_file(spamd_var_run_t)
 
 type spamassassin_exec_t;
-corecmd_executable_file(spamassassin_exec_t)
+application_executable_file(spamassassin_exec_t)
 
 ########################################
 #
--- nsaserefpolicy/policy/modules/services/ssh.te	2007-03-26 16:24:12.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/ssh.te	2007-04-11 16:04:22.000000000 -0400
@@ -24,11 +24,11 @@
 
 # Type for the ssh-agent executable.
 type ssh_agent_exec_t;
-files_type(ssh_agent_exec_t)
+application_executable_file(ssh_agent_exec_t)
 
 # ssh client executable.
 type ssh_exec_t;
-corecmd_executable_file(ssh_exec_t)
+application_executable_file(ssh_exec_t)
 
 type ssh_keygen_t;
 type ssh_keygen_exec_t;
--- nsaserefpolicy/policy/modules/system/application.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/system/application.fc	2007-04-11 16:04:22.000000000 -0400
@@ -0,0 +1 @@
+# No application file contexts.
--- nsaserefpolicy/policy/modules/system/application.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/system/application.if	2007-04-11 16:04:22.000000000 -0400
@@ -0,0 +1,104 @@
+## <summary>Policy for application domains</summary>
+
+########################################
+## <summary>
+##	Make the specified type usable as an application domain.
+## </summary>
+## <param name="type">
+##	<summary>
+##	Type to be used as a domain type.
+##	</summary>
+## </param>
+#
+interface(`application_type',`
+	gen_require(`
+		attribute application_domain_type;
+	')
+
+	typeattribute $1 application_domain_type;
+
+	# start with basic domain
+	domain_type($1)
+')
+
+########################################
+## <summary>
+##	Make the specified type usable for files
+##	that are exectuables, such as binary programs.
+##	This does not include shared libraries.
+## </summary>
+## <param name="type">
+##	<summary>
+##	Type to be used for files.
+##	</summary>
+## </param>
+#
+interface(`application_executable_file',`
+	gen_require(`
+		attribute application_exec_type;
+	')
+
+	typeattribute $1 application_exec_type;
+
+	corecmd_executable_file($1)
+')
+
+########################################
+## <summary>
+## Execute application executables in the caller domain.
+## </summary>
+## <param name="type">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`application_exec',`
+	gen_require(`
+		attribute application_exec_type;
+	')
+
+	can_exec($1, application_exec_type)
+')
+
+########################################
+## <summary>
+##	Execute all executable files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`application_exec_all',`
+       # Need this dontaudit or command completion fires hundreds of avcs
+       corecmd_dontaudit_exec_all_executables($1)
+       corecmd_exec_bin($1)
+       corecmd_exec_shell($1)
+       corecmd_exec_chroot($1)
+       application_exec($1)
+')
+
+########################################
+## <summary>
+##	Create a domain which can be started by users
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Type to be used as a domain.
+##	</summary>
+## </param>
+## <param name="entry_point">
+##	<summary>
+##	Type of the program to be used as an entry point to this domain.
+##	</summary>
+## </param>
+#
+interface(`application_domain',`
+
+	application_type($1)
+	application_executable_file($2)
+	domain_entry_file($1,$2)
+')
--- nsaserefpolicy/policy/modules/system/application.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/system/application.te	2007-04-11 16:04:22.000000000 -0400
@@ -0,0 +1,14 @@
+
+policy_module(application,1.0.0)
+
+# Attribute of user applications
+attribute application_domain_type;
+
+# Executables to be run by user
+attribute application_exec_type;
+
+optional_policy(`
+	ssh_sigchld(application_domain_type)
+	ssh_rw_stream_sockets(application_domain_type)
+')
+
--- nsaserefpolicy/policy/modules/system/fstools.te	2007-03-26 10:39:07.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/system/fstools.te	2007-04-11 16:04:22.000000000 -0400
@@ -9,6 +9,7 @@
 type fsadm_t;
 type fsadm_exec_t;
 init_system_domain(fsadm_t,fsadm_exec_t)
+application_executable_file(fsadm_exec_t)
 role system_r types fsadm_t;
 
 type fsadm_log_t;
--- nsaserefpolicy/policy/modules/system/logging.te	2007-03-26 10:39:07.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/system/logging.te	2007-04-11 16:04:22.000000000 -0400
@@ -11,6 +11,7 @@
 type auditctl_t;
 type auditctl_exec_t;
 init_system_domain(auditctl_t,auditctl_exec_t)
+application_type(auditctl_t)
 role system_r types auditctl_t;
 
 type auditd_etc_t;
--- nsaserefpolicy/policy/modules/system/lvm.te	2007-03-26 10:39:07.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/system/lvm.te	2007-04-11 16:04:22.000000000 -0400
@@ -16,6 +16,7 @@
 type lvm_t;
 type lvm_exec_t;
 init_system_domain(lvm_t,lvm_exec_t)
+application_type(lvm_t)
 # needs privowner because it assigns the identity system_u to device nodes
 # but runs as the identity of the sysadmin
 domain_obj_id_change_exemption(lvm_t)
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2007-03-26 10:39:07.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/system/selinuxutil.te	2007-04-11 16:04:22.000000000 -0400
@@ -26,11 +24,9 @@
 files_type(selinux_config_t)
 
 type checkpolicy_t, can_write_binary_policy;
-domain_type(checkpolicy_t)
-role system_r types checkpolicy_t;
-
 type checkpolicy_exec_t;
-domain_entry_file(checkpolicy_t,checkpolicy_exec_t)
+application_domain(checkpolicy_t, checkpolicy_exec_t)
+role system_r types checkpolicy_t;
 
 #
 # default_context_t is the type applied to
@@ -83,31 +79,34 @@
 type restorecon_exec_t;
 domain_obj_id_change_exemption(restorecon_t)
 init_system_domain(restorecon_t,restorecon_exec_t)
+application_domain(restorecon_t,restorecon_exec_t)
 role system_r types restorecon_t;
 
 type restorecond_t;
 type restorecond_exec_t;
 init_daemon_domain(restorecond_t,restorecond_exec_t)
 domain_obj_id_change_exemption(restorecond_t)
-role system_r types restorecond_t;
 
 type restorecond_var_run_t;
 files_pid_file(restorecond_var_run_t)
 
 type run_init_t;
 type run_init_exec_t;
-domain_type(run_init_t)
-domain_entry_file(run_init_t,run_init_exec_t)
+application_domain(run_init_t, run_init_exec_t)
 domain_system_change_exemption(run_init_t)
+role system_r types run_init_t;
 
 type semanage_t;
-domain_type(semanage_t)
-domain_interactive_fd(semanage_t)
-
 type semanage_exec_t;
-domain_entry_file(semanage_t, semanage_exec_t)
+application_domain(semanage_t, semanage_exec_t)
+domain_interactive_fd(semanage_t)
 role system_r types semanage_t;
 
+ifdef(`targeted_policy',`
+init_use_fds(semanage_t)
+init_system_domain(semanage_t, semanage_exec_t)
+')
+
 type semanage_store_t;
 files_type(semanage_store_t)
 

--------------090702030207000802070602--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
