Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lB3JXmZd032232
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2007 14:33:50 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lB3JXhjY019607
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2007 19:33:44 GMT
Message-ID: <47545A14.3060602@redhat.com>
Date: Mon, 03 Dec 2007 14:33:40 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Many confined domains are calling getpw calls.
Content-Type: multipart/mixed;
 boundary="------------000501060408000501090908"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000501060408000501090908
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This causes these confined domains to require auth_use_nsswitch.

I have searched through and cleaned up a lot of policy using this method.

Extracted from my massive patch for easier application.


Dan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHVFoUrlYvE4MpobMRAr4fAJ9QdJU7PpmotY/o8skiDiihFnr1SQCfeeis
OCqkTaMwp82kcRomOtUNmIM=
=PZjy
-----END PGP SIGNATURE-----

--------------000501060408000501090908
Content-Type: text/x-patch;
 name="policy-nsswitch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-nsswitch.patch"

diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/rpm.te serefpolicy-3.2.1/policy/modules/admin/rpm.te
--- nsaserefpolicy/policy/modules/admin/rpm.te	2007-10-12 08:56:09.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/admin/rpm.te	2007-11-29 14:42:59.000000000 -0500
@@ -139,6 +139,7 @@
 auth_relabel_all_files_except_shadow(rpm_t)
 auth_manage_all_files_except_shadow(rpm_t)
 auth_dontaudit_read_shadow(rpm_t)
+auth_use_nsswitch(rpm_t)
 
 # transition to rpm script:
 rpm_domtrans_script(rpm_t)
@@ -171,8 +172,6 @@
 seutil_manage_src_policy(rpm_t)
 seutil_manage_bin_policy(rpm_t)
 
