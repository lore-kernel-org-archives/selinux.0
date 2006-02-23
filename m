Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1NJQ9pF020235
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2006 14:26:09 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1NJOfAM025214
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2006 19:24:41 GMT
Message-ID: <43FE0C4D.1000003@redhat.com>
Date: Thu, 23 Feb 2006 14:26:05 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Latest changes to policy
Content-Type: multipart/mixed;
 boundary="------------090204000707080107050701"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090204000707080107050701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Change build.conf to
TYPE ?= $(TYPE)

to allow overriding at the command line

Logwatch needs to resolve

VPNc needs to be able to talk to the FD of locallogin

Make vpnc work with NetworkManager

Java always needs execmem so give it to it by default

File context for policygentool

file context for /dev/efirtc

Make polyinstantiation work for /tmp

Fix cacti file_context

allow httpd to transition to httpd_sys_script_t when running a shell

Allow scripts to read eventpollfs

Allow cron to look at httpd_sys_content_t

New version of automount needs sys_resource

Allow automount to run showmount

Automount now needs to getattr on all directories.

crond needs to look at a lot of apache stuff.

Mount and Hal now needs to read autofs_t directories

dontaudit execmem for xserver, we know it needs it.

Make swapon work.

load_policy mls needs to be able to read up











--------------090204000707080107050701
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/Makefile serefpolicy-2.2.21/Makefile
--- nsaserefpolicy/Makefile	2006-02-17 14:46:10.000000000 -0500
+++ serefpolicy-2.2.21/Makefile	2006-02-23 12:35:04.000000000 -0500
@@ -446,14 +446,14 @@
 			$(MODDIR)/$$i/metadata.xml \
 			$(HEADERDIR)/$$i ;\
 	done
-	$(verbose) echo "TYPE=$(TYPE)" > $(HEADERDIR)/build.conf
-	$(verbose) echo "NAME=$(NAME)" >> $(HEADERDIR)/build.conf
+	$(verbose) echo "TYPE ?= $(TYPE)" > $(HEADERDIR)/build.conf
+	$(verbose) echo "NAME ?= $(NAME)" >> $(HEADERDIR)/build.conf
 ifneq "$(DISTRO)" ""
-	$(verbose) echo "DISTRO=$(DISTRO)" >> $(HEADERDIR)/build.conf
+	$(verbose) echo "DISTRO ?= $(DISTRO)" >> $(HEADERDIR)/build.conf
 endif
-	$(verbose) echo "MONOLITHIC=n" >> $(HEADERDIR)/build.conf
-	$(verbose) echo "DIRECT_INITRC=$(DIRECT_INITRC)" >> $(HEADERDIR)/build.conf
-	$(verbose) echo "POLY=$(POLY)" >> $(HEADERDIR)/build.conf
+	$(verbose) echo "MONOLITHIC ?= n" >> $(HEADERDIR)/build.conf
+	$(verbose) echo "DIRECT_INITRC ?= $(DIRECT_INITRC)" >> $(HEADERDIR)/build.conf
+	$(verbose) echo "POLY ?= $(POLY)" >> $(HEADERDIR)/build.conf
 	$(verbose) install -m 644 $(SUPPORT)/Makefile.devel $(HEADERDIR)/Makefile
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/logwatch.te serefpolicy-2.2.21/policy/modules/admin/logwatch.te
--- nsaserefpolicy/policy/modules/admin/logwatch.te	2006-02-21 14:40:22.000000000 -0500
+++ serefpolicy-2.2.21/policy/modules/admin/logwatch.te	2006-02-23 09:41:46.000000000 -0500
@@ -71,6 +71,8 @@
 
 selinux_dontaudit_getattr_dir(logwatch_t)
 
