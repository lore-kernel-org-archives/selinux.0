From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux <SELinux@tycho.nsa.gov>
Subject: policy patch
Date: Wed, 13 Oct 2004 15:55:15 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DNMbBV6sQAHMfpU"
Message-Id: <200410131555.15726.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_DNMbBV6sQAHMfpU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Allow checkpolicy to access /dev/tty.

Change var_lib_rpm_t to rpm_var_lib_t.

Allow load_policy to access /dev/tty.

Removed a dontaudit from login.te that was only needed if you had both a buggy 
init and booted in permissive mode.

Allow setfiles to access /dev/tty, create unix datagram sockets, and read 
locale data.

syslogd should not be running before /dev is labelled so it has no need to 
access tmpfs_t.

Make useradd and groupadd run in the correct domain when run from firstboot to 
give the files the right context.

Allow fsdaemon_t to access etc_runtime_t for /etc/smartd.conf.

Make kmodule run in kudzu_t (it's from the same code base).

Some minor improvements to mailman policy.

Fix a Red Hat Postfix problem and the postconf problem.

Removed some typealias rules that aren't needed any more.

tftpdir_t generally is not the root of a file system and should not have 
attribute root_dir_type.

Added support for the new master socket support in ssh.

xdm_t should not even get access to most types that are labeled as 
homedirfile, so changed the rule to use the attribute home_dir_type.

Fixed howl_t port assignments.  Either howl code has changed recently or the 
current policy was merged wrong.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_DNMbBV6sQAHMfpU
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

diff -ru /usr/src/se/policy/domains/program/checkpolicy.te ./domains/program/checkpolicy.te
--- /usr/src/se/policy/domains/program/checkpolicy.te	2004-09-16 18:06:45.000000000 +1000
+++ ./domains/program/checkpolicy.te	2004-10-04 05:46:14.000000000 +1000
@@ -46,7 +46,7 @@
 `allow checkpolicy_t sshd_devpts_t:dir r_dir_perms;')
 
 # Other access
-allow checkpolicy_t { initrc_devpts_t admin_tty_type }:chr_file { read write ioctl getattr };
+allow checkpolicy_t { initrc_devpts_t admin_tty_type devtty_t }:chr_file { read write ioctl getattr };
 uses_shlib(checkpolicy_t)
 allow checkpolicy_t self:capability dac_override;
 
diff -ru /usr/src/se/policy/domains/program/initrc.te ./domains/program/initrc.te
--- /usr/src/se/policy/domains/program/initrc.te	2004-10-02 03:36:10.000000000 +1000
+++ ./domains/program/initrc.te	2004-10-11 03:45:20.000000000 +1000
@@ -216,8 +216,8 @@
 
 ifdef(`rpm.te', `
 # Access /var/lib/rpm.
-allow initrc_t var_lib_rpm_t:dir rw_dir_perms;
-allow initrc_t var_lib_rpm_t:file create_file_perms;
+allow initrc_t rpm_var_lib_t:dir rw_dir_perms;
+allow initrc_t rpm_var_lib_t:file create_file_perms;
 ')
 ')dnl end distro_redhat
 
diff -ru /usr/src/se/policy/domains/program/load_policy.te ./domains/program/load_policy.te
--- /usr/src/se/policy/domains/program/load_policy.te	2004-08-08 22:16:26.000000000 +1000
+++ ./domains/program/load_policy.te	2004-10-04 05:45:00.000000000 +1000
@@ -48,7 +48,7 @@
 allow load_policy_t devpts_t:dir r_dir_perms;
 
 # Other access
-allow load_policy_t { admin_tty_type initrc_devpts_t }:chr_file { read write ioctl getattr };
+allow load_policy_t { admin_tty_type initrc_devpts_t devtty_t }:chr_file { read write ioctl getattr };
 uses_shlib(load_policy_t)
 allow load_policy_t self:capability dac_override;
 
diff -ru /usr/src/se/policy/domains/program/login.te ./domains/program/login.te
--- /usr/src/se/policy/domains/program/login.te	2004-09-11 16:21:43.000000000 +1000
+++ ./domains/program/login.te	2004-09-07 22:37:55.000000000 +1000
@@ -130,7 +130,6 @@
 can_ypbind($1_login_t)
 
 allow $1_login_t mouse_device_t:chr_file { getattr setattr };
-dontaudit $1_login_t init_t:fd { use };
 ')dnl end login_domain macro
 #################################
 #
diff -ru /usr/src/se/policy/domains/program/setfiles.te ./domains/program/setfiles.te
--- /usr/src/se/policy/domains/program/setfiles.te	2004-09-03 14:10:30.000000000 +1000
+++ ./domains/program/setfiles.te	2004-10-04 06:11:39.000000000 +1000
@@ -19,7 +19,9 @@
 role sysadm_r types setfiles_t;
 
 allow setfiles_t initrc_devpts_t:chr_file { read write ioctl };
-allow setfiles_t { ttyfile ptyfile tty_device_t admin_tty_type }:chr_file { read write ioctl };
+allow setfiles_t { ttyfile ptyfile tty_device_t admin_tty_type devtty_t }:chr_file { read write ioctl };
+
+allow setfiles_t self:unix_dgram_socket create_socket_perms;
 
 domain_auto_trans(sysadm_t, setfiles_exec_t, setfiles_t)
 allow setfiles_t { userdomain privfd initrc_t init_t }:fd use;
@@ -46,6 +48,8 @@
 allow setfiles_t fs_t:filesystem getattr;
 allow setfiles_t fs_type:dir r_dir_perms;
 
+read_locale(setfiles_t)
+
 allow setfiles_t etc_runtime_t:file read;
 allow setfiles_t etc_t:file read;
 allow setfiles_t proc_t:file { getattr read };
diff -ru /usr/src/se/policy/domains/program/sulogin.te ./domains/program/sulogin.te
--- /usr/src/se/policy/domains/program/sulogin.te	2004-10-02 03:36:11.000000000 +1000
+++ ./domains/program/sulogin.te	2004-10-11 04:37:17.000000000 +1000
@@ -38,6 +38,10 @@
 
 allow sulogin_t sysadm_devpts_t:chr_file { getattr ioctl read write };
 allow sulogin_t { staff_home_dir_t sysadm_home_dir_t }:dir { search };
+allow sulogin_t default_context_t:dir search;
 allow sulogin_t default_context_t:file { getattr read };
 
 r_dir_file(sulogin_t, selinux_config_t)
+
+# because file systems are not mounted
+dontaudit sulogin_t file_t:dir search;
diff -ru /usr/src/se/policy/domains/program/syslogd.te ./domains/program/syslogd.te
--- /usr/src/se/policy/domains/program/syslogd.te	2004-10-11 03:50:36.000000000 +1000
+++ ./domains/program/syslogd.te	2004-10-11 04:37:44.000000000 +1000
@@ -94,5 +94,4 @@
 # /initrd is not umounted before minilog starts
 #
 dontaudit syslogd_t file_t:dir search;
-allow syslogd_t { tmpfs_t devpts_t }:dir { search };
-dontaudit syslogd_t unlabeled_t:file read;
+allow syslogd_t devpts_t:dir { search };
diff -ru /usr/src/se/policy/domains/program/unused/anaconda.te ./domains/program/unused/anaconda.te
--- /usr/src/se/policy/domains/program/unused/anaconda.te	2004-09-11 16:21:44.000000000 +1000
+++ ./domains/program/unused/anaconda.te	2004-10-11 03:44:38.000000000 +1000
@@ -187,8 +187,8 @@
 ifdef(`distro_redhat', `
 ifdef(`rpm.te', `
 # Access /var/lib/rpm.
-allow anaconda_t var_lib_rpm_t:dir rw_dir_perms;
-allow anaconda_t var_lib_rpm_t:file create_file_perms;
+allow anaconda_t rpm_var_lib_t:dir rw_dir_perms;
+allow anaconda_t rpm_var_lib_t:file create_file_perms;
 domain_auto_trans(anaconda_t, rpm_exec_t, rpm_t)
 ')
 ')
Only in ./domains/program/unused: bindgraph.te
diff -ru /usr/src/se/policy/domains/program/unused/bootloader.te ./domains/program/unused/bootloader.te
--- /usr/src/se/policy/domains/program/unused/bootloader.te	2004-10-11 03:50:36.000000000 +1000
+++ ./domains/program/unused/bootloader.te	2004-10-11 04:38:52.000000000 +1000
@@ -121,7 +121,7 @@
 allow bootloader_t proc_t:dir { getattr search };
 allow bootloader_t proc_t:file r_file_perms;
 allow bootloader_t proc_t:lnk_file { getattr read };
-allow bootloader_t proc_mdstat_t:file r_file_perms;
+allow bootloader_t proc_mdstat_t:file { getattr read };
 allow bootloader_t self:dir { getattr search read };
 allow bootloader_t sysctl_kernel_t:dir search;
 allow bootloader_t sysctl_kernel_t:file { getattr read };
diff -ru /usr/src/se/policy/domains/program/unused/firstboot.te ./domains/program/unused/firstboot.te
--- /usr/src/se/policy/domains/program/unused/firstboot.te	2004-09-24 06:31:21.000000000 +1000
+++ ./domains/program/unused/firstboot.te	2004-10-01 06:19:47.000000000 +1000
@@ -19,7 +19,6 @@
 ')
 
 etc_domain(firstboot)
-typealias firstboot_etc_t alias etc_firstboot_t;
 
 allow firstboot_t proc_t:file r_file_perms;
 
@@ -30,6 +29,8 @@
 file_type_auto_trans(firstboot_t, etc_t, firstboot_rw_t, file)
 
 can_exec_any(firstboot_t)
+domain_auto_trans(firstboot_t, useradd_exec_t, useradd_t)
+domain_auto_trans(firstboot_t, groupadd_exec_t, groupadd_t)
 allow firstboot_t etc_runtime_t:file { getattr read };
 
 r_dir_file(firstboot_t, etc_t)
diff -ru /usr/src/se/policy/domains/program/unused/fs_daemon.te ./domains/program/unused/fs_daemon.te
--- /usr/src/se/policy/domains/program/unused/fs_daemon.te	2004-02-03 02:17:22.000000000 +1100
+++ ./domains/program/unused/fs_daemon.te	2004-10-04 06:05:27.000000000 +1000
@@ -12,3 +12,4 @@
 allow fsdaemon_t device_t:dir read;
 allow fsdaemon_t fixed_disk_device_t:blk_file rw_file_perms;
 allow fsdaemon_t self:capability { sys_rawio sys_admin };
+allow fsdaemon_t etc_runtime_t:file { getattr read };
diff -ru /usr/src/se/policy/domains/program/unused/i18n_input.te ./domains/program/unused/i18n_input.te
--- /usr/src/se/policy/domains/program/unused/i18n_input.te	2004-10-11 03:50:37.000000000 +1000
+++ ./domains/program/unused/i18n_input.te	2004-10-11 04:42:15.000000000 +1000
@@ -12,13 +12,6 @@
 can_network(i18n_input_t)
 can_ypbind(i18n_input_t)
 
-## No Unix Socket Connection at the moment
-##
-# can_unix_send( { i18n_input_t sysadm_t }, { i18n_input_t sysadm_t } )
-# allow i18n_input_t self:unix_dgram_socket create_socket_perms;
-# allow i18n_input_t self:unix_stream_socket create_stream_socket_perms;
-# can_unix_connect(i18n_input_t, self)
-
 can_tcp_connect(userdomain, i18n_input_t)
 
 allow i18n_input_t self:fifo_file rw_file_perms;
diff -ru /usr/src/se/policy/domains/program/unused/kudzu.te ./domains/program/unused/kudzu.te
--- /usr/src/se/policy/domains/program/unused/kudzu.te	2004-10-07 16:14:46.000000000 +1000
+++ ./domains/program/unused/kudzu.te	2004-10-04 05:54:24.000000000 +1000
@@ -15,8 +15,8 @@
 allow kudzu_t etc_t:file { getattr read };
 allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config };
 allow kudzu_t modules_conf_t:file { getattr read };
-allow kudzu_t modules_object_t:dir { getattr search };
-allow kudzu_t modules_dep_t:file { getattr read };
+allow kudzu_t modules_object_t:dir r_dir_perms;
+allow kudzu_t { modules_object_t modules_dep_t }:file { getattr read };
 allow kudzu_t mouse_device_t:chr_file { read write };
 allow kudzu_t proc_t:file { getattr read };
 allow kudzu_t { fixed_disk_device_t removable_device_t }:blk_file rw_file_perms;
diff -ru /usr/src/se/policy/domains/program/unused/mailman.te ./domains/program/unused/mailman.te
--- /usr/src/se/policy/domains/program/unused/mailman.te	2004-08-28 12:05:03.000000000 +1000
+++ ./domains/program/unused/mailman.te	2004-10-08 06:06:06.000000000 +1000
@@ -87,7 +87,10 @@
 
 allow mta_delivery_agent mailman_data_t:dir search;
 allow mta_delivery_agent mailman_data_t:lnk_file read;
-domain_auto_trans(mta_delivery_agent, mailman_mail_exec_t, mailman_mail_t)
+domain_auto_trans({ mta_delivery_agent initrc_t }, mailman_mail_exec_t, mailman_mail_t)
+ifdef(`direct_sysadm_daemon', `
+domain_auto_trans(sysadm_t, mailman_mail_exec_t, mailman_mail_t)
+')
 allow mailman_mail_t self:unix_dgram_socket create_socket_perms;
 
 system_crond_entry(mailman_queue_exec_t, mailman_queue_t)
diff -ru /usr/src/se/policy/domains/program/unused/mdadm.te ./domains/program/unused/mdadm.te
--- /usr/src/se/policy/domains/program/unused/mdadm.te	2004-09-11 16:21:44.000000000 +1000
+++ ./domains/program/unused/mdadm.te	2004-10-04 02:53:30.000000000 +1000
@@ -6,6 +6,8 @@
 daemon_base_domain(mdadm, `, fs_domain')
 role sysadm_r types mdadm_t;
 
+allow initrc_t mdadm_var_run_t:file create_file_perms;
+
 # Kernel filesystem permissions
 r_dir_file(mdadm_t, proc_t)
 allow mdadm_t proc_mdstat_t:file rw_file_perms;
diff -ru /usr/src/se/policy/domains/program/unused/postfix.te ./domains/program/unused/postfix.te
--- /usr/src/se/policy/domains/program/unused/postfix.te	2004-10-02 03:36:11.000000000 +1000
+++ ./domains/program/unused/postfix.te	2004-10-11 15:36:41.000000000 +1000
@@ -94,7 +94,7 @@
 dontaudit postfix_master_t selinux_config_t:dir search;
 can_exec({ sysadm_mail_t system_mail_t }, postfix_master_exec_t)
 ifdef(`distro_redhat', `
-file_type_auto_trans({ sysadm_mail_t system_mail_t }, postfix_etc_t, etc_aliases_t)
+file_type_auto_trans({ sysadm_mail_t system_mail_t postfix_master_t }, postfix_etc_t, etc_aliases_t)
 ', `
 file_type_auto_trans({ sysadm_mail_t system_mail_t }, etc_t, etc_aliases_t)
 ')
@@ -103,7 +103,7 @@
 ifdef(`pppd.te', `
 domain_auto_trans(pppd_t, postfix_master_exec_t, postfix_master_t)
 ')
-can_exec(postfix_master_t, ls_exec_t)
+can_exec(postfix_master_t, { ls_exec_t sbin_t })
 allow postfix_master_t sysctl_kernel_t:dir r_dir_perms;
 allow postfix_master_t sysctl_kernel_t:file r_file_perms;
 allow postfix_master_t self:fifo_file rw_file_perms;
diff -ru /usr/src/se/policy/domains/program/unused/procmail.te ./domains/program/unused/procmail.te
--- /usr/src/se/policy/domains/program/unused/procmail.te	2004-08-28 12:05:04.000000000 +1000
+++ ./domains/program/unused/procmail.te	2004-10-10 17:32:31.000000000 +1000
@@ -70,4 +70,7 @@
 
 ifdef(`sendmail.te', `
 r_dir_file(procmail_t, etc_mail_t)
+ifdef(`hide_broken_symptoms', `
+dontaudit procmail_t mqueue_spool_t:file { getattr read };
+')
 ')
diff -ru /usr/src/se/policy/domains/program/unused/radvd.te ./domains/program/unused/radvd.te
--- /usr/src/se/policy/domains/program/unused/radvd.te	2004-03-18 15:36:09.000000000 +1100
+++ ./domains/program/unused/radvd.te	2004-10-07 14:26:35.000000000 +1000
@@ -11,7 +11,7 @@
 daemon_domain(radvd)
 
 etc_domain(radvd)
-typealias radvd_etc_t alias etc_radvd_t;
+allow radvd_t etc_t:file { getattr read };
 
 allow radvd_t self:{ rawip_socket unix_dgram_socket } rw_socket_perms;
 
diff -ru /usr/src/se/policy/domains/program/unused/rpm.te ./domains/program/unused/rpm.te
--- /usr/src/se/policy/domains/program/unused/rpm.te	2004-10-07 16:14:46.000000000 +1000
+++ ./domains/program/unused/rpm.te	2004-10-11 04:51:43.000000000 +1000
@@ -172,7 +172,7 @@
 allow crond_t rpm_t:fifo_file r_file_perms;
 ')
 
-allow rpm_script_t proc_t:dir { search getattr read };
+allow rpm_script_t proc_t:dir r_dir_perms;
 allow rpm_script_t proc_t:{ file lnk_file } r_file_perms;
 
 allow rpm_script_t devtty_t:chr_file rw_file_perms;
diff -ru /usr/src/se/policy/domains/program/unused/squid.te ./domains/program/unused/squid.te
--- /usr/src/se/policy/domains/program/unused/squid.te	2004-09-16 18:06:56.000000000 +1000
+++ ./domains/program/unused/squid.te	2004-09-29 21:57:20.000000000 +1000
@@ -66,4 +66,6 @@
 allow squid_t { bin_t sbin_t }:dir search;
 
 dontaudit squid_t { home_root_t security_t devpts_t }:dir getattr;
+ifdef(`targeted_policy', `
 dontaudit squid_t tty_device_t:chr_file { read write };
+')
diff -ru /usr/src/se/policy/domains/program/unused/tftpd.te ./domains/program/unused/tftpd.te
--- /usr/src/se/policy/domains/program/unused/tftpd.te	2004-10-11 03:50:38.000000000 +1000
+++ ./domains/program/unused/tftpd.te	2004-10-11 04:54:30.000000000 +1000
@@ -16,7 +16,7 @@
 type tftp_port_t, port_type, reserved_port_type;
 
 # tftpdir_t is the type of files in the /tftpboot directories.
-type tftpdir_t, file_type, root_dir_type, sysadmfile;
+type tftpdir_t, file_type, sysadmfile;
 r_dir_file(tftpd_t, tftpdir_t)
 
 domain_auto_trans(inetd_t, tftpd_exec_t, tftpd_t)
diff -ru /usr/src/se/policy/file_contexts/program/fs_daemon.fc ./file_contexts/program/fs_daemon.fc
--- /usr/src/se/policy/file_contexts/program/fs_daemon.fc	2004-02-03 02:17:23.000000000 +1100
+++ ./file_contexts/program/fs_daemon.fc	2004-10-04 06:04:44.000000000 +1000
@@ -1,3 +1,4 @@
 # fs admin daemons
 /usr/sbin/smartd	--	system_u:object_r:fsdaemon_exec_t
 /var/run/smartd.pid	--	system_u:object_r:fsdaemon_var_run_t
+/etc/smartd.conf	--	system_u:object_r:etc_runtime_t
diff -ru /usr/src/se/policy/file_contexts/program/kudzu.fc ./file_contexts/program/kudzu.fc
--- /usr/src/se/policy/file_contexts/program/kudzu.fc	2003-11-27 05:04:46.000000000 +1100
+++ ./file_contexts/program/kudzu.fc	2004-09-26 05:24:38.000000000 +1000
@@ -1,2 +1,3 @@
 # kudzu
 /usr/sbin/kudzu	--	system_u:object_r:kudzu_exec_t
+/sbin/kmodule	--	system_u:object_r:kudzu_exec_t
diff -ru /usr/src/se/policy/file_contexts/program/mailman.fc ./file_contexts/program/mailman.fc
--- /usr/src/se/policy/file_contexts/program/mailman.fc	2004-10-02 03:36:12.000000000 +1000
+++ ./file_contexts/program/mailman.fc	2004-10-12 17:32:59.000000000 +1000
@@ -14,10 +14,12 @@
 ')
 
 ifdef(`distro_redhat', `
-/usr/lib/mailman/cgi-bin/.* -- system_u:object_r:mailman_cgi_exec_t
+/usr/lib/mailman/cgi-bin/.*	-- system_u:object_r:mailman_cgi_exec_t
 /var/mailman(/.*)?		   system_u:object_r:mailman_data_t
 /var/mailman/locks(/.*)?	   system_u:object_r:mailman_lock_t
 /var/mailman/archives(/.*)?	   system_u:object_r:mailman_archive_t
 /usr/lib/mailman/scripts/mailman -- system_u:object_r:mailman_mail_exec_t
-/usr/lib/mailman/bin/qrunner     -- system_u:object_r:mailman_queue_exec_t
+/usr/lib/mailman/bin/qrunner  	-- system_u:object_r:mailman_queue_exec_t
+/var/mailman/lists(/.*)?	system_u:object_r:mailman_data_t
+/var/mailman/logs(/.*)?		   system_u:object_r:mailman_log_t
 ')
diff -ru /usr/src/se/policy/file_contexts/program/postfix.fc ./file_contexts/program/postfix.fc
--- /usr/src/se/policy/file_contexts/program/postfix.fc	2004-09-23 22:31:22.000000000 +1000
+++ ./file_contexts/program/postfix.fc	2004-10-11 15:35:56.000000000 +1000
@@ -18,7 +18,6 @@
 /usr/lib(exec)?/postfix/pipe	--	system_u:object_r:postfix_pipe_exec_t
 /usr/sbin/postalias	--	system_u:object_r:postfix_master_exec_t
 /usr/sbin/postcat	--	system_u:object_r:postfix_master_exec_t
-/usr/sbin/postconf	--	system_u:object_r:postfix_master_exec_t
 /usr/sbin/postdrop	--	system_u:object_r:postfix_postdrop_exec_t
 /usr/sbin/postfix	--	system_u:object_r:postfix_master_exec_t
 /usr/sbin/postkick	--	system_u:object_r:postfix_master_exec_t
diff -ru /usr/src/se/policy/macros/global_macros.te ./macros/global_macros.te
--- /usr/src/se/policy/macros/global_macros.te	2004-10-07 16:14:50.000000000 +1000
+++ ./macros/global_macros.te	2004-09-29 01:13:57.000000000 +1000
@@ -373,7 +372,6 @@
 # classes to use; default is file.
 define(`var_run_domain', `
 type $1_var_run_t, file_type, sysadmfile, pidfile;
-typealias $1_var_run_t alias var_run_$1_t;
 
 ifelse(`$2', `', `
 file_type_auto_trans($1_t, var_run_t, $1_var_run_t, file)
diff -ru /usr/src/se/policy/macros/program/ssh_macros.te ./macros/program/ssh_macros.te
--- /usr/src/se/policy/macros/program/ssh_macros.te	2004-10-11 03:50:41.000000000 +1000
+++ ./macros/program/ssh_macros.te	2004-09-30 07:08:07.000000000 +1000
@@ -104,6 +104,8 @@
 
 # Access the users .ssh directory.
 file_type_auto_trans({ sysadm_ssh_t $1_ssh_t }, $1_home_dir_t, $1_home_ssh_t, dir)
+file_type_auto_trans($1_ssh_t, $1_home_dir_t, $1_home_ssh_t, sock_file)
+allow $1_t $1_home_ssh_t:sock_file create_file_perms;
 allow { sysadm_ssh_t $1_ssh_t } $1_home_ssh_t:file create_file_perms;
 allow { sysadm_ssh_t $1_ssh_t } $1_home_ssh_t:lnk_file { getattr read };
 dontaudit $1_ssh_t $1_home_t:dir { getattr search };
diff -ru /usr/src/se/policy/macros/program/xserver_macros.te ./macros/program/xserver_macros.te
--- /usr/src/se/policy/macros/program/xserver_macros.te	2004-10-11 03:50:41.000000000 +1000
+++ ./macros/program/xserver_macros.te	2004-10-11 14:34:17.000000000 +1000
@@ -64,7 +64,7 @@
 
 allow xdm_xserver_t init_t:fd use;
 
-dontaudit xdm_xserver_t homedirfile:dir { read search };
+dontaudit xdm_xserver_t home_dir_type:dir { read search };
 ', `
 # The user role is authorized for this domain.
 role $1_r types $1_xserver_t;
diff -ru /usr/src/se/policy/net_contexts ./net_contexts
--- /usr/src/se/policy/net_contexts	2004-10-07 16:14:35.000000000 +1000
+++ ./net_contexts	2004-10-07 18:39:54.000000000 +1000
@@ -158,7 +158,10 @@
 portcon tcp 5323 system_u:object_r:imaze_port_t
 portcon udp 5323 system_u:object_r:imaze_port_t
 ')
-ifdef(`howl.te', `portcon tcp 5353 system_u:object_r:howl_port_t')
+ifdef(`howl.te', `
+portcon tcp 5335 system_u:object_r:howl_port_t
+portcon udp 5353 system_u:object_r:howl_port_t
+')
 ifdef(`jabberd.te', `
 portcon tcp 5222 system_u:object_r:jabber_client_port_t
 portcon tcp 5223 system_u:object_r:jabber_client_port_t

--Boundary-00=_DNMbBV6sQAHMfpU--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
