Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8TJ5oFr032192
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 15:05:50 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8TJ5Gu8005120
	for <selinux@tycho.nsa.gov>; Fri, 29 Sep 2006 19:05:16 GMT
Message-ID: <451D6E92.70607@redhat.com>
Date: Fri, 29 Sep 2006 15:05:54 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: latest diffs
Content-Type: multipart/mixed;
 boundary="------------000604090308020903090009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000604090308020903090009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added two new booleans.

allow_polyinstatiation which will remove lots of privs if your system 
does not use it.

intel wants to allow ia32el to dynamically transition from unconfined_t 
to unconfined_execmem_t when running 32 bit applications on ia64 
platforms.  We do not want this in general so this boolean turns it off

allow_unconfined_execmem_dyntrans


On MLS machines we do not want certain user roles to be able to execute 
some confined domains.  So I added a new attribute user_exec_file that 
designates confined apps that can be executed by user accounts without  
a dynamic transition.

Amanda now needs to create directories in amanda_log_t.

yum-updatesd is marked as rpm_exec_t and needs to dbus to mono apps.

rpm_scripts needs to be able to run pidof and stuff like that so needs 
mcs_ptrace_all and killall

sysadm_passwd_t runs nscd apps

rhgb executes files in /etc/profile.d

vmware requires unconfined_t node_type:rawip_socket node_bind

relabeling of chr_devices for cups in MLS requires relaabelto

automount wants to manage autofs_t:sym_link

Adding support for fuse-encfs although kernel section is broken

rhgb needs to setattr on it devpts_t

automount uses rawip_socket

cupsd needs to read hplib_etc_t files/dirs

dovecot wants to rewrite utmp file

hal wants to be able to create symlinks in /media (ipod for example)

Additional lpr_exec_t, sorry about not fixing the ones you already added

dontaudt ncsd_t trying to talk to sysadm_t when run under the covers of 
useradd

rhgb needs access to devpts chr_file

rhgb runs consoletype

It also needs siginh on xserver to work properly

setroubleshoot needs getsched

Began iscsi domain

libjavaplugin_ojigcc3 needs textrel

auditctl needs to be able to getattr on file systems

auditd needs fs_use_all_levels

fusermount needs label

mdadm wants to rw_dir on mdadm_var_run_t:dir


newrole needs multilevel fd

semanage_t needs to verify file context

setrands needs mls fd access

Don't transition to bluetooth_helper from unconfined_t

unconfined_t needs to be able to kill and ptrace all apps

xend needs to communicate with xserver over tcp (vnc?)





--------------000604090308020903090009
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/global_tunables serefpolicy-2.3.16/policy/global_tunables
--- nsaserefpolicy/policy/global_tunables	2006-09-25 15:11:11.000000000 -0400
+++ serefpolicy-2.3.16/policy/global_tunables	2006-09-27 17:30:35.000000000 -0400
@@ -594,3 +594,18 @@
 ## </desc>
 gen_tunable(spamd_enable_home_dirs,true)
 ')
+
+## <desc>
+## <p>
+## Allow httpd cgi support
+## </p>
+## </desc>
+gen_tunable(allow_polyinstantiation,false)
+
+
+## <desc>
+## <p>
+## Allow unconfined to dyntrans to unconfined_execmem
+## </p>
+## </desc>
+gen_tunable(allow_unconfined_execmem_dyntrans,false)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/acct.te serefpolicy-2.3.16/policy/modules/admin/acct.te
--- nsaserefpolicy/policy/modules/admin/acct.te	2006-07-14 17:04:46.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/admin/acct.te	2006-09-27 16:09:00.000000000 -0400
@@ -9,6 +9,7 @@
 type acct_t;
 type acct_exec_t;
 init_system_domain(acct_t,acct_exec_t)
