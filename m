Message-ID: <415AAE8C.5050102@redhat.com>
Date: Wed, 29 Sep 2004 08:46:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: New policy diff
Content-Type: multipart/mixed;
 boundary="------------000904000906010603060906"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000904000906010603060906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added policy for vpnc.
Mailman location on redhat is changing.
More fixes for xinetd apps


--------------000904000906010603060906
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.17.23/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2004-09-09 16:22:12.000000000 -0400
+++ policy-1.17.23/domains/program/syslogd.te	2004-09-28 14:04:49.000000000 -0400
@@ -98,3 +98,4 @@
 
 dontaudit syslogd_t kernel_t:fd use;
 dontaudit syslogd_t kernel_t:file read;
+dontaudit syslogd_t unlabeled_t:file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/comsat.te policy-1.17.23/domains/program/unused/comsat.te
--- nsapolicy/domains/program/unused/comsat.te	2004-09-27 15:04:34.000000000 -0400
+++ policy-1.17.23/domains/program/unused/comsat.te	2004-09-28 10:46:55.000000000 -0400
@@ -1,6 +1,7 @@
 #DESC comsat - biff server
 #
 # Author:  Dan Walsh <dwalsh@redhat.com>
+# Depends: inetd.te
 #
 
 #################################
@@ -11,4 +12,6 @@
 #
 
 type comsat_port_t, port_type;
-inetd_child_domain(comsat)
+inetd_child_domain( comsat, udp )
+allow comsat_t initrc_var_run_t:file { read lock };
+dontaudit comsat_t initrc_var_run_t:file write;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.17.23/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2004-09-01 11:17:48.000000000 -0400
+++ policy-1.17.23/domains/program/unused/ftpd.te	2004-09-28 10:46:55.000000000 -0400
@@ -44,6 +44,8 @@
 rw_dir_create_file(ftpd_t, var_lock_t)
 allow ftpd_t ftp_port_t:tcp_socket name_bind;
 can_tcp_connect(userdomain, ftpd_t)
