Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAL5D1Ii029375
	for <selinux@tycho.nsa.gov>; Sun, 21 Nov 2004 00:13:01 -0500 (EST)
Message-ID: <41A023DE.5070808@redhat.com>
Date: Sun, 21 Nov 2004 00:13:02 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: gentoo policy for dante
References: <4198E94B.8070008@gentoo.org>	 <1100808438.26930.28.camel@moss-lions.epoch.ncsc.mil>	 <419D1ABD.4020901@gentoo.org> <1100893919.31793.32.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1100893919.31793.32.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------010401060904050806050000"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010401060904050806050000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

More policy changes.

--------------010401060904050806050000
Content-Type: text/x-patch;
 name="policy-small.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-small.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.19.4/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2004-11-20 22:29:08.000000000 -0500
+++ policy-1.19.4/domains/program/unused/apache.te	2004-11-20 23:55:38.629090793 -0500
@@ -264,7 +264,7 @@
 r_dir_file(httpd_suexec_t, nfs_t)
 can_exec(httpd_suexec_t, nfs_t)
 }
-
+r_dir_file(httpd_t, fonts_t)
 
 #
 # Allow users to mount additional directories as http_source
@@ -289,10 +289,6 @@
 allow httpd_sys_script_t user_home_dir_t:dir { getattr search };
 allow httpd_t user_home_dir_t:dir { getattr search };
 }
