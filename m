Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0JJGPXf006339
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 14:16:26 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0JJGNh0007703
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 19:16:24 GMT
Message-ID: <43CFE58A.40909@redhat.com>
Date: Thu, 19 Jan 2006 14:16:26 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Latest Diffs
Content-Type: multipart/mixed;
 boundary="------------070900040904020906040509"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070900040904020906040509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

add allow_execheap boolean in case we need it.

Fixes for logwatch.

Fixes for wine and mono apps to be able to handle no execheap/execstack

Allow xdm in targeted policy execheap

Fix spec for libdeploy.so


--------------070900040904020906040509
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/Makefile serefpolicy-2.2.2/Makefile
--- nsaserefpolicy/Makefile	2006-01-19 10:00:35.000000000 -0500
+++ serefpolicy-2.2.2/Makefile	2006-01-19 10:42:14.000000000 -0500
@@ -92,7 +92,7 @@
 
 # enable MLS if requested.
 ifneq ($(findstring -mls,$(TYPE)),)
-	override M4PARAM += -D enable_mls
+	override M4PARAM += -D enable_mls -D separate_secadm
 	override CHECKPOLICY += -M
 	override CHECKMODULE += -M
 endif
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/global_tunables serefpolicy-2.2.2/policy/global_tunables
--- nsaserefpolicy/policy/global_tunables	2006-01-13 09:48:26.000000000 -0500
+++ serefpolicy-2.2.2/policy/global_tunables	2006-01-19 10:55:45.000000000 -0500
@@ -22,6 +22,10 @@
 
 ## Allow making the stack executable via mprotect.
 ## Also requires allow_execmem.
+gen_tunable(allow_execheap,false)
+
+## Allow making the stack executable via mprotect.
+## Also requires allow_execmem.
 gen_tunable(allow_execstack,false)
 
 ## Allow ftp servers to modify public files
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/logwatch.te serefpolicy-2.2.2/policy/modules/admin/logwatch.te
--- nsaserefpolicy/policy/modules/admin/logwatch.te	2006-01-13 17:06:02.000000000 -0500
+++ serefpolicy-2.2.2/policy/modules/admin/logwatch.te	2006-01-19 11:23:59.000000000 -0500
@@ -38,6 +38,7 @@
 kernel_read_kernel_sysctl(logwatch_t)
 kernel_read_system_state(logwatch_t)
 
+corecmd_read_sbin_symlink(logwatch_t)
 corecmd_read_sbin_file(logwatch_t)
 corecmd_exec_bin(logwatch_t)
 corecmd_exec_shell(logwatch_t)
@@ -68,6 +69,8 @@
 
 miscfiles_read_localization(logwatch_t)
 
+selinux_dontaudit_getattr_dir(logwatch_t)
+
 userdom_dontaudit_search_sysadm_home_dir(logwatch_t)
 userdom_dontaudit_getattr_sysadm_home_dir(logwatch_t)
 
@@ -94,6 +97,10 @@
 	nscd_use_socket(logwatch_t)
 ')
 
