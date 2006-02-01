Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k11DXMXf000258
	for <selinux@tycho.nsa.gov>; Wed, 1 Feb 2006 08:33:22 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k11DW5dS002748
	for <selinux@tycho.nsa.gov>; Wed, 1 Feb 2006 13:32:05 GMT
Message-ID: <43E0B8AA.6060407@redhat.com>
Date: Wed, 01 Feb 2006 08:33:30 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Latest Diffs
Content-Type: multipart/mixed;
 boundary="------------070603090602030707080408"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070603090602030707080408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

mls passwd changes from TCS.

I added a noaudit flag to unconfined_domain_template to stop mono/wine 
from spewing execmem messages to the auditlog.

filesystem cut and paste errors

ia64 needs fs_associate(dosfs_t)  I think its /boot is a dos partition.

Missing a couple of httpd_cache_t for FC4

Allow httpd_suexec_t to execute httpdcontent

Fix some automount/hald  searching

irqbalance wants to read etc and etc_runtime files.

wpa_supplicant changes for networkmanager, although there are more coming.

procmail talks to sendmail via unix_stream_socket.

spamasssasin wants to talk to ldap.

xserver changes in file context to map to current fedora.

Need to transition for unconfined_t to xdm_xserver_t, in order to allow 
startx to work from a user account.

Add file_context for initng





--------------070603090602030707080408
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/usermanage.te serefpolicy-2.2.10/policy/modules/admin/usermanage.te
--- nsaserefpolicy/policy/modules/admin/usermanage.te	2006-02-01 08:23:27.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/admin/usermanage.te	2006-02-01 08:25:15.000000000 -0500
@@ -328,6 +328,9 @@
 
 miscfiles_read_localization(passwd_t)
 