-# 
-# Allow httpd to work with postgresql
-#
-allow httpd_t tmp_t:sock_file rw_file_perms;
 ') dnl targeted policy
 
 ifdef(`distro_redhat', `
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.19.4/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-11-18 08:13:58.000000000 -0500
+++ policy-1.19.4/domains/program/unused/hald.te	2004-11-20 23:55:38.633090342 -0500
@@ -21,6 +21,7 @@
 ifdef(`dbusd.te', `
 allow hald_t system_dbusd_t:dbus { acquire_svc send_msg };
 dbusd_client(system, hald)
+allow hald_t self:dbus send_msg;
 ')
 
 allow hald_t { self proc_t }:file { getattr read };
@@ -69,3 +70,4 @@
 allow hald_t device_t:dir create_dir_perms;
 allow hald_t device_t:chr_file create_file_perms;
 tmp_domain(hald)
+allow hald_t mnt_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kerberos.te policy-1.19.4/domains/program/unused/kerberos.te
--- nsapolicy/domains/program/unused/kerberos.te	2004-11-09 13:35:12.000000000 -0500
+++ policy-1.19.4/domains/program/unused/kerberos.te	2004-11-20 23:55:38.633090342 -0500
@@ -50,26 +50,31 @@
 # Bind to the kerberos, kerberos-adm ports.
 allow krb5kdc_t kerberos_port_t:udp_socket name_bind;
 allow krb5kdc_t kerberos_port_t:tcp_socket name_bind;
-allow kadmind_t kerberos_admin_port_t:tcp_socket name_bind;
+allow kadmind_t kerberos_admin_port_t:{ udp_socket tcp_socket } name_bind;
+dontaudit kadmind_t reserved_port_type:tcp_socket name_bind;
+allow kadmind_t reserved_port_t:tcp_socket name_bind;
 
 #
 # Rules for Kerberos5 KDC daemon
 allow krb5kdc_t self:unix_dgram_socket create_socket_perms;
 allow krb5kdc_t self:unix_stream_socket create_socket_perms;
+allow kadmind_t  self:unix_stream_socket create_socket_perms;
 allow krb5kdc_t krb5kdc_conf_t:dir search;
 allow krb5kdc_t krb5kdc_conf_t:file r_file_perms;
 allow krb5kdc_t krb5kdc_principal_t:file r_file_perms;
 dontaudit krb5kdc_t krb5kdc_principal_t:file write;
 allow krb5kdc_t locale_t:file { getattr read };
 dontaudit krb5kdc_t krb5kdc_conf_t:file write;
-allow krb5kdc_t etc_t:dir { getattr search };
-allow krb5kdc_t etc_t:file { getattr read };
-allow krb5kdc_t krb5_conf_t:file r_file_perms;
-dontaudit krb5kdc_t krb5_conf_t:file write;
+allow { kadmind_t krb5kdc_t } etc_t:dir { getattr search };
+allow { kadmind_t krb5kdc_t } etc_t:file { getattr read };
+allow { kadmind_t krb5kdc_t } krb5_conf_t:file r_file_perms;
+dontaudit { kadmind_t krb5kdc_t } krb5_conf_t:file write;
 tmp_domain(krb5kdc)
 log_domain(krb5kdc)
-allow krb5kdc_t urandom_device_t:chr_file { getattr read };
-allow krb5kdc_t self:netlink_socket { create bind getattr read write };
+allow { kadmind_t krb5kdc_t } urandom_device_t:chr_file { getattr read };
+allow kadmind_t random_device_t:chr_file { getattr read };
+allow krb5kdc_t self:netlink_route_socket r_netlink_socket_perms;
+allow kadmind_t self:netlink_route_socket r_netlink_socket_perms;
 allow krb5kdc_t proc_t:dir r_dir_perms;
 allow krb5kdc_t proc_t:file { getattr read };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postgresql.te policy-1.19.4/domains/program/unused/postgresql.te
--- nsapolicy/domains/program/unused/postgresql.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.4/domains/program/unused/postgresql.te	2004-11-20 23:55:38.634090229 -0500
@@ -110,6 +110,14 @@
 dontaudit postgresql_t selinux_config_t:dir { search };
 allow postgresql_t mail_spool_t:dir { search };
 rw_dir_create_file(postgresql_t, var_lock_t)
+can_exec(postgresql_t, { shell_exec_t bin_t } )
+ifdef(`httpd.te', `
+# 
+# Allow httpd to work with postgresql
+#
+allow httpd_t postgresql_tmp_t:sock_file rw_file_perms;
+can_unix_connect(httpd_t, posgresql_t)
+')
 
 ifdef(`distro_gentoo', `
 # "su - postgres ..." is called from initrc_t
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/stunnel.te policy-1.19.4/domains/program/unused/stunnel.te
--- nsapolicy/domains/program/unused/stunnel.te	2004-11-18 14:44:59.000000000 -0500
+++ policy-1.19.4/domains/program/unused/stunnel.te	2004-11-20 23:55:38.635090116 -0500
@@ -2,21 +2,10 @@
 #
 # Author:   petre rodan <kaiowas@gentoo.org>
 #
+inetd_child_domain(stunnel, tcp)
 
-type stunnel_port_t, port_type;
-
-daemon_domain(stunnel)
-
-can_network(stunnel_t)
-
-type stunnel_etc_t, file_type, sysadmfile;
-
-allow stunnel_t self:capability { setgid setuid sys_chroot };
-allow stunnel_t self:fifo_file { read write };
-allow stunnel_t self:tcp_socket { read write };
-allow stunnel_t self:unix_stream_socket { connect create };
-
+allow stunnel_t self:capability sys_chroot;
 allow stunnel_t stunnel_port_t:tcp_socket { name_bind };
 
+type stunnel_etc_t, file_type, sysadmfile;
 r_dir_file(stunnel_t, stunnel_etc_t)
-r_dir_file(stunnel_t, etc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/cups.fc policy-1.19.4/file_contexts/program/cups.fc
--- nsapolicy/file_contexts/program/cups.fc	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.4/file_contexts/program/cups.fc	2004-11-20 23:55:38.635090116 -0500
@@ -1,7 +1,7 @@
 # cups printing
 /etc/cups(/.*)?			system_u:object_r:cupsd_etc_t
 /usr/share/cups(/.*)?		system_u:object_r:cupsd_etc_t
-/etc/alchemist/namespace/printconf/(/.*)? system_u:object_r:cupsd_rw_etc_t
+/etc/alchemist/namespace/printconf(/.*)? system_u:object_r:cupsd_rw_etc_t
 /var/cache/alchemist/printconf.* system_u:object_r:cupsd_rw_etc_t
 /etc/cups/client\.conf	--	system_u:object_r:etc_t
 /etc/cups/cupsd\.conf.* --	system_u:object_r:cupsd_rw_etc_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/dovecot.fc policy-1.19.4/file_contexts/program/dovecot.fc
--- nsapolicy/file_contexts/program/dovecot.fc	2004-11-19 11:20:43.000000000 -0500
+++ policy-1.19.4/file_contexts/program/dovecot.fc	2004-11-20 23:55:38.636090003 -0500
@@ -9,4 +9,4 @@
 /usr/share/ssl/certs/dovecot\.pem --	system_u:object_r:dovecot_cert_t
 /usr/share/ssl/private/dovecot\.pem --	system_u:object_r:dovecot_cert_t
 /var/run/dovecot(-login)?(/.*)?		system_u:object_r:dovecot_var_run_t
-/usr/lib/dovecot/.+	--		system_u:object_r:bin_t
+/usr/lib(64)?/dovecot/.+	--		system_u:object_r:bin_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/dpkg.fc policy-1.19.4/file_contexts/program/dpkg.fc
--- nsapolicy/file_contexts/program/dpkg.fc	2004-11-19 11:20:43.000000000 -0500
+++ policy-1.19.4/file_contexts/program/dpkg.fc	2004-11-20 23:55:38.636090003 -0500
@@ -47,5 +47,5 @@
 /usr/share/shorewall/.*	--	system_u:object_r:bin_t
 /usr/share/reportbug/.*	--	system_u:object_r:bin_t
 /etc/network/ifstate.*	--	system_u:object_r:etc_runtime_t
-/usr/lib/gconf2/gconfd-2 --	system_u:object_r:bin_t
+/usr/lib(64)?/gconf2/gconfd-2 --	system_u:object_r:bin_t
 /bin/mountpoint		--	system_u:object_r:fsadm_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/hotplug.fc policy-1.19.4/file_contexts/program/hotplug.fc
--- nsapolicy/file_contexts/program/hotplug.fc	2004-11-19 11:20:43.000000000 -0500
+++ policy-1.19.4/file_contexts/program/hotplug.fc	2004-11-20 23:55:38.637089890 -0500
@@ -1,10 +1,10 @@
 # hotplug
 /etc/hotplug(/.*)?		system_u:object_r:hotplug_etc_t
 /sbin/hotplug		--	system_u:object_r:hotplug_exec_t
-/etc/hotplug\.d/.*	--	system_u:object_r:hotplug_exec_t
 /sbin/netplugd		--	system_u:object_r:hotplug_exec_t
-/etc/hotplug.d/default/default.* system_u:object_r:sbin_t
-/etc/netplug.d(/.*)? 	 	system_u:object_r:sbin_t
+/etc/hotplug\.d/.*	--	system_u:object_r:hotplug_exec_t
+/etc/hotplug\.d/default/default.* system_u:object_r:sbin_t
+/etc/netplug\.d(/.*)? 	 	system_u:object_r:sbin_t
 /etc/hotplug/.*agent	--	system_u:object_r:sbin_t
 /etc/hotplug/.*rc	-- 	system_u:object_r:sbin_t
 /etc/hotplug/hotplug\.functions --	system_u:object_r:sbin_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/nrpe.fc policy-1.19.4/file_contexts/program/nrpe.fc
--- nsapolicy/file_contexts/program/nrpe.fc	2004-11-19 11:20:44.000000000 -0500
+++ policy-1.19.4/file_contexts/program/nrpe.fc	2004-11-20 23:55:38.637089890 -0500
@@ -1,5 +1,5 @@
 # nrpe
 /usr/bin/nrpe		--	system_u:object_r:nrpe_exec_t
 /etc/nagios/nrpe\.cfg	--	system_u:object_r:nrpe_etc_t
-/usr/lib/netsaint/plugins(/.*)?	--	system_u:object_r:bin_t
-/usr/lib/nagios/plugins(/.*)?	--	system_u:object_r:bin_t
+/usr/lib(64)?/netsaint/plugins(/.*)?	--	system_u:object_r:bin_t
+/usr/lib(64)?/nagios/plugins(/.*)?	--	system_u:object_r:bin_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/xdm.fc policy-1.19.4/file_contexts/program/xdm.fc
--- nsapolicy/file_contexts/program/xdm.fc	2004-11-19 11:20:44.000000000 -0500
+++ policy-1.19.4/file_contexts/program/xdm.fc	2004-11-20 23:55:38.638089778 -0500
@@ -21,7 +21,6 @@
 ifdef(`distro_suse', `
 /var/lib/pam_devperm/:0	--	system_u:object_r:xdm_var_lib_t
 ')
-/usr/lib/qt-3.3/etc/settings/qtrc(/.*)? system_u:object_r:xdm_var_lib_t
 
 #
 # Additional Xsession scripts
@@ -37,4 +36,4 @@
 /etc/kde3?/kdm/Xreset     --		system_u:object_r:xsession_exec_t
 /etc/kde3?/kdm/Xsession		--	system_u:object_r:xsession_exec_t
 /etc/kde3?/kdm/backgroundrc	system_u:object_r:xdm_var_run_t
-/usr/lib(64)?/qt-3.2/etc/settings(/.*)?	system_u:object_r:xdm_var_run_t
+/usr/lib(64)?/qt-.*/etc/settings(/.*)?	system_u:object_r:xdm_var_run_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.19.4/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.4/file_contexts/types.fc	2004-11-20 23:55:38.639089665 -0500
@@ -458,3 +458,11 @@
 #  we defined a type to dontaudit
 #
 /etc/krb5\.conf		--	system_u:object_r:krb5_conf_t
+
+#
+# Thunderbird
+#
+/usr/lib(64)?/[^/]*thunderbird[^/]*/thunderbird --      system_u:object_r:bin_t
+/usr/lib(64)?/[^/]*thunderbird[^/]*/thunderbird-bin -- system_u:object_r:bin_t
+/usr/lib(64)?/[^/]*thunderbird[^/]*/run-mozilla\.sh -- system_u:object_r:bin_t
+/usr/lib(64)?/[^/]*thunderbird[^/]*/mozilla-xremote-client -- system_u:object_r:bin_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.19.4/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.4/macros/base_user_macros.te	2004-11-20 23:55:38.640089552 -0500
@@ -82,7 +82,7 @@
 allow $1_t usbtty_device_t:chr_file read;
 
 # GNOME checks for usb and other devices
-r_dir_file($1_t,usbfs_t)
+rw_dir_file($1_t,usbfs_t)
 
 can_exec($1_t, noexattrfile)
 # Bind to a Unix domain socket in /tmp.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/core_macros.te policy-1.19.4/macros/core_macros.te
--- nsapolicy/macros/core_macros.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.4/macros/core_macros.te	2004-11-20 23:55:38.640089552 -0500
@@ -152,12 +152,12 @@
 #
 # Permissions for creating and using sockets.
 # 
-define(`connected_socket_perms', `{ create_socket_perms -connect }')
+define(`connected_socket_perms', `{ create ioctl read getattr write setattr append bind getopt setopt shutdown }')
 
 #
 # Permissions for creating and using sockets.
 # 
-define(`connected_stream_socket_perms', `{ create_stream_socket_perms -connect }')
+define(`connected_stream_socket_perms', `{ connected_socket_perms listen accept }')
 
 
 #
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mount_macros.te policy-1.19.4/macros/program/mount_macros.te
--- nsapolicy/macros/program/mount_macros.te	2004-11-18 08:13:59.000000000 -0500
+++ policy-1.19.4/macros/program/mount_macros.te	2004-11-20 23:55:38.641089439 -0500
@@ -21,7 +21,7 @@
 # macro if $2_def is defined
 define(`$2_def', `')
 #
-type $2_t, domain, privlog $3;
+type $2_t, domain, privlog $3, nscd_client_domain;
 
 allow $2_t sysfs_t:dir search;
 
@@ -65,6 +65,8 @@
 allow $2_t $1_tty_device_t:chr_file { getattr read write ioctl };
 allow $2_t $1_devpts_t:chr_file { getattr read write };
 ifdef(`gnome-pty-helper.te', `allow $2_t $1_gph_t:fd use;')
+allow $2_t var_t:dir search;
+allow $2_t var_run_t:dir search;
 
 ifdef(`distro_redhat',`
 ifdef(`pamconsole.te',`
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.19.4/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.4/macros/program/mozilla_macros.te	2004-11-21 00:00:58.136040632 -0500
@@ -22,6 +22,7 @@
 
 # Unrestricted inheritance from the caller.
 allow $1_t $1_mozilla_t:process { noatsecure siginh rlimitinh };
+allow $1_mozilla_t $1_t:process signull;
 
 # Set resource limits and scheduling info.
 allow $1_mozilla_t self:process { setrlimit setsched };
@@ -116,6 +117,11 @@
 dontaudit $1_mozilla_t file_type:dir getattr;
 allow $1_mozilla_t self:sem create_sem_perms;
 
+ifdef(`userhelper.te', `
+domain_auto_trans($1_mozilla_t, userhelper_exec_t, $1_userhelper_t)
+')
+dontaudit $1_mozilla_t selinux_config_t:dir search;
+
 ifdef(`xdm.te', `
 allow $1_mozilla_t xdm_t:fifo_file { write read };
 allow $1_mozilla_t xdm_tmp_t:dir search;

--------------010401060904050806050000--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
