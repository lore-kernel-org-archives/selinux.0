Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8DFhb4r032244
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 11:43:37 -0400
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8DFgjSW022757
	for <selinux@tycho.nsa.gov>; Wed, 13 Sep 2006 15:42:46 GMT
Subject: Moving xconsole from xserver to logging policy
From: Erich Schubert <erich@debian.org>
To: SELinux List <selinux@tycho.nsa.gov>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: multipart/mixed; boundary="=-GP7Og8BB3JyHgx2ANM8f"
Date: Wed, 13 Sep 2006 17:43:27 +0200
Message-Id: <1158162208.1594.37.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-GP7Og8BB3JyHgx2ANM8f
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,
Basically, /dev/xconsole is a FIFO written to by syslog, and often is
present even when there is no X. Therefore, this should go into the
logging policy.
Patch attached.

best regards,
Erich Schubert
--=20
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
 Nothing prevents happiness like the memory of happiness. --- A. Gide //\
       Die einzige Hoffnung auf Freude liegt in den menschlichen      V_/=
_
               Beziehungen. --- Antoine de Saint-Exup=E9ry

--=-GP7Og8BB3JyHgx2ANM8f
Content-Disposition: attachment; filename=xconsole
Content-Type: text/x-patch; name=xconsole; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Index: policy/modules/services/xserver.te
===================================================================
--- policy/modules/services/xserver.te	(Revision 242)
+++ policy/modules/services/xserver.te	(Arbeitskopie)
@@ -19,12 +19,6 @@
 type xauth_exec_t;
 corecmd_executable_file(xauth_exec_t)
 
-# this is not actually a device, its a pipe
-type xconsole_device_t;
-files_type(xconsole_device_t)
-fs_associate_tmpfs(xconsole_device_t)
-files_associate_tmp(xconsole_device_t)
-
 type xdm_t;
 # real declaration moved to mls until
 # range_transition works in loadable modules
@@ -97,8 +91,6 @@
 # Supress permission check on .ICE-unix
 dontaudit xdm_t ice_tmp_t:dir { getattr setattr };
 
-allow xdm_t xconsole_device_t:fifo_file { getattr setattr };
-
 allow xdm_t xdm_tmp_t:dir manage_dir_perms;
 allow xdm_t xdm_tmp_t:file manage_file_perms;
 allow xdm_t xdm_tmp_t:sock_file manage_file_perms;
@@ -204,6 +196,7 @@
 libs_exec_lib_files(xdm_t)
 
 logging_read_generic_logs(xdm_t)
+logging_setattr_xconsole_pipes(xdm_t)
 
 miscfiles_read_localization(xdm_t)
 miscfiles_read_fonts(xdm_t)
Index: policy/modules/services/xserver.fc
===================================================================
--- policy/modules/services/xserver.fc	(Revision 242)
+++ policy/modules/services/xserver.fc	(Arbeitskopie)
@@ -12,11 +12,6 @@
 ')
 
 #
-# /dev
-#
-/dev/xconsole		-p	gen_context(system_u:object_r:xconsole_device_t,s0)
-
-#
 # /etc
 #
 
Index: policy/modules/services/xserver.if
===================================================================
--- policy/modules/services/xserver.if	(Revision 242)
+++ policy/modules/services/xserver.if	(Arbeitskopie)
@@ -694,42 +694,6 @@
 
 ########################################
 ## <summary>
