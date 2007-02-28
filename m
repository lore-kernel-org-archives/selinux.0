Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1SKQk6H030790
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 15:26:46 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1SKS8aL000425
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 20:28:09 GMT
Message-ID: <45E5E54F.1@redhat.com>
Date: Wed, 28 Feb 2007 15:25:51 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Added application_exec_type patch
Content-Type: multipart/mixed;
 boundary="------------070602000606090701090902"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070602000606090701090902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch  an attribute  of application_exec_type to any executable 
that can be executed by a user. 

I have only patched the executables that currently transition to a 
domain if run under inetd or init, but do not transition if run by a user.

Also changed corecommand_exec_any to only execute executables that a 
user is supposed to run.  So if sysadm_t tries to execute a dameon 
directly it will get a permission denied.

--------------070602000606090701090902
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/acct.te serefpolicy-2.5.6/policy/modules/admin/acct.te
--- nsaserefpolicy/policy/modules/admin/acct.te	2007-01-02 12:57:51.000000000 -0500
+++ serefpolicy-2.5.6/policy/modules/admin/acct.te	2007-02-28 12:03:02.000000000 -0500
@@ -9,6 +9,7 @@
 type acct_t;
 type acct_exec_t;
 init_system_domain(acct_t,acct_exec_t)
+application_executable_file(acct_exec_t)
 
 type acct_data_t;
 logging_log_file(acct_data_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/consoletype.te serefpolicy-2.5.6/policy/modules/admin/consoletype.te
--- nsaserefpolicy/policy/modules/admin/consoletype.te	2007-02-19 11:32:54.000000000 -0500
+++ serefpolicy-2.5.6/policy/modules/admin/consoletype.te	2007-02-28 12:03:02.000000000 -0500
@@ -16,6 +21,7 @@
 ifdef(`targeted_policy',`',`
 	init_system_domain(consoletype_t,consoletype_exec_t)
 ')
+application_executable_file(consoletype_exec_t)
 
 ########################################
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/dmesg.te serefpolicy-2.5.6/policy/modules/admin/dmesg.te
--- nsaserefpolicy/policy/modules/admin/dmesg.te	2006-11-16 17:15:26.000000000 -0500
+++ serefpolicy-2.5.6/policy/modules/admin/dmesg.te	2007-02-28 12:03:02.000000000 -0500
@@ -10,6 +10,7 @@
 	type dmesg_t;
 	type dmesg_exec_t;
 	init_system_domain(dmesg_t,dmesg_exec_t)
+	application_executable_file(dmesg_exec_t)
 	role system_r types dmesg_t;
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/netutils.te serefpolicy-2.5.6/policy/modules/admin/netutils.te
--- nsaserefpolicy/policy/modules/admin/netutils.te	2007-01-02 12:57:51.000000000 -0500
+++ serefpolicy-2.5.6/policy/modules/admin/netutils.te	2007-02-28 12:03:02.000000000 -0500
@@ -22,6 +22,7 @@
 type traceroute_t;
 type traceroute_exec_t;
 init_system_domain(traceroute_t,traceroute_exec_t)
+application_executable_file(traceroute_exec_t)
 role system_r types traceroute_t;
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.te serefpolicy-2.5.6/policy/modules/admin/rpm.te
--- nsaserefpolicy/policy/modules/admin/rpm.te	2007-02-19 11:32:54.000000000 -0500
+++ serefpolicy-2.5.6/policy/modules/admin/rpm.te	2007-02-28 12:03:02.000000000 -0500
@@ -9,6 +9,8 @@
 type rpm_t;
 type rpm_exec_t;
 init_system_domain(rpm_t,rpm_exec_t)
+application_executable_file(rpm_exec_t)
+
 domain_obj_id_change_exemption(rpm_t)
 domain_role_change_exemption(rpm_t)
 domain_system_change_exemption(rpm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/sudo.te serefpolicy-2.5.6/policy/modules/admin/sudo.te
--- nsaserefpolicy/policy/modules/admin/sudo.te	2007-02-19 11:32:54.000000000 -0500
+++ serefpolicy-2.5.6/policy/modules/admin/sudo.te	2007-02-28 12:03:02.000000000 -0500
@@ -7,5 +7,6 @@
 
 type sudo_exec_t;
 files_type(sudo_exec_t)
+application_executable_file(sudo_exec_t)
 
 # Remaining policy in per user domain template.
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corecommands.if serefpolicy-2.5.6/policy/modules/kernel/corecommands.if
--- nsaserefpolicy/policy/modules/kernel/corecommands.if	2007-02-19 11:32:51.000000000 -0500
+++ serefpolicy-2.5.6/policy/modules/kernel/corecommands.if	2007-02-28 12:03:02.000000000 -0500
@@ -928,7 +928,15 @@
 		type bin_t, sbin_t;
 	')
 
-	can_exec($1,exec_type)
+	# Need this dontaudit or command completion fires hundreds of avcs
+ 	dontaudit $1 exec_type:file execute;
+ 	corecmd_exec_bin($1)
+ 	corecmd_exec_sbin($1)
+ 	corecmd_exec_shell($1)
+ 	corecmd_exec_ls($1)
+ 	corecmd_exec_chroot($1)
+ 	application_exec($1)
+ 
 	list_dirs_pattern($1,{ bin_t sbin_t },{ bin_t sbin_t })
 	read_lnk_files_pattern($1,{ bin_t sbin_t },{ bin_t sbin_t })
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cvs.te serefpolicy-2.5.6/policy/modules/services/cvs.te
--- nsaserefpolicy/policy/modules/services/cvs.te	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.6/policy/modules/services/cvs.te	2007-02-28 12:03:02.000000000 -0500
@@ -9,6 +9,7 @@
 type cvs_t;
 type cvs_exec_t;
 inetd_tcp_service_domain(cvs_t,cvs_exec_t)
+application_executable_file(cvs_exec_t)
 role system_r types cvs_t;
 
 type cvs_data_t; # customizable
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/mta.te serefpolicy-2.5.6/policy/modules/services/mta.te
--- nsaserefpolicy/policy/modules/services/mta.te	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.6/policy/modules/services/mta.te	2007-02-28 12:03:02.000000000 -0500
@@ -27,6 +27,7 @@
 
 type sendmail_exec_t;
 files_type(sendmail_exec_t)
+application_executable_file(sendmail_exec_t)
 
 mta_base_mail_template(system)
 role system_r types system_mail_t;
@@ -91,6 +92,7 @@
 optional_policy(`
 	apache_read_squirrelmail_data(system_mail_t)
 	apache_append_squirrelmail_data(system_mail_t)
+	apache_search_bugzilla_dirs(system_mail_t)
 
 	# apache should set close-on-exec
 	apache_dontaudit_append_log(system_mail_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rsync.te serefpolicy-2.5.6/policy/modules/services/rsync.te
--- nsaserefpolicy/policy/modules/services/rsync.te	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.6/policy/modules/services/rsync.te	2007-02-28 12:03:02.000000000 -0500
@@ -9,6 +9,7 @@
 type rsync_t;
 type rsync_exec_t;
 init_daemon_domain(rsync_t,rsync_exec_t)
+application_executable_file(rsync_exec_t)
 role system_r types rsync_t;
 
 type rsync_data_t;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/spamassassin.te serefpolicy-2.5.6/policy/modules/services/spamassassin.te
--- nsaserefpolicy/policy/modules/services/spamassassin.te	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.6/policy/modules/services/spamassassin.te	2007-02-28 12:03:02.000000000 -0500
@@ -8,7 +8,7 @@
 
 # spamassassin client executable
 type spamc_exec_t;
-corecmd_executable_file(spamc_exec_t)
+application_executable_file(spamc_exec_t)
 
 type spamd_t;
 type spamd_exec_t;
@@ -24,7 +28,7 @@
 files_pid_file(spamd_var_run_t)
 
 type spamassassin_exec_t;
-corecmd_executable_file(spamassassin_exec_t)
+application_executable_file(spamassassin_exec_t)
 
 ########################################
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ssh.te serefpolicy-2.5.6/policy/modules/services/ssh.te
--- nsaserefpolicy/policy/modules/services/ssh.te	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.6/policy/modules/services/ssh.te	2007-02-28 12:03:02.000000000 -0500
@@ -10,11 +10,11 @@
 
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/application.fc serefpolicy-2.5.6/policy/modules/system/application.fc
--- nsaserefpolicy/policy/modules/system/application.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.6/policy/modules/system/application.fc	2007-02-28 14:53:19.000000000 -0500
@@ -0,0 +1 @@
+# No application file contexts.
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/application.if serefpolicy-2.5.6/policy/modules/system/application.if
--- nsaserefpolicy/policy/modules/system/application.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.6/policy/modules/system/application.if	2007-02-28 12:06:13.000000000 -0500
@@ -0,0 +1,41 @@
+## <summary>Policy for application domains</summary>
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/application.te serefpolicy-2.5.6/policy/modules/system/application.te
--- nsaserefpolicy/policy/modules/system/application.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.6/policy/modules/system/application.te	2007-02-28 12:04:47.000000000 -0500
@@ -0,0 +1,6 @@
+
+policy_module(application,1.0.0)
+
+# Executables to be run by user
+attribute application_exec_type;
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/fstools.te serefpolicy-2.5.6/policy/modules/system/fstools.te
--- nsaserefpolicy/policy/modules/system/fstools.te	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.6/policy/modules/system/fstools.te	2007-02-28 12:03:02.000000000 -0500
@@ -9,6 +9,7 @@
 type fsadm_t;
 type fsadm_exec_t;
 init_system_domain(fsadm_t,fsadm_exec_t)
+application_executable_file(fsadm_exec_t)
 role system_r types fsadm_t;
 
 type fsadm_log_t;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.5.6/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2007-01-02 12:57:49.000000000 -0500
+++ serefpolicy-2.5.6/policy/modules/system/mount.te	2007-02-28 12:03:02.000000000 -0500
@@ -9,6 +9,7 @@
 type mount_t;
 type mount_exec_t;
 init_system_domain(mount_t,mount_exec_t)
+application_executable_file(mount_exec_t)
 role system_r types mount_t;
 
 type mount_loopback_t; # customizable

--------------070602000606090701090902--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