+optional_policy(`ntp',`
+	ntp_domtrans(logwatch_t)
+')
+
 optional_policy(`rpc',`
 	rpc_search_nfs_state_data(logwatch_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/java.te serefpolicy-2.2.2/policy/modules/apps/java.te
--- nsaserefpolicy/policy/modules/apps/java.te	2006-01-12 18:28:45.000000000 -0500
+++ serefpolicy-2.2.2/policy/modules/apps/java.te	2006-01-19 13:05:16.000000000 -0500
@@ -8,3 +8,4 @@
 
 type java_exec_t;
 files_type(java_exec_t)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/mono.fc serefpolicy-2.2.2/policy/modules/apps/mono.fc
--- nsaserefpolicy/policy/modules/apps/mono.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.2/policy/modules/apps/mono.fc	2006-01-19 12:46:09.000000000 -0500
@@ -0,0 +1,2 @@
+/usr/bin/mono	--	gen_context(system_u:object_r:mono_exec_t,s0)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/mono.if serefpolicy-2.2.2/policy/modules/apps/mono.if
--- nsaserefpolicy/policy/modules/apps/mono.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.2/policy/modules/apps/mono.if	2006-01-19 12:46:09.000000000 -0500
@@ -0,0 +1,23 @@
+## <summary>Load keyboard mappings.</summary>
+
+########################################
+## <summary>
+##	Execute the mono program in the mono domain.
+## </summary>
+## <param name="domain">
+##	The type of the process performing this action.
+## </param>
+#
+interface(`mono_domtrans',`
+	gen_require(`
+		type mono_t, mono_exec_t;
+	')
+
+	corecmd_search_bin($1)
+	domain_auto_trans($1, mono_exec_t, mono_t)
+
+	allow $1 mono_t:fd use;
+	allow mono_t $1:fd use;
+	allow mono_t $1:fifo_file rw_file_perms;
+	allow mono_t $1:process sigchld;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/mono.te serefpolicy-2.2.2/policy/modules/apps/mono.te
--- nsaserefpolicy/policy/modules/apps/mono.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.2/policy/modules/apps/mono.te	2006-01-19 13:29:46.000000000 -0500
@@ -0,0 +1,25 @@
+policy_module(mono,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type mono_t;
+domain_type(mono_t)
+
+type mono_exec_t;
+domain_entry_file(mono_t,mono_exec_t)
+
+
+########################################
+#
+# Local policy
+#
+
+ifdef(`targeted_policy',`
+	allow mono_t self:process execheap;
+	unconfined_domain_template(mono_t)
+	role system_r types mono_t;
+')
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/wine.fc serefpolicy-2.2.2/policy/modules/apps/wine.fc
--- nsaserefpolicy/policy/modules/apps/wine.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.2/policy/modules/apps/wine.fc	2006-01-19 10:58:16.000000000 -0500
@@ -0,0 +1,2 @@
+/usr/bin/wine	--	gen_context(system_u:object_r:wine_exec_t,s0)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/wine.if serefpolicy-2.2.2/policy/modules/apps/wine.if
--- nsaserefpolicy/policy/modules/apps/wine.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.2/policy/modules/apps/wine.if	2006-01-19 10:58:17.000000000 -0500
@@ -0,0 +1,23 @@
+## <summary>Load keyboard mappings.</summary>
+
+########################################
+## <summary>
+##	Execute the wine program in the wine domain.
+## </summary>
+## <param name="domain">
+##	The type of the process performing this action.
+## </param>
+#
+interface(`wine_domtrans',`
+	gen_require(`
+		type wine_t, wine_exec_t;
+	')
+
+	corecmd_search_bin($1)
+	domain_auto_trans($1, wine_exec_t, wine_t)
+
+	allow $1 wine_t:fd use;
+	allow wine_t $1:fd use;
+	allow wine_t $1:fifo_file rw_file_perms;
+	allow wine_t $1:process sigchld;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/wine.te serefpolicy-2.2.2/policy/modules/apps/wine.te
--- nsaserefpolicy/policy/modules/apps/wine.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.2.2/policy/modules/apps/wine.te	2006-01-19 13:30:34.000000000 -0500
@@ -0,0 +1,25 @@
+policy_module(wine,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type wine_t;
+domain_type(wine_t)
+
+type wine_exec_t;
+domain_entry_file(wine_t,wine_exec_t)
+
+
+########################################
+#
+# Local policy
+#
+
+ifdef(`targeted_policy',`
+	allow wine_t self:process { execstack execmem };
+	unconfined_domain_template(wine_t)
+	role system_r types wine_t;
+	allow wine_t file_type:file execmod;
+')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/kernel/filesystem.if serefpolicy-2.2.2/policy/modules/kernel/filesystem.if
--- nsaserefpolicy/policy/modules/kernel/filesystem.if	2006-01-19 10:00:41.000000000 -0500
+++ serefpolicy-2.2.2/policy/modules/kernel/filesystem.if	2006-01-19 10:42:14.000000000 -0500
@@ -1826,6 +1826,22 @@
 
 ########################################
 ## <summary>
+##	Dontaudit Search directories on a ramfs
+## </summary>
+## <param name="domain">
+##	Domain allowed access.
+## </param>
+#
+interface(`fs_dontaudit_search_ramfs',`
+	gen_require(`
+		type ramfs_t;
+	')
+
+	dontaudit $1 ramfs_t:dir search;
+')
+
+########################################
+## <summary>
 ##	Write to named pipe on a ramfs filesystem.
 ## </summary>
 ## <param name="domain">
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/bind.if serefpolicy-2.2.2/policy/modules/services/bind.if
--- nsaserefpolicy/policy/modules/services/bind.if	2006-01-13 09:48:26.000000000 -0500
+++ serefpolicy-2.2.2/policy/modules/services/bind.if	2006-01-19 13:58:34.000000000 -0500
@@ -165,6 +165,7 @@
 	')
 
 	files_search_var($1)
+	allow $1 named_conf_t:dir search_dir_perms;
 	allow $1 named_zone_t:dir search_dir_perms;
 	allow $1 named_cache_t:dir search_dir_perms;
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xdm.te serefpolicy-2.2.2/policy/modules/services/xdm.te
--- nsaserefpolicy/policy/modules/services/xdm.te	2006-01-19 10:00:41.000000000 -0500
+++ serefpolicy-2.2.2/policy/modules/services/xdm.te	2006-01-19 13:56:19.000000000 -0500
@@ -74,7 +74,7 @@
 files_read_etc_runtime_files(xdm_t)
 
 ifdef(`targeted_policy',`
-	allow xdm_t self:process execmem;
+	allow xdm_t self:process { execheap execmem };
 	unconfined_domain_template(xdm_t)
 	unconfined_domtrans(xdm_t)
 ',`
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/libraries.fc serefpolicy-2.2.2/policy/modules/system/libraries.fc
--- nsaserefpolicy/policy/modules/system/libraries.fc	2006-01-17 13:22:14.000000000 -0500
+++ serefpolicy-2.2.2/policy/modules/system/libraries.fc	2006-01-19 13:00:21.000000000 -0500
@@ -166,7 +166,7 @@
 /usr/lib(64)?/libdivxencore.so.0		--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 # Java, Sun Microsystems (JPackage SRPM)
-/usr/.*/jre/lib/i386/libdeploy.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/.*/jre.*/lib/i386/libdeploy.so	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 /usr(/.*)?/Reader/intellinux/plug_ins/.*\.api -- gen_context(system_u:object_r:shlib_t,s0)
 /usr(/.*)?/Reader/intellinux/plug_ins/AcroForm\.api -- gen_context(system_u:object_r:textrel_shlib_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.if serefpolicy-2.2.2/policy/modules/system/unconfined.if
--- nsaserefpolicy/policy/modules/system/unconfined.if	2006-01-17 13:22:14.000000000 -0500
+++ serefpolicy-2.2.2/policy/modules/system/unconfined.if	2006-01-19 10:56:11.000000000 -0500
@@ -45,6 +45,12 @@
 		auditallow $1 self:process execmem;
 	')
 
+	tunable_policy(`allow_execheap',`
+		# Allow making the stack executable via mprotect.
+		allow $1 self:process execheap;
+		auditallow $1 self:process execheap;
+	')
+
 	tunable_policy(`allow_execmem && allow_execstack',`
 		# Allow making the stack executable via mprotect.
 		allow $1 self:process execstack;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/unconfined.te serefpolicy-2.2.2/policy/modules/system/unconfined.te
--- nsaserefpolicy/policy/modules/system/unconfined.te	2006-01-17 17:08:57.000000000 -0500
+++ serefpolicy-2.2.2/policy/modules/system/unconfined.te	2006-01-19 13:44:58.000000000 -0500
@@ -97,6 +97,10 @@
 		modutils_domtrans_update_mods(unconfined_t)
 	')
 
+	optional_policy(`mono',`
+		mono_domtrans(unconfined_t)
+	')
+
 	optional_policy(`netutils',`
 		netutils_domtrans_ping(unconfined_t)
 	')
@@ -141,11 +145,8 @@
 		webalizer_domtrans(unconfined_t)
 	')
 
-	ifdef(`TODO',`
-	ifdef(`use_mcs',`
-	rw_dir_create_file(sysadm_su_t, home_dir_type)
-	')
-	allow unconfined_t initrc_t : dbus { send_msg acquire_svc };
-	allow initrc_t unconfined_t : dbus { send_msg acquire_svc };
-	') dnl end TODO
+	optional_policy(`wine',`
+		wine_domtrans(unconfined_t)
+	')
+
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/users serefpolicy-2.2.2/policy/users
--- nsaserefpolicy/policy/users	2005-12-05 22:35:02.000000000 -0500
+++ serefpolicy-2.2.2/policy/users	2006-01-19 10:42:14.000000000 -0500
@@ -26,7 +26,9 @@
 ifdef(`targeted_policy',`
 gen_user(user_u, user_r sysadm_r system_r, s0, s0 - s15:c0.c255, c0.c255)
 ',`
-gen_user(user_u, user_r, s0, s0 - s15:c0.c255, c0.c255)
+gen_user(user_u, user_r, s0, s0 - s0, c0)
+gen_user(staff_u, staff_r secadm_r sysadm_r, s0, s0 - s15:c0.c255, c0.c255)
+gen_user(sysadm_u, sysadm_r, s0, s0 - s15:c0.c255, c0.c255)
 ')
 
 #
@@ -40,8 +42,8 @@
 	gen_user(root, user_r sysadm_r system_r, s0, s0 - s15:c0.c255, c0.c255)
 ',`
 	ifdef(`direct_sysadm_daemon',`
-		gen_user(root, sysadm_r staff_r system_r, s0, s0 - s15:c0.c255, c0.c255)
+		gen_user(root, sysadm_r staff_r secadm_r system_r, s0, s0 - s15:c0.c255, c0.c255)
 	',`
-		gen_user(root, sysadm_r staff_r, s0, s0 - s15:c0.c255, c0.c255)
+		gen_user(root, sysadm_r staff_r secadm_r , s0, s0 - s15:c0.c255, c0.c255)
 	')
 ')

--------------070900040904020906040509--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