-##	Set the attributes of the X windows console named pipes.
-## </summary>
-## <param name="domain">
-##	<summary>
-##	Domain allowed access.
-##	</summary>
-## </param>
-#
-interface(`xserver_setattr_console_pipes',`
-	gen_require(`
-		type xconsole_device_t;
-	')
-
-	allow $1 xconsole_device_t:fifo_file setattr;
-')
-
-########################################
-## <summary>
-##	Read and write the X windows console named pipe.
-## </summary>
-## <param name="domain">
-##	<summary>
-##	Domain allowed access.
-##	</summary>
-## </param>
-#
-interface(`xserver_rw_console',`
-	gen_require(`
-		type xconsole_device_t;
-	')
-
-	allow $1 xconsole_device_t:fifo_file { getattr read write };
-')
-
-########################################
-## <summary>
 ##	Use file descriptors for xdm.
 ## </summary>
 ## <param name="domain">
Index: policy/modules/system/logging.te
===================================================================
--- policy/modules/system/logging.te	(Revision 242)
+++ policy/modules/system/logging.te	(Arbeitskopie)
@@ -57,6 +57,12 @@
 type var_log_t;
 logging_log_file(var_log_t)
 
+# this is not actually a device, its a pipe
+type xconsole_device_t;
+files_type(xconsole_device_t)
+fs_associate_tmpfs(xconsole_device_t)
+files_associate_tmp(xconsole_device_t)
+
 ########################################
 #
 # Auditd local policy
@@ -294,6 +300,9 @@
 allow syslogd_t syslogd_var_run_t:dir rw_dir_perms;
 files_pid_filetrans(syslogd_t,syslogd_var_run_t,file)
 
+# log to xconsole
+allow syslogd_t xconsole_device_t:fifo_file rw_file_perms;
+
 kernel_read_kernel_sysctls(syslogd_t)
 kernel_read_proc_symlinks(syslogd_t)
 # Allow access to /proc/kmsg for syslog-ng
@@ -388,8 +397,3 @@
 optional_policy(`
 	udev_read_db(syslogd_t)
 ')
-
-optional_policy(`
-	# log to the xconsole
-	xserver_rw_console(syslogd_t)
-')
Index: policy/modules/system/logging.if
===================================================================
--- policy/modules/system/logging.if	(Revision 242)
+++ policy/modules/system/logging.if	(Arbeitskopie)
@@ -583,3 +583,40 @@
 	allow $1 var_log_t:dir rw_dir_perms;
 	allow $1 var_log_t:file create_file_perms;
 ')
+
+########################################
+## <summary>
+##	Set the attributes of the xconsole named pipes.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`logging_setattr_xconsole_pipes',`
+	gen_require(`
+		type xconsole_device_t;
+	')
+
+	allow $1 xconsole_device_t:fifo_file setattr;
+')
+
+########################################
+## <summary>
+##	Read the xconsole named pipe.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`logging_r_xconsole',`
+	gen_require(`
+		type xconsole_device_t;
+	')
+
+	allow $1 xconsole_device_t:fifo_file { getattr read };
+')
+
Index: policy/modules/system/init.te
===================================================================
--- policy/modules/system/init.te	(Revision 242)
+++ policy/modules/system/init.te	(Arbeitskopie)
@@ -360,6 +360,7 @@
 logging_read_all_logs(initrc_t)
 logging_append_all_logs(initrc_t)
 logging_read_audit_config(initrc_t)
+logging_setattr_xconsole_pipes(initrc_t)
 
 miscfiles_read_localization(initrc_t)
 # slapd needs to read cert files from its initscript
@@ -757,9 +758,6 @@
 ')
 
 optional_policy(`
-	# Set device ownerships/modes.
-	xserver_setattr_console_pipes(initrc_t)
-
 	# init script wants to check if it needs to update windowmanagerlist
 	xserver_read_xdm_rw_config(initrc_t)
 ')
Index: policy/modules/system/logging.fc
===================================================================
--- policy/modules/system/logging.fc	(Revision 242)
+++ policy/modules/system/logging.fc	(Arbeitskopie)
@@ -1,5 +1,6 @@
 
 /dev/log		-s	gen_context(system_u:object_r:devlog_t,s0)
+/dev/xconsole		-p	gen_context(system_u:object_r:xconsole_device_t,s0)
 
 /etc/audit(/.*)?		gen_context(system_u:object_r:auditd_etc_t,s15:c0.c255)
 

--=-GP7Og8BB3JyHgx2ANM8f--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