+# Allows it to check exec privs on daemon
+can_exec(inetd_t, ftpd_exec_t)
 }
 ifdef(`inetd.te', `
 if (!ftpd_is_daemon) {
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.17.23/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2004-09-27 20:48:35.000000000 -0400
+++ policy-1.17.23/domains/program/unused/hotplug.te	2004-09-28 10:46:55.000000000 -0400
@@ -42,7 +42,10 @@
 allow hotplug_t { bin_t sbin_t }:dir search;
 allow hotplug_t { bin_t sbin_t }:lnk_file read;
 can_exec(hotplug_t, { hotplug_exec_t bin_t sbin_t ls_exec_t shell_exec_t hotplug_etc_t etc_t })
-ifdef(`hostname.te', `can_exec(hotplug_t, hostname_exec_t)')
+ifdef(`hostname.te', `
+can_exec(hotplug_t, hostname_exec_t)
+dontaudit hostname_t hotplug_t:fd { use };
+')
 ifdef(`netutils.te', `
 ifdef(`distro_redhat', `
 # for arping used for static IP addresses on PCMCIA ethernet
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ktalkd.te policy-1.17.23/domains/program/unused/ktalkd.te
--- nsapolicy/domains/program/unused/ktalkd.te	2004-09-27 15:04:34.000000000 -0400
+++ policy-1.17.23/domains/program/unused/ktalkd.te	2004-09-28 10:46:55.000000000 -0400
@@ -11,4 +11,5 @@
 #
 
 type ktalkd_port_t, port_type;
-inetd_child_domain(ktalkd)
+inetd_child_domain(ktalkd, udp)
+allow inetd_t ktalkd_port_t:udp_socket name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/vpnc.te policy-1.17.23/domains/program/unused/vpnc.te
--- nsapolicy/domains/program/unused/vpnc.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.23/domains/program/unused/vpnc.te	2004-09-28 10:46:55.000000000 -0400
@@ -0,0 +1,31 @@
+#DESC vpnc
+#
+# Author:  Dan Walsh <dwalsh@redhat.com>
+#
+
+#################################
+#
+# Rules for the vpnc_t domain, et al.
+#
+# vpnc_t is the domain for the vpnc program.
+# vpnc_exec_t is the type of the vpnc executable.
+#
+daemon_domain(vpnc)
+
+# for SSP
+allow vpnc_t { random_device_t urandom_device_t }:chr_file read;
+
+# Use the network.
+can_network(vpnc_t)
+can_ypbind(vpnc_t)
+
+# Use capabilities.
+allow vpnc_t self:capability { net_admin ipc_lock net_bind_service net_raw };
+
+allow vpnc_t devpts_t:dir search;
+allow vpnc_t etc_t:file { getattr read };
+allow vpnc_t tun_tap_device_t:chr_file { ioctl read write };
+allow vpnc_t vpnc_t:rawip_socket create_socket_perms;
+allow vpnc_t vpnc_t:unix_dgram_socket create_socket_perms;
+allow vpnc_t vpnc_t:unix_stream_socket create_socket_perms;
+allow vpnc_t admin_tty_type:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mailman.fc policy-1.17.23/file_contexts/program/mailman.fc
--- nsapolicy/file_contexts/program/mailman.fc	2004-09-27 20:48:35.000000000 -0400
+++ policy-1.17.23/file_contexts/program/mailman.fc	2004-09-28 10:46:55.000000000 -0400
@@ -1,27 +1,23 @@
 # mailman list server
 /var/log/mailman(/.*)?		   system_u:object_r:mailman_log_t
+/usr/lib/mailman/cron/.*	-- system_u:object_r:mailman_queue_exec_t
+usr/lib/mailman/bin/mailmanctl -- system_u:object_r:mailman_mail_exec_t
+
 ifdef(`distro_debian', `
 /usr/lib/cgi-bin/mailman/.* -- system_u:object_r:mailman_cgi_exec_t
-/usr/lib/mailman/cron/.*	-- system_u:object_r:mailman_queue_exec_t
 /usr/lib/mailman/mail/wrapper -- system_u:object_r:mailman_mail_exec_t
 /usr/mailman/mail/wrapper 	-- system_u:object_r:mailman_mail_exec_t
 /var/lib/mailman(/.*)?	   system_u:object_r:mailman_data_t
 /var/lib/mailman/archives(/.*)?	system_u:object_r:mailman_archive_t
-/usr/lib/mailman/bin/mailmanctl -- system_u:object_r:mailman_mail_exec_t
 /etc/cron\.daily/mailman 	-- system_u:object_r:mailman_queue_exec_t
 /etc/cron\.monthly/mailman 	-- system_u:object_r:mailman_queue_exec_t
 ')
+
 ifdef(`distro_redhat', `
-/var/mailman/cgi-bin/.*		-- system_u:object_r:mailman_cgi_exec_t
-/var/mailman/data(/.*)?		   system_u:object_r:mailman_data_t
+/usr/lib/mailman/cgi-bin/.* -- system_u:object_r:mailman_cgi_exec_t
+/var/mailman(/.*)?		   system_u:object_r:mailman_data_t
 /var/mailman/locks(/.*)?	   system_u:object_r:mailman_lock_t
-/var/mailman/cron		-d system_u:object_r:bin_t
-/var/mailman/cron/.+		-- system_u:object_r:mailman_queue_exec_t
 /var/mailman/archives(/.*)?	   system_u:object_r:mailman_archive_t
-/var/mailman/scripts/mailman 	-- system_u:object_r:mailman_mail_exec_t
-/var/mailman/bin/qrunner     	-- system_u:object_r:mailman_queue_exec_t
-/var/mailman/bin/mailmanctl     -- system_u:object_r:mailman_mail_exec_t
-/var/mailman/mail/mailman 	-- system_u:object_r:mailman_mail_exec_t
-/var/mailman/Mailman(/.*?)	   system_u:object_r:lib_t
-/var/mailman/pythonlib(/.*?)	   system_u:object_r:lib_t
+/usr/lib/mailman/scripts/mailman -- system_u:object_r:mailman_mail_exec_t
+/usr/lib/mailman/bin/qrunner     -- system_u:object_r:mailman_queue_exec_t
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mozilla.fc policy-1.17.23/file_contexts/program/mozilla.fc
--- nsapolicy/file_contexts/program/mozilla.fc	2004-09-22 16:19:13.000000000 -0400
+++ policy-1.17.23/file_contexts/program/mozilla.fc	2004-09-28 10:46:55.000000000 -0400
@@ -17,4 +17,5 @@
 /usr/lib(64)?/mozilla[^/]*/mozilla-.* --	system_u:object_r:mozilla_exec_t
 /usr/lib(64)?/firefox[^/]*/mozilla-.* --	system_u:object_r:mozilla_exec_t
 /usr/lib(64)?/[^/]*firefox[^/]*/firefox-bin --	system_u:object_r:mozilla_exec_t
+/usr/lib(64)?/[^/]*firefox[^/]*/firefox --	system_u:object_r:bin_t
 /etc/mozpluggerrc system_u:object_r:mozilla_conf_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/rhgb.fc policy-1.17.23/file_contexts/program/rhgb.fc
--- nsapolicy/file_contexts/program/rhgb.fc	2004-09-22 16:19:13.000000000 -0400
+++ policy-1.17.23/file_contexts/program/rhgb.fc	2004-09-28 10:46:55.000000000 -0400
@@ -1,3 +1,2 @@
 /usr/bin/rhgb		--	system_u:object_r:rhgb_exec_t
-#/etc/dbus-1(/.*)?		system_u:object_r:etc_dbusd_t
-/etc/rhgb		-d	system_u:object_r:mnt_t
+/etc/rhgb(/.*)?		-d	system_u:object_r:mnt_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/rpm.fc policy-1.17.23/file_contexts/program/rpm.fc
--- nsapolicy/file_contexts/program/rpm.fc	2004-09-20 15:41:00.000000000 -0400
+++ policy-1.17.23/file_contexts/program/rpm.fc	2004-09-28 12:03:20.000000000 -0400
@@ -32,6 +32,8 @@
 /usr/share/system-config-language/system-config-language -- system_u:object_r:bin_t
 /usr/share/system-config-mouse/system-config-mouse -- system_u:object_r:bin_t
 /usr/share/system-config-netboot/system-config-netboot.py -- system_u:object_r:bin_t
+/usr/share/system-config-netboot/pxeos.py -- system_u:object_r:bin_t
+/usr/share/system-config-netboot/pxeboot.py -- system_u:object_r:bin_t
 /usr/share/system-config-nfs/system-config-nfs.py -- system_u:object_r:bin_t
 /usr/share/system-config-rootpassword/system-config-rootpassword -- system_u:object_r:bin_t
 /usr/share/system-config-samba/system-config-samba.py -- system_u:object_r:bin_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/vpnc.fc policy-1.17.23/file_contexts/program/vpnc.fc
--- nsapolicy/file_contexts/program/vpnc.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.23/file_contexts/program/vpnc.fc	2004-09-28 10:46:55.000000000 -0400
@@ -0,0 +1,2 @@
+# vpnc
+/usr/sbin/vpnc		--	system_u:object_r:vpnc_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/inetd_macros.te policy-1.17.23/macros/program/inetd_macros.te
--- nsapolicy/macros/program/inetd_macros.te	2004-09-27 15:04:36.000000000 -0400
+++ policy-1.17.23/macros/program/inetd_macros.te	2004-09-28 10:48:08.000000000 -0400
@@ -38,8 +38,11 @@
 var_run_domain($1)
 
 # Use sockets inherited from inetd.
+ifelse($2, udp, `
+allow $1_t inetd_t:udp_socket rw_socket_perms;
+', `
 allow $1_t inetd_t:tcp_socket rw_stream_socket_perms;
-
+')
 # for identd
 allow $1_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
 allow $1_t self:capability { setuid setgid };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.17.23/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-09-27 20:48:36.000000000 -0400
+++ policy-1.17.23/macros/program/mozilla_macros.te	2004-09-28 10:46:55.000000000 -0400
@@ -80,15 +80,7 @@
 #
 if (mozilla_readhome || mozilla_writehome) {
 r_dir_file($1_mozilla_t, $1_home_t)
-
-ifdef(`gpg.te', `
-dontaudit $1_mozilla_t $1_gpg_secret_t:dir { getattr };
-')
-ifdef(`screen.te', `
-dontaudit $1_mozilla_t $1_home_screen_t:file { getattr };
-')
-dontaudit $1_mozilla_t $1_home_ssh_t:dir { getattr };
-
+dontaudit $1_mozilla_t homedirfile:{ file dir } getattr;
 file_type_auto_trans($1_mozilla_t, tmp_t, $1_tmp_t)
 } else {
 file_type_auto_trans($1_mozilla_t, tmp_t, $1_mozilla_rw_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/screen_macros.te policy-1.17.23/macros/program/screen_macros.te
--- nsapolicy/macros/program/screen_macros.te	2004-09-01 11:17:49.000000000 -0400
+++ policy-1.17.23/macros/program/screen_macros.te	2004-09-28 10:46:55.000000000 -0400
@@ -26,7 +26,7 @@
 typealias $1_home_t alias $1_home_screen_t;
 ', `
 type $1_screen_t, domain, privlog, privfd;
-type $1_home_screen_t, file_type, sysadmfile;
+type $1_home_screen_t, file_type, homedirfile, sysadmfile;
 
 # Transition from the user domain to this domain.
 domain_auto_trans($1_t, screen_exec_t, $1_screen_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/sendmail_macros.te policy-1.17.23/macros/program/sendmail_macros.te
--- nsapolicy/macros/program/sendmail_macros.te	2004-09-29 07:36:46.817140452 -0400
+++ policy-1.17.23/macros/program/sendmail_macros.te	2004-09-27 20:49:59.000000000 -0400
@@ -44,7 +44,7 @@
 
 ifelse(`$1', `sysadm', `
 allow $1_mail_t proc_t:dir { getattr search };
-allow $1_mail_t proc_t:{ lnk_file file } { getattr read };
+allow $1_mail_t proc_t:file { getattr read };
 allow $1_mail_t sysctl_kernel_t:file { getattr read };
 allow $1_mail_t etc_runtime_t:file { getattr read };
 ', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/spamassassin_macros.te policy-1.17.23/macros/program/spamassassin_macros.te
--- nsapolicy/macros/program/spamassassin_macros.te	2004-09-02 14:45:47.000000000 -0400
+++ policy-1.17.23/macros/program/spamassassin_macros.te	2004-09-28 10:46:55.000000000 -0400
@@ -80,7 +80,7 @@
 dontaudit $1_spamassassin_t { sysctl_t sysctl_kernel_t }:dir search;
 
 # The type of ~/.spamassassin
-type $1_home_spamassassin_t, file_type, sysadmfile;
+type $1_home_spamassassin_t, file_type, homedirfile, sysadmfile;
 create_dir_file($1_t, $1_home_spamassassin_t)
 allow $1_t $1_home_spamassassin_t:notdevfile_class_set { relabelfrom relabelto };
 allow $1_t $1_home_spamassassin_t:dir { relabelfrom relabelto };
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.17.23/net_contexts
--- nsapolicy/net_contexts	2004-09-27 20:48:35.000000000 -0400
+++ policy-1.17.23/net_contexts	2004-09-28 10:46:55.000000000 -0400
@@ -30,7 +30,6 @@
 portcon udp 37 system_u:object_r:inetd_port_t
 portcon tcp 113 system_u:object_r:inetd_port_t
 portcon udp 512 system_u:object_r:biff_port_t
-portcon udp 517 system_u:object_r:inetd_port_t
 portcon tcp 891 system_u:object_r:inetd_port_t
 portcon udp 891 system_u:object_r:inetd_port_t
 portcon tcp 892 system_u:object_r:inetd_port_t
@@ -95,9 +94,9 @@
 ifdef(`syslogd.te', `
 portcon udp 514 system_u:object_r:syslogd_port_t
 ')
-ifdef(`talk.te', `
-portcon udp 517 system_u:object_r:talk_port_t
-portcon udp 518 system_u:object_r:ntalk_port_t
+ifdef(`ktalkd.te', `
+portcon udp 517 system_u:object_r:ktalkd_port_t
+portcon udp 518 system_u:object_r:ktalkd_port_t
 ')
 ifdef(`cups.te', `
 portcon tcp 631 system_u:object_r:ipp_port_t
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.17.23/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2004-08-12 10:45:41.000000000 -0400
+++ policy-1.17.23/targeted/domains/unconfined.te	2004-09-28 10:46:55.000000000 -0400
@@ -12,7 +12,8 @@
 
 # Define some type aliases to help with compatibility with
 # macros and domains from the "strict" policy.
-typealias unconfined_t alias { kernel_t init_t initrc_t sysadm_t rpm_t rpm_script_t };
+typealias bin_t alias su_exec_t;
+typealias unconfined_t alias { kernel_t init_t initrc_t sysadm_t rpm_t rpm_script_t logrotate_t };
 typealias var_lib_t alias { rpm_var_lib_t };
 type mount_t, domain;
 type initrc_devpts_t, ptyfile;
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.23/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.17.23/tunables/distro.tun	2004-09-28 10:46:55.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.23/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-09-27 20:48:36.000000000 -0400
+++ policy-1.17.23/tunables/tunable.tun	2004-09-28 10:46:55.000000000 -0400
@@ -1,42 +1,42 @@
 # Allow all domains to connect to nscd
-dnl define(`nscd_all_connect')
+define(`nscd_all_connect')
 
 # Allow users to control network interfaces (also needs USERCTL=true)
 dnl define(`user_net_control')
 
 # Allow users to execute the mount command
-dnl define(`user_can_mount')
+define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Support NFS home directories
-dnl define(`nfs_home_dirs')
+define(`nfs_home_dirs')
 
 # Allow users to run games
-dnl define(`use_games')
+define(`use_games')
 
 # Allow ypbind to run with NIS
-dnl define(`allow_ypbind')
+define(`allow_ypbind')
 
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

--------------000904000906010603060906--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
