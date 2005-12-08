Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jB8LLaMA013697
	for <selinux@tycho.nsa.gov>; Thu, 8 Dec 2005 16:21:36 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jB8LDrYY018199
	for <selinux@tycho.nsa.gov>; Thu, 8 Dec 2005 21:13:53 GMT
Message-ID: <4398A239.1080005@redhat.com>
Date: Thu, 08 Dec 2005 16:14:33 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Latest Ref Policy Diffs
Content-Type: multipart/mixed;
 boundary="------------070006080107090902040100"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070006080107090902040100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Major change in targeted policy is about to hit.  Basically we are going 
to turn off allow_execmod, allow_execmem, and allow_execstack by default 
for unconfined_t programs.

So several of these patches are to allow that to happen.  Including 
turning on a real xdm policy.  Getting rid of the alias of 
texrel_shlib_t to shlib_t.  Mozilla libraries all marked 
texrel_shlib_t.  ( A bug has been reported on this and hopefully a fix will
be added.)

So far I see hal and Xorg as needing execmem.

gfs support is added

Most if not all of the kernel leaky file descriptors have been fixed so 
alot of nasty dontaudits are no longer necessary.

customizable_types file generated from base.pp for targeted policy.

-- 



--------------070006080107090902040100
Content-Type: text/x-patch;
 name="policy-20051208.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20051208.patch"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/config/appconfig-targeted-mcs/default_contexts serefpolicy-2.1.0/config/appconfig-targeted-mcs/default_contexts
--- nsaserefpolicy/config/appconfig-targeted-mcs/default_contexts	2005-11-14 18:24:05.000000000 -0500
+++ serefpolicy-2.1.0/config/appconfig-targeted-mcs/default_contexts	2005-12-08 15:30:35.000000000 -0500
@@ -1,3 +1,4 @@
+system_r:xdm_t:s0		system_r:unconfined_t:s0
 system_r:unconfined_t:s0	system_r:unconfined_t:s0
 system_r:initrc_t:s0		system_r:unconfined_t:s0
 system_r:local_login_t:s0	system_r:unconfined_t:s0
diff --exclude-from=exclude -N -u -r nsaserefpolicy/Makefile serefpolicy-2.1.0/Makefile
--- nsaserefpolicy/Makefile	2005-12-05 22:35:02.000000000 -0500
+++ serefpolicy-2.1.0/Makefile	2005-12-08 15:28:11.000000000 -0500
@@ -92,7 +92,7 @@
 
 # enable MLS if requested.
 ifneq ($(findstring -mls,$(TYPE)),)
-	override M4PARAM += -D enable_mls
+	override M4PARAM += -D enable_mls -D separate_secadm
 	override CHECKPOLICY += -M
 	override CHECKMODULE += -M
 endif
@@ -274,11 +274,6 @@
 	@mkdir -p $(APPDIR)
 	$(QUIET) install -m 644 $< $@
 
-$(APPDIR)/customizable_types: policy.conf
-	@mkdir -p $(APPDIR)
-	$(QUIET) grep "^type .*customizable" $< | cut -d',' -f1 | cut -d' ' -f2 > tmp/customizable_types
-	$(QUIET) install -m 644 tmp/customizable_types $@ 
-
 $(APPDIR)/default_type: $(APPCONF)/default_type
 	@mkdir -p $(APPDIR)
 	$(QUIET) install -m 644 $< $@
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/su.if serefpolicy-2.1.0/policy/modules/admin/su.if
--- nsaserefpolicy/policy/modules/admin/su.if	2005-11-29 18:36:30.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/admin/su.if	2005-12-08 15:28:11.000000000 -0500
@@ -50,6 +50,9 @@
 	selinux_compute_relabel_context($1_su_t)
 	selinux_compute_user_contexts($1_su_t)
 