-sysnet_read_config(rpm_t)
-
 userdom_use_unpriv_users_fds(rpm_t)
 
 optional_policy(`
@@ -184,10 +183,6 @@
 ')
 
 optional_policy(`
-	nis_use_ypbind(rpm_t)
-')
-
-optional_policy(`
 	prelink_domtrans(rpm_t)
 ')
 
@@ -289,6 +284,7 @@
 auth_dontaudit_getattr_shadow(rpm_script_t)
 # ideally we would not need this
 auth_manage_all_files_except_shadow(rpm_script_t)
+auth_use_nsswitch(rpm_script_t)
 
 corecmd_exec_all_executables(rpm_script_t)
 
@@ -339,10 +335,6 @@
 ')
 
 optional_policy(`
-	nis_use_ypbind(rpm_script_t)
-')
-
-optional_policy(`
 	tzdata_domtrans(rpm_t)
 	tzdata_domtrans(rpm_script_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/sudo.if serefpolicy-3.2.1/policy/modules/admin/sudo.if
--- nsaserefpolicy/policy/modules/admin/sudo.if	2007-07-23 10:20:14.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/admin/sudo.if	2007-11-29 14:44:03.000000000 -0500
@@ -69,7 +69,6 @@
 	allow $1_sudo_t self:unix_dgram_socket sendto;
 	allow $1_sudo_t self:unix_stream_socket connectto;
 	allow $1_sudo_t self:netlink_audit_socket { create bind write nlmsg_read read };
-	allow $1_sudo_t self:netlink_route_socket r_netlink_socket_perms;
 
 	# Enter this derived domain from the user domain
 	domtrans_pattern($2, sudo_exec_t, $1_sudo_t)
@@ -92,6 +91,7 @@
 	auth_domtrans_chk_passwd($1_sudo_t)
 	# sudo stores a token in the pam_pid directory
 	auth_manage_pam_pid($1_sudo_t)
+	auth_use_nsswitch($1_sudo_t)
 
 	corecmd_read_bin_symlinks($1_sudo_t)
 	corecmd_getattr_all_executables($1_sudo_t)
@@ -125,14 +125,6 @@
 	# for some PAM modules and for cwd
 	userdom_dontaudit_search_all_users_home_content($1_sudo_t)
 
-	optional_policy(`
-		nis_use_ypbind($1_sudo_t)
-	')
-
-	optional_policy(`
-		nscd_socket_use($1_sudo_t)
-	')
-
 	ifdef(`TODO',`
 	# for when the network connection is killed
 	dontaudit unpriv_userdomain $1_sudo_t:process signal;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/admin/usermanage.te serefpolicy-3.2.1/policy/modules/admin/usermanage.te
--- nsaserefpolicy/policy/modules/admin/usermanage.te	2007-10-23 07:37:52.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/admin/usermanage.te	2007-11-29 14:46:29.000000000 -0500
@@ -93,6 +93,7 @@
 
 auth_domtrans_chk_passwd(chfn_t)
 auth_dontaudit_read_shadow(chfn_t)
+auth_use_nsswitch(chfn_t)
 
 # allow checking if a shell is executable
 corecmd_check_exec_shell(chfn_t)
@@ -123,14 +124,6 @@
 # on user home dir
 userdom_dontaudit_search_all_users_home_content(chfn_t)
 
-optional_policy(`
-	nis_use_ypbind(chfn_t)
-')
-
-optional_policy(`
-	nscd_socket_use(chfn_t)
-')
-
 ########################################
 #
 # Crack local policy
@@ -300,6 +293,7 @@
 auth_manage_shadow(passwd_t)
 auth_relabel_shadow(passwd_t)
 auth_etc_filetrans_shadow(passwd_t)
+auth_use_nsswitch(passwd_t)
 
 # allow checking if a shell is executable
 corecmd_check_exec_shell(passwd_t)
@@ -335,11 +329,6 @@
 userdom_dontaudit_search_all_users_home_content(passwd_t)
 
 optional_policy(`
-	nis_use_ypbind(passwd_t)
-')
-
-optional_policy(`
-	nscd_socket_use(passwd_t)
 	nscd_domtrans(passwd_t)
 ')
 
@@ -393,6 +382,7 @@
 auth_manage_shadow(sysadm_passwd_t)
 auth_relabel_shadow(sysadm_passwd_t)
 auth_etc_filetrans_shadow(sysadm_passwd_t)
+auth_use_nsswitch(sysadm_passwd_t)
 
 # allow vipw to exec the editor
 corecmd_exec_bin(sysadm_passwd_t)
@@ -426,11 +416,6 @@
 userdom_dontaudit_search_all_users_home_content(sysadm_passwd_t)
 
 optional_policy(`
-	nis_use_ypbind(sysadm_passwd_t)
-')
-
-optional_policy(`
-	nscd_socket_use(sysadm_passwd_t)
 	nscd_domtrans(sysadm_passwd_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/apache.te serefpolicy-3.2.1/policy/modules/services/apache.te
--- nsaserefpolicy/policy/modules/services/apache.te	2007-11-29 13:29:35.000000000 -0500
+++ serefpolicy-3.2.1/policy/modules/services/apache.te	2007-11-29 14:48:53.000000000 -0500
@@ -346,8 +346,6 @@
 
 seutil_dontaudit_search_config(httpd_t)
 
-sysnet_read_config(httpd_t)
-
 userdom_use_unpriv_users_fds(httpd_t)
 
 mta_send_mail(httpd_t)
@@ -571,7 +569,6 @@
 allow httpd_suexec_t self:capability { setuid setgid };
 allow httpd_suexec_t self:process signal_perms;
 allow httpd_suexec_t self:unix_stream_socket create_stream_socket_perms;
-allow httpd_suexec_t self:netlink_route_socket r_netlink_socket_perms;
 
 domtrans_pattern(httpd_t, httpd_suexec_exec_t, httpd_suexec_t)
 
@@ -602,6 +599,8 @@
 files_dontaudit_search_pids(httpd_suexec_t)
 files_search_home(httpd_suexec_t)
 
+auth_use_nsswitch(httpd_suexec_t)
+
 libs_use_ld_so(httpd_suexec_t)
 libs_use_shared_libs(httpd_suexec_t)
 
@@ -624,8 +623,6 @@
 	corenet_udp_sendrecv_all_ports(httpd_suexec_t)
 	corenet_tcp_connect_all_ports(httpd_suexec_t)
 	corenet_sendrecv_all_client_packets(httpd_suexec_t)
-
-	sysnet_read_config(httpd_suexec_t)
 ')
 
 tunable_policy(`httpd_enable_cgi && httpd_unified',`
@@ -659,14 +656,6 @@
 	nagios_domtrans_cgi(httpd_suexec_t)
 ')
 
-optional_policy(`
-	nis_use_ypbind(httpd_suexec_t)
-')
-
-optional_policy(`
-	nscd_socket_use(httpd_suexec_t)
-')
-
 ########################################
 #
 # Apache system script local policy
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/comsat.te serefpolicy-3.2.1/policy/modules/services/comsat.te
--- nsaserefpolicy/policy/modules/services/comsat.te	2007-07-16 14:09:46.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/comsat.te	2007-11-29 14:49:43.000000000 -0500
@@ -57,6 +57,8 @@
 files_search_spool(comsat_t)
 files_search_home(comsat_t)
 
+auth_use_nsswitch(comsat_t)
+
 init_read_utmp(comsat_t)
 init_dontaudit_write_utmp(comsat_t)
 
@@ -67,8 +69,6 @@
 
 miscfiles_read_localization(comsat_t)
 
-sysnet_read_config(comsat_t)
-
 userdom_dontaudit_getattr_sysadm_ttys(comsat_t)
 
 mta_getattr_spool(comsat_t)
@@ -77,10 +77,3 @@
 	kerberos_use(comsat_t)
 ')
 
-optional_policy(`
-	nis_use_ypbind(comsat_t)
-')
-
-optional_policy(`
-	nscd_socket_use(comsat_t)
-')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/consolekit.te serefpolicy-3.2.1/policy/modules/services/consolekit.te
--- nsaserefpolicy/policy/modules/services/consolekit.te	2007-10-29 07:52:49.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/consolekit.te	2007-11-29 14:50:47.000000000 -0500
@@ -10,7 +10,6 @@
 type consolekit_exec_t;
 init_daemon_domain(consolekit_t, consolekit_exec_t)
 
-# pid files
 type consolekit_var_run_t;
 files_pid_file(consolekit_var_run_t)
 
@@ -25,7 +24,6 @@
 allow consolekit_t self:unix_stream_socket create_stream_socket_perms;
 allow consolekit_t self:unix_dgram_socket create_socket_perms;
 
-# pid file
 manage_files_pattern(consolekit_t,consolekit_var_run_t,consolekit_var_run_t)
 files_pid_filetrans(consolekit_t,consolekit_var_run_t, file)
 
@@ -47,6 +45,8 @@
 
 term_use_all_terms(consolekit_t)
 
+auth_use_nsswitch(consolekit_t)
+
 libs_use_ld_so(consolekit_t)
 libs_use_shared_libs(consolekit_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cron.te serefpolicy-3.2.1/policy/modules/services/cron.te
--- nsaserefpolicy/policy/modules/services/cron.te	2007-10-12 08:56:07.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/cron.te	2007-11-29 14:52:23.000000000 -0500
@@ -143,6 +143,8 @@
 
 init_rw_utmp(crond_t)
 
+auth_use_nsswitch(crond_t)
+
 libs_use_ld_so(crond_t)
 libs_use_shared_libs(crond_t)
 
@@ -198,14 +200,6 @@
 ')
 
 optional_policy(`
-	nis_use_ypbind(crond_t)
-')
-
-optional_policy(`
-	nscd_socket_use(crond_t)
-')
-
-optional_policy(`
 	# Commonly used from postinst scripts
 	rpm_read_pipes(crond_t)
 ')
@@ -328,6 +322,8 @@
 # prelink tells init to restart it self, we either need to allow or dontaudit
 init_write_initctl(system_crond_t)
 
+auth_use_nsswitch(system_crond_t)
+
 libs_use_ld_so(system_crond_t)
 libs_use_shared_libs(system_crond_t)
 libs_exec_lib_files(system_crond_t)
@@ -396,14 +392,6 @@
 ')
 
 optional_policy(`
-	nis_use_ypbind(system_crond_t)
-')
-
-optional_policy(`
-	nscd_socket_use(system_crond_t)
-')
-
-optional_policy(`
 	postfix_read_config(system_crond_t)
 ')	
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cups.te serefpolicy-3.2.1/policy/modules/services/cups.te
--- nsaserefpolicy/policy/modules/services/cups.te	2007-11-16 15:30:49.000000000 -0500
+++ serefpolicy-3.2.1/policy/modules/services/cups.te	2007-11-29 14:56:39.000000000 -0500
@@ -86,7 +86,6 @@
 allow cupsd_t self:unix_stream_socket { create_stream_socket_perms connectto };
 allow cupsd_t self:unix_dgram_socket create_socket_perms;
 allow cupsd_t self:netlink_selinux_socket create_socket_perms;
-allow cupsd_t self:netlink_route_socket r_netlink_socket_perms;
 allow cupsd_t self:tcp_socket create_stream_socket_perms;
 allow cupsd_t self:udp_socket create_socket_perms;
 allow cupsd_t self:appletalk_socket create_socket_perms;
@@ -205,6 +204,8 @@
 
 init_exec_script_files(cupsd_t)
 
+auth_use_nsswitch(cupsd_t)
+
 libs_use_ld_so(cupsd_t)
 libs_use_shared_libs(cupsd_t)
 # Read /usr/lib/gconv/gconv-modules.* and /usr/lib/python2.2/.*
@@ -262,10 +263,6 @@
 ')
 
 optional_policy(`
-	nscd_socket_use(cupsd_t)
-')
-
-optional_policy(`
 	# cups execs smbtool which reads samba_etc_t files
 	samba_read_config(cupsd_t)
 	samba_rw_var_files(cupsd_t)
@@ -291,7 +288,6 @@
 allow cupsd_config_t self:unix_stream_socket create_socket_perms;
 allow cupsd_config_t self:unix_dgram_socket create_socket_perms;
 allow cupsd_config_t self:tcp_socket create_stream_socket_perms;
-allow cupsd_config_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow cupsd_config_t cupsd_t:process signal;
 ps_process_pattern(cupsd_config_t,cupsd_t)
@@ -349,6 +345,8 @@
 # Alternatives asks for this
 init_getattr_script_files(cupsd_config_t)
 
+auth_use_nsswitch(cupsd_config_t)
+
 libs_use_ld_so(cupsd_config_t)
 libs_use_shared_libs(cupsd_config_t)
 
@@ -358,8 +356,6 @@
 
 seutil_dontaudit_search_config(cupsd_config_t)
 
-sysnet_read_config(cupsd_config_t)
-
 userdom_dontaudit_use_unpriv_user_fds(cupsd_config_t)
 userdom_dontaudit_search_sysadm_home_dirs(cupsd_config_t)
 
@@ -402,14 +398,6 @@
 ')
 
 optional_policy(`
-	nis_use_ypbind(cupsd_config_t)
-')
-
-optional_policy(`
-	nscd_socket_use(cupsd_config_t)
-')
-
-optional_policy(`
 	rpm_read_db(cupsd_config_t)
 ')
 
@@ -430,7 +418,6 @@
 allow cupsd_lpd_t self:fifo_file rw_fifo_file_perms;
 allow cupsd_lpd_t self:tcp_socket connected_stream_socket_perms;
 allow cupsd_lpd_t self:udp_socket create_socket_perms;
-allow cupsd_lpd_t self:netlink_route_socket r_netlink_socket_perms;
 
 # for identd
 # cjp: this should probably only be inetd_child rules?
@@ -480,6 +467,8 @@
 
 files_read_etc_files(cupsd_lpd_t)
 
+auth_use_nsswitch(cupsd_lpd_t)
+
 libs_use_ld_so(cupsd_lpd_t)
 libs_use_shared_libs(cupsd_lpd_t)
 
@@ -487,22 +476,12 @@
 
 miscfiles_read_localization(cupsd_lpd_t)
 
-sysnet_read_config(cupsd_lpd_t)
-
 cups_stream_connect(cupsd_lpd_t)
 
 optional_policy(`
 	inetd_service_domain(cupsd_lpd_t,cupsd_lpd_exec_t)
 ')
 
-optional_policy(`
-	nis_use_ypbind(cupsd_lpd_t)
-')
-
-optional_policy(`
-	nscd_socket_use(cupsd_lpd_t)
-')
-
 ########################################
 #
 # HPLIP local policy
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/cyrus.te serefpolicy-3.2.1/policy/modules/services/cyrus.te
--- nsaserefpolicy/policy/modules/services/cyrus.te	2007-10-12 08:56:07.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/cyrus.te	2007-11-29 14:57:57.000000000 -0500
@@ -41,7 +41,6 @@
 allow cyrus_t self:unix_stream_socket connectto;
 allow cyrus_t self:tcp_socket create_stream_socket_perms;
 allow cyrus_t self:udp_socket create_socket_perms;
-allow cyrus_t self:netlink_route_socket r_netlink_socket_perms;
 
 manage_dirs_pattern(cyrus_t,cyrus_tmp_t,cyrus_tmp_t)
 manage_files_pattern(cyrus_t,cyrus_tmp_t,cyrus_tmp_t)
@@ -95,6 +94,8 @@
 files_read_etc_runtime_files(cyrus_t)
 files_read_usr_files(cyrus_t)
 
+auth_use_nsswitch(cyrus_t)
+
 libs_use_ld_so(cyrus_t)
 libs_use_shared_libs(cyrus_t)
 libs_exec_lib_files(cyrus_t)
@@ -122,14 +123,6 @@
 ')
 
 optional_policy(`
-	ldap_stream_connect(cyrus_t)
-')
-
-optional_policy(`
-	nis_use_ypbind(cyrus_t)
-')
-
-optional_policy(`
 	sasl_connect(cyrus_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dbskk.te serefpolicy-3.2.1/policy/modules/services/dbskk.te
--- nsaserefpolicy/policy/modules/services/dbskk.te	2007-07-16 14:09:46.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/dbskk.te	2007-11-29 14:57:33.000000000 -0500
@@ -63,6 +63,8 @@
 
 files_read_etc_files(dbskkd_t)
 
+auth_use_nsswitch(dbskkd_t)
+
 libs_use_ld_so(dbskkd_t)
 libs_use_shared_libs(dbskkd_t)
 
@@ -70,12 +72,3 @@
 
 miscfiles_read_localization(dbskkd_t)
 
-sysnet_read_config(dbskkd_t)
-
-optional_policy(`
-	nis_use_ypbind(dbskkd_t)
-')
-
-optional_policy(`
-	nscd_socket_use(dbskkd_t)
-')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dbus.if serefpolicy-3.2.1/policy/modules/services/dbus.if
--- nsaserefpolicy/policy/modules/services/dbus.if	2007-10-29 07:52:49.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/dbus.if	2007-11-29 14:59:12.000000000 -0500
@@ -148,6 +148,7 @@
 	selinux_compute_user_contexts($1_dbusd_t)
 
 	auth_read_pam_console_data($1_dbusd_t)
+	auth_use_nsswitch($1_dbusd_t)
 
 	libs_use_ld_so($1_dbusd_t)
 	libs_use_shared_libs($1_dbusd_t)
@@ -160,8 +161,6 @@
 	seutil_read_config($1_dbusd_t)
 	seutil_read_default_contexts($1_dbusd_t)
 
-	sysnet_read_config($1_dbusd_t)
-
 	userdom_read_user_home_content_files($1, $1_dbusd_t)
 
 	ifdef(`hide_broken_symptoms', `
@@ -181,10 +180,6 @@
 	')
 
 	optional_policy(`
-		nscd_socket_use($1_dbusd_t)
-	')
-
-	optional_policy(`
 		xserver_use_xdm_fds($1_dbusd_t)
 		xserver_rw_xdm_pipes($1_dbusd_t)
 	')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/dovecot.te serefpolicy-3.2.1/policy/modules/services/dovecot.te
--- nsaserefpolicy/policy/modules/services/dovecot.te	2007-10-12 08:56:07.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/dovecot.te	2007-11-29 15:01:31.000000000 -0500
@@ -46,7 +46,6 @@
 allow dovecot_t self:tcp_socket create_stream_socket_perms;
 allow dovecot_t self:unix_dgram_socket create_socket_perms;
 allow dovecot_t self:unix_stream_socket { create_stream_socket_perms connectto };
-allow dovecot_t self:netlink_route_socket r_netlink_socket_perms;
 
 domtrans_pattern(dovecot_t, dovecot_auth_exec_t, dovecot_auth_t)
 
@@ -103,6 +102,8 @@
 
 init_getattr_utmp(dovecot_t)
 
+auth_use_nsswitch(dovecot_t)
+
 libs_use_ld_so(dovecot_t)
 libs_use_shared_libs(dovecot_t)
 
@@ -111,9 +112,6 @@
 miscfiles_read_certs(dovecot_t)
 miscfiles_read_localization(dovecot_t)
 
-sysnet_read_config(dovecot_t)
-sysnet_use_ldap(dovecot_auth_t)
-
 userdom_dontaudit_use_unpriv_user_fds(dovecot_t)
 userdom_dontaudit_search_sysadm_home_dirs(dovecot_t)
 userdom_priveleged_home_dir_manager(dovecot_t)
@@ -125,10 +123,6 @@
 ')
 
 optional_policy(`
-	nis_use_ypbind(dovecot_t)
-')
-
-optional_policy(`
 	seutil_sigchld_newrole(dovecot_t)
 ')
 
@@ -185,8 +179,6 @@
 
 seutil_dontaudit_search_config(dovecot_auth_t)
 
-sysnet_dns_name_resolve(dovecot_auth_t)
-
 optional_policy(`
 	kerberos_use(dovecot_auth_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ldap.te serefpolicy-3.2.1/policy/modules/services/ldap.te
--- nsaserefpolicy/policy/modules/services/ldap.te	2007-10-12 08:56:07.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/ldap.te	2007-11-29 15:02:48.000000000 -0500
@@ -42,7 +42,6 @@
 dontaudit slapd_t self:capability sys_tty_config;
 allow slapd_t self:process setsched;
 allow slapd_t self:fifo_file { read write };
-allow slapd_t self:netlink_route_socket r_netlink_socket_perms;
 allow slapd_t self:udp_socket create_socket_perms;
 #slapd needs to listen and accept needed by ldapsearch (slapd needs to accept from ldapseach)
 allow slapd_t self:tcp_socket create_stream_socket_perms;
@@ -104,6 +103,8 @@
 files_read_usr_files(slapd_t)
 files_list_var_lib(slapd_t)
 
+auth_use_nsswitch(slapd_t)
+
 libs_use_ld_so(slapd_t)
 libs_use_shared_libs(slapd_t)
 
@@ -112,8 +113,6 @@
 miscfiles_read_certs(slapd_t)
 miscfiles_read_localization(slapd_t)
 
-sysnet_read_config(slapd_t)
-
 userdom_dontaudit_use_unpriv_user_fds(slapd_t)
 userdom_dontaudit_search_sysadm_home_dirs(slapd_t)
 
@@ -122,10 +121,6 @@
 ')
 
 optional_policy(`
-	nis_use_ypbind(slapd_t)
-')
-
-optional_policy(`
 	seutil_sigchld_newrole(slapd_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/mailman.if serefpolicy-3.2.1/policy/modules/services/mailman.if
--- nsaserefpolicy/policy/modules/services/mailman.if	2007-07-16 14:09:46.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/mailman.if	2007-11-29 15:04:56.000000000 -0500
@@ -74,6 +74,8 @@
 	files_read_var_lib_symlinks(mailman_$1_t)
 	files_read_etc_runtime_files(mailman_$1_t)
 
+	auth_use_nsswitch(mailman_$1_t)
+
 	libs_use_ld_so(mailman_$1_t)
 	libs_use_shared_libs(mailman_$1_t)
 	libs_exec_ld_so(mailman_$1_t)
@@ -82,12 +84,6 @@
 	logging_send_syslog_msg(mailman_$1_t)
 
 	miscfiles_read_localization(mailman_$1_t)
-
-	sysnet_read_config(mailman_$1_t)
-
-	optional_policy(`
-		nis_use_ypbind(mailman_$1_t)
-	')
 ')
 
 #######################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/mailman.te serefpolicy-3.2.1/policy/modules/services/mailman.te
--- nsaserefpolicy/policy/modules/services/mailman.te	2007-07-10 13:21:26.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/mailman.te	2007-11-29 15:05:44.000000000 -0500
@@ -36,8 +36,6 @@
 # to global scope until such facilities exist.
 
 optional_policy(`
-	allow mailman_cgi_t self:netlink_route_socket r_netlink_socket_perms;
-
 	dev_read_urand(mailman_cgi_t)
 
 	manage_dirs_pattern(mailman_cgi_t,mailman_archive_t,mailman_archive_t)
@@ -87,7 +85,6 @@
 allow mailman_queue_t self:process signal;
 allow mailman_queue_t self:fifo_file rw_fifo_file_perms;
 allow mailman_queue_t self:unix_dgram_socket create_socket_perms;
-allow mailman_queue_t self:netlink_route_socket r_netlink_socket_perms;
 
 manage_dirs_pattern(mailman_queue_t,mailman_archive_t,mailman_archive_t)
 manage_files_pattern(mailman_queue_t,mailman_archive_t,mailman_archive_t)
@@ -113,6 +110,3 @@
 	cron_system_entry(mailman_queue_t,mailman_queue_exec_t)
 ')
 
-optional_policy(`
-	nscd_socket_use(mailman_queue_t)
-')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/nagios.te serefpolicy-3.2.1/policy/modules/services/nagios.te
--- nsaserefpolicy/policy/modules/services/nagios.te	2007-10-12 08:56:07.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/nagios.te	2007-11-29 15:06:34.000000000 -0500
@@ -93,6 +93,8 @@
 # for who
 init_read_utmp(nagios_t)
 
+auth_use_nsswitch(nagios_t)
+
 libs_use_ld_so(nagios_t)
 libs_use_shared_libs(nagios_t)
 
@@ -106,10 +108,6 @@
 mta_send_mail(nagios_t)
 
 optional_policy(`
-	auth_use_nsswitch(nagios_t)
-')
-
-optional_policy(`
 	netutils_domtrans_ping(nagios_t)
 	netutils_signal_ping(nagios_t)
 	netutils_kill_ping(nagios_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/ntp.te serefpolicy-3.2.1/policy/modules/services/ntp.te
--- nsaserefpolicy/policy/modules/services/ntp.te	2007-10-12 08:56:07.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/ntp.te	2007-11-29 15:07:31.000000000 -0500
@@ -105,8 +105,6 @@
 
 miscfiles_read_localization(ntpd_t)
 
-sysnet_read_config(ntpd_t)
-
 userdom_dontaudit_use_unpriv_user_fds(ntpd_t)
 userdom_list_sysadm_home_dirs(ntpd_t)
 userdom_dontaudit_list_sysadm_home_dirs(ntpd_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/postfix.if serefpolicy-3.2.1/policy/modules/services/postfix.if
--- nsaserefpolicy/policy/modules/services/postfix.if	2007-10-12 08:56:07.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/postfix.if	2007-11-29 15:08:32.000000000 -0500
@@ -83,6 +83,8 @@
 	init_dontaudit_use_fds(postfix_$1_t)
 	init_sigchld(postfix_$1_t)
 
+	auth_use_nsswitch(postfix_$1_t)
+
 	libs_use_ld_so(postfix_$1_t)
 	libs_use_shared_libs(postfix_$1_t)
 
@@ -94,10 +96,6 @@
 	userdom_dontaudit_use_unpriv_user_fds(postfix_$1_t)
 
 	optional_policy(`
-		nscd_socket_use(postfix_$1_t)
-	')
-
-	optional_policy(`
 		udev_read_db(postfix_$1_t)
 	')
 ')
@@ -134,10 +132,6 @@
 	corenet_udp_bind_all_nodes(postfix_$1_t)
 	corenet_tcp_connect_all_ports(postfix_$1_t)
 	corenet_sendrecv_all_client_packets(postfix_$1_t)
-
-	optional_policy(`
-		auth_use_nsswitch(postfix_$1_t)
-	')
 ')
 
 ########################################
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/postfix.te serefpolicy-3.2.1/policy/modules/services/postfix.te
--- nsaserefpolicy/policy/modules/services/postfix.te	2007-11-08 09:29:27.000000000 -0500
+++ serefpolicy-3.2.1/policy/modules/services/postfix.te	2007-11-29 15:09:46.000000000 -0500
@@ -172,15 +172,10 @@
 # postfix does a "find" on startup for some reason - keep it quiet
 seutil_dontaudit_search_config(postfix_master_t)
 
-sysnet_read_config(postfix_master_t)
-
 mta_rw_aliases(postfix_master_t)
 mta_read_sendmail_bin(postfix_master_t)
 
 optional_policy(`
-	auth_use_nsswitch(postfix_master_t)
-')
-optional_policy(`
 	cyrus_stream_connect(postfix_master_t)
 ')
 
@@ -351,8 +346,6 @@
 
 seutil_read_config(postfix_map_t)
 
-sysnet_read_config(postfix_map_t)
-
 tunable_policy(`read_default_t',`
 	files_list_default(postfix_map_t)
 	files_read_default_files(postfix_map_t)
@@ -365,10 +358,6 @@
 	locallogin_dontaudit_use_fds(postfix_map_t)
 ')
 
-optional_policy(`
-	nscd_socket_use(postfix_map_t)
-')
-
 ########################################
 #
 # Postfix pickup local policy
@@ -433,8 +422,6 @@
 term_dontaudit_use_all_user_ptys(postfix_postdrop_t)
 term_dontaudit_use_all_user_ttys(postfix_postdrop_t)
 
-sysnet_dns_name_resolve(postfix_postdrop_t)
-
 mta_rw_user_mail_stream_sockets(postfix_postdrop_t)
 
 optional_policy(`
@@ -474,8 +461,6 @@
 init_sigchld_script(postfix_postqueue_t)
 init_use_script_fds(postfix_postqueue_t)
 
-sysnet_dontaudit_read_config(postfix_postqueue_t)
-
 ########################################
 #
 # Postfix qmgr local policy
@@ -518,8 +503,6 @@
 term_use_all_user_ptys(postfix_showq_t)
 term_use_all_user_ttys(postfix_showq_t)
 
-sysnet_dns_name_resolve(postfix_showq_t)
-
 ########################################
 #
 # Postfix smtp delivery local policy
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rlogin.te serefpolicy-3.2.1/policy/modules/services/rlogin.te
--- nsaserefpolicy/policy/modules/services/rlogin.te	2007-10-02 09:54:52.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/rlogin.te	2007-11-29 15:10:52.000000000 -0500
@@ -84,8 +84,6 @@
 
 seutil_dontaudit_search_config(rlogind_t)
 
-sysnet_read_config(rlogind_t)
-
 userdom_setattr_unpriv_users_ptys(rlogind_t)
 # cjp: this is egregious
 userdom_read_all_users_home_content_files(rlogind_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rpc.if serefpolicy-3.2.1/policy/modules/services/rpc.if
--- nsaserefpolicy/policy/modules/services/rpc.if	2007-10-12 08:56:07.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/rpc.if	2007-11-29 15:13:40.000000000 -0500
@@ -53,7 +53,6 @@
 	allow $1_t self:process signal_perms;
 	allow $1_t self:unix_dgram_socket create_socket_perms;
 	allow $1_t self:unix_stream_socket create_stream_socket_perms;
-	allow $1_t self:netlink_route_socket r_netlink_socket_perms;
 	allow $1_t self:tcp_socket create_stream_socket_perms;
 	allow $1_t self:udp_socket create_socket_perms;
 
@@ -100,6 +99,7 @@
 	files_search_var($1_t)
 	files_search_var_lib($1_t)
 
+	auth_use_nsswitch($1_t)
 	libs_use_ld_so($1_t)
 	libs_use_shared_libs($1_t)
 
@@ -107,16 +107,9 @@
 
 	miscfiles_read_localization($1_t)
 
-	sysnet_dns_name_resolve($1_t)
-	sysnet_read_config($1_t)
-
 	userdom_dontaudit_use_unpriv_user_fds($1_t)
 
 	optional_policy(`
-		nis_use_ypbind($1_t)
-	')
-
-	optional_policy(`
 		seutil_sigchld_newrole($1_t)
 	')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rsync.te serefpolicy-3.2.1/policy/modules/services/rsync.te
--- nsaserefpolicy/policy/modules/services/rsync.te	2007-11-16 13:45:14.000000000 -0500
+++ serefpolicy-3.2.1/policy/modules/services/rsync.te	2007-11-29 15:15:09.000000000 -0500
@@ -65,8 +65,6 @@
 manage_files_pattern(rsync_t,rsync_var_run_t,rsync_var_run_t)
 files_pid_filetrans(rsync_t,rsync_var_run_t,file)
 
-auth_use_nsswitch(rsync_t)
-
 kernel_read_kernel_sysctls(rsync_t)
 kernel_read_system_state(rsync_t)
 kernel_read_network_state(rsync_t)
@@ -90,6 +88,8 @@
 files_read_etc_files(rsync_t)
 files_search_home(rsync_t)
 
+auth_use_nsswitch(rsync_t)
+
 libs_use_ld_so(rsync_t)
 libs_use_shared_libs(rsync_t)
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/samba.te serefpolicy-3.2.1/policy/modules/services/samba.te
--- nsaserefpolicy/policy/modules/services/samba.te	2007-10-12 08:56:07.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/samba.te	2007-11-29 15:18:33.000000000 -0500
@@ -146,7 +146,6 @@
 allow samba_net_t self:unix_stream_socket create_stream_socket_perms;
 allow samba_net_t self:udp_socket create_socket_perms;
 allow samba_net_t self:tcp_socket create_socket_perms;
-allow samba_net_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow samba_net_t samba_etc_t:file read_file_perms;
 
@@ -183,6 +182,8 @@
 
 files_read_etc_files(samba_net_t)
 
+auth_use_nsswitch(samba_net_t)
+
 libs_use_ld_so(samba_net_t)
 libs_use_shared_libs(samba_net_t)
 
@@ -190,9 +191,6 @@
 
 miscfiles_read_localization(samba_net_t) 
 
-sysnet_read_config(samba_net_t)
-sysnet_use_ldap(samba_net_t)
-
 userdom_dontaudit_search_sysadm_home_dirs(samba_net_t)
 
 optional_policy(`
@@ -222,7 +220,6 @@
 allow smbd_t self:udp_socket create_socket_perms;
 allow smbd_t self:unix_dgram_socket { create_socket_perms sendto };
 allow smbd_t self:unix_stream_socket { create_stream_socket_perms connectto };
-allow smbd_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow smbd_t samba_etc_t:file { rw_file_perms setattr };
 
@@ -321,8 +318,6 @@
 miscfiles_read_localization(smbd_t)
 miscfiles_read_public_files(smbd_t)
 
-sysnet_read_config(smbd_t)
-
 userdom_dontaudit_search_sysadm_home_dirs(smbd_t)
 userdom_dontaudit_use_unpriv_user_fds(smbd_t)
 userdom_use_unpriv_users_fds(smbd_t)
@@ -454,6 +449,8 @@
 files_read_etc_files(nmbd_t)
 files_list_var_lib(nmbd_t)
 
+auth_use_nsswitch(nmbd_t)
+
 libs_use_ld_so(nmbd_t)
 libs_use_shared_libs(nmbd_t)
 
@@ -462,17 +459,11 @@
 
 miscfiles_read_localization(nmbd_t)
 
-sysnet_read_config(nmbd_t)
-
 userdom_dontaudit_search_sysadm_home_dirs(nmbd_t)
 userdom_dontaudit_use_unpriv_user_fds(nmbd_t)
 userdom_use_unpriv_users_fds(nmbd_t)
 
 optional_policy(`
-	nis_use_ypbind(nmbd_t)
-')
-
-optional_policy(`
 	seutil_sigchld_newrole(nmbd_t)
 ')
 
@@ -542,6 +533,8 @@
 files_etc_filetrans_etc_runtime(smbmount_t,file)
 files_read_etc_files(smbmount_t)
 
+auth_use_nsswitch(smbmount_t)
+
 miscfiles_read_localization(smbmount_t)
 
 mount_use_fds(smbmount_t)
@@ -553,18 +546,8 @@
 
 logging_search_logs(smbmount_t)
 
-sysnet_read_config(smbmount_t)
-
 userdom_use_all_users_fds(smbmount_t)
 
-optional_policy(`
-	nis_use_ypbind(smbmount_t)
-')
-
-optional_policy(`
-	nscd_socket_use(smbmount_t)
-')
-
 ########################################
 #
 # SWAT Local policy
@@ -576,7 +559,6 @@
 allow swat_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
 allow swat_t self:tcp_socket create_stream_socket_perms;
 allow swat_t self:udp_socket create_socket_perms;
-allow swat_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow swat_t nmbd_exec_t:file { execute read };
 
@@ -628,6 +610,7 @@
 fs_getattr_xattr_fs(swat_t)
 
 auth_domtrans_chk_passwd(swat_t)
+auth_use_nsswitch(swat_t)
 
 libs_use_ld_so(swat_t)
 libs_use_shared_libs(swat_t)
@@ -637,8 +620,6 @@
 
 miscfiles_read_localization(swat_t)
 
-sysnet_read_config(swat_t)
-
 optional_policy(`
 	cups_read_rw_config(swat_t)
 	cups_stream_connect(swat_t)
@@ -652,14 +633,6 @@
 	kerberos_use(swat_t)
 ')
 
-optional_policy(`
-	nis_use_ypbind(swat_t)
-')
-
-optional_policy(`
-	nscd_socket_use(swat_t)
-')
-
 ########################################
 #
 # Winbind local policy
@@ -672,7 +645,6 @@
 allow winbind_t self:fifo_file { read write };
 allow winbind_t self:unix_dgram_socket create_socket_perms;
 allow winbind_t self:unix_stream_socket create_stream_socket_perms;
-allow winbind_t self:netlink_route_socket r_netlink_socket_perms;
 allow winbind_t self:tcp_socket create_stream_socket_perms;
 allow winbind_t self:udp_socket create_socket_perms;
 
@@ -734,6 +706,7 @@
 fs_search_auto_mountpoints(winbind_t)
 
 auth_domtrans_chk_passwd(winbind_t)
+auth_use_nsswitch(winbind_t)
 
 domain_use_interactive_fds(winbind_t)
 
@@ -746,9 +719,6 @@
 
 miscfiles_read_localization(winbind_t)
 
-sysnet_read_config(winbind_t)
-sysnet_dns_name_resolve(winbind_t)
-
 userdom_dontaudit_use_unpriv_user_fds(winbind_t)
 userdom_dontaudit_search_sysadm_home_dirs(winbind_t)
 userdom_priveleged_home_dir_manager(winbind_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/squid.te serefpolicy-3.2.1/policy/modules/services/squid.te
--- nsaserefpolicy/policy/modules/services/squid.te	2007-10-12 08:56:07.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/squid.te	2007-11-29 15:19:41.000000000 -0500
@@ -127,6 +127,8 @@
 files_dontaudit_getattr_tmp_dirs(squid_t)
 files_getattr_home_dir(squid_t)
 
+auth_use_nsswitch(squid_t)
+
 libs_use_ld_so(squid_t)
 libs_use_shared_libs(squid_t)
 # to allow running programs from /usr/lib/squid (IE unlinkd)
@@ -137,9 +139,6 @@
 miscfiles_read_certs(squid_t)
 miscfiles_read_localization(squid_t)
 
-sysnet_dns_name_resolve(squid_t)
-sysnet_read_config(squid_t)
-
 userdom_use_unpriv_users_fds(squid_t)
 userdom_dontaudit_use_unpriv_user_fds(squid_t)
 userdom_dontaudit_search_sysadm_home_dirs(squid_t)
@@ -157,14 +156,6 @@
 ')
 
 optional_policy(`
-	nis_use_ypbind(squid_t)
-')
-
-optional_policy(`
-	nscd_socket_use(squid_t)
-')
-
-optional_policy(`
 	samba_domtrans_winbind_helper(squid_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/stunnel.te serefpolicy-3.2.1/policy/modules/services/stunnel.te
--- nsaserefpolicy/policy/modules/services/stunnel.te	2007-10-12 08:56:07.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/stunnel.te	2007-11-29 15:20:53.000000000 -0500
@@ -38,7 +38,6 @@
 allow stunnel_t self:fifo_file rw_fifo_file_perms;
 allow stunnel_t self:tcp_socket create_stream_socket_perms;
 allow stunnel_t self:udp_socket create_socket_perms;
-allow stunnel_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow stunnel_t stunnel_etc_t:dir { getattr read search };
 allow stunnel_t stunnel_etc_t:file { read getattr };
@@ -68,6 +67,8 @@
 
 fs_getattr_all_fs(stunnel_t)
 
+auth_use_nsswitch(stunnel_t)
+
 libs_use_ld_so(stunnel_t)
 libs_use_shared_libs(stunnel_t)
 
@@ -112,14 +113,6 @@
 	optional_policy(`
         	kerberos_use(stunnel_t)
 	')
-
-	optional_policy(`
-        	nis_use_ypbind(stunnel_t)
-	')
-
-	optional_policy(`
-        	nscd_socket_use(stunnel_t)
-	')
 ')
 
 # hack since this port has no interfaces since it doesnt
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/telnet.te serefpolicy-3.2.1/policy/modules/services/telnet.te
--- nsaserefpolicy/policy/modules/services/telnet.te	2007-07-16 14:09:46.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/telnet.te	2007-11-29 15:21:56.000000000 -0500
@@ -32,7 +32,6 @@
 allow telnetd_t self:udp_socket create_socket_perms;
 # for identd; cjp: this should probably only be inetd_child rules?
 allow telnetd_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
-allow telnetd_t self:netlink_route_socket r_netlink_socket_perms;
 allow telnetd_t self:capability { setuid setgid };
 
 allow telnetd_t telnetd_devpts_t:chr_file { rw_chr_file_perms setattr };
@@ -63,6 +62,7 @@
 fs_getattr_xattr_fs(telnetd_t)
 
 auth_rw_login_records(telnetd_t)
+auth_use_nsswitch(telnetd_t)
 
 corecmd_search_bin(telnetd_t)
 
@@ -82,8 +82,6 @@
 
 seutil_dontaudit_search_config(telnetd_t)
 
-sysnet_read_config(telnetd_t)
-
 remotelogin_domtrans(telnetd_t)
 
 # for identd; cjp: this should probably only be inetd_child rules?
@@ -92,14 +90,6 @@
 	kerberos_read_keytab(telnetd_t)
 ')
 
-optional_policy(`
-	nis_use_ypbind(telnetd_t)
-')
-
-optional_policy(`
-	nscd_socket_use(telnetd_t)
-')
-
 ifdef(`TODO',`
 # Allow krb5 telnetd to use fork and open /dev/tty for use
 allow telnetd_t userpty_type:chr_file setattr;
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/uucp.te serefpolicy-3.2.1/policy/modules/services/uucp.te
--- nsaserefpolicy/policy/modules/services/uucp.te	2007-10-12 08:56:07.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/uucp.te	2007-11-29 15:22:43.000000000 -0500
@@ -88,6 +88,8 @@
 files_search_home(uucpd_t)
 files_search_spool(uucpd_t)
 
+auth_use_nsswitch(uucpd_t)
+
 libs_use_ld_so(uucpd_t)
 libs_use_shared_libs(uucpd_t)
 
@@ -95,20 +97,10 @@
 
 miscfiles_read_localization(uucpd_t)
 
-sysnet_read_config(uucpd_t)
-
 optional_policy(`
 	kerberos_use(uucpd_t)
 ')
 
-optional_policy(`
-	nis_use_ypbind(uucpd_t)
-')
-
-optional_policy(`
-	nscd_socket_use(uucpd_t)
-')
-
 ########################################
 #
 # UUX Local policy
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/xserver.if serefpolicy-3.2.1/policy/modules/services/xserver.if
--- nsaserefpolicy/policy/modules/services/xserver.if	2007-10-12 08:56:07.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/services/xserver.if	2007-11-29 15:24:25.000000000 -0500
@@ -58,7 +58,6 @@
 	allow $1_xserver_t self:msg { send receive };
 	allow $1_xserver_t self:unix_dgram_socket { create_socket_perms sendto };
 	allow $1_xserver_t self:unix_stream_socket { create_stream_socket_perms connectto };
-	allow $1_xserver_t self:netlink_route_socket r_netlink_socket_perms;
 	allow $1_xserver_t self:tcp_socket create_stream_socket_perms;
 	allow $1_xserver_t self:udp_socket create_socket_perms;
 
@@ -143,6 +142,8 @@
 	fs_search_auto_mountpoints($1_xserver_t)
 	fs_search_ramfs($1_xserver_t)
 
+	auth_use_nsswitch($1_xserver_t)
+
 	init_getpgid($1_xserver_t)
 
 	term_setattr_unallocated_ttys($1_xserver_t)
@@ -160,8 +161,6 @@
 
 	seutil_dontaudit_search_config($1_xserver_t)
 
-	sysnet_read_config($1_xserver_t)
-
 	ifndef(`distro_redhat',`
 		allow $1_xserver_t self:process { execmem execheap execstack };
 	')
@@ -179,14 +178,6 @@
 	')
 
 	optional_policy(`
-		nis_use_ypbind($1_xserver_t)
-	')
-
-	optional_policy(`
-		nscd_socket_use($1_xserver_t)
-	')
-
-	optional_policy(`
 		rhgb_getpgid($1_xserver_t)
 		rhgb_signal($1_xserver_t)
 	')
@@ -370,11 +361,11 @@
 	# cjp: why?
 	term_use_ptmx($1_xauth_t)
 
+	auth_use_nsswitch($1_xauth_t)
+
 	libs_use_ld_so($1_xauth_t)
 	libs_use_shared_libs($1_xauth_t)
 
-	sysnet_dns_name_resolve($1_xauth_t)
-
 	userdom_use_user_terminals($1,$1_xauth_t)
 	userdom_read_user_tmp_files($1,$1_xauth_t)
 
@@ -387,10 +378,6 @@
 	')
 
 	optional_policy(`
-		nis_use_ypbind($1_xauth_t)
-	')
-
-	optional_policy(`
 		ssh_sigchld($1_xauth_t)
 		ssh_read_pipes($1_xauth_t)
 		ssh_dontaudit_rw_tcp_sockets($1_xauth_t)
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/init.te serefpolicy-3.2.1/policy/modules/system/init.te
--- nsaserefpolicy/policy/modules/system/init.te	2007-10-29 07:52:50.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/system/init.te	2007-11-29 15:25:45.000000000 -0500
@@ -196,7 +196,6 @@
 allow initrc_t self:tcp_socket create_stream_socket_perms;
 allow initrc_t self:udp_socket create_socket_perms;
 allow initrc_t self:fifo_file rw_file_perms;
-allow initrc_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow initrc_t initrc_devpts_t:chr_file rw_term_perms;
 term_create_pty(initrc_t,initrc_devpts_t)
@@ -345,6 +344,8 @@
 files_list_default(initrc_t)
 files_mounton_default(initrc_t)
 
+auth_use_nsswitch(initrc_t)
+
 libs_rw_ld_so_cache(initrc_t)
 libs_use_ld_so(initrc_t)
 libs_use_shared_libs(initrc_t)
@@ -365,8 +366,6 @@
 
 seutil_read_config(initrc_t)
 
-sysnet_read_config(initrc_t)
-
 userdom_read_all_users_home_content_files(initrc_t)
 # Allow access to the sysadm TTYs. Note that this will give access to the 
 # TTYs to any process in the initrc_t domain. Therefore, daemons and such
@@ -589,7 +588,6 @@
 ')
 
 optional_policy(`
-	ldap_read_config(initrc_t)
 	ldap_list_db(initrc_t)
 ')
 
@@ -648,15 +646,10 @@
 ')
 
 optional_policy(`
-	nis_use_ypbind(initrc_t)
 	nis_list_var_yp(initrc_t)
 ')
 
 optional_policy(`
-	nscd_socket_use(initrc_t)
-')
-
-optional_policy(`
 	openvpn_read_config(initrc_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/lvm.te serefpolicy-3.2.1/policy/modules/system/lvm.te
--- nsaserefpolicy/policy/modules/system/lvm.te	2007-10-12 08:56:08.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/system/lvm.te	2007-11-29 15:27:04.000000000 -0500
@@ -104,6 +104,8 @@
 
 storage_raw_read_fixed_disk(clvmd_t)
 
+auth_use_nsswitch(clvmd_t)
+
 libs_use_ld_so(clvmd_t)
 libs_use_shared_libs(clvmd_t)
 
@@ -114,8 +116,6 @@
 seutil_dontaudit_search_config(clvmd_t)
 seutil_sigchld_newrole(clvmd_t)
 
-sysnet_read_config(clvmd_t)
-
 userdom_dontaudit_use_unpriv_user_fds(clvmd_t)
 userdom_dontaudit_search_sysadm_home_dirs(clvmd_t)
 
@@ -131,10 +131,6 @@
 ')
 
 optional_policy(`
-	nis_use_ypbind(clvmd_t)
-')
-
-optional_policy(`
 	ricci_dontaudit_rw_modcluster_pipes(clvmd_t)
 	ricci_dontaudit_use_modcluster_fds(clvmd_t)
 ')
diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/mount.te serefpolicy-3.2.1/policy/modules/system/mount.te
--- nsaserefpolicy/policy/modules/system/mount.te	2007-10-12 08:56:08.000000000 -0400
+++ serefpolicy-3.2.1/policy/modules/system/mount.te	2007-11-29 15:27:48.000000000 -0500
@@ -39,7 +39,6 @@
 allow mount_t self:capability { ipc_lock sys_rawio sys_admin dac_override chown sys_tty_config setuid setgid };
 
 allow mount_t mount_loopback_t:file read_file_perms;
-allow mount_t self:netlink_route_socket r_netlink_socket_perms;
 
 allow mount_t mount_tmp_t:file manage_file_perms;
 allow mount_t mount_tmp_t:dir manage_dir_perms;
@@ -102,6 +101,8 @@
 init_use_script_ptys(mount_t)
 init_dontaudit_getattr_initctl(mount_t)
 
+auth_use_nsswitch(mount_t)
+
 libs_use_ld_so(mount_t)
 libs_use_shared_libs(mount_t)
 
@@ -159,13 +160,7 @@
 
 	fs_search_rpc(mount_t)
 
-	sysnet_dns_name_resolve(mount_t)
-
 	rpc_stub(mount_t)
-
-	optional_policy(`
-		nis_use_ypbind(mount_t)
-	')
 ')
 
 optional_policy(`

--------------000501060408000501090908
Content-Type: application/octet-stream;
 name="policy-nsswitch.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="policy-nsswitch.patch.sig"

iD8DBQBHVFoUrlYvE4MpobMRAjx3AJ9HZD/FBnn6hFq32ByqkFo61qWeXQCgk++JtYRa4PGs
oibYUtcakENJ9pE=
--------------000501060408000501090908--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
