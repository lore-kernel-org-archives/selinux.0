Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72FZkAR031596
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 11:35:47 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72FZkWr028948
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:35:46 GMT
Message-ID: <46B1F9CD.5070202@redhat.com>
Date: Thu, 02 Aug 2007 11:35:41 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Application_domain
Content-Type: multipart/mixed;
 boundary="------------050203080604020402050202"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050203080604020402050202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

My definition of the application domain, is any file that a normal user 
is expected to execute.   It can either have a  transition or not.  If I 
define application_domain then it will transition.  If I just define 
application_executable_file, then logged in users can execute it without 
a transition.

Daemons for the most part should NOT be application_domains.   This way 
we can dontaudit getattr of daemons that users would/should not be 
allowed to execute. 

Some applictions can be in both domains.  For example cvs, rsync can be 
run without transitioning by users but when run from an initscript they 
transition. 

This patch makes changes to the pool to match this.

I included the entire readahead patch in this patch as this should



--------------050203080604020402050202
Content-Type: text/x-patch;
 name="application.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="application.patch"

--- nsaserefpolicy/policy/modules/admin/acct.te	2007-05-29 14:10:59.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/admin/acct.te	2007-08-02 10:58:36.000000000 -0400
@@ -9,6 +9,7 @@
 type acct_t;
 type acct_exec_t;
 init_system_domain(acct_t,acct_exec_t)
+application_executable_file(acct_exec_t)
 
 type acct_data_t;
 logging_log_file(acct_data_t)
--- nsaserefpolicy/policy/modules/admin/netutils.te	2007-07-25 10:37:43.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/admin/netutils.te	2007-08-02 10:58:36.000000000 -0400
@@ -29,6 +29,7 @@
 type traceroute_t;
 type traceroute_exec_t;
 init_system_domain(traceroute_t,traceroute_exec_t)
+application_executable_file(traceroute_exec_t)
 role system_r types traceroute_t;
 
 ########################################
--- nsaserefpolicy/policy/modules/admin/rpm.te	2007-07-25 10:37:43.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/admin/rpm.te	2007-08-02 10:58:36.000000000 -0400
@@ -9,6 +9,8 @@
 type rpm_t;
 type rpm_exec_t;
 init_system_domain(rpm_t,rpm_exec_t)
+application_executable_file(rpm_exec_t)
+
 domain_obj_id_change_exemption(rpm_t)
 domain_role_change_exemption(rpm_t)
 domain_system_change_exemption(rpm_t)
--- nsaserefpolicy/policy/modules/services/cvs.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/cvs.te	2007-08-02 10:58:36.000000000 -0400
@@ -16,6 +16,7 @@
 type cvs_t;
 type cvs_exec_t;
 inetd_tcp_service_domain(cvs_t,cvs_exec_t)
+application_executable_file(cvs_exec_t)
 role system_r types cvs_t;
 
 type cvs_data_t; # customizable
--- nsaserefpolicy/policy/modules/services/rsync.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/rsync.te	2007-08-02 10:58:37.000000000 -0400
@@ -17,6 +17,7 @@
 type rsync_t;
 type rsync_exec_t;
 init_daemon_domain(rsync_t,rsync_exec_t)
+application_executable_file(rsync_exec_t)
 role system_r types rsync_t;
 
 type rsync_data_t;
--- nsaserefpolicy/policy/modules/services/ssh.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/ssh.te	2007-08-02 10:58:37.000000000 -0400
@@ -24,7 +24,7 @@
 
 # Type for the ssh-agent executable.
 type ssh_agent_exec_t;
-files_type(ssh_agent_exec_t)
+application_executable_file(ssh_agent_exec_t)
 
 # ssh client executable.
 type ssh_exec_t;
--- nsaserefpolicy/policy/modules/system/application.if	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/application.if	2007-08-02 10:58:37.000000000 -0400
@@ -63,6 +63,26 @@
 
 ########################################
 ## <summary>
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
 ##	Create a domain which can be started by users
 ## </summary>
 ## <param name="domain">
--- nsaserefpolicy/policy/modules/system/fstools.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/fstools.te	2007-08-02 10:58:37.000000000 -0400
@@ -9,6 +9,7 @@
 type fsadm_t;
 type fsadm_exec_t;
 init_system_domain(fsadm_t,fsadm_exec_t)
+application_executable_file(fsadm_exec_t)
 role system_r types fsadm_t;
 
 type fsadm_log_t;
--- nsaserefpolicy/policy/modules/system/init.if	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/init.if	2007-08-02 10:58:37.000000000 -0400
@@ -194,9 +194,13 @@
 	gen_require(`
 		type initrc_t;
 		role system_r;
+		attribute daemon;
 	')
 
-	application_domain($1,$2)
+	domain_type($1)
+	domain_entry_file($1,$2)
+
+	typeattribute $1 daemon;
 
 	role system_r types $1;
 
--- nsaserefpolicy/policy/modules/system/lvm.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/lvm.te	2007-08-02 10:58:37.000000000 -0400
@@ -16,6 +16,7 @@
 type lvm_t;
 type lvm_exec_t;
 init_system_domain(lvm_t,lvm_exec_t)
+application_executable_file(lvm_exec_t)
 # needs privowner because it assigns the identity system_u to device nodes
 # but runs as the identity of the sysadmin
 domain_obj_id_change_exemption(lvm_t)
--- nsaserefpolicy/policy/modules/system/mount.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/mount.te	2007-08-02 10:58:37.000000000 -0400
@@ -16,19 +23,21 @@
 type mount_t;
 type mount_exec_t;
 init_system_domain(mount_t,mount_exec_t)
+application_executable_file(mount_exec_t)
 role system_r types mount_t;
 
+typealias mount_t alias mount_ntfs_t;
+typealias mount_exec_t alias mount_ntfs_exec_t;
+
 type mount_loopback_t; # customizable
 files_type(mount_loopback_t)
 
 type mount_tmp_t;
 files_tmp_file(mount_tmp_t)
 
-# causes problems with interfaces when
-# this is optionally declared in monolithic
-# policy--duplicate type declaration
 type unconfined_mount_t;
 application_domain(unconfined_mount_t,mount_exec_t)
+role system_r types unconfined_mount_t;
 
 ########################################
 #
--- nsaserefpolicy/policy/modules/system/userdomain.if	2007-07-03 07:06:32.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/userdomain.if	2007-08-02 10:58:37.000000000 -0400
@@ -62,6 +62,10 @@
 
 	allow $1_t $1_tty_device_t:chr_file { setattr rw_chr_file_perms };
 
+	application_exec_all($1_t)
+
+	auth_use_nsswitch($1_t)
+
 	kernel_read_kernel_sysctls($1_t)
 	kernel_dontaudit_list_unlabeled($1_t)
 	kernel_dontaudit_getattr_unlabeled_files($1_t)

--------------050203080604020402050202--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