+	files_dontaudit_getattr_tmp_dir($1_su_t)
+	files_dontaudit_read_etc_runtime_files($1_su_t)
+
 	auth_domtrans_chk_passwd($1_su_t)
 	auth_dontaudit_read_shadow($1_su_t)
 	auth_use_nsswitch($1_su_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/filesystem.te serefpolicy-2.1.0/policy/modules/kernel/filesystem.te
--- nsaserefpolicy/policy/modules/kernel/filesystem.te	2005-11-25 08:11:10.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/kernel/filesystem.te	2005-12-08 15:28:11.000000000 -0500
@@ -25,6 +25,7 @@
 fs_use_xattr jfs gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr reiserfs gen_context(system_u:object_r:fs_t,s0);
 fs_use_xattr xfs gen_context(system_u:object_r:fs_t,s0);
+fs_use_xattr gfs gen_context(system_u:object_r:fs_t,s0);
 
 # Use the allocating task SID to label inodes in the following filesystem
 # types, and label the filesystem itself with the specified context.
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/canna.te serefpolicy-2.1.0/policy/modules/services/canna.te
--- nsaserefpolicy/policy/modules/services/canna.te	2005-12-06 19:49:49.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/services/canna.te	2005-12-08 15:28:11.000000000 -0500
@@ -47,7 +47,6 @@
 
 kernel_read_kernel_sysctl(canna_t)
 kernel_read_system_state(canna_t)
-kernel_dontaudit_use_fd(canna_t)
 
 corenet_tcp_sendrecv_all_if(canna_t)
 corenet_raw_sendrecv_all_if(canna_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.te serefpolicy-2.1.0/policy/modules/services/cups.te
--- nsaserefpolicy/policy/modules/services/cups.te	2005-12-06 19:49:50.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/services/cups.te	2005-12-08 15:28:11.000000000 -0500
@@ -471,6 +471,7 @@
 # Cups configuration daemon local policy
 #
 
+allow cupsd_config_t cupsd_log_t:file rw_file_perms;
 allow cupsd_config_t self:capability { chown sys_tty_config };
 dontaudit cupsd_config_t self:capability sys_tty_config;
 allow cupsd_config_t self:process signal_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dbus.te serefpolicy-2.1.0/policy/modules/services/dbus.te
--- nsaserefpolicy/policy/modules/services/dbus.te	2005-12-06 19:49:50.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/services/dbus.te	2005-12-08 15:28:11.000000000 -0500
@@ -32,7 +32,7 @@
 # cjp: dac_override should probably go in a distro_debian
 allow system_dbusd_t self:capability { dac_override setgid setpcap setuid };
 dontaudit system_dbusd_t self:capability sys_tty_config;
-allow system_dbusd_t self:process { getattr signal_perms };
+allow system_dbusd_t self:process { getattr signal_perms setcap };
 allow system_dbusd_t self:fifo_file { read write };
 allow system_dbusd_t self:dbus { send_msg acquire_svc };
 allow system_dbusd_t self:unix_stream_socket { connectto create_stream_socket_perms connectto };
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ftp.te serefpolicy-2.1.0/policy/modules/services/ftp.te
--- nsaserefpolicy/policy/modules/services/ftp.te	2005-12-06 19:49:50.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/services/ftp.te	2005-12-08 15:28:11.000000000 -0500
@@ -105,6 +105,9 @@
 
 domain_use_wide_inherit_fd(ftpd_t)
 
+files_search_var_lib_dir(ftpd_t)
+auth_use_nsswitch(ftpd_t)
+
 files_search_etc(ftpd_t)
 files_read_etc_files(ftpd_t)
 files_read_etc_runtime_files(ftpd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.1.0/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2005-12-06 19:49:50.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/services/hal.te	2005-12-08 15:28:11.000000000 -0500
@@ -23,11 +23,13 @@
 
 allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search mknod sys_rawio };
 dontaudit hald_t self:capability sys_tty_config;
-allow hald_t self:process signal_perms;
+# vbetool requires execmem
+allow hald_t self:process { execmem signal_perms };
 allow hald_t self:fifo_file rw_file_perms;
 allow hald_t self:unix_stream_socket { create_stream_socket_perms connectto };
 allow hald_t self:unix_dgram_socket create_socket_perms;
 allow hald_t self:netlink_route_socket r_netlink_socket_perms;
+allow hald_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 allow hald_t self:netlink_kobject_uevent_socket create_socket_perms;
 allow hald_t self:tcp_socket create_stream_socket_perms;
 allow hald_t self:udp_socket create_socket_perms;
@@ -59,7 +61,10 @@
 corenet_tcp_bind_all_nodes(hald_t)
 corenet_udp_bind_all_nodes(hald_t)
 
-dev_read_sysfs(hald_t)
+# hal is now execing pm-suspend
+files_create_boot_flag(hald_t)
+dev_rw_sysfs(hald_t)
+
 dev_rw_usbfs(hald_t)
 dev_read_urand(hald_t)
 dev_read_input(hald_t)
@@ -138,6 +143,10 @@
 	cups_signal_config(hald_t)
 ')
 
+optional_policy(`ntp',`
+	ntp_domtrans(hald_t)
+')
+
 optional_policy(`dbus',`
 	dbus_system_bus_client_template(hald,hald_t)
 	dbus_send_system_bus_msg(hald_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/mta.te serefpolicy-2.1.0/policy/modules/services/mta.te
--- nsaserefpolicy/policy/modules/services/mta.te	2005-12-06 19:49:50.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/services/mta.te	2005-12-08 15:28:11.000000000 -0500
@@ -57,15 +57,6 @@
 
 userdom_use_sysadm_terms(system_mail_t)
 
-ifdef(`hide_broken_symptoms',`
-	# Red Hat systems seem to have a stray
-	# fds open from the initrd
-	ifdef(`distro_redhat',`
-		kernel_dontaudit_use_fd(system_mail_t)
-		storage_dontaudit_read_fixed_disk(system_mail_t)
-	')
-')
-
 ifdef(`targeted_policy',`
 	typealias system_mail_t alias sysadm_mail_t;
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/nis.if serefpolicy-2.1.0/policy/modules/services/nis.if
--- nsaserefpolicy/policy/modules/services/nis.if	2005-12-06 19:49:50.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/services/nis.if	2005-12-08 15:28:11.000000000 -0500
@@ -150,8 +150,10 @@
 interface(`nis_signal_ypbind',`
 	gen_require(`
 		type ypbind_t;
+		type ypbind_var_run_t;
 	')
 
+	allow $1 ypbind_var_run_t:file read;
 	allow $1 ypbind_t:process signal;
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/sasl.te serefpolicy-2.1.0/policy/modules/services/sasl.te
--- nsaserefpolicy/policy/modules/services/sasl.te	2005-12-06 19:49:51.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/services/sasl.te	2005-12-08 15:28:11.000000000 -0500
@@ -18,6 +18,7 @@
 # Local policy
 #
 
+allow saslauthd_t self:capability setuid;
 dontaudit saslauthd_t self:capability sys_tty_config;
 allow saslauthd_t self:process signal_perms;
 allow saslauthd_t self:fifo_file { read write };
@@ -56,9 +57,10 @@
 domain_use_wide_inherit_fd(saslauthd_t)
 
 files_read_etc_files(saslauthd_t)
-files_read_etc_runtime_files(saslauthd_t)
+files_dontaudit_read_etc_runtime_files(saslauthd_t)
 files_search_var_lib(saslauthd_t)
 files_dontaudit_getattr_home_dir(saslauthd_t)
+files_dontaudit_getattr_tmp_dir(saslauthd_t)
 
 init_use_fd(saslauthd_t)
 init_use_script_pty(saslauthd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/spamassassin.te serefpolicy-2.1.0/policy/modules/services/spamassassin.te
--- nsaserefpolicy/policy/modules/services/spamassassin.te	2005-12-06 19:49:51.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/services/spamassassin.te	2005-12-08 15:28:11.000000000 -0500
@@ -73,6 +73,7 @@
 corenet_tcp_bind_all_nodes(spamd_t)
 corenet_udp_bind_all_nodes(spamd_t)
 corenet_tcp_bind_spamd_port(spamd_t)
+corenet_udp_bind_generic_port(spamd_t)
 
 dev_read_sysfs(spamd_t)
 dev_read_urand(spamd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xdm.te serefpolicy-2.1.0/policy/modules/services/xdm.te
--- nsaserefpolicy/policy/modules/services/xdm.te	2005-11-25 08:11:12.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/services/xdm.te	2005-12-08 15:28:11.000000000 -0500
@@ -6,11 +6,7 @@
 # Declarations
 #
 
-ifdef(`targeted_policy',`
-	unconfined_alias_domain(xdm_t)
-',`
-	type xdm_t;
-')
+type xdm_t;
 
 # real declaration moved to mls until
 # range_transition works in loadable modules
@@ -79,6 +75,8 @@
 
 ifdef(`targeted_policy',`
 	unconfined_domain_template(xdm_t)
+	allow xdm_t self:process execmem;
+	 unconfined_domtrans(xdm_t)
 ',`
 	allow xdm_t xdm_lock_t:file create_file_perms;
 	files_create_lock(xdm_t,xdm_lock_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/hostname.te serefpolicy-2.1.0/policy/modules/system/hostname.te
--- nsaserefpolicy/policy/modules/system/hostname.te	2005-11-25 08:11:12.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/system/hostname.te	2005-12-08 15:28:11.000000000 -0500
@@ -22,7 +22,6 @@
 allow hostname_t self:unix_stream_socket create_stream_socket_perms;
 dontaudit hostname_t self:capability sys_tty_config;
 
-kernel_dontaudit_use_fd(hostname_t)
 kernel_list_proc(hostname_t)
 kernel_read_proc_symlinks(hostname_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.if serefpolicy-2.1.0/policy/modules/system/init.if
--- nsaserefpolicy/policy/modules/system/init.if	2005-12-05 22:35:03.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/system/init.if	2005-12-08 15:28:11.000000000 -0500
@@ -31,18 +31,6 @@
 	allow init_t $1:fd use;
 	allow $1 init_t:fifo_file rw_file_perms;
 	allow $1 init_t:process sigchld;
-
-	# Red Hat systems seem to have stray
-	# fds open from the initrd
-	ifdef(`hide_broken_symptoms',`
-		# Red Hat systems seem to have a stray
-		# fds open from the initrd
-		ifdef(`distro_redhat',`
-			kernel_dontaudit_use_fd($1)
-			storage_dontaudit_read_fixed_disk($1)
-			files_dontaudit_read_root_file($1)
-		')
-	')
 ')
 
 ########################################
@@ -82,16 +70,6 @@
 		typeattribute $2 direct_init_entry;
 	')
 
-	ifdef(`hide_broken_symptoms',`
-		# Red Hat systems seem to have a stray
-		# fds open from the initrd
-		ifdef(`distro_redhat',`
-			kernel_dontaudit_use_fd($1)
-			storage_dontaudit_read_fixed_disk($1)
-			files_dontaudit_read_root_file($1)
-		')
-	')
-
 	ifdef(`targeted_policy',`
 		# this regex is a hack, since it assumes there is a
 		# _t at the end of the domain type.  If there is no _t
@@ -164,15 +142,6 @@
 	allow $1 initrc_t:fifo_file rw_file_perms;
 	allow $1 initrc_t:process sigchld;
 
-	ifdef(`hide_broken_symptoms',`
-		# Red Hat systems seem to have a stray
-		# fds open from the initrd
-		ifdef(`distro_redhat',`
-			kernel_dontaudit_use_fd($1)
-			storage_dontaudit_read_fixed_disk($1)
-			files_dontaudit_read_root_file($1)
-		')
-	')
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.fc serefpolicy-2.1.0/policy/modules/system/libraries.fc
--- nsaserefpolicy/policy/modules/system/libraries.fc	2005-12-02 17:53:27.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/system/libraries.fc	2005-12-08 15:28:11.000000000 -0500
@@ -62,7 +62,8 @@
 /usr/lib(64)?/im/.*\.so.*		--	gen_context(system_u:object_r:shlib_t,s0)
 /usr/lib(64)?/iiim/.*\.so.*		--	gen_context(system_u:object_r:shlib_t,s0)
 
-/usr/lib(64)?/libGL(core)?/.so(\.[^/]*)* --	gen_context(system_u:object_r:texrel_shlib_t,s0)
+/usr/lib(64)?/libGL(core)?\.so(\.[^/]*)* --	gen_context(system_u:object_r:texrel_shlib_t,s0)
+/usr/lib(64)?/libGLU\.so(\.[^/]*)* --	gen_context(system_u:object_r:texrel_shlib_t,s0)
 /usr/lib(64)?(/.*)?/libnvidia.*\.so(\.[^/]*)* -- gen_context(system_u:object_r:texrel_shlib_t,s0)
 
 /usr/(local/)?lib/wine/.*\.so  		--	gen_context(system_u:object_r:texrel_shlib_t,s0)
@@ -103,7 +104,10 @@
 /usr/lib/valgrind/hp2ps			--	gen_context(system_u:object_r:texrel_shlib_t,s0)
 /usr/lib/valgrind/stage2		--	gen_context(system_u:object_r:texrel_shlib_t,s0)
 /usr/lib/valgrind/vg.*\.so		--	gen_context(system_u:object_r:texrel_shlib_t,s0)
-/usr/lib/.*/libxpcom_core.so		--	gen_context(system_u:object_r:texrel_shlib_t,s0)
+/usr/lib(64)?/thunderbird.*\.so		--	gen_context(system_u:object_r:texrel_shlib_t,s0)
+/usr/lib(64)?/mozilla.*\.so		--	gen_context(system_u:object_r:texrel_shlib_t,s0)
+/usr/lib(64)?/sunbird.*\.so		--	gen_context(system_u:object_r:texrel_shlib_t,s0)
+/usr/lib(64)?/firefox.*\.so		--	gen_context(system_u:object_r:texrel_shlib_t,s0)
 /usr/lib/.*/program/libicudata\.so.*	--	gen_context(system_u:object_r:texrel_shlib_t,s0)
 /usr/lib/.*/program/libsts645li\.so	--	gen_context(system_u:object_r:texrel_shlib_t,s0)
 /usr/lib/.*/program/libvclplug_gen645li\.so --	gen_context(system_u:object_r:texrel_shlib_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.te serefpolicy-2.1.0/policy/modules/system/libraries.te
--- nsaserefpolicy/policy/modules/system/libraries.te	2005-11-25 08:11:12.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/system/libraries.te	2005-12-08 15:28:11.000000000 -0500
@@ -42,12 +42,8 @@
 # texrel_shlib_t is the type of shared objects in the system lib
 # directories, which require text relocation.
 #
-ifdef(`targeted_policy',`
-	typealias lib_t alias texrel_shlib_t;
-',`
-	type texrel_shlib_t;
-	files_type(texrel_shlib_t)
-')
+type texrel_shlib_t;
+files_type(texrel_shlib_t)
 
 ########################################
 #
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/locallogin.te serefpolicy-2.1.0/policy/modules/system/locallogin.te
--- nsaserefpolicy/policy/modules/system/locallogin.te	2005-11-25 08:11:12.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/system/locallogin.te	2005-12-08 15:28:11.000000000 -0500
@@ -168,13 +168,6 @@
 # Search for mail spool file.
 mta_getattr_spool(local_login_t)
 
-# Red Hat systems seem to have a stray
-# fd open from the initrd
-ifdef(`distro_redhat',`
-	kernel_dontaudit_use_fd(local_login_t)
-	files_dontaudit_read_root_file(local_login_t)
-')
-
 ifdef(`targeted_policy',`
 	unconfined_domain_template(local_login_t)
 	unconfined_shell_domtrans(local_login_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.1.0/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2005-12-06 19:49:51.000000000 -0500
+++ serefpolicy-2.1.0/policy/modules/system/mount.te	2005-12-08 15:28:11.000000000 -0500
@@ -26,7 +26,6 @@
 files_create_tmp_files(mount_t,mount_tmp_t,{ file dir })
 
 kernel_read_system_state(mount_t)
-kernel_dontaudit_use_fd(mount_t)
 
 corenet_dontaudit_tcp_bind_all_reserved_ports(mount_t)
 corenet_dontaudit_udp_bind_all_reserved_ports(mount_t)
@@ -95,9 +94,7 @@
 
 optional_policy(`portmap',`
 	# for nfs
-	#allow portmap_t mount_t:udp_socket { sendto recvfrom };
-	#allow mount_t portmap_t:udp_socket { sendto recvfrom };
-	#allow mount_t rpc_pipefs_t:dir search;
+	allow mount_t rpc_pipefs_t:dir search;
 	corenet_tcp_sendrecv_all_if(mount_t)
 	corenet_raw_sendrecv_all_if(mount_t)
 	corenet_udp_sendrecv_all_if(mount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/Rules.modular serefpolicy-2.1.0/Rules.modular
--- nsaserefpolicy/Rules.modular	2005-11-23 10:06:37.000000000 -0500
+++ serefpolicy-2.1.0/Rules.modular	2005-12-08 15:28:11.000000000 -0500
@@ -41,6 +41,8 @@
 
 install: $(INSTPKG) $(APPFILES)
 
+APPFILES += $(APPDIR)/customizable_types 
+
 ########################################
 #
 # Load all configured modules
@@ -82,6 +84,11 @@
 	@echo "Creating $(NAME) base module package"
 	$(QUIET) $(SEMOD_PKG) -o $@ -m tmp/base.mod -f $(BASE_FC)
 
+$(APPDIR)/customizable_types: base.pp
+	@mkdir -p $(APPDIR)
+	$(QUIET) grep "^type .*customizable" $< | cut -d',' -f1 | cut -d' ' -f2 > tmp/customizable_types
+	$(QUIET) install -m 644 tmp/customizable_types $@ 
+
 tmp/base.mod: base.conf
 	@echo "Compiling $(NAME) base module"
 	$(QUIET) $(CHECKMODULE) $^ -o $@
diff --exclude-from=exclude -N -u -r nsaserefpolicy/Rules.monolithic serefpolicy-2.1.0/Rules.monolithic
--- nsaserefpolicy/Rules.monolithic	2005-12-06 19:49:49.000000000 -0500
+++ serefpolicy-2.1.0/Rules.monolithic	2005-12-08 15:28:11.000000000 -0500
@@ -14,6 +14,11 @@
 
 APPFILES += $(APPDIR)/customizable_types $(INSTALLDIR)/booleans
 
+$(APPDIR)/customizable_types: policy.conf
+	@mkdir -p $(APPDIR)
+	$(QUIET) grep "^type .*customizable" $< | cut -d',' -f1 | cut -d' ' -f2 > tmp/customizable_types
+	$(QUIET) install -m 644 tmp/customizable_types $@ 
+
 # for monolithic policy use all base and module to create policy
 ALL_MODULES := $(strip $(BASE_MODS) $(MOD_MODS))
 
@@ -22,7 +27,7 @@
 ALL_FC_FILES := $(ALL_MODULES:.te=.fc)
 
 PRE_TE_FILES := $(SECCLASS) $(ISIDS) $(AVS) $(M4SUPPORT) $(POLDIR)/mls $(POLDIR)/mcs
-POST_TE_FILES := $(USER_FILES) $(POLDIR)/constraints
+POST_TE_FILES := $(POLDIR)/systemuser $(POLDIR)/users $(POLDIR)/constraints
 
 POLICY_SECTIONS := tmp/pre_te_files.conf tmp/generated_definitions.conf tmp/all_interfaces.conf tmp/all_attrs_types.conf $(GLOBALBOOL) $(GLOBALTUN) tmp/only_te_rules.conf tmp/all_post.conf
 

--------------070006080107090902040100--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
