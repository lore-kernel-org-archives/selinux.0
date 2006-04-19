Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3J3GDJe021861
	for <selinux@tycho.nsa.gov>; Tue, 18 Apr 2006 23:16:13 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k3J3GCrc006900
	for <selinux@tycho.nsa.gov>; Wed, 19 Apr 2006 03:16:13 GMT
Message-ID: <4445AB7F.2000402@redhat.com>
Date: Tue, 18 Apr 2006 23:16:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest diffs
Content-Type: multipart/mixed;
 boundary="------------040109060702060909040305"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040109060702060909040305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix java domain,

Fix cups file context defs

ftp wants to use ldap to get users

postfix_map_t dontaudits

postgresql sometimes puts sock_file on /tmp

privoxy wants to connect to http_cache_ports

fix samb_net_t typo

samba needs access to ldap

samba wants to update utmp file

I believe sa-learn should be spamc_exec_t

pam_console needs to use certificates.

Additional textrel_shlib_t

Create new unconfined_mount_t to maintain /etc/mtab file context

useradd needs to be able to create user_home_dir_t.

customized types are not being created correctly.


--------------040109060702060909040305
Content-Type: text/x-patch;
 name="policy-20060411.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20060411.patch"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/java.te serefpolicy-2.2.33/policy/modules/apps/java.te
--- nsaserefpolicy/policy/modules/apps/java.te	2006-04-18 22:49:59.000000000 -0400
+++ serefpolicy-2.2.33/policy/modules/apps/java.te	2006-04-18 23:05:25.000000000 -0400
@@ -7,8 +7,11 @@
 #
 
 type java_t;
+domain_type(java_t)
+
 type java_exec_t;
 init_system_domain(java_t,java_exec_t)
+files_type(java_exec_t)
 
 ########################################
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/devices.if serefpolicy-2.2.33/policy/modules/kernel/devices.if
--- nsaserefpolicy/policy/modules/kernel/devices.if	2006-04-18 22:49:59.000000000 -0400
+++ serefpolicy-2.2.33/policy/modules/kernel/devices.if	2006-04-18 23:05:25.000000000 -0400
@@ -2874,3 +2874,23 @@
 
 	typeattribute $1 devices_unconfined_type;
 ')
