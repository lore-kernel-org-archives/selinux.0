Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i91KjLrT004910
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 16:45:22 -0400 (EDT)
Message-ID: <415DC1D7.9040109@redhat.com>
Date: Fri, 01 Oct 2004 16:45:11 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
Subject: Re: policy patches
References: <200409292354.15227.russell@coker.com.au> <200409300620.41527.russell@coker.com.au> <1096648965.13366.35.camel@moss-lions.epoch.ncsc.mil> <200410020344.04225.russell@coker.com.au>
In-Reply-To: <200410020344.04225.russell@coker.com.au>
Content-Type: multipart/mixed;
 boundary="------------020200020908060300000205"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020200020908060300000205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Cleaned up patch with some of russells changes.

chage has been updated to do a checkPasswdAccess(PASSWD__ROOTOK) now.


--------------020200020908060300000205
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/getty.te policy-1.17.26/domains/program/getty.te
--- nsapolicy/domains/program/getty.te	2004-08-20 13:57:27.000000000 -0400
+++ policy-1.17.26/domains/program/getty.te	2004-10-01 16:40:12.320803326 -0400
@@ -58,3 +58,4 @@
 
 rw_dir_create_file(getty_t, var_lock_t)
 r_dir_file(getty_t, sysfs_t)
+allow getty_t initrc_devpts_t:chr_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/passwd.te policy-1.17.26/domains/program/passwd.te
--- nsapolicy/domains/program/passwd.te	2004-09-23 15:08:59.000000000 -0400
+++ policy-1.17.26/domains/program/passwd.te	2004-10-01 16:40:12.321803216 -0400
@@ -42,7 +42,7 @@
 allow $1_t etc_t:lnk_file read;
 
 # Use capabilities.
-allow $1_t self:capability { chown dac_override fsetid setuid sys_resource };
+allow $1_t self:capability { chown dac_override fsetid setuid setgid sys_resource };
 
 # Access terminals.
 allow $1_t { ttyfile ptyfile }:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/amanda.te policy-1.17.26/domains/program/unused/amanda.te
--- nsapolicy/domains/program/unused/amanda.te	2004-08-27 09:30:29.000000000 -0400
+++ policy-1.17.26/domains/program/unused/amanda.te	2004-10-01 16:40:12.322803106 -0400
@@ -33,7 +33,6 @@
 
 type amanda_t, domain, privlog;
 role system_r types amanda_t;
-type amandaidx_port_t, port_type;
 
 # type for the amanda executables
 type amanda_exec_t, file_type, sysadmfile, exec_type;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/comsat.te policy-1.17.26/domains/program/unused/comsat.te
--- nsapolicy/domains/program/unused/comsat.te	2004-09-30 20:48:48.000000000 -0400
+++ policy-1.17.26/domains/program/unused/comsat.te	2004-10-01 16:40:12.322803106 -0400
@@ -11,7 +11,10 @@
 # comsat_exec_t is the type of the comsat executable.
 #
 
-type comsat_port_t, port_type;
-inetd_child_domain(comsat, udp)
-allow comsat_t initrc_var_run_t:file { read lock };
+inetd_child_domain(comsat,udp)
+allow comsat_t initrc_var_run_t:file r_file_perms;
 dontaudit comsat_t initrc_var_run_t:file write;
