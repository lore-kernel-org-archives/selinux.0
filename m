Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5CJVvUg013289
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 15:31:57 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5CJVuZr008490
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 19:31:56 GMT
Message-ID: <448DC130.4010309@redhat.com>
Date: Mon, 12 Jun 2006 15:32:00 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest diffs
Content-Type: multipart/mixed;
 boundary="------------080609040004050308010402"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080609040004050308010402
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix prelink file context

Add unconfined_domain transition to rpm_script_t,
also moved bootloader transition out of targeted policy ifdef

webalizer wants to do udp.

One last fix for allowing mounting any file on any file.

gfs2 supports extended attributes.
gfs does not, so I am calling them nfs

New version of automount wants new privs.

I am looking into updating prelink cron entry to do restorecon to 
eliminate avc messages, also trying
to get prelink maintainer to modify program which would make this change 
not as important

hplib is communicating with nfs somehow.

proftpd uses a socket to communicate with itself

hald needs nsswitch stuff

krb5kdc needs to read kernel network state.

mysql uses nsswitch

NetworkManager neets to transition to pppd to bring up dialup networking.

ntpd - nsswitch

procmail transition to clamav

pegasus we need to setup a chat with pegasus maintainer.  He wants 
transition from unconfined_t.

pyzor wants to read home dir.

xfs - nsswitch

Fix auditd config files specs

semanage needs additional perms to work with setrans file

merged unconfined_execmem into unconfined.te

remove todo stuff from userdomain.

useradd needs to be able to create user_home_dir_t in mls policy





--------------080609040004050308010402
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/config/appconfig-strict-mls/default_type serefpolicy-2.2.45/config/appconfig-strict-mls/default_type
--- nsaserefpolicy/config/appconfig-strict-mls/default_type	2006-01-06 17:55:17.000000000 -0500
+++ serefpolicy-2.2.45/config/appconfig-strict-mls/default_type	2006-06-09 15:45:23.000000000 -0400
@@ -2,3 +2,4 @@
 secadm_r:secadm_t
 staff_r:staff_t
 user_r:user_t
+auditadm_r:auditadm_t
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/consoletype.te serefpolicy-2.2.45/policy/modules/admin/consoletype.te
--- nsaserefpolicy/policy/modules/admin/consoletype.te	2006-05-19 10:07:51.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/admin/consoletype.te	2006-06-09 15:45:23.000000000 -0400
@@ -8,7 +8,12 @@
 
 type consoletype_t;
 type consoletype_exec_t;
-init_domain(consoletype_t,consoletype_exec_t)
+#dont transition from initrc
+#init_domain(consoletype_t,consoletype_exec_t)
+domain_type(consoletype_t)
+domain_entry_file(consoletype_t,consoletype_exec_t)
+role system_r types consoletype_t;
+
 mls_file_read_up(consoletype_t)
 mls_file_write_down(consoletype_t)
 role system_r types consoletype_t;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/prelink.fc serefpolicy-2.2.45/policy/modules/admin/prelink.fc
--- nsaserefpolicy/policy/modules/admin/prelink.fc	2006-01-25 12:52:21.000000000 -0500
+++ serefpolicy-2.2.45/policy/modules/admin/prelink.fc	2006-06-09 15:45:23.000000000 -0400
@@ -3,6 +3,6 @@
 
 /usr/sbin/prelink(\.bin)?	--	gen_context(system_u:object_r:prelink_exec_t,s0)
 
