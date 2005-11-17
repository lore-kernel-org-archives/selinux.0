Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAHG2pMA010981
	for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2005 11:02:51 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jAHFsWLH016470
	for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2005 15:54:32 GMT
Message-ID: <437CA7D7.6090308@redhat.com>
Date: Thu, 17 Nov 2005 10:55:03 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Current Reference Policy patch
Content-Type: multipart/mixed;
 boundary="------------000507030306090308040709"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000507030306090308040709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Need to turn on rpm and not alias to unconfined_t, because the rule

rpm_t->shell_exec_t->rpm_script_t was causing all terminal windows to 
run in rpm_script_t in targeted.

Allow users to su to root and then suspend the session.

Pegasus policy was too loose.
/bin/ksh should be sheel_exec_t
(.*)?  is the same as .* and causes python to blow up.

-- 



--------------000507030306090308040709
Content-Type: text/x-patch;
 name="policy-20051114.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20051114.patch"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/booleans.conf serefpolicy-2.0.1/policy/booleans.conf
--- nsaserefpolicy/policy/booleans.conf	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.0.1/policy/booleans.conf	2005-11-16 21:23:07.000000000 -0500
@@ -0,0 +1,208 @@
+# Allow making anonymous memory executable, e.g.for runtime-code generation or executable stack.
+# 
+allow_execmem = true
+
+# Allow making a modified private filemapping executable (text relocation).
+# 
+allow_execmod = true
+
+# Allow making the stack executable via mprotect.Also requires allow_execmem.
+# 
+allow_execstack = true
+
+# Allow ftp servers to modify public filesused for public file transfer services.
+# 
+allow_ftpd_anon_write = false
+
+# Allow gssd to read temp directory.
+# 
+allow_gssd_read_tmp = true
+
+# Allow Apache to modify public filesused for public file transfer services.
+# 
+allow_httpd_anon_write = false
+
+# Allow system to run with kerberos
+# 
+allow_kerberos = true
+
+# Allow rsync to modify public filesused for public file transfer services.
+# 
+allow_rsync_anon_write = false
+
+# Allow sasl to read shadow
+# 
+allow_saslauthd_read_shadow = false
+
+# Allow samba to modify public filesused for public file transfer services.
+# 
+allow_smbd_anon_write = false
+
+# Allow sysadm to ptrace all processes
+# 
+allow_ptrace = false
+
+# Allow system to run with NIS
+# 
+allow_ypbind = false
+
+# Enable extra rules in the cron domainto support fcron.
+# 
+fcron_crond = false
+
+# Allow ftp to read and write files in the user home directories
+# 
+ftp_home_dir = false
+
+# Allow ftpd to run directly without inetd
+# 
+ftpd_is_daemon = true
+
+# Allow httpd to use built in scripting (usually php)
+# 
+httpd_builtin_scripting = true
+
+# Allow http daemon to tcp connect
+# 
+httpd_can_network_connect = false
+
+# Allow httpd cgi support
+# 
+httpd_enable_cgi = true
+
+# Allow httpd to act as a FTP server bylistening on the ftp port.
+# 
+httpd_enable_ftp_server = false
+
+# Allow httpd to read home directories
+# 
+httpd_enable_homedirs = true
+
+# Run SSI execs in system CGI script domain.
+# 
+httpd_ssi_exec = true
+
+# Allow http daemon to communicate with the TTY
+# 
+httpd_tty_comm = false
+
+# Run CGI in the main httpd domain
+# 
+httpd_unified = true
+
+# Allow BIND to write the master zone files.Generally this is used for dynamic DNS.
+# 
+named_write_master_zones = false
+
+# Allow nfs to be exported read/write.
+# 
+nfs_export_all_rw = true
+
+# Allow nfs to be exported read only
+# 
+nfs_export_all_ro = true
+
+# Allow pppd to load kernel modules for certain modems
+# 
+pppd_can_insmod = false
+
+# Allow reading of default_t files.
+# 
+read_default_t = true
+
+# Allow ssh to run from inetd instead of as a daemon.
+# 
+run_ssh_inetd = false
+
+# Allow samba to export user home directories.
+# 
+samba_enable_home_dirs = false
+
+# Allow squid to connect to all ports, not justHTTP, FTP, and Gopher ports.
+# 
+squid_connect_any = false
+
+# Allow ssh logins as sysadm_r:sysadm_t
+# 
+ssh_sysadm_login = false
+
+# Configure stunnel to be a standalone daemon orinetd service.
+# 
+stunnel_is_daemon = false
+
+# Support NFS home directories
+# 
+use_nfs_home_dirs = false
+
+# Support SAMBA home directories
+# 
+use_samba_home_dirs = false
+
+# Control users use of ping and traceroute
+# 
+user_ping = true
+
+# Allow gpg executable stack
+# 
+allow_gpg_execstack = false
+
+# allow host key based authentication
+# 
+allow_ssh_keysign = false
+
+# Allow users to connect to mysql
+# 
+allow_user_mysql_connect = false
+
+# Allow system cron jobs to relabel filesystemfor restoring file contexts.
+# 
+cron_can_relabel = false
+
+# Allow pppd to be run for a regular user
+# 
+pppd_for_user = false
+
+# Allow applications to read untrusted contentIf this is disallowed, Internet content hasto be manually relabeled for read access to be granted
+# 
+read_untrusted_content = false
+
+# Allow user spamassassin clients to use the network.
+# 
+spamassassin_can_network = false
+
+# Allow staff_r users to search the sysadm homedir and read files (such as ~/.bashrc)
+# 
+staff_read_sysadm_file = false
+
+# Allow regular users direct mouse access
+# 
+user_direct_mouse = false
+
+# Allow users to read system messages.
+# 
+user_dmesg = false
+
+# Allow users to control network interfaces(also needs USERCTL=true)
+# 
+user_net_control = false
+
+# Allow user to r/w files on filesystemsthat do not have extended attributes (FAT, CDROM, FLOPPY)
+# 
+user_rw_noexattrfile = false
+
+# Allow users to rw usb devices
+# 
+user_rw_usb = false
+
+# Allow users to run TCP servers (bind to ports and accept connection fromthe same domain and outside users)  disabling this forces FTP passive modeand may change other protocols.
+# 
+user_tcp_server = false
+
+# Allow w to display everyone
+# 
+user_ttyfile_stat = false
+
+# Allow applications to write untrusted contentIf this is disallowed, no Internet contentwill be stored.
+# 
+write_untrusted_content = false
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.te serefpolicy-2.0.1/policy/modules/admin/rpm.te
--- nsaserefpolicy/policy/modules/admin/rpm.te	2005-11-16 16:27:12.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules/admin/rpm.te	2005-11-16 21:23:07.000000000 -0500
@@ -6,11 +6,7 @@
 # Declarations
 #
 