+
+########################################
+## <summary>
+##	Dontaudit getattr on all device nodes.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`dev_dontaudit_getattr_all_device_nodes',`
+	gen_require(`
+		attribute device_node;
+	')
+
+	dontaudit $1 device_t:dir_file_class_set getattr;
+	dontaudit $1 device_node:dir_file_class_set getattr;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.2.33/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-04-18 22:49:59.000000000 -0400
+++ serefpolicy-2.2.33/policy/modules/kernel/files.if	2006-04-18 23:05:25.000000000 -0400
@@ -1679,6 +1679,21 @@
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/mls.te serefpolicy-2.2.33/policy/modules/kernel/mls.te
--- nsaserefpolicy/policy/modules/kernel/mls.te	2006-03-07 10:31:09.000000000 -0500
+++ serefpolicy-2.2.33/policy/modules/kernel/mls.te	2006-04-18 23:05:25.000000000 -0400
@@ -60,6 +60,7 @@
 
 ifdef(`enable_mls',`
 range_transition initrc_t auditd_exec_t s15:c0.c255;
+range_transition secadm_t auditctl_exec_t s15:c0.c255;
 range_transition kernel_t init_exec_t s0 - s15:c0.c255;
 range_transition kernel_t lvm_exec_t s0 - s15:c0.c255;
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.fc serefpolicy-2.2.33/policy/modules/services/cups.fc
--- nsaserefpolicy/policy/modules/services/cups.fc	2006-03-23 14:33:30.000000000 -0500
+++ serefpolicy-2.2.33/policy/modules/services/cups.fc	2006-04-18 23:05:25.000000000 -0400
@@ -35,7 +35,8 @@
 /usr/share/hplip/hpssd.py --	gen_context(system_u:object_r:hplip_exec_t,s0)
 
 /var/cache/alchemist/printconf.* gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
-/var/cache/foomatic(/.*)? --	gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
+/var/cache/foomatic(/.*)? 	gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
+/var/cache/cups(/.*)? 		gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
 
 /var/lib/cups/certs	-d	gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
 /var/lib/cups/certs/.*	--	gen_context(system_u:object_r:cupsd_rw_etc_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ftp.te serefpolicy-2.2.33/policy/modules/services/ftp.te
--- nsaserefpolicy/policy/modules/services/ftp.te	2006-04-12 13:44:37.000000000 -0400
+++ serefpolicy-2.2.33/policy/modules/services/ftp.te	2006-04-18 23:05:25.000000000 -0400
@@ -126,6 +126,7 @@
 seutil_dontaudit_search_config(ftpd_t)
 
 sysnet_read_config(ftpd_t)
+sysnet_use_ldap(ftpd_t)
 
 userdom_dontaudit_search_sysadm_home_dirs(ftpd_t)
 userdom_dontaudit_use_unpriv_user_fds(ftpd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/postfix.te serefpolicy-2.2.33/policy/modules/services/postfix.te
--- nsaserefpolicy/policy/modules/services/postfix.te	2006-04-18 22:50:00.000000000 -0400
+++ serefpolicy-2.2.33/policy/modules/services/postfix.te	2006-04-18 23:05:25.000000000 -0400
@@ -315,6 +315,7 @@
 
 kernel_read_kernel_sysctls(postfix_map_t)
 kernel_dontaudit_list_proc(postfix_map_t)
+kernel_dontaudit_read_system_state(postfix_map_t)
 
 corenet_tcp_sendrecv_all_if(postfix_map_t)
 corenet_udp_sendrecv_all_if(postfix_map_t)
@@ -360,6 +361,7 @@
 ifdef(`targeted_policy',`
 	# FIXME: would be better to use a run interface
 	role system_r types postfix_map_t;
+	term_dontaudit_use_generic_ptys(postfix_map_t)
 ')
 
 tunable_policy(`read_default_t',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/postgresql.if serefpolicy-2.2.33/policy/modules/services/postgresql.if
--- nsaserefpolicy/policy/modules/services/postgresql.if	2006-02-10 17:05:19.000000000 -0500
+++ serefpolicy-2.2.33/policy/modules/services/postgresql.if	2006-04-18 23:05:25.000000000 -0400
@@ -113,10 +113,12 @@
 #
 interface(`postgresql_stream_connect',`
 	gen_require(`
-		type postgresql_t, postgresql_var_run_t;
+		type postgresql_t, postgresql_var_run_t, postgresql_tmp_t;
 	')
 
 	files_search_pids($1)
 	allow $1 postgresql_t:unix_stream_socket connectto;
 	allow $1 postgresql_var_run_t:sock_file write;
+        # Some versions of postgresql put the sock file in /tmp
+	allow $1 postgresql_tmp_t:sock_file write;
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/privoxy.te serefpolicy-2.2.33/policy/modules/services/privoxy.te
--- nsaserefpolicy/policy/modules/services/privoxy.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.33/policy/modules/services/privoxy.te	2006-04-18 23:05:25.000000000 -0400
@@ -50,6 +50,7 @@
 corenet_non_ipsec_sendrecv(privoxy_t)
 corenet_tcp_bind_http_cache_port(privoxy_t)
 corenet_tcp_connect_http_port(privoxy_t)
+corenet_tcp_connect_http_cache_port(privoxy_t)
 corenet_tcp_connect_ftp_port(privoxy_t)
 corenet_tcp_connect_tor_port(privoxy_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/samba.te serefpolicy-2.2.33/policy/modules/services/samba.te
--- nsaserefpolicy/policy/modules/services/samba.te	2006-04-18 22:50:00.000000000 -0400
+++ serefpolicy-2.2.33/policy/modules/services/samba.te	2006-04-18 23:05:25.000000000 -0400
@@ -106,8 +106,8 @@
 files_tmp_filetrans(samba_net_t, samba_net_tmp_t, { file dir })
 
 allow samba_net_t samba_var_t:dir rw_dir_perms;
+allow samba_net_t samba_var_t:file create_file_perms;
 allow samba_net_t samba_var_t:lnk_file create_lnk_perms;
-allow samba_net_t samba_var_t:file create_lnk_perms;
 
 kernel_read_proc_symlinks(samba_net_t)
 
@@ -160,8 +160,10 @@
 	corenet_non_ipsec_sendrecv(samba_net_t)
 	corenet_tcp_bind_all_nodes(samba_net_t)
 	sysnet_read_config(samba_net_t)
+        corenet_tcp_connect_ldap_port(samba_net_t)
 ')
 
+
 optional_policy(`
 	nscd_socket_use(samba_net_t)
 ')
@@ -269,6 +271,7 @@
 
 init_use_fds(smbd_t)
 init_use_script_ptys(smbd_t)
+init_rw_utmp(smbd_t)
 
 libs_use_ld_so(smbd_t)
 libs_use_shared_libs(smbd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/spamassassin.fc serefpolicy-2.2.33/policy/modules/services/spamassassin.fc
--- nsaserefpolicy/policy/modules/services/spamassassin.fc	2005-12-01 17:57:16.000000000 -0500
+++ serefpolicy-2.2.33/policy/modules/services/spamassassin.fc	2006-04-18 23:05:25.000000000 -0400
@@ -1,5 +1,5 @@
 
-/usr/bin/sa-learn	--	gen_context(system_u:object_r:spamd_exec_t,s0)
+/usr/bin/sa-learn	--	gen_context(system_u:object_r:spamc_exec_t,s0)
 /usr/bin/spamc		--	gen_context(system_u:object_r:spamc_exec_t,s0)
 /usr/bin/spamd		--	gen_context(system_u:object_r:spamd_exec_t,s0)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.if serefpolicy-2.2.33/policy/modules/services/xserver.if
--- nsaserefpolicy/policy/modules/services/xserver.if	2006-04-06 15:31:54.000000000 -0400
+++ serefpolicy-2.2.33/policy/modules/services/xserver.if	2006-04-18 23:05:25.000000000 -0400
@@ -1070,3 +1070,24 @@
 
 	dontaudit $1 xdm_xserver_t:tcp_socket { read write };
 ')
+
+########################################
+## <summary>
+##	Allow read and write to
+##	a XDM X server socket.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to allow
+##	</summary>
+## </param>
+#
+interface(`xserver_rw_xdm_sockets',`
+	gen_require(`
+		type xdm_xserver_tmp_t;
+	')
+
+	allow $1 xdm_xserver_tmp_t:dir search;
+	allow $1 xdm_xserver_tmp_t:sock_file { read write };
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/authlogin.te serefpolicy-2.2.33/policy/modules/system/authlogin.te
--- nsaserefpolicy/policy/modules/system/authlogin.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.33/policy/modules/system/authlogin.te	2006-04-18 23:05:25.000000000 -0400
@@ -173,9 +173,13 @@
 dev_setattr_video_dev(pam_console_t)
 dev_getattr_xserver_misc_dev(pam_console_t)
 dev_setattr_xserver_misc_dev(pam_console_t)
+dev_read_urand(pam_console_t)
 
 fs_search_auto_mountpoints(pam_console_t)
 
+miscfiles_read_localization(pam_console_t)
+miscfiles_read_certs(pam_console_t)
+
 storage_getattr_fixed_disk_dev(pam_console_t)
 storage_setattr_fixed_disk_dev(pam_console_t)
 storage_getattr_removable_dev(pam_console_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/fstools.te serefpolicy-2.2.33/policy/modules/system/fstools.te
--- nsaserefpolicy/policy/modules/system/fstools.te	2006-04-04 18:06:38.000000000 -0400
+++ serefpolicy-2.2.33/policy/modules/system/fstools.te	2006-04-18 23:05:25.000000000 -0400
@@ -77,6 +77,7 @@
 dev_getattr_usbfs_dirs(fsadm_t)
 # Access to /dev/mapper/control
 dev_rw_lvm_control(fsadm_t)
+dev_dontaudit_getattr_all_device_nodes(fsadm_t)
 
 fs_search_auto_mountpoints(fsadm_t)
 fs_getattr_xattr_fs(fsadm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-2.2.33/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2006-04-18 22:50:00.000000000 -0400
+++ serefpolicy-2.2.33/policy/modules/system/init.te	2006-04-18 23:05:25.000000000 -0400
@@ -352,6 +352,7 @@
 files_mounton_isid_type_dirs(initrc_t)
 files_list_default(initrc_t)
 files_mounton_default(initrc_t)
+files_unlink_boot_flag(initrc_t)
 
 libs_rw_ld_so_cache(initrc_t)
 libs_use_ld_so(initrc_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.fc serefpolicy-2.2.33/policy/modules/system/libraries.fc
--- nsaserefpolicy/policy/modules/system/libraries.fc	2006-04-18 22:50:00.000000000 -0400
+++ serefpolicy-2.2.33/policy/modules/system/libraries.fc	2006-04-18 23:05:25.000000000 -0400
@@ -83,7 +83,6 @@
 /usr/lib(64)?/nvidia-graphics(-[^/]*/)?libGL(core)?\.so(\.[^/]*)*             --      	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/nvidia-graphics(-[^/]*/)?libnvidia.*\.so(\.[^/]*)*              --      	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/nvidia-graphics(-[^/]*/)?libXvMCNVIDIA\.so.*            --      	gen_context(system_u:object_r:textrel_shlib_t,s0)
-/usr/lib(64)?/vmware(.*/)?VmPerl\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 /usr/(local/)?lib(64)?/wine/.*\.so  		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/(local/)?lib/libfame-.*\.so.*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -189,6 +188,8 @@
 
 # vmware 
 /usr/lib(64)?/vmware/lib(/.*)?/libgdk-x11-.*\.so.*  -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/vmware/lib(/.*)?/HConfig.so  -- gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/vmware/(.*/)?VmPerl\.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 # Java, Sun Microsystems (JPackage SRPM)
 /usr/(.*/)?jre.*/libdeploy.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
@@ -223,3 +224,5 @@
 /var/spool/postfix/lib(64)?/lib.*\.so.*	--	gen_context(system_u:object_r:shlib_t,s0)
 /var/spool/postfix/lib(64)?/[^/]*/lib.*\.so.* -- gen_context(system_u:object_r:shlib_t,s0)
 /var/spool/postfix/lib(64)?/devfsd/.*\.so.* -- gen_context(system_u:object_r:shlib_t,s0)
+/usr/NX/lib/libXcomp.so.*	--  gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/NX/lib/libjpeg.so.* 	--  gen_context(system_u:object_r:textrel_shlib_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.if serefpolicy-2.2.33/policy/modules/system/mount.if
--- nsaserefpolicy/policy/modules/system/mount.if	2006-03-02 18:45:56.000000000 -0500
+++ serefpolicy-2.2.33/policy/modules/system/mount.if	2006-04-18 23:05:25.000000000 -0400
@@ -113,3 +113,25 @@
 	allow $1 mount_t:udp_socket rw_socket_perms;
 ')
 
+########################################
+## <summary>
+##	Execute mount in the unconfined_mount domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`unconfined_mount_domtrans',`
+	gen_require(`
+		type unconfined_mount_t, mount_exec_t;
+	')
+
+	domain_auto_trans($1,mount_exec_t,unconfined_mount_t)
+
+	allow $1 unconfined_mount_t:fd use;
+	allow unconfined_mount_t $1:fd use;
+	allow unconfined_mount_t $1:fifo_file rw_file_perms;
+	allow unconfined_mount_t $1:process sigchld;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.2.33/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2006-04-12 13:44:38.000000000 -0400
+++ serefpolicy-2.2.33/policy/modules/system/mount.te	2006-04-18 23:05:25.000000000 -0400
@@ -151,3 +151,12 @@
 optional_policy(`
 	samba_domtrans_smbmount(mount_t)
 ')
+
+ifdef(`targeted_policy', `
+	type unconfined_mount_t;
+	domain_type(unconfined_mount_t)
+	role system_r types unconfined_mount_t;
+	domain_entry_file(unconfined_mount_t,mount_exec_t)
+	files_manage_etc_runtime_files(unconfined_mount_t)
+	unconfined_domain(unconfined_mount_t)
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.if serefpolicy-2.2.33/policy/modules/system/selinuxutil.if
--- nsaserefpolicy/policy/modules/system/selinuxutil.if	2006-03-29 14:18:17.000000000 -0500
+++ serefpolicy-2.2.33/policy/modules/system/selinuxutil.if	2006-04-18 23:05:25.000000000 -0400
@@ -697,8 +697,8 @@
 
 	files_search_etc($1)
 	allow $1 selinux_config_t:dir search;
-	allow $1 file_context_t:dir r_dir_perms;
-	allow $1 file_context_t:file rw_file_perms;
+	allow $1 file_context_t:dir rw_dir_perms;
+	allow $1 file_context_t:file create_file_perms;
 	allow $1 file_context_t:lnk_file { getattr read };
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.te serefpolicy-2.2.33/policy/modules/system/unconfined.te
--- nsaserefpolicy/policy/modules/system/unconfined.te	2006-04-18 22:50:00.000000000 -0400
+++ serefpolicy-2.2.33/policy/modules/system/unconfined.te	2006-04-18 23:05:25.000000000 -0400
@@ -37,10 +37,13 @@
 	logging_domtrans_auditctl(unconfined_t)
 
 	seutil_domtrans_restorecon(unconfined_t)
+	seutil_domtrans_semanage(unconfined_t)
 
 	userdom_unconfined(unconfined_t)
 	userdom_priveleged_home_dir_manager(unconfined_t)
 
+	unconfined_mount_domtrans(unconfined_t)
+
 	optional_policy(`
 		ada_domtrans(unconfined_t)
 	')
@@ -140,10 +143,6 @@
 	')
 
 	optional_policy(`
-		seutil_domtrans_semanage(unconfined_t)
-	')
-
-	optional_policy(`
 		sysnet_domtrans_dhcpc(unconfined_t)
 	')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.if serefpolicy-2.2.33/policy/modules/system/userdomain.if
--- nsaserefpolicy/policy/modules/system/userdomain.if	2006-04-18 22:50:01.000000000 -0400
+++ serefpolicy-2.2.33/policy/modules/system/userdomain.if	2006-04-18 23:07:34.000000000 -0400
@@ -4171,6 +4173,7 @@
 		type user_home_dir_t;
 	')
 
+	allow $1 user_home_dir_t:dir create_dir_perms;
 	files_home_filetrans($1,user_home_dir_t,dir)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/Rules.modular serefpolicy-2.2.33/Rules.modular
--- nsaserefpolicy/Rules.modular	2006-03-23 14:33:29.000000000 -0500
+++ serefpolicy-2.2.33/Rules.modular	2006-04-18 23:05:25.000000000 -0400
@@ -208,7 +208,7 @@
 #
 $(APPDIR)/customizable_types: $(BASE_CONF)
 	@mkdir -p $(APPDIR)
-	$(verbose) $(GREP) '^[[:blank:]]*type .*customizable' $< | cut -d',' -f1 | cut -d' ' -f2 | $(SORT) -u > $(TMPDIR)/customizable_types
+	$(verbose) $(GREP) '^[[:blank:]]*type .*customizable' $< | cut -d';' -f1 | cut -d',' -f1 | cut -d' ' -f2 | $(SORT) -u > $(TMPDIR)/customizable_types
 	$(verbose) install -m 644 $(TMPDIR)/customizable_types $@ 
 
 ########################################

--------------040109060702060909040305--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