+userdom_executable_file(acct_exec_t)
 
 type acct_data_t;
 logging_log_file(acct_data_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/amanda.te serefpolicy-2.3.16/policy/modules/admin/amanda.te
--- nsaserefpolicy/policy/modules/admin/amanda.te	2006-09-22 14:07:08.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/admin/amanda.te	2006-09-26 20:28:43.000000000 -0400
@@ -97,7 +97,7 @@
 allow amanda_t amanda_gnutarlists_t:lnk_file manage_file_perms;
 
 allow amanda_t amanda_log_t:file create_file_perms;
-allow amanda_t amanda_log_t:dir { rw_dir_perms setattr };
+allow amanda_t amanda_log_t:dir create_dir_perms;
 logging_log_filetrans(amanda_t,amanda_log_t,{ file dir })
 
 allow amanda_t amanda_tmp_t:dir create_dir_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/consoletype.te serefpolicy-2.3.16/policy/modules/admin/consoletype.te
--- nsaserefpolicy/policy/modules/admin/consoletype.te	2006-08-29 09:00:30.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/admin/consoletype.te	2006-09-27 16:06:16.000000000 -0400
@@ -16,6 +21,7 @@
 ifdef(`targeted_policy',`',`
 	init_system_domain(consoletype_t,consoletype_exec_t)
 ')
+userdom_executable_file(consoletype_exec_t)
 
 ########################################
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/dmesg.te serefpolicy-2.3.16/policy/modules/admin/dmesg.te
--- nsaserefpolicy/policy/modules/admin/dmesg.te	2006-07-14 17:04:46.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/admin/dmesg.te	2006-09-27 16:09:32.000000000 -0400
@@ -10,6 +10,7 @@
 	type dmesg_t;
 	type dmesg_exec_t;
 	init_system_domain(dmesg_t,dmesg_exec_t)
+	userdom_executable_file(dmesg_exec_t)
 	role system_r types dmesg_t;
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/netutils.te serefpolicy-2.3.16/policy/modules/admin/netutils.te
--- nsaserefpolicy/policy/modules/admin/netutils.te	2006-08-02 10:34:09.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/admin/netutils.te	2006-09-27 16:12:06.000000000 -0400
@@ -18,10 +18,12 @@
 type ping_exec_t;
 init_system_domain(ping_t,ping_exec_t)
 role system_r types ping_t;
+userdom_executable_file(ping_exec_t)
 
 type traceroute_t;
 type traceroute_exec_t;
 init_system_domain(traceroute_t,traceroute_exec_t)
+userdom_executable_file(traceroute_exec_t)
 role system_r types traceroute_t;
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.if serefpolicy-2.3.16/policy/modules/admin/rpm.if
--- nsaserefpolicy/policy/modules/admin/rpm.if	2006-09-15 13:14:27.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/admin/rpm.if	2006-09-28 07:58:06.000000000 -0400
@@ -257,3 +257,24 @@
 	dontaudit $1 rpm_var_lib_t:file create_file_perms;
 	dontaudit $1 rpm_var_lib_t:lnk_file create_lnk_perms;
 ')
+
+########################################
+## <summary>
+##	Send and receive messages from
+##	rpm over dbus.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`rpm_dbus_chat',`
+	gen_require(`
+		type rpm_t;
+		class dbus send_msg;
+	')
+
+	allow $1 rpm_t:dbus send_msg;
+	allow rpm_t $1:dbus send_msg;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.te serefpolicy-2.3.16/policy/modules/admin/rpm.te
--- nsaserefpolicy/policy/modules/admin/rpm.te	2006-09-22 14:07:08.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/admin/rpm.te	2006-09-27 16:13:07.000000000 -0400
@@ -9,6 +9,8 @@
 type rpm_t;
 type rpm_exec_t;
 init_system_domain(rpm_t,rpm_exec_t)
+userdom_executable_file(rpm_exec_t)
+
 domain_obj_id_change_exemption(rpm_t)
 domain_role_change_exemption(rpm_t)
 domain_system_change_exemption(rpm_t)
@@ -254,6 +256,9 @@
 kernel_read_kernel_sysctls(rpm_script_t)
 kernel_read_system_state(rpm_script_t)
 
+mcs_killall(rpm_script_t)
+mcs_ptrace_all(rpm_script_t)
+
 dev_list_sysfs(rpm_script_t)
 
 # ideally we would not need this
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/su.if serefpolicy-2.3.16/policy/modules/admin/su.if
--- nsaserefpolicy/policy/modules/admin/su.if	2006-09-22 14:07:08.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/admin/su.if	2006-09-27 10:15:21.000000000 -0400
@@ -266,7 +266,7 @@
 		')
 	')
 
-	ifdef(`enable_polyinstantiation',`
+	tunable_policy(`allow_polyinstantiation',`
 		fs_mount_xattr_fs($1_su_t)
 		fs_unmount_xattr_fs($1_su_t)
 	')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/usermanage.te serefpolicy-2.3.16/policy/modules/admin/usermanage.te
--- nsaserefpolicy/policy/modules/admin/usermanage.te	2006-09-22 14:07:08.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/admin/usermanage.te	2006-09-28 10:21:26.000000000 -0400
@@ -379,6 +379,7 @@
 allow sysadm_passwd_t sysadm_passwd_tmp_t:file create_file_perms;
 files_tmp_filetrans(sysadm_passwd_t, sysadm_passwd_tmp_t, { file dir })
 files_search_var(sysadm_passwd_t)
+files_dontaudit_search_home(sysadm_passwd_t)
 
 kernel_read_kernel_sysctls(sysadm_passwd_t)
 # for /proc/meminfo
@@ -444,6 +445,7 @@
 
 optional_policy(`
 	nscd_domtrans(sysadm_passwd_t)
+	nscd_socket_use(sysadm_passwd_t)
 ')
 
 ########################################
@@ -473,6 +475,8 @@
 selinux_compute_create_context(useradd_t)
 selinux_compute_relabel_context(useradd_t)
 selinux_compute_user_contexts(useradd_t)
+seutil_read_default_contexts(useradd_t)
+
 # for getting the number of groups
 kernel_read_kernel_sysctls(useradd_t)
 
@@ -521,6 +525,7 @@
 userdom_home_filetrans_generic_user_home_dir(useradd_t)
 userdom_manage_generic_user_home_content_dirs(useradd_t)
 userdom_manage_generic_user_home_content_files(useradd_t)
+userdom_manage_user_home_dirs(useradd_t)
 userdom_manage_staff_home_dirs(useradd_t)
 userdom_generic_user_home_dir_filetrans_generic_user_home_content(useradd_t,notdevfile_class_set)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/mono.te serefpolicy-2.3.16/policy/modules/apps/mono.te
--- nsaserefpolicy/policy/modules/apps/mono.te	2006-09-22 14:07:03.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/apps/mono.te	2006-09-28 07:58:50.000000000 -0400
@@ -44,4 +44,7 @@
 	optional_policy(`
 		unconfined_dbus_connect(mono_t)
 	')
+	optional_policy(`
+		rpm_dbus_chat(mono_t)
+	')
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corecommands.fc serefpolicy-2.3.16/policy/modules/kernel/corecommands.fc
--- nsaserefpolicy/policy/modules/kernel/corecommands.fc	2006-09-22 14:07:03.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/kernel/corecommands.fc	2006-09-28 19:35:55.000000000 -0400
@@ -65,6 +65,7 @@
 
 /etc/xen/qemu-ifup		--	gen_context(system_u:object_r:bin_t,s0)
 /etc/xen/scripts(/.*)?			gen_context(system_u:object_r:bin_t,s0)
+/etc/profile.d(/.*)?			gen_context(system_u:object_r:bin_t,s0)
 
 ifdef(`distro_debian',`
 /etc/mysql/debian-start		--	gen_context(system_u:object_r:bin_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corecommands.if serefpolicy-2.3.16/policy/modules/kernel/corecommands.if
--- nsaserefpolicy/policy/modules/kernel/corecommands.if	2006-09-15 13:14:21.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/kernel/corecommands.if	2006-09-29 09:56:57.000000000 -0400
@@ -928,7 +928,19 @@
 		type bin_t, sbin_t;
 	')
 
-	can_exec($1,exec_type)
+
+	ifdef(`targeted_policy',`
+		can_exec($1,exec_type)
+	', `
+		corecmd_exec_bin($1)
+		corecmd_exec_sbin($1)
+		corecmd_exec_shell($1)
+		corecmd_exec_ls($1)
+		corecmd_exec_chroot($1)
+	')
+
+	userdom_exec($1)
+
 	allow $1 { bin_t sbin_t }:dir list_dir_perms;
 	allow $1 { bin_t sbin_t }:lnk_file read_file_perms;
 ')
@@ -950,6 +962,7 @@
 		type bin_t, sbin_t;
 	')
 
+	userdom_manage_user_executables($1)
 	allow $1 exec_type:file manage_file_perms;
 	allow $1 { bin_t sbin_t }:dir rw_dir_perms;
 	allow $1 { bin_t sbin_t }:lnk_file create_lnk_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corenetwork.te.in serefpolicy-2.3.16/policy/modules/kernel/corenetwork.te.in
--- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in	2006-09-29 14:28:01.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/kernel/corenetwork.te.in	2006-09-29 14:26:26.000000000 -0400
@@ -205,4 +208,4 @@
 
 # Bind to any network address.
 allow corenet_unconfined_type port_type:{ tcp_socket udp_socket } name_bind;
-allow corenet_unconfined_type node_type:{ tcp_socket udp_socket } node_bind;
+allow corenet_unconfined_type node_type:{ tcp_socket udp_socket rawip_socket } node_bind;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.3.16/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-09-29 14:28:01.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/kernel/files.if	2006-09-29 13:48:53.000000000 -0400
@@ -896,8 +896,8 @@
 	allow $1 { file_type $2 }:lnk_file { getattr relabelfrom relabelto };
 	allow $1 { file_type $2 }:fifo_file { getattr relabelfrom relabelto };
 	allow $1 { file_type $2 }:sock_file { getattr relabelfrom relabelto };
-	allow $1 { file_type $2 }:blk_file { getattr relabelfrom };
-	allow $1 { file_type $2 }:chr_file { getattr relabelfrom };
+	allow $1 { file_type $2 }:blk_file { getattr relabelfrom relabelto };
+	allow $1 { file_type $2 }:chr_file { getattr relabelfrom relabelto };
 
 	# satisfy the assertions:
 	seutil_relabelto_bin_policy($1)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/filesystem.if serefpolicy-2.3.16/policy/modules/kernel/filesystem.if
--- nsaserefpolicy/policy/modules/kernel/filesystem.if	2006-09-25 15:11:10.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/kernel/filesystem.if	2006-09-26 10:02:05.000000000 -0400
@@ -3381,3 +3381,25 @@
 	allow $1 noxattrfs:blk_file { getattr relabelfrom };
 	allow $1 noxattrfs:chr_file { getattr relabelfrom };
 ')
+
+
+########################################
+## <summary>
+##	Create, read, write, and delete symbolic links
+##	on a autofs filesystem.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`fs_manage_autofs_symlinks',`
+	gen_require(`
+		type autofs_t;
+	')
+
+	allow $1 autofs_t:dir rw_dir_perms;
+	allow $1 autofs_t:lnk_file create_lnk_perms;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/filesystem.te serefpolicy-2.3.16/policy/modules/kernel/filesystem.te
--- nsaserefpolicy/policy/modules/kernel/filesystem.te	2006-09-25 15:11:10.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/kernel/filesystem.te	2006-09-27 17:19:21.000000000 -0400
@@ -21,6 +21,7 @@
 
 # Use xattrs for the following filesystem types.
 # Requires that a security xattr handler exist for the filesystem.
+fs_use_xattr encfs gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr ext2 gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr ext3 gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr gfs2 gen_context(system_u:object_r:fs_t,s0);
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/kernel.te serefpolicy-2.3.16/policy/modules/kernel/kernel.te
--- nsaserefpolicy/policy/modules/kernel/kernel.te	2006-09-22 09:35:44.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/kernel/kernel.te	2006-09-26 09:53:18.000000000 -0400
@@ -326,6 +326,7 @@
 
 ifdef(`targeted_policy',`
 	allow unlabeled_t self:filesystem associate;
+	allow unlabeled_t self:association polmatch;
 ')
 
 optional_policy(`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/storage.if serefpolicy-2.3.16/policy/modules/kernel/storage.if
--- nsaserefpolicy/policy/modules/kernel/storage.if	2006-07-14 17:04:29.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/kernel/storage.if	2006-09-26 09:53:18.000000000 -0400
@@ -37,6 +37,7 @@
 	')
 
 	dontaudit $1 fixed_disk_device_t:blk_file getattr;
+	dontaudit $1 fixed_disk_device_t:chr_file getattr; # /dev/rawctl
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/terminal.if serefpolicy-2.3.16/policy/modules/kernel/terminal.if
--- nsaserefpolicy/policy/modules/kernel/terminal.if	2006-09-22 14:07:03.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/kernel/terminal.if	2006-09-29 10:05:27.000000000 -0400
@@ -458,6 +457,26 @@
 
 ########################################
 ## <summary>
+##	Allow setting the attributes of
+##	generic pty devices.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+# dwalsh: added for rhgb
+interface(`term_setattr_generic_ptys',`
+	gen_require(`
+		type devpts_t;
+	')
+
+	allow $1 devpts_t:chr_file setattr;
+')
+
+########################################
+## <summary>
 ##	Read and write the generic pty
 ##	type.  This is generally only used in
 ##	the targeted policy.
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/automount.te serefpolicy-2.3.16/policy/modules/services/automount.te
--- nsaserefpolicy/policy/modules/services/automount.te	2006-09-22 14:07:05.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/automount.te	2006-09-26 10:01:31.000000000 -0400
@@ -36,6 +36,8 @@
 allow automount_t self:unix_dgram_socket create_socket_perms;
 allow automount_t self:tcp_socket create_stream_socket_perms;
 allow automount_t self:udp_socket create_socket_perms;
+allow automount_t self:rawip_socket create_socket_perms;
+
 allow automount_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow automount_t automount_etc_t:file { getattr read };
@@ -74,6 +76,7 @@
 files_mounton_all_mountpoints(automount_t)
 files_mount_all_file_type_fs(automount_t)
 files_unmount_all_file_type_fs(automount_t)
+files_manage_non_security_dirs(automount_t)
 
 fs_mount_all_fs(automount_t)
 fs_unmount_all_fs(automount_t)
@@ -128,6 +131,7 @@
 fs_manage_auto_mountpoints(automount_t)
 fs_unmount_autofs(automount_t)
 fs_mount_autofs(automount_t)
+fs_manage_autofs_symlinks(automount_t)
 
 term_dontaudit_use_console(automount_t)
 term_dontaudit_getattr_pty_dirs(automount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.te serefpolicy-2.3.16/policy/modules/services/cups.te
--- nsaserefpolicy/policy/modules/services/cups.te	2006-09-22 14:07:06.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/cups.te	2006-09-27 15:05:01.000000000 -0400
@@ -124,6 +124,9 @@
 allow cupsd_t ptal_var_run_t:sock_file { write setattr };
 allow cupsd_t ptal_t:unix_stream_socket connectto;
 
+allow cupsd_t hplip_etc_t:file r_file_perms;
+allow cupsd_t hplip_etc_t:dir r_dir_perms;
+
 kernel_read_system_state(cupsd_t)
 kernel_read_network_state(cupsd_t)
 kernel_read_all_sysctls(cupsd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cvs.te serefpolicy-2.3.16/policy/modules/services/cvs.te
--- nsaserefpolicy/policy/modules/services/cvs.te	2006-07-14 17:04:40.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/cvs.te	2006-09-27 16:16:32.000000000 -0400
@@ -9,6 +9,7 @@
 type cvs_t;
 type cvs_exec_t;
 inetd_tcp_service_domain(cvs_t,cvs_exec_t)
+userdom_executable_file(cvs_exec_t)
 role system_r types cvs_t;
 
 type cvs_data_t; # customizable
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dbus.if serefpolicy-2.3.16/policy/modules/services/dbus.if
--- nsaserefpolicy/policy/modules/services/dbus.if	2006-09-15 13:14:24.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/dbus.if	2006-09-26 09:53:18.000000000 -0400
@@ -123,6 +123,7 @@
 	selinux_compute_relabel_context($1_dbusd_t)
 	selinux_compute_user_contexts($1_dbusd_t)
 
+	corecmd_bin_domtrans($1_dbusd_t, $1_t)
 	corecmd_list_bin($1_dbusd_t)
 	corecmd_read_bin_symlinks($1_dbusd_t)
 	corecmd_read_bin_files($1_dbusd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dovecot.te serefpolicy-2.3.16/policy/modules/services/dovecot.te
--- nsaserefpolicy/policy/modules/services/dovecot.te	2006-09-06 13:04:51.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/dovecot.te	2006-09-27 06:32:56.000000000 -0400
@@ -171,6 +171,8 @@
 
 allow dovecot_auth_t dovecot_var_run_t:dir r_dir_perms;
 
+init_rw_utmp(dovecot_auth_t)
+
 kernel_read_all_sysctls(dovecot_auth_t)
 kernel_read_system_state(dovecot_auth_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.3.16/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2006-09-25 15:11:11.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/hal.te	2006-09-27 15:11:25.000000000 -0400
@@ -85,6 +85,7 @@
 files_rw_etc_runtime_files(hald_t)
 files_manage_mnt_dirs(hald_t)
 files_manage_mnt_files(hald_t)
+files_manage_mnt_symlinks(hald_t)
 files_search_var_lib(hald_t)
 files_read_usr_files(hald_t)
 # hal is now execing pm-suspend
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/lpd.fc serefpolicy-2.3.16/policy/modules/services/lpd.fc
--- nsaserefpolicy/policy/modules/services/lpd.fc	2006-09-29 14:28:02.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/lpd.fc	2006-09-26 09:53:18.000000000 -0400
@@ -6,21 +6,25 @@
 #
 # /usr
 #
-/usr/bin/lp(\.cups)?	--	gen_context(system_u:object_r:lpr_exec_t,s0)
-/usr/bin/lpr(\.cups)?	--	gen_context(system_u:object_r:lpr_exec_t,s0)
-/usr/bin/lpq(\.cups)?	--	gen_context(system_u:object_r:lpr_exec_t,s0)
-/usr/bin/lprm(\.cups)?	--	gen_context(system_u:object_r:lpr_exec_t,s0)
-/usr/bin/lpstat(\.cups)? --	gen_context(system_u:object_r:lpr_exec_t,s0)
-
 /usr/sbin/checkpc	--	gen_context(system_u:object_r:checkpc_exec_t,s0)
 /usr/sbin/lpd		--	gen_context(system_u:object_r:lpd_exec_t,s0)
 /usr/sbin/lpadmin	--	gen_context(system_u:object_r:lpr_exec_t,s0)
 /usr/sbin/lpc(\.cups)?	--	gen_context(system_u:object_r:lpr_exec_t,s0)
-
+/usr/sbin/accept	--	gen_context(system_u:object_r:lpr_exec_t,s0)
+/usr/sbin/lpinfo	--	gen_context(system_u:object_r:lpr_exec_t,s0)
+/usr/sbin/lpmove	--	gen_context(system_u:object_r:lpr_exec_t,s0)
 /usr/share/printconf/.* --	gen_context(system_u:object_r:printconf_t,s0)
+/usr/bin/lp(\.cups)?	--	gen_context(system_u:object_r:lpr_exec_t,s0)
+/usr/bin/lpr(\.cups)?	--	gen_context(system_u:object_r:lpr_exec_t,s0)
+/usr/bin/lpq(\.cups)?	--	gen_context(system_u:object_r:lpr_exec_t,s0)
+/usr/bin/lprm(\.cups)?	--	gen_context(system_u:object_r:lpr_exec_t,s0)
+/usr/bin/lpstat(\.cups)? --	gen_context(system_u:object_r:lpr_exec_t,s0)
+/usr/bin/cancel(\.cups)?	--	gen_context(system_u:object_r:lpr_exec_t,s0)
+/usr/bin/lpoptions	--	gen_context(system_u:object_r:lpr_exec_t,s0)
 
 #
 # /var
 #
 /var/spool/lpd(/.*)?		gen_context(system_u:object_r:print_spool_t,s0)
 /var/run/lprng(/.*)?		gen_context(system_u:object_r:lpd_var_run_t,s0)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/mta.te serefpolicy-2.3.16/policy/modules/services/mta.te
--- nsaserefpolicy/policy/modules/services/mta.te	2006-08-29 09:00:28.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/mta.te	2006-09-27 16:18:32.000000000 -0400
@@ -27,6 +27,7 @@
 
 type sendmail_exec_t;
 files_type(sendmail_exec_t)
+userdom_executable_file(sendmail_exec_t)
 
 mta_base_mail_template(system)
 role system_r types system_mail_t;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/nscd.if serefpolicy-2.3.16/policy/modules/services/nscd.if
--- nsaserefpolicy/policy/modules/services/nscd.if	2006-08-07 18:55:18.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/nscd.if	2006-09-26 09:53:18.000000000 -0400
@@ -181,3 +181,23 @@
 
 	allow $1 nscd_t:nscd *;
 ')
+
+
+########################################
+## <summary>
+##	Allow role on this domain
+## </summary>
+## <param name="role">
+##	<summary>
+##	The role to be allowed the nscd domain.
+##	</summary>
+## </param>
+#
+interface(`nscd_role',`
+	gen_require(`
+		type nscd_t;
+	')
+
+	role $1 types nscd_t;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/nscd.te serefpolicy-2.3.16/policy/modules/services/nscd.te
--- nsaserefpolicy/policy/modules/services/nscd.te	2006-09-25 15:11:11.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/nscd.te	2006-09-28 10:19:19.000000000 -0400
@@ -120,6 +120,9 @@
 	term_dontaudit_use_unallocated_ttys(nscd_t)
 	term_dontaudit_use_generic_ptys(nscd_t)
 	files_dontaudit_read_root_files(nscd_t)
+',`
+	userdom_dontaudit_use_sysadm_ttys(nscd_t)
+	userdom_dontaudit_use_sysadm_ptys(nscd_t)
 ')
 
 optional_policy(`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/procmail.te serefpolicy-2.3.16/policy/modules/services/procmail.te
--- nsaserefpolicy/policy/modules/services/procmail.te	2006-09-15 13:14:25.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/procmail.te	2006-09-27 16:19:02.000000000 -0400
@@ -10,6 +10,7 @@
 type procmail_exec_t;
 domain_type(procmail_t)
 domain_entry_file(procmail_t,procmail_exec_t)
+userdom_executable_file(procmail_exec_t)
 role system_r types procmail_t;
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rhgb.te serefpolicy-2.3.16/policy/modules/services/rhgb.te
--- nsaserefpolicy/policy/modules/services/rhgb.te	2006-09-06 13:04:51.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/rhgb.te	2006-09-29 01:20:51.000000000 -0400
@@ -13,10 +13,8 @@
 type rhgb_tmpfs_t;
 files_tmpfs_file(rhgb_tmpfs_t)
 
-ifdef(`strict_policy',`
-	type rhgb_devpts_t;
-	term_pty(rhgb_devpts_t)
-')
+type rhgb_devpts_t;
+term_pty(rhgb_devpts_t)
 
 ########################################
 #
@@ -25,7 +23,7 @@
 
 allow rhgb_t self:capability { fsetid setgid setuid sys_admin sys_tty_config };
 dontaudit rhgb_t self:capability sys_tty_config;
-allow rhgb_t self:process signal_perms;
+allow rhgb_t self:process { setpgid signal_perms };
 allow rhgb_t self:shm create_shm_perms;
 allow rhgb_t self:unix_stream_socket create_stream_socket_perms;
 allow rhgb_t self:fifo_file rw_file_perms;
@@ -112,16 +110,21 @@
 # for running setxkbmap
 xserver_read_xkb_libs(rhgb_t)
 
+selinux_dontaudit_search_fs(rhgb_t)
+selinux_dontaudit_read_fs(rhgb_t)
+seutil_search_default_contexts(rhgb_t)
+seutil_read_config(rhgb_t)
+
 ifdef(`strict_policy',`
 	allow rhgb_t rhgb_devpts_t:chr_file { rw_file_perms setattr };
 	term_create_pty(rhgb_t,rhgb_devpts_t)
+
 ', `
 	files_dontaudit_read_root_files(rhgb_t)
 
-	term_dontaudit_use_generic_ptys(rhgb_t)
-	term_dontaudit_setattr_generic_ptys(rhgb_t)
+	term_use_generic_ptys(rhgb_t)
+	term_setattr_generic_ptys(rhgb_t)
 	term_dontaudit_use_unallocated_ttys(rhgb_t)
-	term_dontaudit_use_generic_ptys(rhgb_t)
 
 	xserver_domtrans_xdm_xserver(rhgb_t)
 	xserver_signal_xdm_xserver(rhgb_t)
@@ -140,8 +143,13 @@
 	udev_read_db(rhgb_t)
 ')
 
+optional_policy(`
+	consoletype_exec(rhgb_t)
+')
+
 ifdef(`TODO',`
 	#this seems a bit much
 	allow domain rhgb_devpts_t:chr_file { read write };
 	allow initrc_t rhgb_gph_t:fd use;
 ')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rsync.te serefpolicy-2.3.16/policy/modules/services/rsync.te
--- nsaserefpolicy/policy/modules/services/rsync.te	2006-07-14 17:04:41.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/rsync.te	2006-09-27 16:19:26.000000000 -0400
@@ -9,6 +9,7 @@
 type rsync_t;
 type rsync_exec_t;
 init_daemon_domain(rsync_t,rsync_exec_t)
+userdom_executable_file(rsync_exec_t)
 role system_r types rsync_t;
 
 type rsync_data_t;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/setroubleshoot.te serefpolicy-2.3.16/policy/modules/services/setroubleshoot.te
--- nsaserefpolicy/policy/modules/services/setroubleshoot.te	2006-09-22 14:07:05.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/setroubleshoot.te	2006-09-26 09:53:18.000000000 -0400
@@ -28,7 +28,7 @@
 #
 
 allow setroubleshootd_t self:capability { dac_override sys_tty_config };
-allow setroubleshootd_t self:process { signal getattr };
+allow setroubleshootd_t self:process { signal getattr getsched };
 allow setroubleshootd_t self:fifo_file rw_file_perms;
 allow setroubleshootd_t self:tcp_socket create_stream_socket_perms;
 allow setroubleshootd_t self:unix_stream_socket { create_stream_socket_perms connectto };
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/spamassassin.te serefpolicy-2.3.16/policy/modules/services/spamassassin.te
--- nsaserefpolicy/policy/modules/services/spamassassin.te	2006-09-01 14:10:18.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/spamassassin.te	2006-09-27 16:26:15.000000000 -0400
@@ -8,7 +8,7 @@
 
 # spamassassin client executable
 type spamc_exec_t;
-corecmd_executable_file(spamc_exec_t)
+userdom_executable_file(spamc_exec_t)
 
 type spamd_t;
 type spamd_exec_t;
@@ -24,7 +24,7 @@
 files_pid_file(spamd_var_run_t)
 
 type spamassassin_exec_t;
-corecmd_executable_file(spamassassin_exec_t)
+userdom_executable_file(spamassassin_exec_t)
 
 ########################################
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ssh.te serefpolicy-2.3.16/policy/modules/services/ssh.te
--- nsaserefpolicy/policy/modules/services/ssh.te	2006-09-25 15:11:11.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/ssh.te	2006-09-27 16:30:19.000000000 -0400
@@ -10,7 +10,7 @@
 
 # ssh client executable.
 type ssh_exec_t;
-corecmd_executable_file(ssh_exec_t)
+userdom_executable_file(ssh_exec_t)
 
 type ssh_keygen_t;
 type ssh_keygen_exec_t;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.if serefpolicy-2.3.16/policy/modules/services/xserver.if
--- nsaserefpolicy/policy/modules/services/xserver.if	2006-09-15 13:14:25.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/xserver.if	2006-09-29 00:59:16.000000000 -0400
@@ -898,10 +898,12 @@
 
 	domain_auto_trans($1,xserver_exec_t,xdm_xserver_t)
 
+	allow $1 xdm_xserver_t:process siginh;
 	allow $1 xdm_xserver_t:fd use;
 	allow xdm_xserver_t $1:fd use;
 	allow xdm_xserver_t $1:fifo_file rw_file_perms;
 	allow xdm_xserver_t $1:process sigchld;
+
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.te serefpolicy-2.3.16/policy/modules/services/xserver.te
--- nsaserefpolicy/policy/modules/services/xserver.te	2006-09-06 13:04:51.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/services/xserver.te	2006-09-27 10:14:32.000000000 -0400
@@ -462,7 +462,7 @@
 allow rhgb_t xdm_xserver_t:process signal;
 ')
 
-ifdef(`enable_polyinstantiation',`
+tunable_policy(`allow_polyinstantiation',`
 # xdm needs access for linking .X11-unix to poly /tmp
 allow xdm_t polymember:dir { add_name remove_name write };
 allow xdm_t polymember:lnk_file { create unlink };
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/authlogin.if serefpolicy-2.3.16/policy/modules/system/authlogin.if
--- nsaserefpolicy/policy/modules/system/authlogin.if	2006-09-15 13:14:27.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/authlogin.if	2006-09-27 10:14:47.000000000 -0400
@@ -230,7 +230,7 @@
 	seutil_read_config($1)
 	seutil_read_default_contexts($1)
 
-	ifdef(`enable_polyinstantiation',`
+	tunable_policy(`allow_polyinstantiation',`
 		files_polyinstantiate_all($1)
 	')
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/fstools.te serefpolicy-2.3.16/policy/modules/system/fstools.te
--- nsaserefpolicy/policy/modules/system/fstools.te	2006-09-22 14:07:06.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/fstools.te	2006-09-27 16:27:37.000000000 -0400
@@ -9,7 +9,7 @@
 type fsadm_t;
 type fsadm_exec_t;
 init_system_domain(fsadm_t,fsadm_exec_t)
-mls_file_read_up(fsadm_t)
+userdom_executable_file(fsadm_exec_t)
 role system_r types fsadm_t;
 
 type fsadm_log_t;
@@ -98,6 +98,7 @@
 fs_read_tmpfs_symlinks(fsadm_t)
 
 mls_file_write_down(fsadm_t)
+mls_file_read_up(fsadm_t)
 
 storage_raw_read_fixed_disk(fsadm_t)
 storage_raw_write_fixed_disk(fsadm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.fc serefpolicy-2.3.16/policy/modules/system/init.fc
--- nsaserefpolicy/policy/modules/system/init.fc	2006-08-25 13:29:58.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/init.fc	2006-09-26 09:53:18.000000000 -0400
@@ -66,3 +66,6 @@
 /var/run/sysconfig(/.*)?	gen_context(system_u:object_r:initrc_var_run_t,s0)
 ')
 
+# Until their is a policy for pcscd we need these
+/var/run/pcscd\.pub	--	gen_context(system_u:object_r:initrc_var_run_t,s0)
+/var/run/pcscd\.pid	--	gen_context(system_u:object_r:initrc_var_run_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.3.16/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-09-29 14:28:02.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/init.te	2006-09-27 15:58:36.000000000 -0400
@@ -151,6 +151,7 @@
 mcs_process_set_categories(init_t)
 
 mls_process_write_down(init_t)
+mls_fd_use_all_levels(init_t)
 
 selinux_set_boolean(init_t)
 
@@ -365,7 +366,8 @@
 logging_append_all_logs(initrc_t)
 logging_read_audit_config(initrc_t)
 
-miscfiles_read_localization(initrc_t)
+miscfiles_rw_localization(initrc_t)
+
 # slapd needs to read cert files from its initscript
 miscfiles_read_certs(initrc_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/iscsi.fc serefpolicy-2.3.16/policy/modules/system/iscsi.fc
--- nsaserefpolicy/policy/modules/system/iscsi.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.16/policy/modules/system/iscsi.fc	2006-09-26 10:04:37.000000000 -0400
@@ -0,0 +1,7 @@
+# iscsid executable will have:
+# label: system_u:object_r:iscsid_exec_t
+# MLS sensitivity: s0
+# MCS categories: <none>
+
+/sbin/iscsid		--	gen_context(system_u:object_r:iscsid_exec_t,s0)
+/var/run/iscsid.pid	--	gen_context(system_u:object_r:iscsi_var_run_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/iscsi.if serefpolicy-2.3.16/policy/modules/system/iscsi.if
--- nsaserefpolicy/policy/modules/system/iscsi.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.16/policy/modules/system/iscsi.if	2006-09-26 10:04:37.000000000 -0400
@@ -0,0 +1,24 @@
+## <summary>policy for iscsid</summary>
+
+########################################
+## <summary>
+##	Execute a domain transition to run iscsid.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`iscsid_domtrans',`
+	gen_require(`
+		type iscsid_t, iscsid_exec_t;
+	')
+
+	domain_auto_trans($1,iscsid_exec_t,iscsid_t)
+
+	allow $1 iscsid_t:fd use;
+	allow iscsid_t $1:fd use;
+	allow iscsid_t $1:fifo_file rw_file_perms;
+	allow iscsid_t $1:process sigchld;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/iscsi.te serefpolicy-2.3.16/policy/modules/system/iscsi.te
--- nsaserefpolicy/policy/modules/system/iscsi.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.3.16/policy/modules/system/iscsi.te	2006-09-26 10:04:37.000000000 -0400
@@ -0,0 +1,74 @@
+policy_module(iscsid,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type iscsid_t;
+type iscsid_exec_t;
+domain_type(iscsid_t)
+init_daemon_domain(iscsid_t, iscsid_exec_t)
+
+type iscsi_tmp_t;
+files_tmp_file(iscsi_tmp_t)
+
+type iscsi_var_run_t;
+files_pid_file(iscsi_var_run_t)
+
+
+########################################
+#
+# iscsid local policy
+#
+# Check in /etc/selinux/refpolicy/include for macros to use instead of allow rules.
+
+# Some common macros (you might be able to remove some)
+files_read_etc_files(iscsid_t)
+libs_use_ld_so(iscsid_t)
+libs_use_shared_libs(iscsid_t)
+miscfiles_read_localization(iscsid_t)
+## internal communication is often done using fifo and unix sockets.
+allow iscsid_t self:fifo_file { read write };
+allow iscsid_t self:unix_stream_socket create_stream_socket_perms;
+
+## Networking basics (adjust to your needs!)
+sysnet_dns_name_resolve(iscsid_t)
+corenet_tcp_sendrecv_all_if(iscsid_t)
+corenet_tcp_sendrecv_all_nodes(iscsid_t)
+corenet_tcp_sendrecv_all_ports(iscsid_t)
+corenet_non_ipsec_sendrecv(iscsid_t)
+corenet_tcp_connect_http_port(iscsid_t)
+#corenet_tcp_connect_all_ports(iscsid_t)
+## if it is a network daemon, consider these:
+#corenet_tcp_bind_all_ports(iscsid_t)
+#corenet_tcp_bind_all_nodes(iscsid_t)
+allow iscsid_t self:tcp_socket { listen accept };
+
+# Init script handling
+init_use_fds(iscsid_t)
+init_use_script_ptys(iscsid_t)
+domain_use_interactive_fds(iscsid_t)
+
+logging_send_syslog_msg(iscsid_t)
+
+allow iscsid_t self:capability { ipc_lock net_admin sys_nice sys_resource };
+allow iscsid_t self:netlink_socket { bind create };
+allow iscsid_t self:unix_dgram_socket create_socket_perms;
+
+allow iscsid_t devpts_t:chr_file { read write };
+
+allow iscsid_t self:process setsched;
+allow iscsid_t self:sem create_sem_perms;
+allow iscsid_t self:shm create_shm_perms;
+
+dev_rw_sysfs(iscsid_t)
+
+allow iscsid_t iscsi_var_run_t:dir rw_dir_perms;
+allow iscsid_t iscsi_var_run_t:file create_file_perms;
+files_pid_filetrans(iscsid_t,iscsi_var_run_t,file)
+
+allow iscsid_t iscsi_tmp_t:dir create_dir_perms;
+allow iscsid_t iscsi_tmp_t:file create_file_perms;
+fs_tmpfs_filetrans(iscsid_t, iscsi_tmp_t, file )
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.fc serefpolicy-2.3.16/policy/modules/system/libraries.fc
--- nsaserefpolicy/policy/modules/system/libraries.fc	2006-09-22 14:07:07.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/libraries.fc	2006-09-27 15:02:39.000000000 -0400
@@ -255,6 +255,7 @@
 /usr/(.*/)?jre.*/libdeploy\.so(\.[^/]*)* --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/(local/)?(.*/)?jre.*/libjvm\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/(local/)?(.*/)?jre.*/libawt\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/(local/)?(.*/)?jre.*/libjavaplugin_ojigcc3\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 /usr/(local/)?Adobe/(.*/)?intellinux/nppdf\.so -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/(local/)?Adobe/(.*/)?intellinux/sidecars/* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/logging.te serefpolicy-2.3.16/policy/modules/system/logging.te
--- nsaserefpolicy/policy/modules/system/logging.te	2006-09-29 14:28:02.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/logging.te	2006-09-29 11:18:36.000000000 -0400
@@ -75,6 +75,7 @@
 allow auditctl_t auditd_etc_t:file r_file_perms;
 
 # Needed for adding watches
+fs_getattr_all_fs(auditctl_t)
 files_getattr_all_dirs(auditctl_t)
 files_read_etc_files(auditctl_t)
 
@@ -95,6 +96,8 @@
 
 logging_send_syslog_msg(auditctl_t)
 
+selinux_search_fs(auditctl_t)
+
 ifdef(`targeted_policy',`
 	term_use_generic_ptys(auditctl_t)
 	term_use_unallocated_ttys(auditctl_t)
@@ -164,6 +167,7 @@
 mls_file_read_up(auditd_t)
 mls_file_write_down(auditd_t) # Need to be able to write to /var/run/ directory
 mls_rangetrans_target(auditd_t)
+mls_fd_use_all_levels(auditd_t)
 
 seutil_dontaudit_read_config(auditd_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.fc serefpolicy-2.3.16/policy/modules/system/mount.fc
--- nsaserefpolicy/policy/modules/system/mount.fc	2006-07-14 17:04:43.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/mount.fc	2006-09-27 17:50:25.000000000 -0400
@@ -4,4 +4,5 @@
 # mount file contexts
 #
 /bin/mount.*			--	gen_context(system_u:object_r:mount_exec_t,s0)
+/usr/bin/fusermount		--	gen_context(system_u:object_r:mount_exec_t,s0)
 /bin/umount.*			--	gen_context(system_u:object_r:mount_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.3.16/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2006-09-15 13:14:27.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/mount.te	2006-09-27 16:29:01.000000000 -0400
@@ -9,6 +9,7 @@
 type mount_t;
 type mount_exec_t;
 init_system_domain(mount_t,mount_exec_t)
+userdom_executable_file(mount_exec_t)
 role system_r types mount_t;
 
 type mount_loopback_t; # customizable
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/raid.te serefpolicy-2.3.16/policy/modules/system/raid.te
--- nsaserefpolicy/policy/modules/system/raid.te	2006-09-29 14:28:02.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/raid.te	2006-09-28 12:22:13.000000000 -0400
@@ -23,6 +23,7 @@
 dontaudit mdadm_t self:capability sys_tty_config;
 allow mdadm_t self:process { sigchld sigkill sigstop signull signal };
 
+allow mdadm_t mdadm_var_run_t:dir rw_dir_perms;
 allow mdadm_t mdadm_var_run_t:file create_file_perms;
 files_pid_filetrans(mdadm_t,mdadm_var_run_t,file)
 
@@ -36,6 +37,8 @@
 dev_dontaudit_getattr_all_blk_files(mdadm_t)
 dev_dontaudit_getattr_all_chr_files(mdadm_t)
 dev_dontaudit_getattr_generic_files(mdadm_t)
+dev_dontaudit_getattr_generic_chr_files(mdadm_t)
+dev_dontaudit_getattr_generic_blk_files(mdadm_t)
 
 fs_search_auto_mountpoints(mdadm_t)
 fs_dontaudit_list_tmpfs(mdadm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.te serefpolicy-2.3.16/policy/modules/system/selinuxutil.te
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2006-09-22 14:07:07.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/selinuxutil.te	2006-09-29 13:23:46.000000000 -0400
@@ -274,6 +274,7 @@
 mls_file_upgrade(newrole_t)
 mls_file_downgrade(newrole_t)
 mls_process_set_level(newrole_t)
+mls_fd_share_all_levels(newrole_t)
 
 selinux_get_fs_mount(newrole_t)
 selinux_validate_context(newrole_t)
@@ -587,6 +588,7 @@
 mls_rangetrans_target(semanage_t)
 mls_file_read_up(semanage_t)
 
+selinux_validate_context(semanage_t)
 selinux_get_enforce_mode(semanage_t)
 # for setsebool:
 selinux_set_boolean(semanage_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/setrans.fc serefpolicy-2.3.16/policy/modules/system/setrans.fc
--- nsaserefpolicy/policy/modules/system/setrans.fc	2006-07-14 17:04:44.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/setrans.fc	2006-09-26 09:53:18.000000000 -0400
@@ -1,3 +1,3 @@
 /sbin/mcstransd	--	gen_context(system_u:object_r:setrans_exec_t,s0)
 
-/var/run/setrans(/.*)?	gen_context(system_u:object_r:setrans_var_run_t,s15:c0.c255)
+/var/run/setrans(/.*)?	gen_context(system_u:object_r:setrans_var_run_t,s15:c0.c1023)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/setrans.te serefpolicy-2.3.16/policy/modules/system/setrans.te
--- nsaserefpolicy/policy/modules/system/setrans.te	2006-09-22 14:07:07.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/setrans.te	2006-09-27 15:59:14.000000000 -0400
@@ -53,6 +53,7 @@
 mls_file_write_down(setrans_t)
 mls_net_receive_all_levels(setrans_t)
 mls_rangetrans_target(setrans_t)
+mls_fd_use_all_levels(setrans_t)
 
 selinux_compute_access_vector(setrans_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.if serefpolicy-2.3.16/policy/modules/system/unconfined.if
--- nsaserefpolicy/policy/modules/system/unconfined.if	2006-08-29 09:00:29.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/unconfined.if	2006-09-26 09:53:18.000000000 -0400
@@ -31,6 +31,7 @@
 	allow $1 self:nscd *;
 	allow $1 self:dbus *;
 	allow $1 self:passwd *;
+	allow $1 self:association *;
 
 	kernel_unconfined($1)
 	corenet_unconfined($1)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.te serefpolicy-2.3.16/policy/modules/system/unconfined.te
--- nsaserefpolicy/policy/modules/system/unconfined.te	2006-09-29 14:28:02.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/unconfined.te	2006-09-29 12:11:13.000000000 -0400
@@ -64,10 +64,6 @@
 	')
 
 	optional_policy(`
-		bluetooth_domtrans_helper(unconfined_t)
-	')
-
-	optional_policy(`
 		bootloader_domtrans(unconfined_t)
 	')
 
@@ -189,6 +181,8 @@
 	optional_policy(`
 		xserver_domtrans_xdm_xserver(unconfined_t)
 	')
+	mcs_killall(unconfined_t)
+	mcs_ptrace_all(unconfined_t)
 ')
 
 ########################################
@@ -197,6 +191,10 @@
 #
 
 ifdef(`targeted_policy',`
+	tunable_policy(`allow_unconfined_execmem_dyntrans',`
+		allow unconfined_t unconfined_execmem_t:process dyntransition;
+	')
+
 	allow unconfined_execmem_t self:process { execstack execmem };
 	unconfined_domain_noaudit(unconfined_execmem_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.if serefpolicy-2.3.16/policy/modules/system/userdomain.if
--- nsaserefpolicy/policy/modules/system/userdomain.if	2006-09-25 15:11:11.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/userdomain.if	2006-09-29 09:56:59.000000000 -0400
@@ -3896,12 +3896,7 @@
 #
 interface(`userdom_manage_staff_home_dirs',`
 	ifdef(`targeted_policy',`
-		gen_require(`
-			type user_home_dir_t;
-		')
-
-		files_search_home($1)
-		allow $1 user_home_dir_t:dir manage_dir_perms;
+		userdom_manage_user_home_dirs($1)
 	',`
 		gen_require(`
 			type staff_home_dir_t;
@@ -5338,3 +5333,82 @@
 	allow $1 user_home_dir_t:dir create_dir_perms;
 	files_home_filetrans($1,user_home_dir_t,dir)
 ')
+
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
+interface(`userdom_executable_file',`
+	gen_require(`
+		attribute user_exec_type;
+	')
+
+	typeattribute $1 user_exec_type;
+
+	files_type($1)
+')
+
+########################################
+## <summary>
+## Execute user executables in the caller domain.
+## </summary>
+## <param name="type">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`userdom_exec',`
+	gen_require(`
+		attribute user_exec_type;
+	')
+
+	can_exec($1, user_exec_type)
+')
+
+########################################
+## <summary>
+##	Create, read, write, and delete user
+##	home directories.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`userdom_manage_user_home_dirs',`
+	gen_require(`
+		type user_home_dir_t;
+	')
+	files_search_home($1)
+	allow $1 user_home_dir_t:dir manage_dir_perms;
+')
+
+########################################
+## <summary>
+##	Create, read, write, and all executable files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`userdom_manage_user_executables',`
+	gen_require(`
+		attribute user_exec_type;
+	')
+	allow $1 user_exec_type:file manage_file_perms;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.te serefpolicy-2.3.16/policy/modules/system/userdomain.te
--- nsaserefpolicy/policy/modules/system/userdomain.te	2006-09-25 15:11:11.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/userdomain.te	2006-09-27 14:48:29.000000000 -0400
@@ -24,6 +24,9 @@
 # users home directory contents
 attribute home_type;
 
+# Executables to be run by user
+attribute user_exec_type;
+
 # The privhome attribute identifies every domain that can create files under
 # regular user home directories in the regular context (IE act on behalf of
 # a user in writing regular files)
@@ -423,6 +426,9 @@
 	')
 
 	optional_policy(`
+		nscd_role(sysadm_r)
+	')
+	optional_policy(`
 		usermanage_run_admin_passwd(sysadm_t,sysadm_r,admin_terminal)
 		usermanage_run_groupadd(sysadm_t,sysadm_r,admin_terminal)
 		usermanage_run_useradd(sysadm_t,sysadm_r,admin_terminal)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/xen.te serefpolicy-2.3.16/policy/modules/system/xen.te
--- nsaserefpolicy/policy/modules/system/xen.te	2006-09-22 14:07:07.000000000 -0400
+++ serefpolicy-2.3.16/policy/modules/system/xen.te	2006-09-28 12:06:41.000000000 -0400
@@ -132,6 +132,7 @@
 corenet_tcp_bind_soundd_port(xend_t)
 corenet_tcp_bind_generic_port(xend_t)
 corenet_tcp_bind_vnc_port(xend_t)
+corenet_tcp_connect_xserver_port(xend_t)
 corenet_sendrecv_xen_server_packets(xend_t)
 corenet_sendrecv_soundd_server_packets(xend_t)
 corenet_rw_tun_tap_dev(xend_t)

--------------000604090308020903090009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