-/var/lib/misc/prelink\.*		--	gen_context(system_u:object_r:prelink_cache_t,s0)
+/var/lib/misc/prelink\..*	--	gen_context(system_u:object_r:prelink_cache_t,s0)
 
 /var/log/prelink\.log		--	gen_context(system_u:object_r:prelink_log_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.te serefpolicy-2.2.45/policy/modules/admin/rpm.te
--- nsaserefpolicy/policy/modules/admin/rpm.te	2006-06-08 08:45:57.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/admin/rpm.te	2006-06-09 15:45:23.000000000 -0400
@@ -341,12 +341,16 @@
 	optional_policy(`
 		mono_domtrans(rpm_script_t)
 	')
-',`
+
 	optional_policy(`
-		bootloader_domtrans(rpm_script_t)
+		unconfined_domtrans(rpm_script_t)
 	')
 ')
 
+optional_policy(`
+	bootloader_domtrans(rpm_script_t)
+')
+
 ifdef(`distro_redhat',`
 	optional_policy(`
 		mta_send_mail(rpm_script_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/webalizer.te serefpolicy-2.2.45/policy/modules/apps/webalizer.te
--- nsaserefpolicy/policy/modules/apps/webalizer.te	2006-06-08 08:45:57.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/apps/webalizer.te	2006-06-09 15:45:23.000000000 -0400
@@ -44,6 +44,7 @@
 allow webalizer_t self:unix_dgram_socket sendto;
 allow webalizer_t self:unix_stream_socket connectto;
 allow webalizer_t self:tcp_socket connected_stream_socket_perms;
+allow webalizer_t self:udp_socket { connect connected_socket_perms };
 allow webalizer_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow webalizer_t webalizer_etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.2.45/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-06-08 23:00:29.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/kernel/files.if	2006-06-09 15:45:23.000000000 -0400
@@ -1931,6 +1931,21 @@
 ')
 
 ########################################
+#
+# files_unlink_boot_flag(domain)
+#
+# /halt, /.autofsck, etc
+#
+interface(`files_unlink_boot_flag',`
+	gen_require(`
+		type root_t;
+	')
+
+	allow $1 root_t:file unlink;
+')
+
+
+########################################
 ## <summary>
 ##	Read files in /etc that are dynamically
 ##	created on boot, such as mtab.
@@ -4379,3 +4394,23 @@
 
 	typeattribute $1 files_unconfined_type;
 ')
+
+########################################
+## <summary>
+##	Mount a filesystem on all files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`files_mounton_all_files',`
+	gen_require(`
+		attribute file_type, security_file_type;
+	')
+
+	allow $1 { file_type -security_file_type }:dir mounton;
+	allow $1 { file_type -security_file_type }:file mounton;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/filesystem.te serefpolicy-2.2.45/policy/modules/kernel/filesystem.te
--- nsaserefpolicy/policy/modules/kernel/filesystem.te	2006-06-08 08:45:57.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/kernel/filesystem.te	2006-06-09 15:45:23.000000000 -0400
@@ -23,7 +23,7 @@
 # Requires that a security xattr handler exist for the filesystem.
 fs_use_xattr ext2 gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr ext3 gen_context(system_u:object_r:fs_t,s0);
-fs_use_xattr gfs gen_context(system_u:object_r:fs_t,s0);
+fs_use_xattr gfs2 gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr jfs gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr xfs gen_context(system_u:object_r:fs_t,s0);
 
@@ -174,6 +174,7 @@
 genfscon hfs / gen_context(system_u:object_r:nfs_t,s0)
 genfscon hfsplus / gen_context(system_u:object_r:nfs_t,s0)
 genfscon reiserfs / gen_context(system_u:object_r:nfs_t,s0)
+genfscon gfs / gen_context(system_u:object_r:nfs_t,s0)
 
 ########################################
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/kernel.te serefpolicy-2.2.45/policy/modules/kernel/kernel.te
--- nsaserefpolicy/policy/modules/kernel/kernel.te	2006-06-06 22:21:53.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/kernel/kernel.te	2006-06-09 15:45:23.000000000 -0400
@@ -28,6 +28,7 @@
 
 ifdef(`enable_mls',`
 	role secadm_r;
+	role auditadm_r;
 ')
 
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/automount.te serefpolicy-2.2.45/policy/modules/services/automount.te
--- nsaserefpolicy/policy/modules/services/automount.te	2006-06-06 22:21:53.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/services/automount.te	2006-06-09 15:45:23.000000000 -0400
@@ -30,7 +30,7 @@
 
 allow automount_t self:capability { net_bind_service sys_nice sys_resource dac_override };
 dontaudit automount_t self:capability sys_tty_config;
-allow automount_t self:process { signal_perms getpgid setpgid setsched };
+allow automount_t self:process { signal_perms getpgid setpgid setsched setrlimit };
 allow automount_t self:fifo_file rw_file_perms;
 allow automount_t self:unix_stream_socket create_socket_perms;
 allow automount_t self:unix_dgram_socket create_socket_perms;
@@ -58,9 +58,11 @@
 files_pid_filetrans(automount_t,automount_var_run_t,file)
 
 kernel_read_kernel_sysctls(automount_t)
+kernel_read_irq_sysctls(automount_t)
 kernel_read_fs_sysctls(automount_t)
 kernel_read_proc_symlinks(automount_t)
 kernel_read_system_state(automount_t)
+kernel_read_network_state(automount_t)
 kernel_list_proc(automount_t)
 
 files_search_boot(automount_t)
@@ -92,6 +94,7 @@
 dev_read_urand(automount_t)
 
 domain_use_interactive_fds(automount_t)
+domain_dontaudit_read_all_domains_state(automount_t)
 
 files_dontaudit_write_var_dirs(automount_t)
 files_getattr_all_dirs(automount_t)
@@ -104,11 +107,14 @@
 files_getattr_default_dirs(automount_t)
 # because config files can be shell scripts
 files_exec_etc_files(automount_t)
+files_mounton_mnt(automount_t)
 
 fs_getattr_all_fs(automount_t)
 fs_getattr_all_dirs(automount_t)
 fs_search_auto_mountpoints(automount_t)
 fs_manage_auto_mountpoints(automount_t)
+fs_unmount_autofs(automount_t)
+fs_mount_autofs(automount_t)
 
 term_dontaudit_use_console(automount_t)
 term_dontaudit_getattr_pty_dirs(automount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cron.te serefpolicy-2.2.45/policy/modules/services/cron.te
--- nsaserefpolicy/policy/modules/services/cron.te	2006-06-06 22:21:53.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/services/cron.te	2006-06-09 15:45:23.000000000 -0400
@@ -353,6 +353,7 @@
 
 	tunable_policy(`cron_can_relabel',`
 		seutil_domtrans_setfiles(system_crond_t)
+		seutil_domtrans_restorecon(system_crond_t)
 	',`
 		selinux_get_fs_mount(system_crond_t)
 		selinux_validate_context(system_crond_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.te serefpolicy-2.2.45/policy/modules/services/cups.te
--- nsaserefpolicy/policy/modules/services/cups.te	2006-06-08 23:00:30.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/services/cups.te	2006-06-09 15:45:23.000000000 -0400
@@ -638,6 +638,10 @@
 ')
 
 optional_policy(`
+	mount_send_nfs_client_request(hplip_t)
+')
+
+optional_policy(`
 	udev_read_db(hplip_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ftp.te serefpolicy-2.2.45/policy/modules/services/ftp.te
--- nsaserefpolicy/policy/modules/services/ftp.te	2006-06-08 08:45:58.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/services/ftp.te	2006-06-09 15:45:23.000000000 -0400
@@ -59,6 +59,7 @@
 
 allow ftpd_t ftpd_var_run_t:file create_file_perms;
 allow ftpd_t ftpd_var_run_t:dir rw_dir_perms;
+allow ftpd_t ftpd_var_run_t:sock_file create_file_perms;
 files_pid_filetrans(ftpd_t,ftpd_var_run_t,file)
 
 # Create and modify /var/log/xferlog.
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.2.45/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2006-06-06 22:21:54.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/services/hal.te	2006-06-09 15:45:23.000000000 -0400
@@ -140,6 +140,8 @@
 
 sysnet_read_config(hald_t)
 
+auth_use_nsswitch(hald_t)
+
 userdom_dontaudit_use_unpriv_user_fds(hald_t)
 userdom_dontaudit_search_sysadm_home_dirs(hald_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/kerberos.te serefpolicy-2.2.45/policy/modules/services/kerberos.te
--- nsaserefpolicy/policy/modules/services/kerberos.te	2006-06-06 22:21:54.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/services/kerberos.te	2006-06-12 11:25:20.000000000 -0400
@@ -188,6 +188,7 @@
 kernel_read_kernel_sysctls(krb5kdc_t)
 kernel_list_proc(krb5kdc_t)
 kernel_read_proc_symlinks(krb5kdc_t)
+kernel_read_network_state(krb5kdc_t)
 
 corenet_non_ipsec_sendrecv(krb5kdc_t)
 corenet_tcp_sendrecv_all_if(krb5kdc_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/mysql.te serefpolicy-2.2.45/policy/modules/services/mysql.te
--- nsaserefpolicy/policy/modules/services/mysql.te	2006-06-08 08:45:58.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/services/mysql.te	2006-06-09 15:45:23.000000000 -0400
@@ -101,7 +101,7 @@
 
 miscfiles_read_localization(mysqld_t)
 
-sysnet_use_ldap(mysqld_t)
+auth_use_nsswitch(mysqld_t)
 sysnet_read_config(mysqld_t)
 
 userdom_dontaudit_use_unpriv_user_fds(mysqld_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/networkmanager.te serefpolicy-2.2.45/policy/modules/services/networkmanager.te
--- nsaserefpolicy/policy/modules/services/networkmanager.te	2006-06-08 08:45:58.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/services/networkmanager.te	2006-06-11 07:42:46.000000000 -0400
@@ -172,3 +172,7 @@
 	vpn_domtrans(NetworkManager_t)
 	vpn_signal(NetworkManager_t)
 ')
+
+optional_policy(`
+	ppp_domtrans(NetworkManager_t)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ntp.te serefpolicy-2.2.45/policy/modules/services/ntp.te
--- nsaserefpolicy/policy/modules/services/ntp.te	2006-06-06 22:21:55.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/services/ntp.te	2006-06-09 15:45:23.000000000 -0400
@@ -112,6 +112,8 @@
 
 sysnet_read_config(ntpd_t)
 
+auth_use_nsswitch(ntpd_t)
+
 userdom_dontaudit_use_unpriv_user_fds(ntpd_t)
 userdom_list_sysadm_home_dirs(ntpd_t)
 userdom_dontaudit_list_sysadm_home_dirs(ntpd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/pegasus.if serefpolicy-2.2.45/policy/modules/services/pegasus.if
--- nsaserefpolicy/policy/modules/services/pegasus.if	2005-10-25 13:40:18.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/services/pegasus.if	2006-06-09 15:45:23.000000000 -0400
@@ -1 +1,32 @@
 ## <summary>The Open Group Pegasus CIM/WBEM Server.</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run pegasus.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed to transition.
+##	</summary>
+## </param>
+#
+interface(`pegasus_domtrans',`
+	gen_require(`
+		type pegasus_t, pegasus_exec_t;
+	')
+
+	ifdef(`targeted_policy',`
+		if(pegasus_disable_trans) {
+			can_exec($1,pegasus_exec_t)
+		} else {
+			domain_auto_trans($1,pegasus_exec_t,pegasus_t)
+		}
+	', `
+		domain_auto_trans($1,pegasus_exec_t,pegasus_t)
+	')
+
+	allow $1 pegasus_t:fd use;
+	allow pegasus_t $1:fd use;
+	allow pegasus_t $1:fifo_file rw_file_perms;
+	allow pegasus_t $1:process sigchld;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/pegasus.te serefpolicy-2.2.45/policy/modules/services/pegasus.te
--- nsaserefpolicy/policy/modules/services/pegasus.te	2006-06-08 08:45:58.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/services/pegasus.te	2006-06-09 15:45:23.000000000 -0400
@@ -100,13 +100,12 @@
 
 auth_use_nsswitch(pegasus_t)
 auth_domtrans_chk_passwd(pegasus_t)
+auth_read_shadow(pegasus_t)
 
 domain_use_interactive_fds(pegasus_t)
 domain_read_all_domains_state(pegasus_t)
 
-files_read_etc_files(pegasus_t)
-files_list_var_lib(pegasus_t)
-files_read_var_lib_files(pegasus_t)
+files_read_all_files(pegasus_t)
 files_read_var_lib_symlinks(pegasus_t)
 
 hostname_exec(pegasus_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/procmail.te serefpolicy-2.2.45/policy/modules/services/procmail.te
--- nsaserefpolicy/policy/modules/services/procmail.te	2006-06-06 22:21:55.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/services/procmail.te	2006-06-09 15:45:23.000000000 -0400
@@ -109,3 +109,8 @@
 	spamassassin_exec(procmail_t)
 	spamassassin_exec_client(procmail_t)
 ')
+
+optional_policy(`
+	clamav_domtrans_clamscan(procmail_t)
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/pyzor.te serefpolicy-2.2.45/policy/modules/services/pyzor.te
--- nsaserefpolicy/policy/modules/services/pyzor.te	2006-06-08 08:45:58.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/services/pyzor.te	2006-06-09 15:45:23.000000000 -0400
@@ -126,3 +126,7 @@
 optional_policy(`
 	nscd_socket_use(pyzord_t)
 ')
+
+ifdef(`targeted_policy',`
+	userdom_read_generic_user_home_content_files(pyzord_t)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xfs.te serefpolicy-2.2.45/policy/modules/services/xfs.te
--- nsaserefpolicy/policy/modules/services/xfs.te	2006-05-19 10:07:51.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/services/xfs.te	2006-06-09 15:45:23.000000000 -0400
@@ -69,6 +69,8 @@
 miscfiles_read_localization(xfs_t)
 miscfiles_read_fonts(xfs_t)
 
+auth_use_nsswitch(xfs_t)
+
 userdom_dontaudit_use_unpriv_user_fds(xfs_t)
 userdom_dontaudit_search_sysadm_home_dirs(xfs_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/authlogin.if serefpolicy-2.2.45/policy/modules/system/authlogin.if
--- nsaserefpolicy/policy/modules/system/authlogin.if	2006-05-12 09:22:08.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/system/authlogin.if	2006-06-09 15:45:23.000000000 -0400
@@ -1287,6 +1287,7 @@
 	allow $1 var_auth_t:dir r_dir_perms;
 	allow $1 var_auth_t:file create_file_perms;
 	files_list_var_lib($1)
+	allow $1 self:netlink_route_socket r_netlink_socket_perms;
 
 	sysnet_dns_name_resolve($1)
 	sysnet_use_ldap($1)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/hostname.te serefpolicy-2.2.45/policy/modules/system/hostname.te
--- nsaserefpolicy/policy/modules/system/hostname.te	2006-03-02 18:45:56.000000000 -0500
+++ serefpolicy-2.2.45/policy/modules/system/hostname.te	2006-06-09 15:45:23.000000000 -0400
@@ -8,7 +8,10 @@
 
 type hostname_t;
 type hostname_exec_t;
-init_system_domain(hostname_t,hostname_exec_t)
+
+#dont transition from initrc
+domain_type(hostname_t)
+domain_entry_file(hostname_t,hostname_exec_t)
 role system_r types hostname_t;
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.2.45/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-06-08 23:00:33.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/system/init.te	2006-06-09 15:45:23.000000000 -0400
@@ -345,6 +345,7 @@
 files_mounton_isid_type_dirs(initrc_t)
 files_list_default(initrc_t)
 files_mounton_default(initrc_t)
+files_unlink_boot_flag(initrc_t)
 
 libs_rw_ld_so_cache(initrc_t)
 libs_use_ld_so(initrc_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/logging.fc serefpolicy-2.2.45/policy/modules/system/logging.fc
--- nsaserefpolicy/policy/modules/system/logging.fc	2006-02-02 16:12:27.000000000 -0500
+++ serefpolicy-2.2.45/policy/modules/system/logging.fc	2006-06-09 15:45:23.000000000 -0400
@@ -1,9 +1,6 @@
 
 /dev/log			-s	gen_context(system_u:object_r:devlog_t,s0)
 
-/etc/auditd.conf		--	gen_context(system_u:object_r:auditd_etc_t,s0)
-/etc/audit.rules		--	gen_context(system_u:object_r:auditd_etc_t,s0)
-
 /sbin/auditctl		--	gen_context(system_u:object_r:auditctl_exec_t,s0)
 /sbin/auditd		--	gen_context(system_u:object_r:auditd_exec_t,s0)
 /sbin/klogd		--	gen_context(system_u:object_r:klogd_exec_t,s0)
@@ -39,3 +36,6 @@
 /var/spool/postfix/pid	-d	gen_context(system_u:object_r:var_run_t,s0)
 
 /var/tinydns/log/main(/.*)?	gen_context(system_u:object_r:var_log_t,s0)
+/etc/audit(/.*)?		gen_context(system_u:object_r:auditd_etc_t,s15:c0.c255)
+
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/logging.te serefpolicy-2.2.45/policy/modules/system/logging.te
--- nsaserefpolicy/policy/modules/system/logging.te	2006-06-08 08:45:58.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/system/logging.te	2006-06-09 15:45:23.000000000 -0400
@@ -70,6 +70,7 @@
 
 allow auditctl_t etc_t:file { getattr read };
 
+allow auditctl_t auditd_etc_t:dir r_dir_perms;
 allow auditctl_t auditd_etc_t:file r_file_perms;
 
 # Needed for adding watches
@@ -111,6 +112,7 @@
 allow auditd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay nlmsg_readpriv };
 allow auditd_t self:fifo_file rw_file_perms;
 
+allow auditd_t auditd_etc_t:dir r_dir_perms;
 allow auditd_t auditd_etc_t:file r_file_perms;
 
 allow auditd_t auditd_log_t:dir rw_dir_perms;
@@ -123,9 +125,8 @@
 files_pid_filetrans(auditd_t,auditd_var_run_t,file)
 
 kernel_read_kernel_sysctls(auditd_t)
-# Needs to be able to run dispatcher.  see /etc/audit/auditd.conf
-# Probably want a transition, and a new auditd_helper app
-kernel_read_system_state(auditd_t)
+kernel_list_proc(auditd_t)
+kernel_read_proc_symlinks(auditd_t)
 
 dev_read_sysfs(auditd_t)
 
@@ -134,11 +135,12 @@
 
 term_dontaudit_use_console(auditd_t)
 
+# cjp: why?
 # Needs to be able to run dispatcher.  see /etc/audit/auditd.conf
 # Probably want a transition, and a new auditd_helper app
 corecmd_exec_sbin(auditd_t)
 corecmd_exec_bin(auditd_t)
-
+kernel_read_system_state(auditd_t)
 
 domain_use_interactive_fds(auditd_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.2.45/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2006-06-06 22:21:56.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/system/mount.te	2006-06-09 15:45:23.000000000 -0400
@@ -111,6 +111,7 @@
 	tunable_policy(`allow_mount_anyfile',`
 		auth_read_all_dirs_except_shadow(mount_t)
 		auth_read_all_files_except_shadow(mount_t)
+		files_mounton_all_files(mount_t)
 	')
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.te serefpolicy-2.2.45/policy/modules/system/selinuxutil.te
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2006-05-19 10:07:51.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/system/selinuxutil.te	2006-06-12 12:06:22.000000000 -0400
@@ -118,6 +118,9 @@
 type semanage_trans_lock_t; 
 files_type(semanage_trans_lock_t)
 
+type semanage_tmp_t; 
+files_tmp_file(semanage_tmp_t)
+
 type setfiles_t, can_relabelto_binary_policy;
 domain_obj_id_change_exemption(setfiles_t)
 domain_type(setfiles_t)
@@ -531,12 +534,17 @@
 # semodule local policy
 #
 
+allow semanage_t self:capability dac_override;
 allow semanage_t self:unix_stream_socket create_stream_socket_perms;
 allow semanage_t self:unix_dgram_socket create_socket_perms;
 allow semanage_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 
 allow semanage_t policy_config_t:file { read write };
 
+allow semanage_t semanage_tmp_t:dir create_dir_perms;
+allow semanage_t semanage_tmp_t:file create_file_perms;
+files_tmp_filetrans(semanage_t, semanage_tmp_t, { file dir })
+
 kernel_read_system_state(semanage_t)
 kernel_read_kernel_sysctls(semanage_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.fc serefpolicy-2.2.45/policy/modules/system/unconfined.fc
--- nsaserefpolicy/policy/modules/system/unconfined.fc	2006-06-08 08:45:58.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/system/unconfined.fc	2006-06-09 15:45:23.000000000 -0400
@@ -4,7 +4,9 @@
 # For the time being until someone writes a sane policy, we need initrc to transition to unconfined_t
 /usr/bin/vncserver	--	gen_context(system_u:object_r:unconfined_exec_t,s0)
 
-ifdef(`targeted_policy',`
-/usr/lib/openoffice.org.*/program/.*\.bin -- gen_context(system_u:object_r:unconfined_execmem_exec_t,s0)
-/usr/bin/valgrind 	--	gen_context(system_u:object_r:unconfined_execmem_exec_t,s0)
+/usr/lib/openoffice.org.*/program/.*\.bin	-- gen_context(system_u:object_r:unconfined_execmem_exec_t,s0)
+/usr/bin/valgrind 	-- gen_context(system_u:object_r:unconfined_execmem_exec_t,s0)
+ifdef(`targeted_policy', `
+/usr/bin/mplayer 	-- gen_context(system_u:object_r:unconfined_execmem_exec_t,s0)
 ')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.if serefpolicy-2.2.45/policy/modules/system/unconfined.if
--- nsaserefpolicy/policy/modules/system/unconfined.if	2006-05-19 13:46:37.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/system/unconfined.if	2006-06-09 15:45:23.000000000 -0400
@@ -449,3 +449,31 @@
 
 	allow $1 unconfined_t:dbus acquire_svc;
 ')
+
+########################################
+## <summary>
+##	Execute the application that requires dexecmem program in the unconfined_execmem domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`unconfined_execmem_domtrans',`
+	ifdef(`targeted_policy',`
+		gen_require(`
+			type unconfined_execmem_t, unconfined_execmem_exec_t;
+		')
+
+		corecmd_search_bin($1)
+		domain_auto_trans($1, unconfined_execmem_exec_t, unconfined_execmem_t)
+
+		allow $1 unconfined_execmem_t:fd use;
+		allow unconfined_execmem_t $1:fd use;
+		allow unconfined_execmem_t $1:fifo_file rw_file_perms;
+		allow unconfined_execmem_t $1:process sigchld;
+	',`
+		errprint(`Warning: $0($1) has no effect in strict policy.'__endline__)
+	')
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.te serefpolicy-2.2.45/policy/modules/system/unconfined.te
--- nsaserefpolicy/policy/modules/system/unconfined.te	2006-06-08 08:45:58.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/system/unconfined.te	2006-06-09 15:45:23.000000000 -0400
@@ -33,8 +33,6 @@
 	allow unconfined_t self:system syslog_read;
 	dontaudit unconfined_t self:capability sys_module;
 
-	domain_auto_trans(unconfined_t,unconfined_execmem_exec_t,unconfined_execmem_t)
-
 	files_create_boot_flag(unconfined_t)
 
 	init_domtrans_script(unconfined_t)
@@ -114,6 +112,10 @@
 	')
 
 	optional_policy(`
+		unconfined_execmem_domtrans(unconfined_t)
+	')
+
+	optional_policy(`
 		lpd_domtrans_checkpc(unconfined_t)
 	')
 
@@ -180,11 +182,16 @@
 	optional_policy(`
 		xserver_domtrans_xdm_xserver(unconfined_t)
 	')
+
+	optional_policy(`
+		pegasus_domtrans(unconfined_t)
+	')
+
 ')
 
 ########################################
 #
-# Unconfined Execmem Local policy
+# Local policy
 #
 
 ifdef(`targeted_policy',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.if serefpolicy-2.2.45/policy/modules/system/userdomain.if
--- nsaserefpolicy/policy/modules/system/userdomain.if	2006-06-06 22:21:56.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/system/userdomain.if	2006-06-12 10:32:05.000000000 -0400
@@ -474,34 +474,6 @@
 		xserver_create_xdm_tmp_sockets($1_t)
 	')
 
-	ifdef(`TODO',`
-	#
-	# Cups daemon running as user tries to write /etc/printcap
-	#
-	dontaudit $1_t usr_t:file setattr;
-
-	# /initrd is left mounted, various programs try to look at it
-	dontaudit $1_t ramfs_t:dir getattr;
-
-	#
-	# Running ifconfig as a user generates the following
-	#
-	dontaudit $1_t sysctl_net_t:dir search;
-
-	r_dir_file($1_t, usercanread)
-
-	# old browser_domain():
-	dontaudit $1 { fs_type proc_fs dev_fs sysctl_type }:dir_file_class_set getattr;
-	dontaudit $1 { fs_type proc_fs dev_fs sysctl_type }:dir search;
-	dontaudit $1 { fs_type proc_fs dev_fs sysctl_type }:dir read;
-
-	allow $1_t usbtty_device_t:chr_file read;
-
-	ifdef(`xdm.te', `
-		allow $1_t xdm_var_lib_t:file r_file_perms;
-	')
-	') dnl endif TODO
-
 ')
 
 #######################################
@@ -4174,7 +4146,7 @@
 	gen_require(`
 		type user_home_dir_t;
 	')
-
+	allow $1 user_home_dir_t:dir manage_dir_perms;
 	files_home_filetrans($1,user_home_dir_t,dir)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.2.45/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-06-08 08:45:58.000000000 -0400
+++ serefpolicy-2.2.45/policy/modules/system/userdomain.te	2006-06-09 15:45:23.000000000 -0400
@@ -1,11 +1,12 @@
 
-policy_module(userdomain,1.3.27)
+policy_module(userdomain,1.3.26)
 
 gen_require(`
 	role sysadm_r, staff_r, user_r;
 
 	ifdef(`enable_mls',`
 		role secadm_r;
+		role auditadm_r;
 	')
 ')
 
@@ -67,6 +68,7 @@
 	# Define some type aliases to help with compatibility with
 	# macros and domains from the "strict" policy.
 	unconfined_alias_domain(secadm_t)
+	unconfined_alias_domain(auditadm_t)
 	unconfined_alias_domain(sysadm_t)
 
 	# User home directory type.
@@ -82,6 +84,7 @@
 
 	# compatibility for switching from strict
 #	dominance { role secadm_r { role system_r; }}
+#	dominance { role auditadm_r { role system_r; }}
 #	dominance { role sysadm_r { role system_r; }}
 #	dominance { role user_r { role system_r; }}
 #	dominance { role staff_r { role system_r; }}
@@ -105,8 +108,10 @@
 
 	ifdef(`enable_mls',`
 		allow secadm_r system_r;
+		allow auditadm_r system_r;
 		allow secadm_r user_r;
 		allow staff_r secadm_r;
+		allow staff_r auditadm_r;
 	')
 
 	optional_policy(`
@@ -126,9 +131,21 @@
 	role_change(staff, sysadm)
 
 	ifdef(`enable_mls',`
-		admin_user_template(secadm)
+#		admin_user_template(secadm)
+#		admin_user_template(auditadm)
+		unpriv_user_template(secadm)
+		unpriv_user_template(auditadm)
+
+		role_change(staff,auditadm)
 		role_change(staff,secadm)
+
 		role_change(sysadm,secadm)
+		role_change(sysadm,auditadm)
+
+		role_change(auditadm,secadm)
+		role_change(auditadm,sysadm)
+
+		role_change(secadm,auditadm)
 		role_change(secadm,sysadm)
 	')
 
@@ -172,19 +189,33 @@
 	')
 
 	ifdef(`enable_mls',`
+		allow secadm_t self:capability dac_override;
 		corecmd_exec_shell(secadm_t)
 		mls_process_read_up(secadm_t)
+		mls_file_read_up(secadm_t)
 		mls_file_write_down(secadm_t)
 		mls_file_upgrade(secadm_t)
 		mls_file_downgrade(secadm_t)
 		init_exec(secadm_t)
 		logging_read_audit_log(secadm_t)
-		logging_run_auditctl(secadm_t,secadm_r,{ secadm_tty_device_t secadm_devpts_t })
 		userdom_dontaudit_append_staff_home_content_files(secadm_t)
-		files_relabel_all_files(secadm_t)
+	        auth_relabel_all_files_except_shadow(secadm_t)
 		auth_relabel_shadow(secadm_t)
+		domain_obj_id_change_exemption(secadm_t)
+	        logging_read_generic_logs(secadm_t)
+
+		seutil_run_runinit(auditadm_t, auditadm_r, { auditadm_tty_device_t auditadm_devpts_t })
+		domain_kill_all_domains(auditadm_t)
+	        seutil_read_bin_policy(auditadm_t)
+		corecmd_exec_shell(auditadm_t)
+	        logging_read_generic_logs(auditadm_t)
+		logging_manage_audit_log(auditadm_t)
+		logging_manage_audit_config(auditadm_t)
+		logging_run_auditctl(auditadm_t,auditadm_r,{ auditadm_tty_device_t auditadm_devpts_t })
+		logging_run_auditd(auditadm_t, auditadm_r, { auditadm_tty_device_t auditadm_devpts_t })
 	', `
-		logging_read_audit_log(sysadm_t)
+		logging_manage_audit_log(sysadm_t)
+		logging_manage_audit_config(sysadm_t)
 		logging_run_auditctl(sysadm_t,sysadm_r,admin_terminal)
 	')
 
@@ -252,6 +283,7 @@
 
 		ifdef(`enable_mls',`
 			consoletype_exec(secadm_t)
+			consoletype_exec(auditadm_t)
 		')
 	')
 
@@ -270,6 +302,7 @@
 
 		ifdef(`enable_mls',`
 			dmesg_exec(secadm_t)
+			dmesg_exec(auditadm_t)
 		')
 	')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/rolemap serefpolicy-2.2.45/policy/rolemap
--- nsaserefpolicy/policy/rolemap	2006-01-26 15:38:41.000000000 -0500
+++ serefpolicy-2.2.45/policy/rolemap	2006-06-09 15:45:23.000000000 -0400
@@ -15,5 +15,6 @@
 
 	ifdef(`enable_mls',`
 		secadm_r secadm secadm_t
+		auditadm_r auditadm auditadm_t
 	')
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/support/misc_macros.spt serefpolicy-2.2.45/policy/support/misc_macros.spt
--- nsaserefpolicy/policy/support/misc_macros.spt	2006-05-19 10:07:51.000000000 -0400
+++ serefpolicy-2.2.45/policy/support/misc_macros.spt	2006-06-09 15:45:23.000000000 -0400
@@ -37,7 +37,7 @@
 #
 # gen_context(context,mls_sensitivity,[mcs_categories])
 #
-define(`gen_context',`$1`'ifdef(`enable_mls',`:$2')`'ifdef(`enable_mcs',`:s0`'ifelse(`$3',,,`:$3')')')dnl
+define(`gen_context',`$1`'ifdef(`enable_mls',`:$2')`'ifdef(`enable_mcs',`:s0`'ifelse(`$3',,,`:$3')')') dnl
 
 ########################################
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/users serefpolicy-2.2.45/policy/users
--- nsaserefpolicy/policy/users	2006-02-15 17:02:30.000000000 -0500
+++ serefpolicy-2.2.45/policy/users	2006-06-09 15:45:23.000000000 -0400
@@ -29,7 +29,7 @@
 gen_user(user_u, user, user_r sysadm_r system_r, s0, s0 - s15:c0.c255, c0.c255)
 ',`
 gen_user(user_u, user, user_r, s0, s0)
-gen_user(staff_u, staff, staff_r sysadm_r ifdef(`enable_mls',`secadm_r'), s0, s0 - s15:c0.c255, c0.c255)
+gen_user(staff_u, staff, staff_r sysadm_r ifdef(`enable_mls',`secadm_r auditadm_r'), s0, s0 - s15:c0.c255, c0.c255)
 gen_user(sysadm_u, sysadm, sysadm_r, s0, s0 - s15:c0.c255, c0.c255)
 ')
 
@@ -44,8 +44,8 @@
 	gen_user(root, user, user_r sysadm_r system_r, s0, s0 - s15:c0.c255, c0.c255)
 ',`
 	ifdef(`direct_sysadm_daemon',`
-		gen_user(root, sysadm, sysadm_r staff_r ifdef(`enable_mls',`secadm_r') system_r, s0, s0 - s15:c0.c255, c0.c255)
+		gen_user(root, sysadm, sysadm_r staff_r ifdef(`enable_mls',`secadm_r auditadm_r') system_r, s0, s0 - s15:c0.c255, c0.c255)
 	',`
-		gen_user(root, sysadm, sysadm_r staff_r ifdef(`enable_mls',`secadm_r'), s0, s0 - s15:c0.c255, c0.c255)
+		gen_user(root, sysadm, sysadm_r staff_r ifdef(`enable_mls',`secadm_r auditadm_r'), s0, s0 - s15:c0.c255, c0.c255)
 	')
 ')

--------------080609040004050308010402--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
