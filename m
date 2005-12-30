Date: Fri, 30 Dec 2005 11:08:27 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux List <SELinux@tycho.nsa.gov>
Subject: logging in using sereference policy
Message-ID: <20051230170827.GA6593@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ok, I'm inlining one patch, and attaching another patch of which the
inlined patch is a subset.

The inlined patch allowed me to log in in enforcing mode.  The rest were
supporting pieces which addressed various denied messages I'd been
seeing.  I know most of these allow statements need to be moved to
appropriate macros in completely different files, but I won't be able to
get around to that until mid next week at the earliest, so here's the
info in any case.

Kind of obvious in retrospect :)  And I sort of knew that must be what
was going on, but wasn't sure how to find the real problem if there was
no audit msg about it.  In the future I may just have to start by adding
a debug make target which removes all dontaudits.

-serge

Index: refpolicy/policy/modules/system/authlogin.if
===================================================================
--- refpolicy.orig/policy/modules/system/authlogin.if	2005-12-08 14:34:32.000000000 -0600
+++ refpolicy/policy/modules/system/authlogin.if	2005-12-30 10:44:51.000000000 -0600
@@ -115,6 +115,8 @@ template(`authlogin_per_userdomain_templ
 	allow $2 self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 
 	dontaudit $2 shadow_t:file { getattr read };
+	typeattribute $2 can_read_shadow_passwords;
+	allow $2 shadow_t:file { getattr read };
 
 	# Transition from the user domain to this domain.
 	domain_auto_trans($2,chkpwd_exec_t,$1_chkpwd_t)
@@ -253,6 +255,8 @@ interface(`auth_domtrans_chk_passwd',`
 	allow system_chkpwd_t $1:process sigchld;
 
 	dontaudit $1 shadow_t:file { getattr read };
+	typeattribute $1 can_read_shadow_passwords;
+	allow $1 shadow_t:file { getattr read };
 
 	dev_read_rand($1)
 	dev_read_urand($1)
Index: refpolicy/policy/modules/system/userdomain.if
===================================================================
--- refpolicy.orig/policy/modules/system/userdomain.if	2005-12-06 15:32:13.000000000 -0600
+++ refpolicy/policy/modules/system/userdomain.if	2005-12-30 10:53:25.000000000 -0600
@@ -33,6 +33,10 @@ template(`base_user_template',`
 	role $1_r types $1_t;
 	allow system_r $1_r;
 
+	# serge
+	allow $1_t local_login_t:process { sigchld };
+	allow $1_t etc_runtime_t:file r_file_perms;
+
 	# user pseudoterminal
 	type $1_devpts_t;
 	term_user_pty($1_t,$1_devpts_t)

thanks,
-serge

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="policy_fixes.patch"

Index: refpolicy/policy/modules/system/udev.te
===================================================================
--- refpolicy.orig/policy/modules/system/udev.te	2005-12-09 15:09:22.000000000 -0600
+++ refpolicy/policy/modules/system/udev.te	2005-12-30 09:04:45.000000000 -0600
@@ -203,3 +203,6 @@ optional_policy(`sysnetwork',`
 ifdef(`TODO',`
 dontaudit udev_t ttyfile:chr_file unlink;
 ') dnl endif TODO
+
+# serge - try to let logins succeed
+allow kernel_t user_t:file read;
Index: refpolicy/policy/modules/kernel/filesystem.te
===================================================================
--- refpolicy.orig/policy/modules/kernel/filesystem.te	2005-12-09 15:09:22.000000000 -0600
+++ refpolicy/policy/modules/kernel/filesystem.te	2005-12-29 20:00:15.000000000 -0600
@@ -166,3 +166,7 @@ files_mountpoint(nfs_t)
 genfscon nfs / gen_context(system_u:object_r:nfs_t,s0)
 genfscon nfs4 / gen_context(system_u:object_r:nfs_t,s0)
 genfscon afs / gen_context(system_u:object_r:nfs_t,s0)
+
+# serge
+allow user_tty_device_t tmpfs_t:filesystem associate;
+allow sysadm_tty_device_t tmpfs_t:filesystem associate;
Index: refpolicy/policy/modules/system/logging.te
===================================================================
--- refpolicy.orig/policy/modules/system/logging.te	2005-12-09 15:09:22.000000000 -0600
+++ refpolicy/policy/modules/system/logging.te	2005-12-29 22:57:47.000000000 -0600
@@ -388,3 +388,12 @@ allow syslogd_t xconsole_device_t:fifo_f
 #
 allow syslogd_t { device_t file_t }:sock_file { getattr unlink };
 ') dnl end TODO
+
+# serge
+allow local_login_t device_t:sock_file rw_file_perms;
+allow local_login_t shlib_t:file execmod;
+allow initrc_t initrc_t:sock_file r_file_perms;
+allow initrc_t initrc_t:capability { sys_admin };
+allow initrc_t proc_kmsg_t:file r_file_perms;
+allow local_login_t sbin_t:file rx_file_perms;
+allow local_login_t sbin_t:file execute_no_trans;
Index: refpolicy/policy/modules/system/init.te
===================================================================
--- refpolicy.orig/policy/modules/system/init.te	2005-12-12 10:53:27.000000000 -0600
+++ refpolicy/policy/modules/system/init.te	2005-12-30 09:56:30.000000000 -0600
@@ -58,6 +58,7 @@ mls_trusted_object(initctl_t)
 gen_require(`
 	type initrc_t;
 ')
+typeattribute initrc_t can_receive_kernel_messages;
 domain_type(initrc_t)
 role system_r types initrc_t;
 
@@ -708,3 +709,44 @@ ifdef(`distro_redhat', `
 	')
 ')
 ') dnl end TODO
+
+# serge
+allow initrc_t device_t:chr_file setattr;
+allow initrc_t device_t:file rw_file_perms;
+allow initrc_t device_t:sock_file create_file_perms;
+allow initrc_t device_t:sock_file setattr;
+allow initrc_t device_t:file { create unlink };
+allow initrc_t device_t:blk_file { create setattr };
+allow initrc_t device_t:dir { create };
+allow initrc_t modules_conf_t:file rw_file_perms;
+allow initrc_t etc_t:file rw_file_perms;
+allow initrc_t src_t:lnk_file r_file_perms;
+allow initrc_t adjtime_t:file rw_file_perms;
+allow initrc_t wtmp_t:file setattr;
+allow initrc_t proc_kmsg_t:file { write setattr };
+
+allow update_modules_t etc_runtime_t:file append;
+allow update_modules_t var_t:dir r_dir_perms;
+allow update_modules_t var_run_t:dir r_dir_perms;
+
+allow depmod_t urandom_device_t:chr_file rw_term_perms;
+allow hwclock_t urandom_device_t:chr_file rw_term_perms;
+allow restorecon_t urandom_device_t:chr_file rw_term_perms;
+allow ifconfig_t urandom_device_t:chr_file rw_term_perms;
+
+allow hwclock_t device_t:chr_file rw_term_perms;
+
+allow kernel_t init_t:file r_file_perms;
+allow kernel_t initrc_t:file r_file_perms;
+allow kernel_t udev_t:file r_file_perms;
+
+allow cardmgr_t device_t:sock_file rw_file_perms;
+
+allow kernel_t init_t:file r_file_perms;
+allow kernel_t udev_t:file r_file_perms;
+allow kernel_t initrc_t:file r_file_perms;
+allow kernel_t apmd_t:file r_file_perms;
+allow kernel_t crond_t:file r_file_perms;
+allow kernel_t cardmgr_t:file r_file_perms;
+allow kernel_t sshd_t:file r_file_perms;
+allow kernel_t getty_t:file r_file_perms;
Index: refpolicy/policy/modules/system/mount.te
===================================================================
--- refpolicy.orig/policy/modules/system/mount.te	2005-12-12 15:50:18.000000000 -0600
+++ refpolicy/policy/modules/system/mount.te	2005-12-30 09:57:30.000000000 -0600
@@ -143,3 +143,6 @@ ifdef(`TODO',`
 # for when /etc/mtab loses its type
 allow mount_t file_t:file unlink;
 ') dnl endif TODO
+
+# serge
+allow mount_t urandom_device_t:chr_file rw_term_perms;
Index: refpolicy/policy/modules/admin/consoletype.te
===================================================================
--- refpolicy.orig/policy/modules/admin/consoletype.te	2005-12-09 15:09:21.000000000 -0600
+++ refpolicy/policy/modules/admin/consoletype.te	2005-12-30 09:57:38.000000000 -0600
@@ -125,3 +125,6 @@ allow consoletype_t printconf_t:file r_f
 ')
 
 ') dnl end TODO
+
+# serge
+allow consoletype_t urandom_device_t:chr_file rw_term_perms;
Index: refpolicy/policy/modules/admin/dmesg.te
===================================================================
--- refpolicy.orig/policy/modules/admin/dmesg.te	2005-12-09 15:09:21.000000000 -0600
+++ refpolicy/policy/modules/admin/dmesg.te	2005-12-30 09:57:34.000000000 -0600
@@ -73,3 +73,6 @@ ifdef(`strict_policy',`
 	')
 
 ')
+
+#serge
+allow dmesg_t urandom_device_t:chr_file rw_term_perms;
Index: refpolicy/policy/modules/system/hostname.te
===================================================================
--- refpolicy.orig/policy/modules/system/hostname.te	2005-12-09 15:09:22.000000000 -0600
+++ refpolicy/policy/modules/system/hostname.te	2005-12-30 09:57:43.000000000 -0600
@@ -87,3 +87,6 @@ optional_policy(`udev',`
 	udev_dontaudit_use_fd(hostname_t)
 	udev_read_db(hostname_t)
 ')
+
+# serge
+allow hostname_t urandom_device_t:chr_file rw_term_perms;
Index: refpolicy/policy/modules/services/ssh.te
===================================================================
--- refpolicy.orig/policy/modules/services/ssh.te	2005-12-09 15:09:22.000000000 -0600
+++ refpolicy/policy/modules/services/ssh.te	2005-12-30 09:46:38.000000000 -0600
@@ -256,3 +256,10 @@ ifdef(`targeted_policy',`',`
 		udev_read_db(ssh_keygen_t)
 	')
 ')
+
+# serge
+allow sshd_t device_t:sock_file rw_file_perms;
+
+# - bad idea?
+allow sshd_t sshd_t:process { execstack execmem };
+
Index: refpolicy/policy/modules/services/cron.te
===================================================================
--- refpolicy.orig/policy/modules/services/cron.te	2005-12-13 14:40:13.000000000 -0600
+++ refpolicy/policy/modules/services/cron.te	2005-12-30 09:43:58.000000000 -0600
@@ -452,3 +452,6 @@ ifdef(`targeted_policy',`
 
 	') dnl end TODO
 ')
+
+# serge
+allow crond_t device_t:sock_file rw_file_perms;
Index: refpolicy/policy/modules/system/getty.te
===================================================================
--- refpolicy.orig/policy/modules/system/getty.te	2005-12-09 15:09:22.000000000 -0600
+++ refpolicy/policy/modules/system/getty.te	2005-12-30 09:55:58.000000000 -0600
@@ -115,3 +115,6 @@ optional_policy(`ppp',`
 optional_policy(`udev',`
 	udev_read_db(getty_t)
 ')
+
+# serge
+allow getty_t urandom_device_t:chr_file rw_term_perms;
Index: refpolicy/policy/modules/system/locallogin.te
===================================================================
--- refpolicy.orig/policy/modules/system/locallogin.te	2005-12-09 15:09:22.000000000 -0600
+++ refpolicy/policy/modules/system/locallogin.te	2005-12-30 09:31:14.000000000 -0600
@@ -280,3 +280,7 @@ ifdef(`sulogin_no_pam', `
 optional_policy(`nis',`
 	nis_use_ypbind(sulogin_t)
 ')
+
+# serge - bc /root is mislabeled
+allow local_login_t default_t:dir r_dir_perms;
+allow local_login_t default_t:file r_file_perms;
Index: refpolicy/policy/modules/system/authlogin.if
===================================================================
--- refpolicy.orig/policy/modules/system/authlogin.if	2005-12-08 14:34:32.000000000 -0600
+++ refpolicy/policy/modules/system/authlogin.if	2005-12-30 10:44:51.000000000 -0600
@@ -115,6 +115,8 @@ template(`authlogin_per_userdomain_templ
 	allow $2 self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 
 	dontaudit $2 shadow_t:file { getattr read };
+	typeattribute $2 can_read_shadow_passwords;
+	allow $2 shadow_t:file { getattr read };
 
 	# Transition from the user domain to this domain.
 	domain_auto_trans($2,chkpwd_exec_t,$1_chkpwd_t)
@@ -253,6 +255,8 @@ interface(`auth_domtrans_chk_passwd',`
 	allow system_chkpwd_t $1:process sigchld;
 
 	dontaudit $1 shadow_t:file { getattr read };
+	typeattribute $1 can_read_shadow_passwords;
+	allow $1 shadow_t:file { getattr read };
 
 	dev_read_rand($1)
 	dev_read_urand($1)
Index: refpolicy/policy/modules/system/userdomain.if
===================================================================
--- refpolicy.orig/policy/modules/system/userdomain.if	2005-12-06 15:32:13.000000000 -0600
+++ refpolicy/policy/modules/system/userdomain.if	2005-12-30 10:53:25.000000000 -0600
@@ -33,6 +33,10 @@ template(`base_user_template',`
 	role $1_r types $1_t;
 	allow system_r $1_r;
 
+	# serge
+	allow $1_t local_login_t:process { sigchld };
+	allow $1_t etc_runtime_t:file r_file_perms;
+
 	# user pseudoterminal
 	type $1_devpts_t;
 	term_user_pty($1_t,$1_devpts_t)

--YiEDa0DAkWCtVeE4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