+sysnet_dns_name_resolve(logwatch_t)
+
 userdom_dontaudit_search_sysadm_home_dirs(logwatch_t)
 userdom_dontaudit_getattr_sysadm_home_dirs(logwatch_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/vpn.te serefpolicy-2.2.21/policy/modules/admin/vpn.te
--- nsaserefpolicy/policy/modules/admin/vpn.te	2006-02-21 14:40:23.000000000 -0500
+++ serefpolicy-2.2.21/policy/modules/admin/vpn.te	2006-02-23 12:21:59.000000000 -0500
@@ -91,6 +91,8 @@
 libs_use_ld_so(vpnc_t)
 libs_use_shared_libs(vpnc_t)
 
+locallogin_use_fd(vpnc_t)
+
 logging_send_syslog_msg(vpnc_t)
 
 miscfiles_read_localization(vpnc_t)
@@ -106,6 +108,10 @@
 
 optional_policy(`dbus',`
 	dbus_system_bus_client_template(vpnc,vpnc_t)
+	dbus_send_system_bus(vpnc_t)
+	optional_policy(`networkmanager',`
+		networkmanager_dbus_chat(vpnc_t)
+	')
 ')
 
 optional_policy(`mount',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/java.if serefpolicy-2.2.21/policy/modules/apps/java.if
--- nsaserefpolicy/policy/modules/apps/java.if	2006-02-21 14:40:23.000000000 -0500
+++ serefpolicy-2.2.21/policy/modules/apps/java.if	2006-02-23 09:41:46.000000000 -0500
@@ -149,13 +149,9 @@
 	userdom_manage_user_home_content_sockets($1,$1_javaplugin_t)
 	userdom_user_home_dir_filetrans_user_home_content($1,$1_javaplugin_t,{ file lnk_file sock_file fifo_file })
 
-	# libdeploy.so legacy
-	tunable_policy(`allow_execmem',`
-		allow $1_javaplugin_t self:process execmem;
-	')
-	
+	allow $1_javaplugin_t self:process execmem;
 	tunable_policy(`allow_java_execstack',`
-		allow $1_javaplugin_t self:process { execmem execstack };
+		allow $1_javaplugin_t self:process execstack;
 
 		allow $1_javaplugin_t $1_javaplugin_tmp_t:file execute;
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/corecommands.fc serefpolicy-2.2.21/policy/modules/kernel/corecommands.fc
--- nsaserefpolicy/policy/modules/kernel/corecommands.fc	2006-01-19 16:02:10.000000000 -0500
+++ serefpolicy-2.2.21/policy/modules/kernel/corecommands.fc	2006-02-23 13:32:13.000000000 -0500
@@ -135,6 +135,7 @@
 
 /usr/share/gnucash/finance-quote-check -- gen_context(system_u:object_r:bin_t,s0)
 /usr/share/gnucash/finance-quote-helper -- gen_context(system_u:object_r:bin_t,s0)
+/usr/share/selinux/devel/policygentool -- gen_context(system_u:object_r:bin_t,s0)
 /usr/share/hal/scripts(/.*)?		gen_context(system_u:object_r:bin_t,s0)
 /usr/share/mc/extfs/.*		--	gen_context(system_u:object_r:bin_t,s0)
 /usr/share/printconf/util/print\.py --	gen_context(system_u:object_r:bin_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/devices.fc serefpolicy-2.2.21/policy/modules/kernel/devices.fc
--- nsaserefpolicy/policy/modules/kernel/devices.fc	2006-02-14 07:20:25.000000000 -0500
+++ serefpolicy-2.2.21/policy/modules/kernel/devices.fc	2006-02-23 10:01:17.000000000 -0500
@@ -39,6 +39,7 @@
 /dev/radio.*		-c	gen_context(system_u:object_r:v4l_device_t,s0)
 /dev/random		-c	gen_context(system_u:object_r:random_device_t,s0)
 /dev/(misc/)?rtc		-c	gen_context(system_u:object_r:clock_device_t,s0)
+/dev/efirtc		-c	gen_context(system_u:object_r:clock_device_t,s0)
 /dev/sequencer		-c	gen_context(system_u:object_r:sound_device_t,s0)
 /dev/sequencer2		-c	gen_context(system_u:object_r:sound_device_t,s0)
 /dev/smpte.*		-c	gen_context(system_u:object_r:sound_device_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.if serefpolicy-2.2.21/policy/modules/kernel/files.if
--- nsaserefpolicy/policy/modules/kernel/files.if	2006-02-21 14:40:23.000000000 -0500
+++ serefpolicy-2.2.21/policy/modules/kernel/files.if	2006-02-23 09:41:46.000000000 -0500
@@ -3358,10 +3358,11 @@
 	allow $1 self:process setfscreate;
 	allow $1 polymember: dir { create setattr };
 	allow $1 polydir: dir { write add_name };
-	allow $1 polyparent:dir { write add_name };
+	allow $1 polyparent:dir { write add_name relabelfrom relabelto };
 
 	# Default type for mountpoints
 	allow $1 poly_t:dir { create mounton };
+	fs_unmount_xattr_fs($1)
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/files.te serefpolicy-2.2.21/policy/modules/kernel/files.te
--- nsaserefpolicy/policy/modules/kernel/files.te	2006-02-14 07:20:25.000000000 -0500
+++ serefpolicy-2.2.21/policy/modules/kernel/files.te	2006-02-23 09:41:46.000000000 -0500
@@ -125,6 +125,7 @@
 #
 type tmp_t, mountpoint; #, polydir
 files_tmp_file(tmp_t)
+files_poly_parent(tmp_t)
 
 #
 # usr_t is the type for /usr.
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.fc serefpolicy-2.2.21/policy/modules/services/apache.fc
--- nsaserefpolicy/policy/modules/services/apache.fc	2006-02-14 07:20:25.000000000 -0500
+++ serefpolicy-2.2.21/policy/modules/services/apache.fc	2006-02-23 09:41:46.000000000 -0500
@@ -45,7 +45,7 @@
 /var/cache/rt3(/.*)?			gen_context(system_u:object_r:httpd_cache_t,s0)
 /var/cache/ssl.*\.sem		--	gen_context(system_u:object_r:httpd_cache_t,s0)
 
-/var/lib/cacti(/.*)?			gen_context(system_u:object_r:httpd_var_lib_t,s0)
+/var/lib/cacti/rra(/.*)?		gen_context(system_u:object_r:httpd_sys_content_t,s0)
 /var/lib/dav(/.*)?			gen_context(system_u:object_r:httpd_var_lib_t,s0)
 /var/lib/htdig(/.*)?			gen_context(system_u:object_r:httpd_sys_content_t,s0)
 /var/lib/httpd(/.*)?			gen_context(system_u:object_r:httpd_var_lib_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.if serefpolicy-2.2.21/policy/modules/services/apache.if
--- nsaserefpolicy/policy/modules/services/apache.if	2006-02-21 14:40:23.000000000 -0500
+++ serefpolicy-2.2.21/policy/modules/services/apache.if	2006-02-23 09:41:46.000000000 -0500
@@ -94,6 +94,7 @@
 
 	corecmd_exec_bin(httpd_$1_script_t)
 	corecmd_exec_sbin(httpd_$1_script_t)
+	corecmd_shell_entry_type(httpd_$1_script_t)
 
 	domain_exec_all_entry_files(httpd_$1_script_t)
 
@@ -174,6 +175,7 @@
 		dev_read_urand(httpd_$1_script_t)
 
 		fs_getattr_xattr_fs(httpd_$1_script_t)
+		fs_read_eventpollfs(httpd_$1_script_t)
 
 		files_read_etc_runtime_files(httpd_$1_script_t)
 		files_read_usr_files(httpd_$1_script_t)
@@ -798,3 +800,22 @@
 
 	allow $1 httpd_sys_script_t:dir search;
 ')
+
+
+########################################
+## <summary>
+##	Read apache system content
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain to not audit.
+##	</summary>
+## </param>
+#
+interface(`apache_read_sys_content',`
+	gen_require(`
+		type httpd_sys_content_t;
+	')
+	allow $1 httpd_sys_content_t:dir r_dir_perms;
+	allow $1 httpd_sys_content_t:file { getattr read };
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/automount.te serefpolicy-2.2.21/policy/modules/services/automount.te
--- nsaserefpolicy/policy/modules/services/automount.te	2006-02-21 14:40:23.000000000 -0500
+++ serefpolicy-2.2.21/policy/modules/services/automount.te	2006-02-23 10:09:09.000000000 -0500
@@ -28,7 +28,7 @@
 # Local policy
 #
 
-allow automount_t self:capability { net_bind_service sys_nice dac_override };
+allow automount_t self:capability { net_bind_service sys_nice sys_resource dac_override };
 dontaudit automount_t self:capability sys_tty_config;
 allow automount_t self:process { signal_perms getpgid setpgid setsched };
 allow automount_t self:fifo_file rw_file_perms;
@@ -83,6 +83,9 @@
 corenet_tcp_connect_portmap_port(automount_t)
 corenet_tcp_connect_all_ports(automount_t)
 corenet_dontaudit_tcp_connect_all_reserved_ports(automount_t)
+# Automount execs showmount when you browse /net.  This is required until
+# Someone writes a showmount policy
+corenet_tcp_bind_reserved_port(automount_t)
 
 dev_read_sysfs(automount_t)
 # for SSP
@@ -91,7 +94,7 @@
 domain_use_interactive_fds(automount_t)
 
 files_dontaudit_write_var_dirs(automount_t)
-files_search_var_lib(automount_t)
+files_getattr_all_dirs(automount_t)
 files_list_mnt(automount_t)
 files_getattr_home_dir(automount_t)
 files_read_etc_files(automount_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cron.te serefpolicy-2.2.21/policy/modules/services/cron.te
--- nsaserefpolicy/policy/modules/services/cron.te	2006-02-23 09:25:09.000000000 -0500
+++ serefpolicy-2.2.21/policy/modules/services/cron.te	2006-02-23 09:41:46.000000000 -0500
@@ -360,6 +360,9 @@
 	optional_policy(`apache',`
 		# Needed	 for certwatch
 		apache_exec_modules(system_crond_t)
+		apache_read_config(system_crond_t)
+		apache_read_log(system_crond_t)
+		apache_read_sys_content(system_crond_t)
 	')
 
 	optional_policy(`cyrus',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/hal.te serefpolicy-2.2.21/policy/modules/services/hal.te
--- nsaserefpolicy/policy/modules/services/hal.te	2006-02-21 14:40:23.000000000 -0500
+++ serefpolicy-2.2.21/policy/modules/services/hal.te	2006-02-23 10:11:00.000000000 -0500
@@ -93,7 +93,7 @@
 
 fs_getattr_all_fs(hald_t)
 fs_search_all(hald_t)
-fs_search_auto_mountpoints(hald_t)
+fs_list_auto_mountpoints(hald_t)
 
 mls_file_read_up(hald_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.te serefpolicy-2.2.21/policy/modules/services/xserver.te
--- nsaserefpolicy/policy/modules/services/xserver.te	2006-02-21 14:40:25.000000000 -0500
+++ serefpolicy-2.2.21/policy/modules/services/xserver.te	2006-02-23 14:10:50.000000000 -0500
@@ -425,7 +425,7 @@
 ifdef(`targeted_policy',`
 	allow xdm_xserver_t self:process { execheap execmem };
 
-	unconfined_domain(xdm_xserver_t)
+	unconfined_domain_noaudit(xdm_xserver_t)
 	unconfined_domtrans(xdm_xserver_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/fstools.te serefpolicy-2.2.21/policy/modules/system/fstools.te
--- nsaserefpolicy/policy/modules/system/fstools.te	2006-02-21 14:40:25.000000000 -0500
+++ serefpolicy-2.2.21/policy/modules/system/fstools.te	2006-02-23 09:41:46.000000000 -0500
@@ -45,7 +45,7 @@
 files_tmp_filetrans(fsadm_t, fsadm_tmp_t, { file dir })
 
 # Enable swapping to files
-allow fsadm_t swapfile_t:file { getattr swapon };
+allow fsadm_t swapfile_t:file { read write getattr swapon };
 
 kernel_read_system_state(fsadm_t)
 kernel_read_kernel_sysctls(fsadm_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-2.2.21/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2006-02-21 14:40:25.000000000 -0500
+++ serefpolicy-2.2.21/policy/modules/system/mount.te	2006-02-23 10:11:48.000000000 -0500
@@ -46,7 +46,7 @@
 fs_unmount_all_fs(mount_t)
 fs_remount_all_fs(mount_t)
 fs_relabelfrom_all_fs(mount_t)
-fs_search_auto_mountpoints(mount_t)
+fs_list_auto_mountpoints(mount_t)
 fs_rw_tmpfs_chr_files(mount_t)
 fs_read_tmpfs_symlinks(mount_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/selinuxutil.te serefpolicy-2.2.21/policy/modules/system/selinuxutil.te
--- nsaserefpolicy/policy/modules/system/selinuxutil.te	2006-02-23 09:25:09.000000000 -0500
+++ serefpolicy-2.2.21/policy/modules/system/selinuxutil.te	2006-02-23 09:41:46.000000000 -0500
@@ -199,6 +199,7 @@
 libs_use_ld_so(load_policy_t)
 libs_use_shared_libs(load_policy_t)
 
+mls_file_read_up(load_policy_t)
 miscfiles_read_localization(load_policy_t)
 
 userdom_use_all_users_fds(load_policy_t)
@@ -319,10 +320,6 @@
 	nscd_socket_use(newrole_t)
 ')
 
-ifdef(`TODO',`
-ifdef(`gnome-pty-helper.te', `allow newrole_t gphdomain:fd use;')
-') dnl ifdef TODO
-
 ########################################
 #
 # Restorecon local policy
diff --exclude-from=exclude -N -u -r nsaserefpolicy/support/Makefile.devel serefpolicy-2.2.21/support/Makefile.devel
--- nsaserefpolicy/support/Makefile.devel	2006-02-22 14:09:04.000000000 -0500
+++ serefpolicy-2.2.21/support/Makefile.devel	2006-02-23 12:38:25.000000000 -0500
@@ -6,10 +6,7 @@
 SED ?= sed
 EINFO ?= echo
 PYTHON ?= python
-
-NAME ?= $(shell $(AWK) -F= '/^SELINUXTYPE/{ print $$2 }' /etc/selinux/config)
-SHAREDIR ?= /usr/share/selinux
-HEADERDIR ?= $(SHAREDIR)/$(NAME)/include
+HEADERDIR ?= .
 
 include $(HEADERDIR)/build.conf
 

--------------090204000707080107050701--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
