Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBGGowIi025662
	for <selinux@tycho.nsa.gov>; Thu, 16 Dec 2004 11:50:58 -0500 (EST)
Message-ID: <41C1BCEF.7090508@redhat.com>
Date: Thu, 16 Dec 2004 11:50:55 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SELinux ML <selinux@tycho.nsa.gov>
Subject: Latest patch
References: <20041209174633.GA8179@jmh.mhn.de> <1103143388.31218.33.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1103143388.31218.33.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------080604050607090606070701"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080604050607090606070701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add winbind policy

Add transitionbool attribute. to indicate whether a domain should have a 
disable_trans boolean created for that domain.
(Mozilla and games in strict policy,  All network domains in targeted)

Added can_secsecparam

Fix httpd_sys_script_t to allow access to mysql sock file.

Began adding user configuration changes, to allow adding users in 
different roles without policy sources installed.

Remove user_can_mount tunable.



--------------080604050607090606070701
Content-Type: text/x-patch;
 name="policy-20041216.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-20041216.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/attrib.te policy-1.19.14/attrib.te
--- nsapolicy/attrib.te	2004-12-02 14:11:41.000000000 -0500
+++ policy-1.19.14/attrib.te	2004-12-16 11:48:36.939342542 -0500
@@ -390,3 +390,6 @@
 # For labeling of content for httpd
 attribute httpdcontent;
 
+# For labeling of domains whos transition can be disabled
+attribute transitionbool;
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/admin.te policy-1.19.14/domains/admin.te
--- nsapolicy/domains/admin.te	2004-09-23 15:08:58.000000000 -0400
+++ policy-1.19.14/domains/admin.te	2004-12-16 11:48:36.940342432 -0500
@@ -23,6 +23,9 @@
 # Allow administrator domains to set policy booleans.
 can_setbool(sysadm_t)
 
+# Allow administrator domains to set security parameters
+can_setsecparam(sysadm_t)
+
 # for su
 allow sysadm_t userdomain:fd use;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.19.14/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2004-12-11 06:31:18.000000000 -0500
+++ policy-1.19.14/domains/program/initrc.te	2004-12-16 11:48:36.941342321 -0500
@@ -137,11 +137,6 @@
 # Update /etc/ld.so.cache.
 allow initrc_t ld_so_cache_t:file rw_file_perms;
 
