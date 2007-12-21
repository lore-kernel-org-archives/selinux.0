Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBLEV8hf020754
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 09:31:09 -0500
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBLEV6p9022647
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 14:31:06 GMT
Date: Fri, 21 Dec 2007 15:31:03 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: refpolicy HEAD, Debian, ioctl on xconsole by syslogd
Message-ID: <20071221143103.GA1335@bobek.pm.i.cz>
References: <20071204111755.GB27359@bobek.pm.i.cz> <1196780661.5854.44.camel@gorn> <20071214115153.GA21605@bobek.pm.i.cz> <1197901948.12626.244.camel@gorn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8t9RHnE3ZwKMSgU+"
In-Reply-To: <1197901948.12626.244.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Dec 17, 2007 at 09:32:28AM -0500, Christopher J. PeBenito wrote:
>...
> > Move xconsole_device_t staff from xserver into logging?
> > 
> > Any idea how to solve this?
> 
> This came up before, and I was under the impression that it had been
> fixed.  I guess not.  You can see the previous thread:
> 
> http://marc.info/?l=selinux&m=115816229022334&w=2

Ok, and what is the conclusion from this thread? I think, that the move
xconsole pipe from xserver to logging can solve problem on Debian.
I didn't find /dev/xconsole on CentoOS, don't know what Gentoo and Suse.

On Debian:
Xconsole pipe is created by init script (/etc/init.d/sysklogd) under
/dev with type device_t, then chown and chmod is done and finally
restorecon is (will be) called on it (obtains xconsole_device_t type).
Init script is capable to create the pipe (with device_t type) thanks to
unconfined module.  I tried to remove unconfined module and some new
denials appeared on system startup and I will report this in 2008 :).

I rewrite Erichs S. changeset a bit and is attached.  One version is
patch with logging_setattr_xconsole macro (xconsole-move.patch) and
another is without it (xconsole-move2.patch).  This macro call with
domain initrc_t as argument is not too interesting I think.  Init script
is capable of creating pipe thanks to unconfined module.  More
permissions are needed without unconfined module.  I save this for
later.

What about to rename xconsole_device_t to xconsole_pipe_t?

Please consider some changes above. Thanks.

Mary Xmass.
-- 
Zito

--8t9RHnE3ZwKMSgU+
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="xconsole-move.patch"

Index: policy/modules/services/xserver.te
===================================================================
--- policy/modules/services/xserver.te	(revision 2560)
+++ policy/modules/services/xserver.te	(working copy)
@@ -32,12 +32,6 @@
 type xauth_exec_t;
 application_executable_file(xauth_exec_t)
 
-# this is not actually a device, its a pipe
-type xconsole_device_t;
-files_type(xconsole_device_t)
-fs_associate_tmpfs(xconsole_device_t)
-files_associate_tmp(xconsole_device_t)
-
 type xdm_t;
 type xdm_exec_t;
 auth_login_pgm_domain(xdm_t)
@@ -108,8 +102,6 @@
 allow xdm_t self:appletalk_socket create_socket_perms;
 allow xdm_t self:key { search link write };
 
-allow xdm_t xconsole_device_t:fifo_file { getattr setattr };
-
 # Allow gdm to run gdm-binary
 can_exec(xdm_t, xdm_exec_t)
 
Index: policy/modules/services/xserver.fc
===================================================================
--- policy/modules/services/xserver.fc	(revision 2560)
+++ policy/modules/services/xserver.fc	(working copy)
@@ -10,11 +10,6 @@
 HOME_DIR/\.Xauthority.*	--	gen_context(system_u:object_r:ROLE_xauth_home_t,s0)
 
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
--- policy/modules/services/xserver.if	(revision 2560)
+++ policy/modules/services/xserver.if	(working copy)
@@ -729,42 +729,6 @@
 
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
-	allow $1 xconsole_device_t:fifo_file rw_fifo_file_perms;
-')
-
-########################################
-## <summary>
 ##	Use file descriptors for xdm.
 ## </summary>
 ## <param name="domain">
Index: policy/modules/system/logging.te
===================================================================
--- policy/modules/system/logging.te	(revision 2560)
+++ policy/modules/system/logging.te	(working copy)
@@ -65,6 +65,12 @@
 	init_ranged_daemon_domain(auditd_t,auditd_exec_t,mls_systemhigh)
 ')
 
+# this is not actually a device, its a pipe
+type xconsole_device_t;
+files_type(xconsole_device_t)
+fs_associate_tmpfs(xconsole_device_t)
+files_associate_tmp(xconsole_device_t)
+
 ########################################
 #
 # Auditctl local policy
@@ -277,6 +283,9 @@
 manage_files_pattern(syslogd_t,syslogd_var_run_t,syslogd_var_run_t)
 files_pid_filetrans(syslogd_t,syslogd_var_run_t,file)
 
+# log to xconsole
+allow syslogd_t xconsole_device_t:fifo_file rw_fifo_file_perms;
+
 kernel_read_kernel_sysctls(syslogd_t)
 kernel_read_proc_symlinks(syslogd_t)
 # Allow access to /proc/kmsg for syslog-ng
@@ -376,8 +385,3 @@
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
--- policy/modules/system/logging.if	(revision 2560)
+++ policy/modules/system/logging.if	(working copy)
@@ -804,3 +804,39 @@
 	logging_admin_audit($1, $2, $3)
 	logging_admin_syslog($1, $2, $3)
 ')