+mls_file_write_down(passwd_t)
+mls_file_downgrade(passwd_t)
+
 seutil_dontaudit_search_config(passwd_t)
 
 userdom_use_unpriv_users_fd(passwd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/mono.te serefpolicy-2.2.10/policy/modules/apps/mono.te
--- nsaserefpolicy/policy/modules/apps/mono.te	2006-01-27 21:35:04.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/apps/mono.te	2006-02-01 08:25:15.000000000 -0500
@@ -19,7 +19,7 @@
 
 ifdef(`targeted_policy',`
 	allow mono_t self:process { execheap execmem };
-	unconfined_domain_template(mono_t)
+	unconfined_domain_template(mono_t, noaudit)
 	role system_r types mono_t;
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/wine.te serefpolicy-2.2.10/policy/modules/apps/wine.te
--- nsaserefpolicy/policy/modules/apps/wine.te	2006-01-19 18:02:04.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/apps/wine.te	2006-02-01 08:25:15.000000000 -0500
@@ -19,7 +19,7 @@
 
 ifdef(`targeted_policy',`
 	allow wine_t self:process { execstack execmem };
-	unconfined_domain_template(wine_t)
+	unconfined_domain_template(wine_t, noaudit)
 	role system_r types wine_t;
 	allow wine_t file_type:file execmod;
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/filesystem.if serefpolicy-2.2.10/policy/modules/kernel/filesystem.if
--- nsaserefpolicy/policy/modules/kernel/filesystem.if	2006-02-01 08:23:28.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/kernel/filesystem.if	2006-02-01 08:25:15.000000000 -0500
@@ -149,7 +149,7 @@
 		type fs_t;
 	')
 
-	allow $1 fs_t:filesystem mount;
+	allow $1 fs_t:filesystem unmount;
 ')
 
 ########################################
@@ -289,7 +289,7 @@
 		type autofs_t;
 	')
 
-	allow $1 autofs_t:filesystem mount;
+	allow $1 autofs_t:filesystem unmount;
 ')
 
 ########################################
@@ -856,7 +856,7 @@
 		type dosfs_t;
 	')
 
-	allow $1 dosfs_t:filesystem mount;
+	allow $1 dosfs_t:filesystem unmount;
 ')
 
 ########################################
@@ -976,7 +976,7 @@
 		type iso9660_t;
 	')
 
-	allow $1 iso9660_t:filesystem mount;
+	allow $1 iso9660_t:filesystem unmount;
 ')
 
 ########################################
@@ -1043,7 +1043,7 @@
 		type nfs_t;
 	')
 
-	allow $1 nfs_t:filesystem mount;
+	allow $1 nfs_t:filesystem unmount;
 ')
 
 ########################################
@@ -1608,7 +1608,7 @@
 		type nfsd_fs_t;
 	')
 
-	allow $1 nfsd_fs_t:filesystem mount;
+	allow $1 nfsd_fs_t:filesystem unmount;
 ')
 
 ########################################
@@ -1709,7 +1709,7 @@
 		type ramfs_t;
 	')
 
-	allow $1 ramfs_t:filesystem mount;
+	allow $1 ramfs_t:filesystem unmount;
 ')
 
 ########################################
@@ -1855,7 +1855,7 @@
 		type romfs_t;
 	')
 
-	allow $1 romfs_t:filesystem mount;
+	allow $1 romfs_t:filesystem unmount;
 ')
 
 ########################################
@@ -1922,7 +1922,7 @@
 		type rpc_pipefs_t;
 	')
 
-	allow $1 rpc_pipefs_t:filesystem mount;
+	allow $1 rpc_pipefs_t:filesystem unmount;
 ')
 
 ########################################
@@ -1988,7 +1988,7 @@
 		type tmpfs_t;
 	')
 
-	allow $1 tmpfs_t:filesystem mount;
+	allow $1 tmpfs_t:filesystem unmount;
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/filesystem.te serefpolicy-2.2.10/policy/modules/kernel/filesystem.te
--- nsaserefpolicy/policy/modules/kernel/filesystem.te	2006-01-17 17:08:52.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/kernel/filesystem.te	2006-02-01 08:25:15.000000000 -0500
@@ -134,6 +134,7 @@
 #
 type dosfs_t, noxattrfs;
 fs_type(dosfs_t)
+fs_associate(dosfs_t)
 genfscon fat / gen_context(system_u:object_r:dosfs_t,s0)
 genfscon msdos / gen_context(system_u:object_r:dosfs_t,s0)
 genfscon ntfs / gen_context(system_u:object_r:dosfs_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/mls.te serefpolicy-2.2.10/policy/modules/kernel/mls.te
--- nsaserefpolicy/policy/modules/kernel/mls.te	2006-01-17 17:08:52.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/kernel/mls.te	2006-02-01 08:25:15.000000000 -0500
@@ -86,7 +86,8 @@
 ')
 
 ifdef(`enable_mls',`
-# run init with maximum MLS range
 range_transition kernel_t init_exec_t s0 - s15:c0.c255;
+range_transition kernel_t lvm_exec_t s0 - s15:c0.c255;
 range_transition initrc_t auditd_exec_t s15:c0.c255;
+range_transition sysadm_t rpm_exec_t s0 - s15:c0.c255;
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.fc serefpolicy-2.2.10/policy/modules/services/apache.fc
--- nsaserefpolicy/policy/modules/services/apache.fc	2005-11-15 09:13:36.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/services/apache.fc	2006-02-01 08:25:15.000000000 -0500
@@ -42,6 +42,8 @@
 /var/cache/php-eaccelerator(/.*)?	gen_context(system_u:object_r:httpd_cache_t,s0)
 /var/cache/php-mmcache(/.*)?		gen_context(system_u:object_r:httpd_cache_t,s0)
 /var/cache/ssl.*\.sem		--	gen_context(system_u:object_r:httpd_cache_t,s0)
+/var/cache/mason(/.*)?			gen_context(system_u:object_r:httpd_cache_t,s0)
+/var/cache/rt3(/.*)?			gen_context(system_u:object_r:httpd_cache_t,s0)
 
 /var/lib/dav(/.*)?			gen_context(system_u:object_r:httpd_var_lib_t,s0)
 /var/lib/htdig(/.*)?			gen_context(system_u:object_r:httpd_sys_content_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.te serefpolicy-2.2.10/policy/modules/services/apache.te
--- nsaserefpolicy/policy/modules/services/apache.te	2006-02-01 08:23:29.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/services/apache.te	2006-02-01 08:25:15.000000000 -0500
@@ -347,6 +347,7 @@
 
 tunable_policy(`httpd_enable_cgi && httpd_unified && httpd_builtin_scripting',`
 	domain_auto_trans(httpd_t, httpdcontent, httpd_sys_script_t)
+	domain_auto_trans(httpd_suexec_t, httpdcontent, httpd_sys_script_t)
 	allow httpd_t httpd_sys_script_t:fd use;
 	allow httpd_sys_script_t httpd_t:fd use;
 	allow httpd_sys_script_t httpd_t:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/automount.te serefpolicy-2.2.10/policy/modules/services/automount.te
--- nsaserefpolicy/policy/modules/services/automount.te	2006-02-01 08:23:29.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/services/automount.te	2006-02-01 08:25:15.000000000 -0500
@@ -64,6 +64,7 @@
 kernel_list_proc(automount_t)
 
 bootloader_getattr_boot_dir(automount_t)
+bootloader_search_boot(automount_t)
 
 corecmd_exec_sbin(automount_t)
 corecmd_exec_bin(automount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.2.10/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2006-02-01 08:23:30.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/services/hal.te	2006-02-01 08:25:15.000000000 -0500
@@ -51,6 +51,7 @@
 kernel_write_proc_files(hald_t)
 
 bootloader_getattr_boot_dir(hald_t)
+bootloader_search_boot(hald_t)
 
 corecmd_exec_bin(hald_t)
 corecmd_exec_sbin(hald_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/irqbalance.te serefpolicy-2.2.10/policy/modules/services/irqbalance.te
--- nsaserefpolicy/policy/modules/services/irqbalance.te	2006-02-01 08:23:30.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/services/irqbalance.te	2006-02-01 08:25:15.000000000 -0500
@@ -31,6 +31,9 @@
 
 dev_read_sysfs(irqbalance_t)
 
+files_read_etc_files(irqbalance_t)
+files_read_etc_runtime_files(irqbalance_t)
+
 fs_getattr_all_fs(irqbalance_t)
 fs_search_auto_mountpoints(irqbalance_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/networkmanager.fc serefpolicy-2.2.10/policy/modules/services/networkmanager.fc
--- nsaserefpolicy/policy/modules/services/networkmanager.fc	2005-11-14 18:24:07.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/services/networkmanager.fc	2006-02-01 08:25:15.000000000 -0500
@@ -1,2 +1,4 @@
 
-/usr/bin/NetworkManager	--	gen_context(system_u:object_r:NetworkManager_exec_t,s0)
+/usr/(s)?bin/NetworkManager	--	gen_context(system_u:object_r:NetworkManager_exec_t,s0)
+/var/run/NetworkManager.pid	--	gen_context(system_u:object_r:NetworkManager_var_run_t,s0)
+/var/run/wpa_supplicant(/.*)?		gen_context(system_u:object_r:NetworkManager_var_run_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/networkmanager.te serefpolicy-2.2.10/policy/modules/services/networkmanager.te
--- nsaserefpolicy/policy/modules/services/networkmanager.te	2006-02-01 08:23:31.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/services/networkmanager.te	2006-02-01 08:25:15.000000000 -0500
@@ -24,7 +24,7 @@
 allow NetworkManager_t self:fifo_file rw_file_perms;
 allow NetworkManager_t self:unix_dgram_socket create_socket_perms;
 allow NetworkManager_t self:unix_stream_socket create_stream_socket_perms;
-allow NetworkManager_t self:netlink_route_socket r_netlink_socket_perms;
+allow NetworkManager_t self:netlink_route_socket create_netlink_socket_perms;
 allow NetworkManager_t self:tcp_socket create_stream_socket_perms;
 allow NetworkManager_t self:udp_socket create_socket_perms;
 allow NetworkManager_t self:packet_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/procmail.te serefpolicy-2.2.10/policy/modules/services/procmail.te
--- nsaserefpolicy/policy/modules/services/procmail.te	2006-02-01 08:23:31.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/services/procmail.te	2006-02-01 08:25:15.000000000 -0500
@@ -96,6 +96,7 @@
 optional_policy(`sendmail',`
 	mta_read_config(procmail_t)
 	sendmail_rw_tcp_socket(procmail_t)
+	sendmail_rw_unix_stream_socket(procmail_t)
 ')
 
 optional_policy(`spamassassin',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/sendmail.if serefpolicy-2.2.10/policy/modules/services/sendmail.if
--- nsaserefpolicy/policy/modules/services/sendmail.if	2006-01-13 17:06:07.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/services/sendmail.if	2006-02-01 08:25:15.000000000 -0500
@@ -52,6 +52,21 @@
 
 	allow $1 sendmail_t:tcp_socket { read write };
 ')
+########################################
+## <summary>
+##	Read and write sendmail unix_stream_sockets.
+## </summary>
+## <param name="domain">
+##	Domain allowed access.
+## </param>
+#
+interface(`sendmail_rw_unix_stream_socket',`
+	gen_require(`
+		type sendmail_t;
+	')
+
+	allow $1 sendmail_t:unix_stream_socket { read write };
+')
 
 ########################################
 ## <summary>
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/spamassassin.te serefpolicy-2.2.10/policy/modules/services/spamassassin.te
--- nsaserefpolicy/policy/modules/services/spamassassin.te	2006-02-01 08:23:31.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/services/spamassassin.te	2006-02-01 08:25:15.000000000 -0500
@@ -77,6 +77,7 @@
 # DnsResolver.pm module which binds to
 # random ports >= 1024.
 corenet_udp_bind_generic_port(spamd_t)
+sysnet_use_ldap(spamd_t)
 
 dev_read_sysfs(spamd_t)
 dev_read_urand(spamd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.fc serefpolicy-2.2.10/policy/modules/services/xserver.fc
--- nsaserefpolicy/policy/modules/services/xserver.fc	2006-02-01 08:23:32.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/services/xserver.fc	2006-02-01 08:25:15.000000000 -0500
@@ -58,16 +58,19 @@
 
 /usr/X11R6/bin/[xgkw]dm	--	gen_context(system_u:object_r:xdm_exec_t,s0)
 /usr/X11R6/bin/iceauth	--	gen_context(system_u:object_r:iceauth_exec_t,s0)
-/usr/X11R6/bin/X		--	gen_context(system_u:object_r:xserver_exec_t,s0)
+/usr/X11R6/bin/X	--	gen_context(system_u:object_r:xserver_exec_t,s0)
 /usr/X11R6/bin/xauth    --      gen_context(system_u:object_r:xauth_exec_t,s0)
 /usr/X11R6/bin/XFree86	--	gen_context(system_u:object_r:xserver_exec_t,s0)
 /usr/X11R6/bin/Xipaq	--	gen_context(system_u:object_r:xserver_exec_t,s0)
 /usr/X11R6/bin/Xorg	--	gen_context(system_u:object_r:xserver_exec_t,s0)
-/usr/X11R6/bin/Xwrapper	--	gen_context(system_u:object_r:xserver_exec_t,s0)
-
 /usr/X11R6/lib/X11/xkb	-d	gen_context(system_u:object_r:xkb_var_lib_t,s0)
 /usr/X11R6/lib/X11/xkb/.* --	gen_context(system_u:object_r:xkb_var_lib_t,s0)
 
+/usr/X11R6/bin/Xwrapper	--	gen_context(system_u:object_r:xserver_exec_t,s0)
+/usr/bin/iceauth	--	gen_context(system_u:object_r:iceauth_exec_t,s0)
+/usr/bin/xauth    	--      gen_context(system_u:object_r:xauth_exec_t,s0)
+/usr/bin/Xorg		--	gen_context(system_u:object_r:xserver_exec_t,s0)
+
 #
 # /var
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.if serefpolicy-2.2.10/policy/modules/services/xserver.if
--- nsaserefpolicy/policy/modules/services/xserver.if	2006-02-01 08:23:32.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/services/xserver.if	2006-02-01 08:25:15.000000000 -0500
@@ -1,4 +1,25 @@
 ## <summary>X Windows Server</summary>
+########################################
+## <summary>
+##	Execute xdmd in the xdmd domain.
+## </summary>
+## <param name="domain">
+##	The type of the process performing this action.
+## </param>
+#
+interface(`xserver_domtrans',`
+	gen_require(`
+		type xdm_xserver_t, xserver_exec_t;
+	')
+
+	domain_auto_trans($1,xserver_exec_t,xdm_xserver_t)
+
+	allow $1 xdm_xserver_t:fd use;
+	allow xdm_xserver_t $1:fd use;
+	allow xdm_xserver_t $1:fifo_file rw_file_perms;
+	allow xdm_xserver_t $1:process sigchld;
+')
+
 
 template(`xserver_common_domain_template',`
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.te serefpolicy-2.2.10/policy/modules/services/xserver.te
--- nsaserefpolicy/policy/modules/services/xserver.te	2006-02-01 08:23:32.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/services/xserver.te	2006-02-01 08:25:15.000000000 -0500
@@ -57,10 +57,8 @@
 type xserver_log_t;
 logging_log_file(xserver_log_t)
 
-ifdef(`strict_policy',`
-	xserver_common_domain_template(xdm)
-	init_system_domain(xdm_xserver_t,xserver_exec_t)
-')
+xserver_common_domain_template(xdm)
+init_system_domain(xdm_xserver_t,xserver_exec_t)
 
 optional_policy(`prelink',`
 	prelink_object_file(xkb_var_lib_t)
@@ -302,6 +300,9 @@
 	allow xdm_t self:process { execheap execmem };
 	unconfined_domain_template(xdm_t)
 	unconfined_domtrans(xdm_t)
+	allow xdm_xserver_t self:process { execheap execmem };
+	unconfined_domain_template(xdm_xserver_t)
+	unconfined_domtrans(xdm_xserver_t)
 ')
 
 tunable_policy(`use_nfs_home_dirs',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.fc serefpolicy-2.2.10/policy/modules/system/init.fc
--- nsaserefpolicy/policy/modules/system/init.fc	2006-01-16 22:19:19.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/system/init.fc	2006-02-01 08:25:15.000000000 -0500
@@ -22,7 +22,8 @@
 #
 # /sbin
 #
-/sbin/init		--	gen_context(system_u:object_r:init_exec_t,s0)
+/sbin/init(ng)?		--	gen_context(system_u:object_r:init_exec_t,s0)
+
 
 ifdef(`distro_gentoo', `
 /sbin/rc			--	gen_context(system_u:object_r:initrc_exec_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.if serefpolicy-2.2.10/policy/modules/system/unconfined.if
--- nsaserefpolicy/policy/modules/system/unconfined.if	2006-01-30 18:40:37.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/system/unconfined.if	2006-02-01 08:25:15.000000000 -0500
@@ -41,14 +41,18 @@
 	tunable_policy(`allow_execheap',`
 		# Allow making the stack executable via mprotect.
 		allow $1 self:process execheap;
-		auditallow $1 self:process execheap;
+		ifelse($2, `', `
+			auditallow $1 self:process execheap;
+		')
 	')
 
 	tunable_policy(`allow_execmem',`
 		# Allow making anonymous memory executable, e.g. 
 		# for runtime-code generation or executable stack.
 		allow $1 self:process execmem;
-		auditallow $1 self:process execmem;
+		ifelse($2, `', `
+			auditallow $1 self:process execmem;
+		')
 	')
 
 	tunable_policy(`allow_execmem && allow_execstack',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.te serefpolicy-2.2.10/policy/modules/system/unconfined.te
--- nsaserefpolicy/policy/modules/system/unconfined.te	2006-01-27 21:35:05.000000000 -0500
+++ serefpolicy-2.2.10/policy/modules/system/unconfined.te	2006-02-01 08:25:15.000000000 -0500
@@ -148,4 +148,8 @@
 	optional_policy(`wine',`
 		wine_domtrans(unconfined_t)
 	')
+
+	optional_policy(`xserver',`
+		xserver_domtrans(unconfined_t)
+	')
 ')

--------------070603090602030707080408--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
