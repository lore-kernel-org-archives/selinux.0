Message-ID: <423BCC68.3090003@redhat.com>
Date: Sat, 19 Mar 2005 01:53:28 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: latest diff
Content-Type: multipart/mixed;
 boundary="------------060103000707060607060406"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060103000707060607060406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Several Ivan Cleanups of x_client_macro, tvtime,  mozilla, mplayer

Some cleanup of the dovecot policy, adding keys

I think we can remove the hostname policy, it adds little value.  I 
added don't audit sys_admin to dhcpc
which is triggered by hostname being run by dhcp.  Code seems to work 
without allowing this privs.  I
think it would work fine without hostname policy.  I think we could 
probably get rid of consoletype also.

Moved arpwatch out of mta.te

Add syslogng support to syslog.te

Dan

-- 



--------------060103000707060607060406
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/crond.te policy-1.23.3/domains/program/crond.te
--- nsapolicy/domains/program/crond.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.3/domains/program/crond.te	2005-03-19 01:46:00.333925920 -0500
@@ -205,11 +205,11 @@
 r_dir_file(system_crond_t, file_context_t)
 can_getsecurity(system_crond_t)
 }
-allow system_crond_t removable_t:filesystem { getattr };
+allow system_crond_t removable_t:filesystem getattr;
 #
 # Required for webalizer
 #
 ifdef(`apache.te', `
 allow system_crond_t httpd_log_t:file { getattr read };
 ')
-dontaudit crond_t self:capability { sys_tty_config };
+dontaudit crond_t self:capability sys_tty_config;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/logrotate.te policy-1.23.3/domains/program/logrotate.te
--- nsapolicy/domains/program/logrotate.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.3/domains/program/logrotate.te	2005-03-19 01:46:00.333925920 -0500
@@ -128,7 +128,7 @@
 
 allow logrotate_t fs_t:filesystem getattr;
 can_exec(logrotate_t, shell_exec_t)
-can_exec(logrotate_t, hostname_exec_t)
+ifdef(`hostname.te', `can_exec(logrotate_t, hostname_exec_t)')
 can_exec(logrotate_t,logfile)
 allow logrotate_t net_conf_t:file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.23.3/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.3/domains/program/syslogd.te	2005-03-19 01:46:00.334925768 -0500
@@ -36,7 +36,7 @@
 allow syslogd_t etc_t:file r_file_perms;
 
 # Use capabilities.
-allow syslogd_t self:capability { dac_override net_bind_service sys_resource sys_tty_config };
+allow syslogd_t self:capability { dac_override net_admin net_bind_service sys_resource sys_tty_config };
 
 # Modify/create log files.
 create_append_log_file(syslogd_t, var_log_t)
@@ -103,5 +103,14 @@
 allow syslogd_t { tmpfs_t devpts_t }:dir search;
 dontaudit syslogd_t unlabeled_t:file read;
 dontaudit syslogd_t { userpty_type devpts_t }:chr_file getattr;
-allow syslogd_t self:capability net_admin;
 allow syslogd_t self:netlink_route_socket r_netlink_socket_perms;
+ifdef(`targeted_policy', `
+allow syslogd_t var_run_t:fifo_file { ioctl read write };
+')
+
+bool use_syslogng false;
+
+if (use_syslogng) {
+allow syslogd_t proc_kmsg_t:file write;
+allow syslogd_t self:capability { sys_admin chown };
+}
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/arpwatch.te policy-1.23.3/domains/program/unused/arpwatch.te
--- nsapolicy/domains/program/unused/arpwatch.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.3/domains/program/unused/arpwatch.te	2005-03-19 01:46:00.335925616 -0500
@@ -40,3 +40,9 @@
 allow initrc_t arpwatch_data_t:file create;
 ')dnl end distro_gentoo
 
+# why is mail delivered to a directory of type arpwatch_data_t?
+allow mta_delivery_agent arpwatch_data_t:dir search;
+allow { system_mail_t mta_user_agent } arpwatch_tmp_t:file rw_file_perms;
+ifdef(`hide_broken_symptoms', `
+dontaudit { system_mail_t mta_user_agent } arpwatch_t:packet_socket { read write };
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/consoletype.te policy-1.23.3/domains/program/unused/consoletype.te
--- nsapolicy/domains/program/unused/consoletype.te	2005-03-15 08:02:23.000000000 -0500
+++ policy-1.23.3/domains/program/unused/consoletype.te	2005-03-19 01:46:00.335925616 -0500
@@ -22,6 +22,7 @@
 domain_auto_trans(initrc_t, consoletype_exec_t, consoletype_t)
 
 allow consoletype_t tty_device_t:chr_file { getattr ioctl write };
+allow consoletype_t devtty_t:chr_file { read write };
 allow consoletype_t initrc_devpts_t:chr_file { read write getattr ioctl };
 
 ifdef(`xdm.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.23.3/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.3/domains/program/unused/cups.te	2005-03-19 01:46:00.336925464 -0500
@@ -71,6 +71,8 @@
 can_exec(cupsd_t, cupsd_exec_t)
 allow cupsd_t cupsd_exec_t:dir search;
 allow cupsd_t cupsd_exec_t:lnk_file read;
+allow cupsd_t reserved_port_t:tcp_socket name_bind;
+dontaudit cupsd_t reserved_port_type:tcp_socket name_bind;
 
 allow cupsd_t self:unix_stream_socket create_socket_perms;
 allow cupsd_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpc.te policy-1.23.3/domains/program/unused/dhcpc.te
--- nsapolicy/domains/program/unused/dhcpc.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.3/domains/program/unused/dhcpc.te	2005-03-19 01:46:00.337925312 -0500
@@ -86,6 +86,7 @@
 
 # Use capabilities
 allow dhcpc_t self:capability { dac_override fsetid net_admin net_raw net_bind_service sys_resource sys_tty_config };
+dontaudit dhcpc_t self:capability sys_admin;
 
 # for access("/etc/bashrc", X_OK) on Red Hat
 dontaudit dhcpc_t self:capability { dac_read_search sys_module };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dovecot.te policy-1.23.3/domains/program/unused/dovecot.te
--- nsapolicy/domains/program/unused/dovecot.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.3/domains/program/unused/dovecot.te	2005-03-19 01:46:00.337925312 -0500
@@ -3,13 +3,19 @@
 # Author:  Russell Coker <russell@coker.com.au>
 # X-Debian-Packages: dovecot-imapd, dovecot-pop3d
 
+#
+# Main dovecot daemon
+#
 daemon_domain(dovecot, `, privhome')
+etc_domain(dovecot);
 
 allow dovecot_t dovecot_var_run_t:sock_file create_file_perms;
 
 can_exec(dovecot_t, dovecot_exec_t)
 
 type dovecot_cert_t, file_type, sysadmfile;
+type dovecot_passwd_t, file_type, sysadmfile;
+type dovecot_spool_t, file_type, sysadmfile;
 
 allow dovecot_t self:capability { dac_override dac_read_search chown net_bind_service setgid setuid sys_chroot };
 allow dovecot_t self:process setrlimit;
@@ -25,9 +31,10 @@
 can_exec(dovecot_t, bin_t)
 
 allow dovecot_t pop_port_t:tcp_socket name_bind;
-allow dovecot_t urandom_device_t:chr_file read;
+allow dovecot_t urandom_device_t:chr_file { getattr read };
 allow dovecot_t cert_t:dir search;
 allow dovecot_t dovecot_cert_t:file { getattr read };
+allow dovecot_t cert_t:dir search;
 
 allow dovecot_t { self proc_t }:file { getattr read };
 allow dovecot_t self:fifo_file rw_file_perms;
@@ -36,11 +43,17 @@
 
 allow dovecot_t tmp_t:dir search;
 rw_dir_file(dovecot_t, mail_spool_t)
+create_dir_file(dovecot_t, dovecot_spool_t)
+create_dir_file(mta_delivery_agent, dovecot_spool_t)
 allow dovecot_t mail_spool_t:lnk_file read;
 allow dovecot_t var_spool_t:dir { search };
 
+#
+# Dovecot auth daemon
+#
 daemon_sub_domain(dovecot_t, dovecot_auth, `, auth_chkpwd')
 allow dovecot_auth_t self:process { fork signal_perms };
+allow dovecot_auth_t self:capability { setgid setuid };
 allow dovecot_auth_t dovecot_t:unix_stream_socket { getattr accept read write ioctl };
 allow dovecot_auth_t self:unix_dgram_socket create_socket_perms;
 allow dovecot_auth_t self:unix_stream_socket create_stream_socket_perms;
@@ -50,6 +63,6 @@
 allow dovecot_auth_t { self proc_t }:file { getattr read };
 read_locale(dovecot_auth_t)
 read_sysctl(dovecot_auth_t)
-allow dovecot_auth_t sysctl_t:dir search;
+allow dovecot_auth_t dovecot_passwd_t:file { getattr read };
 dontaudit dovecot_auth_t selinux_config_t:dir search;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/firstboot.te policy-1.23.3/domains/program/unused/firstboot.te
--- nsapolicy/domains/program/unused/firstboot.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.3/domains/program/unused/firstboot.te	2005-03-19 01:46:00.338925160 -0500
@@ -107,8 +107,10 @@
 
 allow firstboot_t var_run_t:dir getattr;
 allow firstboot_t var_t:dir getattr;
+ifdef(`hostname.te', `
 allow hostname_t devtty_t:chr_file { read write };
 allow hostname_t firstboot_t:fd use;
+')
 ifdef(`iptables.te', `
 allow iptables_t devtty_t:chr_file { read write };
 allow iptables_t firstboot_t:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/games.te policy-1.23.3/domains/program/unused/games.te
--- nsapolicy/domains/program/unused/games.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.3/domains/program/unused/games.te	2005-03-19 01:46:00.354922728 -0500
@@ -13,5 +13,8 @@
 rw_dir_create_file(games_t, games_data_t)
 r_dir_file(initrc_t, games_data_t)
 
+# Run in user_t
+bool disable_games_trans false;
+
 # Everything else is in the x_client_domain macro in
 # macros/program/x_client_macros.te.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mozilla.te policy-1.23.3/domains/program/unused/mozilla.te
--- nsapolicy/domains/program/unused/mozilla.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.3/domains/program/unused/mozilla.te	2005-03-19 01:46:00.355922576 -0500
@@ -14,5 +14,8 @@
 # Allow mozilla to write files in the user home directory
 bool mozilla_writehome false;
 
+# Run in user_t
+bool disable_mozilla_trans false;
+
 # Everything else is in the mozilla_domain macro in
 # macros/program/mozilla_macros.te.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mrtg.te policy-1.23.3/domains/program/unused/mrtg.te
--- nsapolicy/domains/program/unused/mrtg.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.3/domains/program/unused/mrtg.te	2005-03-19 01:46:00.355922576 -0500
@@ -94,5 +94,5 @@
 dontaudit mrtg_t root_t:lnk_file getattr;
 
 allow mrtg_t self:capability { setgid setuid };
-can_exec(mrtg_t, hostname_exec_t)
+ifdef(`hostname.te', `can_exec(mrtg_t, hostname_exec_t)')
 allow mrtg_t var_spool_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mta.te policy-1.23.3/domains/program/unused/mta.te
--- nsapolicy/domains/program/unused/mta.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.3/domains/program/unused/mta.te	2005-03-19 01:46:00.357922272 -0500
@@ -59,15 +59,6 @@
 allow { system_mail_t mta_user_agent } privmail:fifo_file { read write };
 allow { system_mail_t mta_user_agent } admin_tty_type:chr_file { read write };
 
-ifdef(`arpwatch.te', `
-# why is mail delivered to a directory of type arpwatch_data_t?
-allow mta_delivery_agent arpwatch_data_t:dir search;
-allow { system_mail_t mta_user_agent } arpwatch_tmp_t:file rw_file_perms;
-ifdef(`hide_broken_symptoms', `
-dontaudit { system_mail_t mta_user_agent } arpwatch_t:packet_socket { read write };
-')
-')dnl end if arpwatch.te
-
 allow mta_delivery_agent home_root_t:dir { getattr search };
 
 # for /var/spool/mail
@@ -81,4 +72,4 @@
 allow mta_delivery_agent { etc_runtime_t proc_t }:file { getattr read };
 
 allow system_mail_t etc_runtime_t:file { getattr read };
-allow system_mail_t urandom_device_t:chr_file read;
+allow system_mail_t { random_device_t urandom_device_t }:chr_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/dovecot.fc policy-1.23.3/file_contexts/program/dovecot.fc
--- nsapolicy/file_contexts/program/dovecot.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.3/file_contexts/program/dovecot.fc	2005-03-19 01:46:00.357922272 -0500
@@ -1,4 +1,6 @@
 # for Dovecot POP and IMAP server
+/etc/dovecot.conf.*			system_u:object_r:dovecot_etc_t
+/etc/dovecot.passwd.*			system_u:object_r:dovecot_passwd_t
 /usr/sbin/dovecot		--	system_u:object_r:dovecot_exec_t
 ifdef(`distro_redhat', `
 /usr/libexec/dovecot/dovecot-auth --	system_u:object_r:dovecot_auth_exec_t
@@ -10,3 +12,4 @@
 /usr/share/ssl/private/dovecot\.pem --	system_u:object_r:dovecot_cert_t
 /var/run/dovecot(-login)?(/.*)?		system_u:object_r:dovecot_var_run_t
 /usr/lib(64)?/dovecot/.+	--		system_u:object_r:bin_t
+/var/spool/dovecot(/.*)?		system_u:object_r:dovecot_spool_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/games_domain.te policy-1.23.3/macros/program/games_domain.te
--- nsapolicy/macros/program/games_domain.te	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.3/macros/program/games_domain.te	2005-03-19 01:46:00.358922120 -0500
@@ -10,7 +10,23 @@
 #
 #
 define(`games_domain', `
-x_client_domain($1, `games', `, transitionbool')
+
+type $1_games_t, domain, nscd_client_domain;
+
+# Type transition
+if (! disable_games_trans) {
+domain_auto_trans($1_t, games_exec_t, $1_games_t)
+}
+role $1_r types $1_games_t;
+
+# X access, Private tmp
+x_client_domain($1, games)
+tmp_domain($1_games)
+
+# Games seem to need this
+if (allow_execmem) {
+allow $1_games_t self:process execmem;
+}
 
 allow $1_games_t var_t:dir { search getattr };
 rw_dir_create_file($1_games_t, games_data_t)
@@ -29,7 +45,6 @@
 
 dontaudit $1_games_t sysctl_t:dir search;
 
-tmp_domain($1_games)
 allow $1_games_t urandom_device_t:chr_file { getattr ioctl read };
 ifdef(`xdm.te', `
 allow $1_games_t xdm_tmp_t:dir rw_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gift_macros.te policy-1.23.3/macros/program/gift_macros.te
--- nsapolicy/macros/program/gift_macros.te	2005-03-14 14:50:45.000000000 -0500
+++ policy-1.23.3/macros/program/gift_macros.te	2005-03-19 01:46:00.358922120 -0500
@@ -12,20 +12,18 @@
 
 define(`gift_domain', `
 
-# Connect to X
-x_client_domain($1, gift, `')	
-
-# Transition
+# Type transition
+type $1_gift_t, domain, nscd_client_domain;
 domain_auto_trans($1_t, gift_exec_t, $1_gift_t)
-can_exec($1_gift_t, gift_exec_t)
 role $1_r types $1_gift_t;
 
+# X access, Home access
+x_client_domain($1, gift)
+home_domain($1, gift)
+
 # Self permissions
 allow $1_gift_t self:process getsched;
 
-# Home files
-home_domain($1, gift)
-
 # Fonts, icons
 r_dir_file($1_gift_t, usr_t)
 r_dir_file($1_gift_t, fonts_t)
@@ -56,7 +54,7 @@
 
 # giftui looks in .icons, .themes, .fonts-cache.
 dontaudit $1_gift_t $1_home_t:dir { getattr read search };
-dontaudit $1_gift_t $1_home_t:file { getattr read };
+dontaudit $1_gift_t $1_home_t:file { getattr read unlink };
 
 ') dnl gift_domain
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.23.3/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.3/macros/program/mozilla_macros.te	2005-03-19 01:46:00.359921968 -0500
@@ -16,12 +16,16 @@
 # provided separately in domains/program/mozilla.te. 
 #
 define(`mozilla_domain',`
-x_client_domain($1, mozilla, `, web_client_domain, privlog, transitionbool')
+type $1_mozilla_t, domain, web_client_domain, privlog;
 
-# Configuration
-home_domain($1, mozilla)
+# Type transition
+if (! disable_mozilla_trans) {
+domain_auto_trans($1_t, mozilla_exec_t, $1_mozilla_t)
+}
+role $1_r types $1_mozilla_t;
 
-# Allow mozilla to browse files
+home_domain($1, mozilla)
+x_client_domain($1, mozilla)
 file_browse_domain($1_mozilla_t)
 
 allow $1_mozilla_t sound_device_t:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mplayer_macros.te policy-1.23.3/macros/program/mplayer_macros.te
--- nsapolicy/macros/program/mplayer_macros.te	2005-03-15 08:02:24.000000000 -0500
+++ policy-1.23.3/macros/program/mplayer_macros.te	2005-03-19 01:46:00.360921816 -0500
@@ -64,13 +64,15 @@
 
 define(`mplayer_domain',`
 
-# Derive from X client domain
-x_client_domain($1, `mplayer', `')
+type $1_mplayer_t, domain;
 
-# Mplayer configuration here
-home_domain($1, mplayer)
+# Type transition
+domain_auto_trans($1_t, mplayer_exec_t, $1_mplayer_t)
+role $1_r types $1_mplayer_t;
 
-# Allow mplayer to browse files
+# Home access, X access, Browse files
+home_domain($1, mplayer)
+x_client_domain($1, mplayer)
 file_browse_domain($1_mplayer_t)
 
 # Mplayer common stuff
@@ -85,6 +87,9 @@
 # Read home directory content
 r_dir_file($1_mplayer_t, $1_home_t);
 
+# Read CDs
+r_dir_file($1_mplayer_t, removable_t);
+
 # Legacy domain issues
 if (allow_mplayer_execstack) {
 allow $1_mplayer_t $1_mplayer_tmpfs_t:file execute;
@@ -101,12 +106,11 @@
 # FIXME: privhome temporarily removed...
 type $1_mencoder_t, domain;
 
-# Transition
+# Type transition
 domain_auto_trans($1_t, mencoder_exec_t, $1_mencoder_t)
-can_exec($1_mencoder_t, mencoder_exec_t)
 role $1_r types $1_mencoder_t;
 
-# Read home config
+# Access mplayer home domain
 home_domain_access($1_mencoder_t, $1, mplayer)
 
 # Mplayer common stuff
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/screen_macros.te policy-1.23.3/macros/program/screen_macros.te
--- nsapolicy/macros/program/screen_macros.te	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.3/macros/program/screen_macros.te	2005-03-19 01:46:00.360921816 -0500
@@ -21,7 +21,7 @@
 ifdef(`screen.te', `
 define(`screen_domain',`
 # Derived domain based on the calling user domain and the program.
-type $1_screen_t, domain, privlog, privfd;
+type $1_screen_t, domain, privlog, privfd, nscd_client_domain;
 
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, screen_exec_t, $1_screen_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/tvtime_macros.te policy-1.23.3/macros/program/tvtime_macros.te
--- nsapolicy/macros/program/tvtime_macros.te	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.3/macros/program/tvtime_macros.te	2005-03-19 01:46:00.361921664 -0500
@@ -19,16 +19,22 @@
 ifdef(`tvtime.te', `
 define(`tvtime_domain',`
 
+# Type transition
+type $1_tvtime_t, domain, nscd_client_domain;
+domain_auto_trans($1_t, tvtime_exec_t, $1_tvtime_t)
+role $1_r types $1_tvtime_t;
+
+# Home access, X access
 home_domain($1, tvtime)
+tmp_domain($1_tvtime, `', `{ file dir fifo_file }')
 x_client_domain($1, tvtime)
 
 allow $1_tvtime_t urandom_device_t:chr_file read;
 allow $1_tvtime_t clock_device_t:chr_file { ioctl read };
 allow $1_tvtime_t kernel_t:system ipc_info;
-allow $1_tvtime_t sound_device_t:chr_file read;
+allow $1_tvtime_t sound_device_t:chr_file { ioctl read };
 allow $1_tvtime_t $1_home_t:dir { getattr read search };
 allow $1_tvtime_t $1_home_t:file { getattr read };
-tmp_domain($1_tvtime)
 allow $1_tvtime_t self:capability { setuid sys_nice sys_resource };
 allow $1_tvtime_t self:process setsched;
 allow $1_tvtime_t usr_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/x_client_macros.te policy-1.23.3/macros/program/x_client_macros.te
--- nsapolicy/macros/program/x_client_macros.te	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.3/macros/program/x_client_macros.te	2005-03-19 01:46:00.361921664 -0500
@@ -37,39 +37,11 @@
 ')
 
 #
-# x_client_domain(domain_prefix)
+# x_client_domain(user, app)
 #
-# Define a derived domain for an X program when executed by
-# a user domain.  
-#
-# The type declaration for the executable type for this program ($2_exec_t)
-# must be provided separately!
-#
-# The first parameter is the base name for the domain/role (EG user or sysadm)
-# The second parameter is the program name (EG $2)
-# The third parameter is the attributes for the domain (if any)
+# Defines common X access rules for the user_app_t domain
 #
 define(`x_client_domain',`
-# Derived domain based on the calling user domain and the program.
-type $1_$2_t, domain, nscd_client_domain $3;
-
-ifelse(index(`$3', `transitionbool'), -1, `
-domain_auto_trans($1_t, $2_exec_t, $1_$2_t)
-can_exec($1_$2_t, $2_exec_t)
-', `
-# Only do it once
-ifelse($1, user, `
-bool disable_$2 false;
-')
-# Transition from the user domain to the derived domain.
-if (! disable_$2) {
-domain_auto_trans($1_t, $2_exec_t, $1_$2_t)
-can_exec($1_$2_t, $2_exec_t)
-}
-')
-
-# The user role is authorized for this domain.
-role $1_r types $1_$2_t;
 
 # This domain is granted permissions common to most domains (including can_net)
 can_network($1_$2_t)
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.23.3/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.3/tunables/distro.tun	2005-03-19 01:46:00.362921512 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.23.3/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.3/tunables/tunable.tun	2005-03-19 01:46:00.362921512 -0500
@@ -1,27 +1,27 @@
 # Allow users to execute the mount command
-dnl define(`user_can_mount')
+define(`user_can_mount')
 
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

--------------060103000707060607060406--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