-ifdef(`targeted_policy',`
-	unconfined_alias_domain(rpm_t)
-',`
-	type rpm_t;
-')
+type rpm_t;
 
 type rpm_exec_t;
 init_system_domain(rpm_t,rpm_exec_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/su.if serefpolicy-2.0.1/policy/modules/admin/su.if
--- nsaserefpolicy/policy/modules/admin/su.if	2005-11-14 18:24:06.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules/admin/su.if	2005-11-16 21:23:07.000000000 -0500
@@ -214,12 +214,14 @@
 		corecmd_exec_bin($1_su_t)
 		userdom_manage_all_user_files($1_su_t)
 		userdom_manage_all_user_symlinks($1_su_t)
-
+		# allow user to suspend terminal
+		allow $1_su_t self:process sigstop;
 		# newrole does not make any sense in
 		# the targeted policy.  This is to
 		# make sediff easier.
 		if(!secure_mode) {
 			unconfined_domtrans($1_su_t)
+			allow $1_su_t unconfined_t:process signal;
 		}
 	',`
 		if(secure_mode) {
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/gpg.fc serefpolicy-2.0.1/policy/modules/apps/gpg.fc
--- nsaserefpolicy/policy/modules/apps/gpg.fc	2005-11-14 18:24:05.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules/apps/gpg.fc	2005-11-16 21:23:07.000000000 -0500
@@ -8,5 +8,5 @@
 /usr/lib/gnupg/gpgkeys.* --	gen_context(system_u:object_r:gpg_helper_exec_t,s0)
 
 ifdef(`targeted_policy',`',`
-HOME_DIR/\.gnupg(/.+)?		gen_context(system_u:object_r:ROLE_gpg_secret_t,s0)
+HOME_DIR/\.gnupg(/.+)?		gen_context(system_u:object_r:user_gpg_secret_t,s0)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/pegasus.te serefpolicy-2.0.1/policy/modules/services/pegasus.te
--- nsaserefpolicy/policy/modules/services/pegasus.te	2005-11-14 18:24:08.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules/services/pegasus.te	2005-11-16 21:23:07.000000000 -0500
@@ -35,9 +35,10 @@
 allow pegasus_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 allow pegasus_t self:tcp_socket create_stream_socket_perms;
 
-allow pegasus_t pegasus_conf_t:dir rw_dir_perms;
-allow pegasus_t pegasus_conf_t:file create_file_perms;
-allow pegasus_t pegasus_conf_t:lnk_file create_lnk_perms;
+allow pegasus_t pegasus_conf_t:dir r_dir_perms;
+allow pegasus_t pegasus_conf_t:file r_file_perms;
+allow pegasus_t pegasus_conf_t:lnk_file r_file_perms;
+allow pegasus_t pegasus_conf_t:file { link unlink };
 
 allow pegasus_t pegasus_data_t:dir rw_dir_perms;
 allow pegasus_t pegasus_data_t:file create_file_perms;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/spamassassin.fc serefpolicy-2.0.1/policy/modules/services/spamassassin.fc
--- nsaserefpolicy/policy/modules/services/spamassassin.fc	2005-11-14 18:24:07.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules/services/spamassassin.fc	2005-11-16 21:23:07.000000000 -0500
@@ -7,5 +7,5 @@
 /usr/bin/spamassassin	--	gen_context(system_u:object_r:spamassassin_exec_t,s0)
 
 ifdef(`targeted_policy',`',`
-HOME_DIR/\.spamassassin(/.*)?	gen_context(system_u:object_r:ROLE_spamassassin_home_t,s0)
+HOME_DIR/\.spamassassin(/.*)?	gen_context(system_u:object_r:user_spamassassin_home_t,s0)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ssh.fc serefpolicy-2.0.1/policy/modules/services/ssh.fc
--- nsaserefpolicy/policy/modules/services/ssh.fc	2005-11-14 18:24:08.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules/services/ssh.fc	2005-11-16 21:23:07.000000000 -0500
@@ -15,5 +15,5 @@
 ifdef(`targeted_policy', `', `
 /usr/bin/ssh-agent		--	gen_context(system_u:object_r:ssh_agent_exec_t,s0)
 
-HOME_DIR/\.ssh(/.*)?			gen_context(system_u:object_r:ROLE_home_ssh_t,s0)
+HOME_DIR/\.ssh(/.*)?			gen_context(system_u:object_r:user_home_ssh_t,s0)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/corecommands.fc serefpolicy-2.0.1/policy/modules/system/corecommands.fc
--- nsaserefpolicy/policy/modules/system/corecommands.fc	2005-11-15 09:13:38.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules/system/corecommands.fc	2005-11-16 21:24:28.000000000 -0500
@@ -10,6 +10,7 @@
 /bin/sash			--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/tcsh			--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/zsh.*			--	gen_context(system_u:object_r:shell_exec_t,s0)
+/bin/ksh.*			--	gen_context(system_u:object_r:shell_exec_t,s0)
 
 #
 # /dev
@@ -97,8 +98,8 @@
 /usr/lib/qt.*/bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
 # these two lines are separate because of a
 # sorting issue with the java module
-/usr/lib/jvm/java(.*)?/jre/bin -d	gen_context(system_u:object_r:bin_t,s0)
-/usr/lib/jvm/java(.*)?/jre/bin/.*	gen_context(system_u:object_r:bin_t,s0)
+/usr/lib/jvm/java.*/bin -d	gen_context(system_u:object_r:bin_t,s0)
+/usr/lib/jvm/java.*/bin/.*	gen_context(system_u:object_r:bin_t,s0)
 
 /usr/lib(64)?/cups/cgi-bin/.*	--	gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(64)?/cups/filter/.*	--	gen_context(system_u:object_r:bin_t,s0)
@@ -120,7 +121,7 @@
 /usr/lib(64)?/[^/]*thunderbird[^/]*/open-browser\.sh -- gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(64)?/[^/]*/run-mozilla\.sh -- gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(64)?/[^/]*/mozilla-xremote-client -- gen_context(system_u:object_r:bin_t,s0)
-/usr/lib(64)?/thunderbird(.*)?/mozilla-xremote-client -- gen_context(system_u:object_r:bin_t,s0)
+/usr/lib(64)?/thunderbird.*/mozilla-xremote-client -- gen_context(system_u:object_r:bin_t,s0)
 
 /usr/libexec(/.*)?			gen_context(system_u:object_r:bin_t,s0)
 /usr/libexec/openssh/sftp-server --	gen_context(system_u:object_r:bin_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.fc serefpolicy-2.0.1/policy/modules/system/userdomain.fc
--- nsaserefpolicy/policy/modules/system/userdomain.fc	2005-11-15 09:13:40.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules/system/userdomain.fc	2005-11-16 21:23:07.000000000 -0500
@@ -4,6 +4,6 @@
 HOME_DIR		-d	gen_context(system_u:object_r:user_home_dir_t,s0)
 HOME_DIR/.+			gen_context(system_u:object_r:user_home_t,s0)
 ',`
-HOME_DIR		-d	gen_context(system_u:object_r:ROLE_home_dir_t,s0)
-HOME_DIR/.+			gen_context(system_u:object_r:ROLE_home_t,s0)
+HOME_DIR		-d	gen_context(system_u:object_r:user_home_dir_t,s0)
+HOME_DIR/.+			gen_context(system_u:object_r:user_home_t,s0)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules.conf serefpolicy-2.0.1/policy/modules.conf
--- nsaserefpolicy/policy/modules.conf	2005-11-15 19:42:21.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules.conf	2005-11-16 21:23:07.000000000 -0500
@@ -189,7 +189,7 @@
 #
 # Virtual Private Networking client
 # 
-vpn = base
+vpn = off
 
 # Layer: admin
 # Module: consoletype

--------------000507030306090308040709--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