+
+########################################
+## <summary>
+##	Set the attributes of the xconsole named pipe.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`logging_setattr_xconsole',`
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
+	allow $1 xconsole_device_t:fifo_file read_fifo_file_perms;
+')
Index: policy/modules/system/init.te
===================================================================
--- policy/modules/system/init.te	(revision 2560)
+++ policy/modules/system/init.te	(working copy)
@@ -356,6 +356,7 @@
 logging_read_all_logs(initrc_t)
 logging_append_all_logs(initrc_t)
 logging_read_audit_config(initrc_t)
+logging_setattr_xconsole(initrc_t)
 
 miscfiles_read_localization(initrc_t)
 # slapd needs to read cert files from its initscript
@@ -755,9 +756,6 @@
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
--- policy/modules/system/logging.fc	(revision 2560)
+++ policy/modules/system/logging.fc	(working copy)
@@ -1,4 +1,5 @@
 /dev/log		-s	gen_context(system_u:object_r:devlog_t,s0)
+/dev/xconsole		-p	gen_context(system_u:object_r:xconsole_device_t,s0)
 
 /etc/rsyslog.conf		gen_context(system_u:object_r:syslog_conf_t,s0)
 /etc/syslog.conf		gen_context(system_u:object_r:syslog_conf_t,s0)

--8t9RHnE3ZwKMSgU+
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="xconsole-move2.patch"

Index: policy/modules/services/xserver.te
===================================================================
--- policy/modules/services/xserver.te	(revision 2560)
+++ policy/modules/services/xserver.te	(working copy)
@@ -32,12 +32,6 @@
 type xauth_exec_t;
 application_executable_file(xauth_exec_t)
 
-# this is not actually a device, its a pipe
-type xconsole_device_t;
-files_type(xconsole_device_t)
-fs_associate_tmpfs(xconsole_device_t)
-files_associate_tmp(xconsole_device_t)
-
 type xdm_t;
 type xdm_exec_t;
 auth_login_pgm_domain(xdm_t)
@@ -108,8 +102,6 @@
 allow xdm_t self:appletalk_socket create_socket_perms;
 allow xdm_t self:key { search link write };
 
-allow xdm_t xconsole_device_t:fifo_file { getattr setattr };
-
 # Allow gdm to run gdm-binary
 can_exec(xdm_t, xdm_exec_t)
 
Index: policy/modules/services/xserver.fc
===================================================================
--- policy/modules/services/xserver.fc	(revision 2560)
+++ policy/modules/services/xserver.fc	(working copy)
@@ -10,11 +10,6 @@
 HOME_DIR/\.Xauthority.*	--	gen_context(system_u:object_r:ROLE_xauth_home_t,s0)
 
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
--- policy/modules/services/xserver.if	(revision 2560)
+++ policy/modules/services/xserver.if	(working copy)
@@ -729,42 +729,6 @@
 
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
-	allow $1 xconsole_device_t:fifo_file rw_fifo_file_perms;
-')
-
-########################################
-## <summary>
 ##	Use file descriptors for xdm.
 ## </summary>
 ## <param name="domain">
Index: policy/modules/system/logging.te
===================================================================
--- policy/modules/system/logging.te	(revision 2560)
+++ policy/modules/system/logging.te	(working copy)
@@ -65,6 +65,12 @@
 	init_ranged_daemon_domain(auditd_t,auditd_exec_t,mls_systemhigh)
 ')
 
+# this is not actually a device, its a pipe
+type xconsole_device_t;
+files_type(xconsole_device_t)
+fs_associate_tmpfs(xconsole_device_t)
+files_associate_tmp(xconsole_device_t)
+
 ########################################
 #
 # Auditctl local policy
@@ -277,6 +283,9 @@
 manage_files_pattern(syslogd_t,syslogd_var_run_t,syslogd_var_run_t)
 files_pid_filetrans(syslogd_t,syslogd_var_run_t,file)
 
+# log to xconsole
+allow syslogd_t xconsole_device_t:fifo_file rw_fifo_file_perms;
+
 kernel_read_kernel_sysctls(syslogd_t)
 kernel_read_proc_symlinks(syslogd_t)
 # Allow access to /proc/kmsg for syslog-ng
@@ -376,8 +385,3 @@
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
--- policy/modules/system/logging.if	(revision 2560)
+++ policy/modules/system/logging.if	(working copy)
@@ -804,3 +804,21 @@
 	logging_admin_audit($1, $2, $3)
 	logging_admin_syslog($1, $2, $3)
 ')
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
+	allow $1 xconsole_device_t:fifo_file read_fifo_file_perms;
+')
Index: policy/modules/system/init.te
===================================================================
--- policy/modules/system/init.te	(revision 2560)
+++ policy/modules/system/init.te	(working copy)
@@ -755,9 +755,6 @@
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
--- policy/modules/system/logging.fc	(revision 2560)
+++ policy/modules/system/logging.fc	(working copy)
@@ -1,4 +1,5 @@
 /dev/log		-s	gen_context(system_u:object_r:devlog_t,s0)
+/dev/xconsole		-p	gen_context(system_u:object_r:xconsole_device_t,s0)
 
 /etc/rsyslog.conf		gen_context(system_u:object_r:syslog_conf_t,s0)
 /etc/syslog.conf		gen_context(system_u:object_r:syslog_conf_t,s0)

--8t9RHnE3ZwKMSgU+--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