-ifdef(`sendmail.te', `
-# Update /etc/mail.
-allow initrc_t etc_mail_t:file { setattr rw_file_perms };
-')
-
 ifdef(`xfs.te', `
 # Unlink the xfs socket.
 allow initrc_t xfs_tmp_t:dir rw_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.19.14/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2004-12-11 06:31:18.000000000 -0500
+++ policy-1.19.14/domains/program/unused/apache.te	2004-12-16 11:48:36.941342321 -0500
@@ -243,11 +243,12 @@
 ifdef(`mysqld.te', `
 can_unix_connect(httpd_php_t, mysqld_t)
 can_unix_connect(httpd_t, mysqld_t)
+can_unix_connect(httpd_sys_script_t, mysqld_t)
 allow httpd_php_t mysqld_var_run_t:dir search;
 allow httpd_php_t mysqld_var_run_t:sock_file write;
-allow httpd_t mysqld_db_t:dir search;
-allow httpd_t mysqld_db_t:sock_file rw_file_perms;
-allow httpd_t mysqld_var_run_t:sock_file rw_file_perms;
+allow { httpd_t httpd_sys_script_t } mysqld_db_t:dir search;
+allow { httpd_t httpd_sys_script_t } mysqld_db_t:sock_file rw_file_perms;
+allow { httpd_t httpd_sys_script_t } mysqld_var_run_t:sock_file rw_file_perms;
 ')
 allow httpd_t bin_t:dir search;
 allow httpd_t sbin_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.19.14/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2004-12-11 06:31:19.000000000 -0500
+++ policy-1.19.14/domains/program/unused/nscd.te	2004-12-16 11:48:36.942342210 -0500
@@ -59,7 +59,10 @@
 #
 # Handle winbind for samba, Might only be needed for targeted policy
 #
-dontaudit nscd_t var_run_t:sock_file rw_file_perms;
+allow nscd_t winbind_var_run_t:sock_file { read write getattr };
+can_unix_connect(nscd_t, winbind_t)
+allow nscd_t samba_var_t:dir search;
+allow nscd_t winbind_var_run_t:dir { getattr search };
 
 r_dir_file(nscd_t, selinux_config_t)
 can_getsecurity(nscd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/openvpn.te policy-1.19.14/domains/program/unused/openvpn.te
--- nsapolicy/domains/program/unused/openvpn.te	2004-12-02 14:11:42.000000000 -0500
+++ policy-1.19.14/domains/program/unused/openvpn.te	2004-12-16 11:48:36.943342100 -0500
@@ -21,7 +21,7 @@
 allow openvpn_t self:unix_stream_socket create_stream_socket_perms;
 allow openvpn_t self:unix_dgram_socket sendto;
 allow openvpn_t self:unix_stream_socket connectto;
-allow openvpn_t self:capability net_admin;
+allow openvpn_t self:capability { net_admin setgid setuid };
 r_dir_file(openvpn_t, sysctl_net_t)
 
 can_network_server(openvpn_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sendmail.te policy-1.19.14/domains/program/unused/sendmail.te
--- nsapolicy/domains/program/unused/sendmail.te	2004-11-30 05:59:39.000000000 -0500
+++ policy-1.19.14/domains/program/unused/sendmail.te	2004-12-16 11:48:36.943342100 -0500
@@ -14,7 +14,7 @@
 #
 
 # etc_mail_t is the type of /etc/mail.
-type etc_mail_t, file_type, sysadmfile;
+type etc_mail_t, file_type, sysadmfile, usercanread;
 
 daemon_domain(sendmail, `, nscd_client_domain, mta_delivery_agent, mail_server_domain, mail_server_sender', nosysadm)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/winbind.te policy-1.19.14/domains/program/unused/winbind.te
--- nsapolicy/domains/program/unused/winbind.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.19.14/domains/program/unused/winbind.te	2004-12-16 11:48:36.944341989 -0500
@@ -0,0 +1,34 @@
+#DESC winbind - Name  Service  Switch  daemon for resolving names from NT servers
+#
+# Author: Dan Walsh (dwalsh@redhat.com)
+#
+
+#################################
+#
+# Declarations for winbind
+#
+
+daemon_domain(winbind, `, privhome, auth_chkpwd')
+allow winbind_t self:capability net_admin;
+log_domain(winbind)
+allow winbind_t etc_t:file r_file_perms;
+allow winbind_t etc_t:lnk_file read;
+can_network(winbind_t)
+ifdef(`samba.te', `', `
+type samba_etc_t, file_type, sysadmfile, usercanread;
+type samba_log_t, file_type, sysadmfile, logfile;
+type samba_var_t, file_type, sysadmfile;
+type samba_secrets_t, file_type, sysadmfile;
+')
+rw_dir_file(winbind_t, samba_etc_t)
+rw_dir_file(winbind_t, samba_log_t)
+allow winbind_t samba_secrets_t:file rw_file_perms;
+allow winbind_t self:unix_dgram_socket create_socket_perms;
+allow winbind_t self:unix_stream_socket create_stream_socket_perms;
+allow winbind_t urandom_device_t:chr_file { getattr read };
+allow winbind_t self:fifo_file { read write };
+rw_dir_file(winbind_t, samba_var_t)
+allow winbind_t krb5_conf_t:file { getattr read };
+dontaudit winbind_t krb5_conf_t:file { write };
+allow winbind_t self:netlink_route_socket r_netlink_socket_perms;
+allow winbind_t winbind_var_run_t:sock_file create_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/user.te policy-1.19.14/domains/user.te
--- nsapolicy/domains/user.te	2004-12-02 14:11:41.000000000 -0500
+++ policy-1.19.14/domains/user.te	2004-12-16 11:48:36.944341989 -0500
@@ -27,9 +27,6 @@
 # Allow users to control network interfaces (also needs USERCTL=true)
 bool user_net_control false;
 
-# Disable games transitions
-bool disable_games false;
-
 # Allow regular users direct mouse access 
 bool user_direct_mouse false;
 
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/distros.fc policy-1.19.14/file_contexts/distros.fc
--- nsapolicy/file_contexts/distros.fc	2004-12-09 10:26:09.000000000 -0500
+++ policy-1.19.14/file_contexts/distros.fc	2004-12-16 11:48:36.945341878 -0500
@@ -34,6 +34,7 @@
 /usr/share/texmf/web2c/mktexdir	--	system_u:object_r:bin_t
 /usr/share/texmf/web2c/mktexnam	--	system_u:object_r:bin_t
 /usr/share/texmf/web2c/mktexupd	--	system_u:object_r:bin_t
+/usr/share/ssl/misc(/.*)?		system_u:object_r:bin_t
 ')
 
 ifdef(`distro_suse', `
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/samba.fc policy-1.19.14/file_contexts/program/samba.fc
--- nsapolicy/file_contexts/program/samba.fc	2004-12-11 06:31:20.000000000 -0500
+++ policy-1.19.14/file_contexts/program/samba.fc	2004-12-16 11:48:36.945341878 -0500
@@ -19,5 +19,3 @@
 /var/run/samba/smbd\.pid --	system_u:object_r:smbd_var_run_t
 /var/run/samba/nmbd\.pid --	system_u:object_r:nmbd_var_run_t
 /var/spool/samba(/.*)?		system_u:object_r:samba_var_t
-/usr/sbin/winbindd		--	system_u:object_r:smbd_exec_t
-/var/run/winbindd(/.*)?		system_u:object_r:smbd_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/winbind.fc policy-1.19.14/file_contexts/program/winbind.fc
--- nsapolicy/file_contexts/program/winbind.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.19.14/file_contexts/program/winbind.fc	2004-12-16 11:48:36.946341768 -0500
@@ -0,0 +1,10 @@
+/usr/sbin/winbindd	--	system_u:object_r:winbind_exec_t
+/var/run/winbindd(/.*)?		system_u:object_r:winbind_var_run_t
+ifdef(`samba.te', `', `
+/var/log/samba(/.*)?		system_u:object_r:samba_log_t
+/etc/samba(/.*)?		system_u:object_r:samba_etc_t
+/etc/samba/secrets\.tdb	--	system_u:object_r:samba_secrets_t
+/etc/samba/MACHINE\.SID	--	system_u:object_r:samba_secrets_t
+/var/cache/samba(/.*)?		system_u:object_r:samba_var_t
+')
+/var/cache/samba/winbindd_privileged(/.*)?	system_u:object_r:winbind_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/local.users policy-1.19.14/local.users
--- nsapolicy/local.users	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.19.14/local.users	2004-12-16 11:48:36.946341768 -0500
@@ -0,0 +1,21 @@
+##################################
+#
+# User configuration.
+#
+# This file defines additional users recognized by the system security policy.
+# Only the user identities defined in this file and the users.system file
+# may be used as the user attribute in a security context.
+#
+# Each user has a set of roles that may be entered by processes
+# with the users identity.  The syntax of a user declaration is:
+#
+# 	user username roles role_set [ ranges MLS_range_set ];
+#
+# The MLS range set should only be specified if MLS was enabled
+# for the module and checkpolicy.
+
+# sample for administrative user
+user jadmin roles { staff_r sysadm_r ifdef(`direct_sysadm_daemon', `system_r') };
+
+# sample for regular user
+#user jdoe roles { user_r }; 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/core_macros.te policy-1.19.14/macros/core_macros.te
--- nsapolicy/macros/core_macros.te	2004-12-09 10:26:10.000000000 -0500
+++ policy-1.19.14/macros/core_macros.te	2004-12-16 11:48:36.947341657 -0500
@@ -332,6 +332,26 @@
 
 ##################################
 #
+# can_setsecparam(domain)
+#
+# Authorize a domain to set security parameters.
+# Due to its sensitivity, always audit this permission.
+#
+define(`can_setsecparam',`
+# Get the selinuxfs mount point via /proc/self/mounts.
+allow $1 proc_t:dir search;
+allow $1 proc_t:lnk_file read;
+allow $1 self:dir search;
+allow $1 self:file { getattr read };
+# Access selinuxfs.
+allow $1 security_t:dir { read search getattr };
+allow $1 security_t:file { getattr read write };
+allow $1 security_t:security setsecparam;
+auditallow $1 security_t:security setsecparam;
+')
+
+##################################
+#
 # can_loadpol(domain)
 #
 # Authorize a domain to load a policy configuration.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.19.14/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2004-12-11 06:31:21.000000000 -0500
+++ policy-1.19.14/macros/global_macros.te	2004-12-16 11:48:36.948341546 -0500
@@ -296,13 +296,13 @@
 #
 # Allows user to define a tunable to disable domain transition
 #
-ifdef(`targeted_policy', `
+ifelse(index(`$2',`transitionbool'), -1, `', `
 bool $1_disable_trans false;
 if ($1_disable_trans) {
 can_exec(initrc_t, $1_exec_t)
 can_exec(sysadm_t, $1_exec_t)
 } else {
-') dnl targeted_policy
+') dnl transitionbool
 domain_auto_trans(initrc_t, $1_exec_t, $1_t)
 allow initrc_t $1_t:process { noatsecure siginh rlimitinh };
 ifdef(`direct_sysadm_daemon', `
@@ -311,10 +311,9 @@
 allow sysadm_t $1_t:process { noatsecure siginh rlimitinh };
 ')dnl end direct_sysadm_daemon
 ')dnl end nosysadm
-ifdef(`targeted_policy', `
+ifelse(index(`$2', `transitionbool'), -1, `', `
 }
-') dnl targeted_policy
-
+') dnl end transitionbool
 ifdef(`direct_sysadm_daemon', `
 ifelse(`$3', `nosysadm', `', `
 role_transition sysadm_r $1_exec_t system_r;
@@ -340,9 +339,12 @@
 allow $1_t var_t:dir search;
 allow $1_t $1_var_run_t:dir rw_dir_perms;
 ')
-
 define(`daemon_domain', `
+ifdef(`targeted_policy', `
+daemon_base_domain($1, `$2, transitionbool', $3)
+', `
 daemon_base_domain($1, `$2', $3)
+')
 # Create pid file.
 allow $1_t var_t:dir { getattr search };
 var_run_domain($1)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/cdrecord_macros.te policy-1.19.14/macros/program/cdrecord_macros.te
--- nsapolicy/macros/program/cdrecord_macros.te	2004-12-11 06:31:21.000000000 -0500
+++ policy-1.19.14/macros/program/cdrecord_macros.te	2004-12-16 11:48:36.949341436 -0500
@@ -35,6 +35,7 @@
 if (use_nfs_home_dirs) {
 r_dir_file($1_cdrecord_t, nfs_t)
 }
+allow $1_cdrecord_t etc_t:file { getattr read };
 
 # allow searching for cdrom-drive
 allow $1_cdrecord_t device_t:dir { getattr search };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/games_domain.te policy-1.19.14/macros/program/games_domain.te
--- nsapolicy/macros/program/games_domain.te	2004-12-02 14:11:43.000000000 -0500
+++ policy-1.19.14/macros/program/games_domain.te	2004-12-16 11:48:36.949341436 -0500
@@ -10,7 +10,7 @@
 #
 #
 define(`games_domain', `
-x_client_domain($1, `games')
+x_client_domain($1, `games', `, transitionbool')
 allow $1_games_t var_t:dir { search getattr };
 rw_dir_create_file($1_games_t, games_data_t)
 allow $1_games_t sound_device_t:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.19.14/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-12-11 06:31:21.000000000 -0500
+++ policy-1.19.14/macros/program/mozilla_macros.te	2004-12-16 11:48:36.950341325 -0500
@@ -16,7 +16,7 @@
 # provided separately in domains/program/mozilla.te. 
 #
 define(`mozilla_domain',`
-x_client_domain($1, mozilla, `, web_client_domain, privlog')
+x_client_domain($1, mozilla, `, web_client_domain, privlog, transitionbool')
 
 allow $1_mozilla_t sound_device_t:chr_file rw_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/x_client_macros.te policy-1.19.14/macros/program/x_client_macros.te
--- nsapolicy/macros/program/x_client_macros.te	2004-11-30 05:59:40.000000000 -0500
+++ policy-1.19.14/macros/program/x_client_macros.te	2004-12-16 11:48:36.951341214 -0500
@@ -29,15 +29,19 @@
 # Type for files that are read-only for this domain
 type $1_$2_ro_t, file_type, $1_file_type, sysadmfile;
 
-# Transition from the user domain to the derived domain.
-ifelse($2, games, `
-if (! disable_games) {
+ifelse(index(`$3', `transitionbool'), -1, `
 domain_auto_trans($1_t, $2_exec_t, $1_$2_t)
 can_exec($1_$2_t, $2_exec_t)
-}
 ', `
+# Only do it once
+ifelse($1, user, `
+bool disable_$2 false;
+')
+# Transition from the user domain to the derived domain.
+if (! disable_$2) {
 domain_auto_trans($1_t, $2_exec_t, $1_$2_t)
 can_exec($1_$2_t, $2_exec_t)
+}
 ')
 
 # The user role is authorized for this domain.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xserver_macros.te policy-1.19.14/macros/program/xserver_macros.te
--- nsapolicy/macros/program/xserver_macros.te	2004-12-11 06:31:21.000000000 -0500
+++ policy-1.19.14/macros/program/xserver_macros.te	2004-12-16 11:48:36.951341214 -0500
@@ -247,6 +247,10 @@
 # Allow xserver to read events - the synaptics touchpad
 # driver reads raw events
 allow $1_xserver_t event_device_t:chr_file rw_file_perms;
+ifdef(`pamconsole.te', `
+allow $1_xserver_t pam_var_console_t:dir search;
+')
+dontaudit $1_xserver_t selinux_config_t:dir search;
 
 allow $1_xserver_t var_lib_t:dir search;
 rw_dir_create_file($1_xserver_t, var_lib_xkb_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.19.14/macros/user_macros.te
--- nsapolicy/macros/user_macros.te	2004-12-11 06:31:21.000000000 -0500
+++ policy-1.19.14/macros/user_macros.te	2004-12-16 11:49:34.659954788 -0500
@@ -218,22 +218,6 @@
 dontaudit $1_t init_t:fd use;
 dontaudit $1_t initrc_t:fd use;
 allow $1_t initrc_t:fifo_file write;
-ifdef(`user_can_mount', `
-#
-#  Allow users to mount file systems like floppies and cdrom
-#
-mount_domain($1, $1_mount, `, fs_domain')
-r_dir_file($1_t, mnt_t)
-allow $1_mount_t device_t:lnk_file read;
-allow $1_mount_t removable_device_t:blk_file read;
-allow $1_mount_t iso9660_t:filesystem relabelfrom;
-allow $1_mount_t removable_t:filesystem { mount relabelto };
-allow $1_mount_t removable_t:dir mounton;
-ifdef(`xdm.te', `
-allow $1_mount_t xdm_t:fd use;
-allow $1_mount_t xdm_t:fifo_file { read write };
-')
-')
 
 #
 # Rules used to associate a homedir as a mountpoint
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.19.14/Makefile
--- nsapolicy/Makefile	2004-12-11 06:31:17.000000000 -0500
+++ policy-1.19.14/Makefile	2004-12-16 11:48:36.953340993 -0500
@@ -26,6 +26,7 @@
 INSTALLDIR = $(DESTDIR)/etc/selinux/strict
 POLICYPATH = $(INSTALLDIR)/policy
 SRCPATH = $(INSTALLDIR)/src
+USERPATH = $(INSTALLDIR)/users
 CONTEXTPATH = $(INSTALLDIR)/contexts
 LOADPATH = $(POLICYPATH)/$(POLICYVER)
 FCPATH = $(CONTEXTPATH)/files/file_contexts
@@ -37,13 +38,13 @@
 ALLTEFILES := attrib.te tmp/program_used_flags.te $(ALL_MACROS) $(ALL_TYPES) $(ALL_DOMAINS) assert.te 
 TE_RBAC_FILES := $(ALLTEFILES) rbac
 ALL_TUNABLES := $(wildcard tunables/*.tun )
-
+USER_FILES := users serviceusers
 POLICYFILES = $(addprefix $(FLASKDIR),security_classes initial_sids access_vectors)
 ifeq ($(MLS),y)
 POLICYFILES += mls
 endif
 POLICYFILES += $(ALL_TUNABLES) $(TE_RBAC_FILES)
-POLICYFILES += users serviceusers
+POLICYFILES += $(USER_FILES)
 POLICYFILES += constraints initial_sid_contexts fs_use genfs_contexts net_contexts
 
 UNUSED_TE_FILES := $(wildcard domains/program/unused/*.te)
@@ -54,9 +55,24 @@
 APPDIR=$(CONTEXTPATH)
 APPFILES = $(addprefix $(APPDIR)/,default_contexts default_type initrc_context failsafe_context userhelper_context removable_context dbus_contexts) $(CONTEXTPATH)/files/media
 
+$(USERPATH)/system.users: $(ALL_TUNABLES) $(USER_FILES) policy.conf
+	@mkdir -p $(USERPATH)
+	@echo "# " > tmp/system.users
+	@echo "# Do not edit this file. " >> tmp/system.users
+	@echo "# This file is replaced on reinstalls of this policy." >> tmp/system.users
+	@echo "# Please edit local.users to make local changes." >> tmp/system.users
+	@echo "#" >> tmp/system.users
+	m4 $(ALL_TUNABLES) tmp/program_used_flags.te $(USER_FILES) | grep -v "^#" >> tmp/system.users
+	install -m 644 tmp/system.users $@
+
+$(USERPATH)/local.users: local.users
+	@mkdir -p $(USERPATH)
+	m4 $(ALL_TUNABLES) tmp/program_used_flags.te $(USERPATH)/local.users | sed 's/^user/#user/g' >> tmp/local.users
+	install -m 644 tmp/local.users $@
+
 ROOTFILES = $(addprefix $(APPDIR)/users/,root)
 
-install: $(APPFILES) $(ROOTFILES) $(LOADPATH) $(FCPATH) 
+install: $(APPFILES) $(ROOTFILES) $(LOADPATH) $(FCPATH) $(USERPATH)/system.users $(USERPATH)/local.users
 	@echo "Validating file_contexts ..."	
 	$(SETFILES) -q -c $(LOADPATH) $(FCPATH)
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.19.14/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.19.14/tunables/distro.tun	2004-12-16 11:48:36.953340993 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.19.14/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-12-11 06:31:22.000000000 -0500
+++ policy-1.19.14/tunables/tunable.tun	2004-12-16 11:48:36.954340882 -0500
@@ -1,27 +1,24 @@
-# Allow users to execute the mount command
-dnl define(`user_can_mount')
-
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Allow rc scripts to run unconfined, including any daemon
 # started by an rc script that does not have a domain transition
 # explicitly defined.
-dnl define(`unlimitedRC')
+define(`unlimitedRC')
 
 # Allow sysadm_t to directly start daemons
 define(`direct_sysadm_daemon')
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.

--------------080604050607090606070701--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