+allow comsat_t mail_spool_t:dir r_dir_perms;
+allow comsat_t mail_spool_t:lnk_file { read };
+allow comsat_t var_spool_t:dir { search };
+dontaudit comsat_t sysadm_tty_device_t:chr_file { getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.17.26/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2004-09-27 20:48:35.000000000 -0400
+++ policy-1.17.26/domains/program/unused/cups.te	2004-10-01 16:40:12.323802996 -0400
@@ -45,6 +45,7 @@
 ')
 
 ifdef(`inetd.te', `
+allow inetd_t printer_port_t:tcp_socket { name_bind };
 domain_auto_trans(inetd_t, cupsd_exec_t, cupsd_t)
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dbskkd.te policy-1.17.26/domains/program/unused/dbskkd.te
--- nsapolicy/domains/program/unused/dbskkd.te	2004-09-27 15:04:34.000000000 -0400
+++ policy-1.17.26/domains/program/unused/dbskkd.te	2004-10-01 16:40:12.324802886 -0400
@@ -10,5 +10,4 @@
 # dbskkd_exec_t is the type of the dbskkd executable.
 #
 
-type dbskkd_port_t, port_type;
 inetd_child_domain(dbskkd)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.17.26/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-09-27 20:48:35.000000000 -0400
+++ policy-1.17.26/domains/program/unused/hald.te	2004-10-01 16:40:12.324802886 -0400
@@ -61,4 +61,3 @@
 allow hald_t usbfs_t:file { getattr read };
 allow hald_t bin_t:lnk_file read;
 dontaudit hald_t selinux_config_t:dir { search };
-dontaudit hald_t userdomain:fd { use };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/inetd.te policy-1.17.26/domains/program/unused/inetd.te
--- nsapolicy/domains/program/unused/inetd.te	2004-09-27 20:48:35.000000000 -0400
+++ policy-1.17.26/domains/program/unused/inetd.te	2004-10-01 16:40:12.325802776 -0400
@@ -12,13 +12,11 @@
 #
 type telnet_port_t, port_type;
 type biff_port_t, port_type;
-type amidxtape_port_t, port_type;
 
 #################################
 #
 # Rules for the inetd_t domain.
 #
-type inetd_port_t, port_type;
 
 daemon_domain(inetd, `, nscd_client_domain ifdef(`unlimitedInetd', `,admin, etc_writer, fs_domain, auth_write, privmem')' )
 
@@ -50,26 +48,16 @@
 ifdef(`ftpd.te', `allow inetd_t ftp_port_t:tcp_socket name_bind;')
 ifdef(`rlogind.te', `allow inetd_t rlogin_port_t:tcp_socket name_bind;')
 ifdef(`rshd.te', `allow inetd_t rsh_port_t:tcp_socket name_bind;')
-ifdef(`amanda.te', `allow inetd_t amanda_port_t:tcp_socket name_bind;')
-ifdef(`swat.te', `allow inetd_t swat_port_t:tcp_socket name_bind;')
-ifdef(`amanda.te', `
-allow inetd_t biff_port_t:tcp_socket name_bind;
-allow inetd_t biff_port_t:udp_socket name_bind;
-allow inetd_t amidxtape_port_t:tcp_socket name_bind;
-')
 ifdef(`talk.te', `
 allow inetd_t talk_port_t:tcp_socket name_bind;
 allow inetd_t ntalk_port_t:tcp_socket name_bind;
 ')
 
-# allow to bind to chargen, echo, etc
-allow inetd_t inetd_port_t:{ tcp_socket udp_socket } name_bind;
-
 # Communicate with the portmapper.
 ifdef(`portmap.te', `can_udp_send(inetd_t, portmap_t)')
 
 
-inetd_child_domain(inetd_child)
+inetd_child_domain(inetd_child,udp)
 
 ifdef(`unconfined.te', `
 domain_auto_trans(inetd_t, unconfined_exec_t, unconfined_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ktalkd.te policy-1.17.26/domains/program/unused/ktalkd.te
--- nsapolicy/domains/program/unused/ktalkd.te	2004-09-30 20:48:48.000000000 -0400
+++ policy-1.17.26/domains/program/unused/ktalkd.te	2004-10-01 16:40:12.325802776 -0400
@@ -10,6 +10,4 @@
 # ktalkd_exec_t is the type of the ktalkd executable.
 #
 
-type ktalkd_port_t, port_type;
-inetd_child_domain(ktalkd, udp)
-allow inetd_t ktalkd_port_t:udp_socket name_bind;
+inetd_child_domain(ktalkd,udp)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rhgb.te policy-1.17.26/domains/program/unused/rhgb.te
--- nsapolicy/domains/program/unused/rhgb.te	2004-09-27 20:48:35.000000000 -0400
+++ policy-1.17.26/domains/program/unused/rhgb.te	2004-10-01 16:40:12.326802666 -0400
@@ -29,7 +29,7 @@
 # for ramfs file systems
 allow rhgb_t ramfs_t:dir { setattr rw_dir_perms };
 allow rhgb_t ramfs_t:sock_file create_file_perms;
-allow rhgb_t ramfs_t:file unlink;
+allow rhgb_t ramfs_t:{ file fifo_file } create_file_perms;
 allow insmod_t ramfs_t:file write;
 allow insmod_t rhgb_t:fd use;
 
@@ -84,4 +84,9 @@
 ifdef(`firstboot.te', `
 allow rhgb_t firstboot_rw_t:file r_file_perms;
 ')
-
+dontaudit rhgb_t tmp_t:dir { search };
+allow rhgb_t xdm_xserver_t:process { sigkill };
+allow domain rhgb_devpts_t:chr_file { read write };
+ifdef(`fsadm.te', `
+dontaudit fsadm_t ramfs_t:fifo_file { write };
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rsync.te policy-1.17.26/domains/program/unused/rsync.te
--- nsapolicy/domains/program/unused/rsync.te	2004-09-27 15:04:35.000000000 -0400
+++ policy-1.17.26/domains/program/unused/rsync.te	2004-10-01 16:40:12.326802666 -0400
@@ -10,5 +10,4 @@
 # rsync_exec_t is the type of the rsync executable.
 #
 
-type rsync_port_t, port_type;
 inetd_child_domain(rsync)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sendmail.te policy-1.17.26/domains/program/unused/sendmail.te
--- nsapolicy/domains/program/unused/sendmail.te	2004-09-10 11:01:02.000000000 -0400
+++ policy-1.17.26/domains/program/unused/sendmail.te	2004-10-01 16:40:12.327802556 -0400
@@ -65,10 +65,8 @@
 # Read /usr/lib/sasl2/.*
 allow sendmail_t lib_t:file { getattr read };
 
-# /usr/sbin/sendmail asks for w access to utmp, but it will operate
-# correctly without it.  Do not audit write and lock denials to utmp.
-allow sendmail_t initrc_var_run_t:file { getattr read };
-dontaudit sendmail_t initrc_var_run_t:file { lock write };
+# /usr/sbin/sendmail asks for w access to utmp
+allow sendmail_t initrc_var_run_t:file { getattr read lock write };
 
 # When sendmail runs as user_mail_domain, it needs some extra permissions
 # to update /etc/mail/statistics.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/slrnpull.te policy-1.17.26/domains/program/unused/slrnpull.te
--- nsapolicy/domains/program/unused/slrnpull.te	2004-03-31 12:59:08.000000000 -0500
+++ policy-1.17.26/domains/program/unused/slrnpull.te	2004-10-01 16:40:12.328802447 -0400
@@ -19,3 +19,5 @@
 ')
 system_crond_entry(slrnpull_exec_t, slrnpull_t)
 allow userdomain slrnpull_spool_t:dir { search };
+rw_dir_create_file(slrnpull_t, slrnpull_spool_t)
+allow slrnpull_t var_spool_t:dir { search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/snmpd.te policy-1.17.26/domains/program/unused/snmpd.te
--- nsapolicy/domains/program/unused/snmpd.te	2004-09-09 16:22:12.000000000 -0400
+++ policy-1.17.26/domains/program/unused/snmpd.te	2004-10-01 16:40:12.328802447 -0400
@@ -24,6 +24,7 @@
 
 # for the .index file
 var_lib_domain(snmpd)
+file_type_auto_trans(snmpd_t, { var_t }, snmpd_var_lib_t, dir)
 file_type_auto_trans(snmpd_t, { usr_t var_t }, snmpd_var_lib_t, file)
 typealias snmpd_var_lib_t alias snmpd_var_rw_t;
 
@@ -70,3 +71,5 @@
 allow snmpd_t var_lib_nfs_t:dir search;
 
 dontaudit snmpd_t domain:dir { getattr search };
+
+dontaudit snmpd_t selinux_config_t:dir { search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/swat.te policy-1.17.26/domains/program/unused/swat.te
--- nsapolicy/domains/program/unused/swat.te	2004-09-27 15:04:35.000000000 -0400
+++ policy-1.17.26/domains/program/unused/swat.te	2004-10-01 16:40:12.329802337 -0400
@@ -10,5 +10,4 @@
 # swat_exec_t is the type of the swat executable.
 #
 
-type swat_port_t, port_type;
 inetd_child_domain(swat)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/tvtime.te policy-1.17.26/domains/program/unused/tvtime.te
--- nsapolicy/domains/program/unused/tvtime.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.26/domains/program/unused/tvtime.te	2004-10-01 16:40:12.329802337 -0400
@@ -0,0 +1,12 @@
+#DESC tvtime - a high quality television application
+#
+# Domains for the tvtime program.
+# Author     :  Dan Walsh <dwalsh@redhat.com>
+#
+# tvtime_exec_t is the type of the tvtime executable.
+#
+type tvtime_exec_t, file_type, sysadmfile, exec_type;
+type tvtime_dir_t, file_type, sysadmfile, pidfile;
+
+# Everything else is in the tvtime_domain macro in
+# macros/program/tvtime_macros.te.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.17.26/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2004-10-01 15:05:31.000000000 -0400
+++ policy-1.17.26/domains/program/unused/udev.te	2004-10-01 16:40:12.330802227 -0400
@@ -107,3 +107,4 @@
 allow udev_t device_t:dir { relabelfrom relabelto create_dir_perms };
 allow udev_t sysctl_modprobe_t:file { getattr read };
 allow udev_t udev_t:rawip_socket create_socket_perms;
+dontaudit  udev_t domain:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/vpnc.te policy-1.17.26/domains/program/unused/vpnc.te
--- nsapolicy/domains/program/unused/vpnc.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.26/domains/program/unused/vpnc.te	2004-10-01 16:40:12.330802227 -0400
@@ -0,0 +1,30 @@
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
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.17.26/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2004-09-10 11:01:02.000000000 -0400
+++ policy-1.17.26/domains/program/unused/xdm.te	2004-10-01 16:40:12.331802117 -0400
@@ -215,6 +215,7 @@
 dontaudit xdm_t misc_device_t:file_class_set rw_file_perms;
 dontaudit xdm_t removable_device_t:file_class_set rw_file_perms;
 dontaudit xdm_t scsi_generic_device_t:file_class_set rw_file_perms;
+dontaudit xdm_t devpts_t:dir { search };
 
 # Do not audit denied probes of /proc.
 dontaudit xdm_t domain:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/passwd.fc policy-1.17.26/file_contexts/program/passwd.fc
--- nsapolicy/file_contexts/program/passwd.fc	2004-03-03 15:53:52.000000000 -0500
+++ policy-1.17.26/file_contexts/program/passwd.fc	2004-10-01 16:40:12.332802007 -0400
@@ -1,5 +1,6 @@
 # spasswd
 /usr/bin/passwd		--	system_u:object_r:passwd_exec_t
+/usr/bin/chage		--	system_u:object_r:passwd_exec_t
 /usr/bin/chsh		--	system_u:object_r:chfn_exec_t
 /usr/bin/chfn		--	system_u:object_r:chfn_exec_t
 /usr/sbin/vipw		--	system_u:object_r:admin_passwd_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/tvtime.fc policy-1.17.26/file_contexts/program/tvtime.fc
--- nsapolicy/file_contexts/program/tvtime.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.26/file_contexts/program/tvtime.fc	2004-10-01 16:40:12.332802007 -0400
@@ -0,0 +1,3 @@
+# tvtime
+/usr/bin/tvtime		--	system_u:object_r:tvtime_exec_t
+
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/vpnc.fc policy-1.17.26/file_contexts/program/vpnc.fc
--- nsapolicy/file_contexts/program/vpnc.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.26/file_contexts/program/vpnc.fc	2004-10-01 16:40:12.333801897 -0400
@@ -0,0 +1,2 @@
+# vpnc
+/usr/sbin/vpnc		--	system_u:object_r:vpnc_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.17.26/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-09-27 20:48:36.000000000 -0400
+++ policy-1.17.26/macros/base_user_macros.te	2004-10-01 16:40:12.333801897 -0400
@@ -152,6 +152,7 @@
 ifdef(`crontab.te', `crontab_domain($1)')
 
 ifdef(`screen.te', `screen_domain($1)')
+ifdef(`tvtime.te', `tvtime_domain($1)')
 ifdef(`mozilla.te', `mozilla_domain($1)')
 ifdef(`use_games', `ifdef(`games.te', `games_domain($1)')')
 ifdef(`gpg.te', `gpg_domain($1)')
@@ -287,6 +288,7 @@
 #
 allow $1_t rpc_pipefs_t:dir { getattr };
 allow $1_t nfsd_fs_t:dir { getattr };
+allow $1_t binfmt_misc_fs_t:dir { getattr };
 
 # /initrd is left mounted, various programs try to look at it
 dontaudit $1_t ramfs_t:dir { getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.17.26/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2004-09-22 16:19:13.000000000 -0400
+++ policy-1.17.26/macros/global_macros.te	2004-10-01 16:40:12.334801787 -0400
@@ -287,6 +287,7 @@
 allow $1_t device_t:dir { getattr search };
 allow $1_t null_device_t:chr_file rw_file_perms;
 dontaudit $1_t console_device_t:chr_file rw_file_perms;
+dontaudit $1_t unpriv_userdomain:fd use;
 
 r_dir_file($1_t, sysfs_t) 
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/inetd_macros.te policy-1.17.26/macros/program/inetd_macros.te
--- nsapolicy/macros/program/inetd_macros.te	2004-09-30 20:48:49.000000000 -0400
+++ policy-1.17.26/macros/program/inetd_macros.te	2004-10-01 16:40:12.335801677 -0400
@@ -52,4 +52,9 @@
 allow $1_t krb5_conf_t:file r_file_perms;
 dontaudit $1_t krb5_conf_t:file write;
 allow $1_t urandom_device_t:chr_file { getattr read };
+type $1_port_t, port_type;
+allow inetd_t $1_port_t:tcp_socket { name_bind };
+ifelse($2, udp, `
+allow inetd_t $1_port_t:udp_socket { name_bind };
+')
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.17.26/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-10-01 15:05:32.000000000 -0400
+++ policy-1.17.26/macros/program/mozilla_macros.te	2004-10-01 16:40:12.336801567 -0400
@@ -69,8 +69,12 @@
 domain_auto_trans($1_mozilla_t, lpr_exec_t, $1_lpr_t)
 # $1_lpr_t should only need read access to the tmp files
 allow $1_lpr_t $1_mozilla_rw_t:file rw_file_perms;
+dontaudit $1_lpr_t $1_mozilla_t:tcp_socket { read write };
+dontaudit $1_lpr_t $1_mozilla_t:unix_stream_socket { read write };
 ')
 
+dontaudit $1_mozilla_t tmp_t:lnk_file read;
+
 #
 # This is another place where I sould like to allow system customization.
 # We need to allow the admin to select whether then want to allow mozilla
@@ -107,6 +111,7 @@
 dontaudit $1_mozilla_t dri_device_t:chr_file rw_file_perms;
 # Mozilla tries to delete .fonts.cache-1
 dontaudit $1_mozilla_t $1_home_t:file { unlink };
+dontaudit $1_mozilla_t tmpfile:file getattr;
 
 ifdef(`xdm.te', `
 allow $1_mozilla_t xdm_t:fifo_file { write read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/sendmail_macros.te policy-1.17.26/macros/program/sendmail_macros.te
--- nsapolicy/macros/program/sendmail_macros.te	2004-09-30 20:48:49.000000000 -0400
+++ policy-1.17.26/macros/program/sendmail_macros.te	2004-10-01 16:40:12.336801567 -0400
@@ -44,7 +44,7 @@
 
 ifelse(`$1', `sysadm', `
 allow $1_mail_t proc_t:dir { getattr search };
-allow $1_mail_t proc_t:file { getattr read };
+allow $1_mail_t proc_t:{ lnk_file file } { getattr read };
 allow $1_mail_t sysctl_kernel_t:file { getattr read };
 allow $1_mail_t etc_runtime_t:file { getattr read };
 ', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/tvtime_macros.te policy-1.17.26/macros/program/tvtime_macros.te
--- nsapolicy/macros/program/tvtime_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.17.26/macros/program/tvtime_macros.te	2004-10-01 16:40:12.337801457 -0400
@@ -0,0 +1,45 @@
+#
+# Macros for tvtime domains.
+#
+
+#
+# Author: Dan Walsh <dwalsh@redhat.com>
+#
+
+#
+# tvtime_domain(domain_prefix)
+#
+# Define a derived domain for the tvtime program when executed
+# by a user domain.
+#
+# The type declaration for the executable type for this program is
+# provided separately in domains/program/tvtime.te. 
+#
+undefine(`tvtime_domain')
+ifdef(`tvtime.te', `
+define(`tvtime_domain',`
+# Derived domain based on the calling user domain and the program.
+type $1_home_tvtime_t, file_type, homedirfile, sysadmfile;
+
+x_client_domain($1, tvtime)
+
+allow $1_tvtime_t urandom_device_t:chr_file read;
+allow $1_tvtime_t clock_device_t:chr_file { ioctl read };
+allow $1_tvtime_t kernel_t:system { ipc_info };
+allow $1_tvtime_t sound_device_t:chr_file { read };
+allow $1_tvtime_t $1_home_t:dir { getattr read search };
+allow $1_tvtime_t $1_home_t:file { getattr read };
+tmp_domain($1_tvtime)
+allow $1_tvtime_t self:capability { setuid sys_nice sys_resource };
+allow $1_tvtime_t self:process { setsched };
+allow $1_tvtime_t usr_t:file { getattr read };
+allow $1_tvtime_t xdm_tmp_t:dir { search };
+
+')dnl end tvtime_domain
+
+', `
+
+define(`tvtime_domain',`')
+
+')
+
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xserver_macros.te policy-1.17.26/macros/program/xserver_macros.te
--- nsapolicy/macros/program/xserver_macros.te	2004-10-01 15:05:32.000000000 -0400
+++ policy-1.17.26/macros/program/xserver_macros.te	2004-10-01 16:40:12.337801457 -0400
@@ -198,7 +198,10 @@
 
 # Create and access /dev/dri devices.
 allow $1_xserver_t device_t:dir create;
+allow $1_xserver_t device_t:dir { setattr };
 file_type_auto_trans($1_xserver_t, device_t, dri_device_t, chr_file)
+# brought on by rhgb
+allow $1_xserver_t mnt_t:dir { search };
 
 allow $1_xserver_t tty_device_t:chr_file { setattr rw_file_perms };
 
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.17.26/Makefile
--- nsapolicy/Makefile	2004-09-13 15:58:17.000000000 -0400
+++ policy-1.17.26/Makefile	2004-10-01 16:40:12.338801347 -0400
@@ -52,7 +52,7 @@
 FCFILES=file_contexts/types.fc $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te)) $(wildcard file_contexts/misc/*.fc)
 
 APPDIR=$(CONTEXTPATH)
-APPFILES = $(addprefix $(APPDIR)/,default_contexts default_type initrc_context failsafe_context userhelper_context) $(CONTEXTPATH)/files/media
+APPFILES = $(addprefix $(APPDIR)/,default_contexts default_type initrc_context failsafe_context userhelper_context removable_context) $(CONTEXTPATH)/files/media
 
 ROOTFILES = $(addprefix $(APPDIR)/users/,root)
 
@@ -68,6 +68,10 @@
 	mkdir -p $(APPDIR)
 	install -m 644 $< $@
 
+$(APPDIR)/removable_context: appconfig/removable_context
+	mkdir -p $(APPDIR)
+	install -m 644 $< $@
+
 $(APPDIR)/default_type: appconfig/default_type
 	mkdir -p $(APPDIR)
 	install -m 644 $< $@
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.17.26/net_contexts
--- nsapolicy/net_contexts	2004-09-30 20:48:48.000000000 -0400
+++ policy-1.17.26/net_contexts	2004-10-01 16:40:12.339801238 -0400
@@ -18,22 +18,25 @@
 # protocol low-high context
 #
 ifdef(`inetd.te', `
-portcon tcp 7 system_u:object_r:inetd_port_t
-portcon udp 7 system_u:object_r:inetd_port_t
-portcon tcp 9 system_u:object_r:inetd_port_t
-portcon udp 9 system_u:object_r:inetd_port_t
-portcon tcp 13 system_u:object_r:inetd_port_t
-portcon udp 13 system_u:object_r:inetd_port_t
-portcon tcp 19 system_u:object_r:inetd_port_t
-portcon udp 19 system_u:object_r:inetd_port_t
-portcon tcp 37 system_u:object_r:inetd_port_t
-portcon udp 37 system_u:object_r:inetd_port_t
-portcon tcp 113 system_u:object_r:inetd_port_t
-portcon udp 512 system_u:object_r:biff_port_t
-portcon tcp 891 system_u:object_r:inetd_port_t
-portcon udp 891 system_u:object_r:inetd_port_t
-portcon tcp 892 system_u:object_r:inetd_port_t
-portcon udp 892 system_u:object_r:inetd_port_t
+portcon tcp 7 system_u:object_r:inetd_child_port_t
+portcon udp 7 system_u:object_r:inetd_child_port_t
+portcon tcp 9 system_u:object_r:inetd_child_port_t
+portcon udp 9 system_u:object_r:inetd_child_port_t
+portcon tcp 13 system_u:object_r:inetd_child_port_t
+portcon udp 13 system_u:object_r:inetd_child_port_t
+portcon tcp 19 system_u:object_r:inetd_child_port_t
+portcon udp 19 system_u:object_r:inetd_child_port_t
+portcon tcp 37 system_u:object_r:inetd_child_port_t
+portcon udp 37 system_u:object_r:inetd_child_port_t
+portcon tcp 113 system_u:object_r:inetd_child_port_t
+portcon tcp 512 system_u:object_r:inetd_child_port_t
+portcon tcp 543 system_u:object_r:inetd_child_port_t
+portcon tcp 544 system_u:object_r:inetd_child_port_t
+portcon tcp 891 system_u:object_r:inetd_child_port_t
+portcon udp 891 system_u:object_r:inetd_child_port_t
+portcon tcp 892 system_u:object_r:inetd_child_port_t
+portcon udp 892 system_u:object_r:inetd_child_port_t
+portcon tcp 2105 system_u:object_r:inetd_child_port_t
 ')
 ifdef(`ftpd.te', `
 portcon tcp 20 system_u:object_r:ftp_data_port_t
@@ -87,6 +90,9 @@
 portcon udp 162 system_u:object_r:snmp_port_t
 portcon tcp 199 system_u:object_r:snmp_port_t
 ')
+ifdef(`comsat.te', `
+portcon udp 512 system_u:object_r:comsat_port_t
+')
 ifdef(`slapd.te', `portcon tcp 389 system_u:object_r:ldap_port_t')
 ifdef(`rlogind.te', `portcon tcp 513 system_u:object_r:rlogin_port_t')
 ifdef(`rshd.te', `portcon tcp 514 system_u:object_r:rsh_port_t')
@@ -102,7 +108,17 @@
 portcon tcp 631 system_u:object_r:ipp_port_t
 portcon udp 631 system_u:object_r:ipp_port_t
 ')
+ifdef(`kerberos.te', `
+portcon tcp 88 system_u:object_r:kerberos_port_t
+portcon tcp 749 system_u:object_r:kerberos_admin_port_t
+portcon tcp 750 system_u:object_r:kerberos_port_t
+portcon tcp 4444 system_u:object_r:kerberos_master_port_t
+')
 ifdef(`spamd.te', `portcon tcp 783 system_u:object_r:spamd_port_t')
+ifdef(`rsync.te', `
+portcon tcp 873 system_u:object_r:rsync_port_t
+portcon udp 873 system_u:object_r:rsync_port_t
+')
 ifdef(`swat.te', `portcon tcp 901 system_u:object_r:swat_port_t')
 ifdef(`named.te', `portcon tcp 953 system_u:object_r:rndc_port_t')
 ifdef(`use_pop', `
@@ -112,10 +128,13 @@
 ')
 ifdef(`nessusd.te', `portcon tcp 1241 system_u:object_r:nessus_port_t')
 ifdef(`monopd.te', `portcon tcp 1234 system_u:object_r:monopd_port_t')
-ifdef(`radius.te', `portcon udp 1645 system_u:object_r:radius_port_t
+ifdef(`radius.te', `
+portcon udp 1645 system_u:object_r:radius_port_t
 portcon udp 1646 system_u:object_r:radacct_port_t
 portcon udp 1812 system_u:object_r:radius_port_t
-portcon udp 1813 system_u:object_r:radacct_port_t')
+portcon udp 1813 system_u:object_r:radacct_port_t
+')
+ifdef(`dbskkd.te', `portcon tcp 1178 system_u:object_r:dbskkd_port_t')
 ifdef(`gatekeeper.te', `
 portcon udp 1718 system_u:object_r:gatekeeper_port_t
 portcon udp 1719 system_u:object_r:gatekeeper_port_t
@@ -146,7 +165,7 @@
 portcon tcp 5269 system_u:object_r:jabber_interserver_port_t
 ')
 ifdef(`postgresql.te', `portcon tcp 5432 system_u:object_r:postgresql_port_t')
-ifdef(`nrpe.te', `portcon tcp 5666 system_u:object_r:inetd_port_t')
+ifdef(`nrpe.te', `portcon tcp 5666 system_u:object_r:inetd_child_port_t')
 ifdef(`xdm.te', `
 portcon tcp 5900  system_u:object_r:vnc_port_t 
 ')
@@ -190,8 +209,8 @@
 portcon tcp 10080 system_u:object_r:amanda_port_t
 portcon udp 10081 system_u:object_r:amanda_port_t
 portcon tcp 10081 system_u:object_r:amanda_port_t
-portcon tcp 10082 system_u:object_r:amandaidx_port_t
-portcon tcp 10083 system_u:object_r:amidxtape_port_t
+portcon tcp 10082 system_u:object_r:amanda_port_t
+portcon tcp 10083 system_u:object_r:amanda_port_t
 ')
 ifdef(`postgrey.te', `portcon tcp 60000 system_u:object_r:postgrey_port_t')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.26/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-20 13:57:29.000000000 -0400
+++ policy-1.17.26/tunables/distro.tun	2004-10-01 16:40:12.340801128 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.26/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-09-27 20:48:36.000000000 -0400
+++ policy-1.17.26/tunables/tunable.tun	2004-10-01 16:40:12.340801128 -0400
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

--------------020200020908060300000205--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
