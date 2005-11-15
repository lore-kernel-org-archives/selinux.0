Message-ID: <4379EFBE.8070202@redhat.com>
Date: Tue, 15 Nov 2005 09:25:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux-dev@tresys.com,
   selinux@tycho.nsa.gov
Subject: Policy mods in last nights refpolicy
References: <437907D7.8090002@cornell.edu>	 <1132054159.5415.282.camel@moss-spartans.epoch.ncsc.mil>	 <1132055891.5415.305.camel@moss-spartans.epoch.ncsc.mil>	 <4379E4D1.2010900@redhat.com> <1132063930.5415.364.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1132063930.5415.364.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------010200030209090705080706"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010200030209090705080706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



-- 



--------------010200030209090705080706
Content-Type: text/x-patch;
 name="policy-20051114.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20051114.patch"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/booleans.conf serefpolicy-2.0.1/policy/booleans.conf
--- nsaserefpolicy/policy/booleans.conf	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.0.1/policy/booleans.conf	2005-11-15 09:19:21.000000000 -0500
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
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/apps/gpg.fc serefpolicy-2.0.1/policy/modules/apps/gpg.fc
--- nsaserefpolicy/policy/modules/apps/gpg.fc	2005-11-14 18:24:05.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules/apps/gpg.fc	2005-11-15 09:19:21.000000000 -0500
@@ -8,5 +8,5 @@
 /usr/lib/gnupg/gpgkeys.* --	gen_context(system_u:object_r:gpg_helper_exec_t,s0)
 
 ifdef(`targeted_policy',`',`
-HOME_DIR/\.gnupg(/.+)?		gen_context(system_u:object_r:ROLE_gpg_secret_t,s0)
+HOME_DIR/\.gnupg(/.+)?		gen_context(system_u:object_r:user_gpg_secret_t,s0)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ldap.te serefpolicy-2.0.1/policy/modules/services/ldap.te
--- nsaserefpolicy/policy/modules/services/ldap.te	2005-11-14 18:24:08.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules/services/ldap.te	2005-11-15 09:19:21.000000000 -0500
@@ -25,6 +25,13 @@
 type slapd_var_run_t;
 files_pid_file(slapd_var_run_t)
 
+type slapd_lock_t;
+files_lock_file(slapd_lock_t)
+
+type slapd_cert_t;
+files_type(slapd_cert_t)
+
+
 ########################################
 #
 # Local policy
@@ -61,6 +68,13 @@
 allow slapd_t slapd_var_run_t:dir rw_dir_perms;
 files_create_pid(slapd_t,slapd_var_run_t)
 
+allow slapd_t slapd_cert_t:dir { getattr read search };
+allow slapd_t slapd_cert_t:file { read getattr ioctl lock };
+allow slapd_t slapd_cert_t:lnk_file { getattr read };
+
+allow slapd_t slapd_lock_t:file create_file_perms;
+files_create_lock(slapd_t,slapd_lock_t)
+
 kernel_read_system_state(slapd_t)
 kernel_read_kernel_sysctl(slapd_t)
 kernel_tcp_recvfrom(slapd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/spamassassin.fc serefpolicy-2.0.1/policy/modules/services/spamassassin.fc
--- nsaserefpolicy/policy/modules/services/spamassassin.fc	2005-11-14 18:24:07.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules/services/spamassassin.fc	2005-11-15 09:19:21.000000000 -0500
@@ -7,5 +7,5 @@
 /usr/bin/spamassassin	--	gen_context(system_u:object_r:spamassassin_exec_t,s0)
 
 ifdef(`targeted_policy',`',`
-HOME_DIR/\.spamassassin(/.*)?	gen_context(system_u:object_r:ROLE_spamassassin_home_t,s0)
+HOME_DIR/\.spamassassin(/.*)?	gen_context(system_u:object_r:user_spamassassin_home_t,s0)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ssh.fc serefpolicy-2.0.1/policy/modules/services/ssh.fc
--- nsaserefpolicy/policy/modules/services/ssh.fc	2005-11-14 18:24:08.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules/services/ssh.fc	2005-11-15 09:19:21.000000000 -0500
@@ -15,5 +15,5 @@
 ifdef(`targeted_policy', `', `
 /usr/bin/ssh-agent		--	gen_context(system_u:object_r:ssh_agent_exec_t,s0)
 
-HOME_DIR/\.ssh(/.*)?			gen_context(system_u:object_r:ROLE_home_ssh_t,s0)
+HOME_DIR/\.ssh(/.*)?			gen_context(system_u:object_r:user_home_ssh_t,s0)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/authlogin.if serefpolicy-2.0.1/policy/modules/system/authlogin.if
--- nsaserefpolicy/policy/modules/system/authlogin.if	2005-11-14 18:24:06.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules/system/authlogin.if	2005-11-15 09:19:21.000000000 -0500
@@ -931,6 +931,9 @@
 	optional_policy(`samba.te',`
 		samba_connect_winbind($1)
 	')
+	allow $1 var_auth_t:dir r_dir_perms;
+	allow $1 var_auth_t:file create_file_perms;
+
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/files.fc serefpolicy-2.0.1/policy/modules/system/files.fc
--- nsaserefpolicy/policy/modules/system/files.fc	2005-11-14 18:24:06.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules/system/files.fc	2005-11-15 09:19:21.000000000 -0500
@@ -214,3 +214,4 @@
 /var/tmp/lost\+found	-d	gen_context(system_u:object_r:lost_found_t,s0)
 /var/tmp/lost\+found/.*		<<none>>
 /var/tmp/vi\.recover	-d	gen_context(system_u:object_r:tmp_t,s0)
+/var/lib/abl(/.*)?		gen_context(system_u:object_r:var_auth_t,s0)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/files.te serefpolicy-2.0.1/policy/modules/system/files.te
--- nsaserefpolicy/policy/modules/system/files.te	2005-11-14 18:24:06.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules/system/files.te	2005-11-15 09:19:21.000000000 -0500
@@ -167,3 +167,12 @@
 #
 type var_spool_t;
 files_tmp_file(var_spool_t)
+
+#
+# var_auth_t is the type of /var/lib/auth, usually
+# used for auth data in pam_able
+#
+type var_auth_t, file_type;
+fs_associate(var_auth_t)
+fs_associate_noxattr(var_auth_t)
+
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/logging.te serefpolicy-2.0.1/policy/modules/system/logging.te
--- nsaserefpolicy/policy/modules/system/logging.te	2005-11-14 18:24:06.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules/system/logging.te	2005-11-15 09:19:21.000000000 -0500
@@ -108,6 +108,7 @@
 allow auditd_t self:file { getattr read write };
 allow auditd_t self:unix_dgram_socket create_socket_perms;
 allow auditd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay nlmsg_readpriv };
+allow auditd_t self:fifo_file rw_file_perms;
 
 allow auditd_t auditd_etc_t:file r_file_perms;
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/userdomain.fc serefpolicy-2.0.1/policy/modules/system/userdomain.fc
--- nsaserefpolicy/policy/modules/system/userdomain.fc	2005-11-15 09:13:40.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules/system/userdomain.fc	2005-11-15 09:19:21.000000000 -0500
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
--- nsaserefpolicy/policy/modules.conf	2005-11-15 09:13:36.000000000 -0500
+++ serefpolicy-2.0.1/policy/modules.conf	2005-11-15 09:19:21.000000000 -0500
@@ -189,7 +189,7 @@
 #
 # Virtual Private Networking client
 # 
-vpn = base
+vpn = off
 
 # Layer: admin
 # Module: consoletype
@@ -632,7 +632,7 @@
 #
 # X windows login display manager
 # 
-xdm = base
+xdm = off
 
 # Layer: services
 # Module: networkmanager

--------------010200030209090705080706--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
