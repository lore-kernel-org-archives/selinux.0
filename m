Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1BGECL9018905
	for <selinux@tycho.nsa.gov>; Fri, 11 Feb 2005 11:14:12 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1BGBT04009074
	for <selinux@tycho.nsa.gov>; Fri, 11 Feb 2005 16:11:30 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id j1BGFZq6015298
	for <selinux@tycho.nsa.gov>; Fri, 11 Feb 2005 11:15:35 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id j1BGFZXH015297
	for selinux@tycho.nsa.gov; Fri, 11 Feb 2005 11:15:35 -0500
Message-ID: <420BED11.4020208@redhat.com>
Date: Thu, 10 Feb 2005 18:24:01 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@epoch.ncsc.mil>,
   Jim Carter <jwcart2@epoch.ncsc.mil>
Subject: Latest diffs
Content-Type: multipart/mixed;
 boundary="------------090404060104030607000706"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090404060104030607000706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added secure_file_type attribute

Added dnssec for dns key files to be shared between named and dhcpd.

Added java vm policy

lots of new textrel_shlib_t specs

Fixes to mailman policy to allow creation of new lists

Add mplayer policy

Fixes to make postfix work in targeted policy.

Fixes to allow nmap to run under traceroute policy

Addition of file_browse_domain macro.

Added access_terminal macro

Added legacy_domain macro

Stop httpd_sys_script_t from transitioning in targeted policy if 
httpd_disable_trans is set.

Cleanup tmpreaper, additional tmpfile file_contexts.

Fixes for execmem and execmod

Fixes to Makefile to create homedir_template

Fixed to unconfined.te for targeted to allow sigchld and fd use




--------------090404060104030607000706
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/attrib.te policy-1.21.12/attrib.te
--- nsapolicy/attrib.te	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.12/attrib.te	2005-02-10 15:21:08.000000000 -0500
@@ -221,6 +221,11 @@
 # appropriate.
 attribute file_type;
 
+# The secure_file_type attribute identifies files 
+# which will be treated with a higer level of security.
+# Most domains will be prevented from manipulating files in this domain
+attribute secure_file_type;
+
 # The device_type attribute identifies all types assigned to device nodes
 attribute device_type;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ldconfig.te policy-1.21.12/domains/program/ldconfig.te
--- nsapolicy/domains/program/ldconfig.te	2005-02-10 14:48:38.000000000 -0500
+++ policy-1.21.12/domains/program/ldconfig.te	2005-02-10 15:21:08.000000000 -0500
@@ -38,14 +38,14 @@
 dontaudit ldconfig_t httpd_modules_t:dir search;
 ')
 
-ifdef(`distro_suse', `
-# because of libraries in /var/lib/samba/bin
 allow ldconfig_t { var_t var_lib_t }:dir search;
-')
-
 allow ldconfig_t proc_t:file read;
 ifdef(`hide_broken_symptoms', `
 ifdef(`unconfined.te',`
 dontaudit ldconfig_t unconfined_t:tcp_socket { read write };
-')
+');
 ')dnl end hide_broken_symptoms
+ifdef(`targeted_policy', `
+allow ldconfig_t lib_t:file r_file_perms;
+unconfined_domain(ldconfig_t) 
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.21.12/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2005-02-09 15:01:28.000000000 -0500
+++ policy-1.21.12/domains/program/syslogd.te	2005-02-10 15:21:08.000000000 -0500
@@ -103,3 +103,5 @@
 allow syslogd_t { tmpfs_t devpts_t }:dir search;
 dontaudit syslogd_t unlabeled_t:file read;
 dontaudit syslogd_t { userpty_type devpts_t }:chr_file getattr;
+allow syslogd_t self:capability net_admin;
+allow syslogd_t self:netlink_route_socket r_netlink_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/tmpreaper.te policy-1.21.12/domains/program/tmpreaper.te
--- nsapolicy/domains/program/tmpreaper.te	2005-02-10 14:48:38.000000000 -0500
+++ policy-1.21.12/domains/program/tmpreaper.te	2005-02-10 15:21:08.000000000 -0500
@@ -28,15 +28,6 @@
 r_dir_file(tmpreaper_t, var_lib_t)
 allow tmpreaper_t device_t:dir { getattr search };
 allow tmpreaper_t urandom_device_t:chr_file { getattr read };
-rw_dir_file(tmpreaper_t, var_spool_t)
-allow tmpreaper_t var_spool_t:dir setattr;
-allow tmpreaper_t print_spool_t:dir setattr;
-rw_dir_file(tmpreaper_t, print_spool_t)
 
-ifdef(`distro_redhat', `
-# for the Red Hat tmpreaper program which also manages tetex indexes
-create_dir_file(tmpreaper_t, tetex_data_t)
-allow tmpreaper_t catman_t:dir setattr;
-')
 read_locale(tmpreaper_t)
-
+dontaudit tmpreaper_t init_t:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.21.12/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-02-10 14:48:39.000000000 -0500
+++ policy-1.21.12/domains/program/unused/apache.te	2005-02-10 15:21:08.000000000 -0500
@@ -305,7 +305,7 @@
 # mod_jk2 creates /var/log/httpd/jk2.shm to communicate with tomcat
 # This is a bug but it still exists in FC2
 #
-type httpd_runtime_t, file_type, sysadmfile;
+typealias httpd_log_t  alias httpd_runtime_t;
 allow { httpd_t httpd_sys_script_t } httpd_runtime_t:file { getattr append };
 ') dnl distro_redhat
 #
@@ -322,7 +322,7 @@
 create_dir_file(httpd_t, httpd_squirrelmail_t)
 allow httpd_sys_script_t httpd_squirrelmail_t:file { append read };
 # File Type of squirrelmail attachments
-type squirrelmail_spool_t, file_type, sysadmfile;
+type squirrelmail_spool_t, file_type, sysadmfile, tmpfile;
 allow httpd_t var_spool_t:dir { getattr search };
 create_dir_file(httpd_t, squirrelmail_spool_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cardmgr.te policy-1.21.12/domains/program/unused/cardmgr.te
--- nsapolicy/domains/program/unused/cardmgr.te	2005-02-09 15:01:29.000000000 -0500
+++ policy-1.21.12/domains/program/unused/cardmgr.te	2005-02-10 15:21:08.000000000 -0500
@@ -44,9 +44,6 @@
 
 # Create device files in /tmp.
 type cardmgr_dev_t, file_type, sysadmfile, tmpfile, device_type, dev_fs;
-ifdef(`tmpreaper.te', `
-allow tmpreaper_t cardmgr_dev_t:chr_file { getattr unlink };
-')
 file_type_auto_trans(cardmgr_t, { var_run_t cardmgr_var_run_t device_t tmp_t }, cardmgr_dev_t, { blk_file chr_file })
 
 # Create symbolic links in /dev.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.21.12/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2005-02-10 14:48:39.000000000 -0500
+++ policy-1.21.12/domains/program/unused/cups.te	2005-02-10 15:21:08.000000000 -0500
@@ -33,10 +33,8 @@
 # temporary solution, we need something better
 allow cupsd_t serial_device:chr_file rw_file_perms;
 
-ifdef(`usbmodules.te', `
 r_dir_file(cupsd_t, usbdevfs_t)
 r_dir_file(cupsd_t, usbfs_t)
-')
 
 ifdef(`logrotate.te', `
 domain_auto_trans(logrotate_t, cupsd_exec_t, cupsd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpd.te policy-1.21.12/domains/program/unused/dhcpd.te
--- nsapolicy/domains/program/unused/dhcpd.te	2005-02-09 15:01:28.000000000 -0500
+++ policy-1.21.12/domains/program/unused/dhcpd.te	2005-02-10 15:21:08.000000000 -0500
@@ -75,3 +75,8 @@
 ')
 r_dir_file(dhcpd_t, usr_t)
 allow dhcpd_t { urandom_device_t random_device_t }:chr_file r_file_perms;
+
+ifdef(`named.te', `
+allow dhcpd_t { named_conf_t named_zone_t }:dir search;
+allow dhcpd_t dnssec_t:file { getattr read };
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.21.12/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2005-02-10 14:48:39.000000000 -0500
+++ policy-1.21.12/domains/program/unused/ftpd.te	2005-02-10 15:21:08.000000000 -0500
@@ -90,9 +90,7 @@
 
 dontaudit ftpd_t sysadm_home_dir_t:dir getattr;
 dontaudit ftpd_t selinux_config_t:dir search;
-ifdef(`automount.te', `
 allow ftpd_t autofs_t:dir search;
-')
 allow ftpd_t self:file { getattr read };
 tmp_domain(ftpd)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/java.te policy-1.21.12/domains/program/unused/java.te
--- nsapolicy/domains/program/unused/java.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.12/domains/program/unused/java.te	2005-02-10 15:21:08.000000000 -0500
@@ -0,0 +1,14 @@
+#DESC Java VM 
+#
+# Authors: Dan Walsh <dwalsh@redhat.com> 
+# X-Debian-Packages: java
+#
+
+# Type for the netscape, java or other browser executables.
+type java_exec_t, file_type, sysadmfile, exec_type;
+
+# Allow java to read files in the user home directory
+bool disable_java false;
+
+# Everything else is in the java_domain macro in
+# macros/program/java_macros.te.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kerberos.te policy-1.21.12/domains/program/unused/kerberos.te
--- nsapolicy/domains/program/unused/kerberos.te	2005-02-09 15:01:29.000000000 -0500
+++ policy-1.21.12/domains/program/unused/kerberos.te	2005-02-10 15:21:08.000000000 -0500
@@ -23,7 +23,7 @@
 can_exec(kadmind_t, kadmind_exec_t)
 
 # types for general configuration files in /etc
-type krb5_keytab_t, file_type, sysadmfile;
+type krb5_keytab_t, file_type, sysadmfile, secure_file_type;
 
 # types for KDC configs and principal file(s)
 type krb5kdc_conf_t, file_type, sysadmfile;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mailman.te policy-1.21.12/domains/program/unused/mailman.te
--- nsapolicy/domains/program/unused/mailman.te	2005-02-09 15:01:28.000000000 -0500
+++ policy-1.21.12/domains/program/unused/mailman.te	2005-02-10 15:21:08.000000000 -0500
@@ -20,7 +20,7 @@
 can_exec_any(mailman_$1_t)
 allow mailman_$1_t { proc_t sysctl_t sysctl_kernel_t }:dir search;
 allow mailman_$1_t { proc_t sysctl_kernel_t }:file { read getattr };
-allow mailman_$1_t var_lib_t:dir { getattr search read };
+allow mailman_$1_t var_lib_t:dir r_dir_perms;
 allow mailman_$1_t var_lib_t:lnk_file read;
 allow mailman_$1_t device_t:dir search;
 allow mailman_$1_t etc_runtime_t:file { read getattr };
@@ -29,8 +29,10 @@
 allow mailman_$1_t mailman_lock_t:dir rw_dir_perms;
 allow mailman_$1_t fs_t:filesystem getattr;
 can_network(mailman_$1_t)
-allow mailman_$1_t self:unix_stream_socket create_socket_perms;
+can_ypbind(mailman_$1_t)
+allow mailman_$1_t self:{ unix_stream_socket unix_dgram_socket } create_socket_perms;
 allow mailman_$1_t var_t:dir r_dir_perms;
+tmp_domain(mailman_$1)
 ')
 
 mailman_domain(queue, `, auth_chkpwd, nscd_client_domain')
@@ -71,7 +73,7 @@
 domain_auto_trans({ httpd_t httpd_suexec_t }, mailman_cgi_exec_t, mailman_cgi_t)
 # should have separate types for public and private archives
 r_dir_file(httpd_t, mailman_archive_t)
-rw_dir_create_file(mailman_cgi_t, mailman_archive_t)
+create_dir_file(mailman_cgi_t, mailman_archive_t)
 allow httpd_t mailman_data_t:dir { getattr search };
 
 dontaudit mailman_cgi_t httpd_log_t:file append;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mplayer.te policy-1.21.12/domains/program/unused/mplayer.te
--- nsapolicy/domains/program/unused/mplayer.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.12/domains/program/unused/mplayer.te	2005-02-10 15:21:08.000000000 -0500
@@ -0,0 +1,12 @@
+#DESC mplayer - media player 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Type for the mplayer executable.
+type mplayer_exec_t, file_type, exec_type, sysadmfile;
+type mencoder_exec_t, file_type, exec_type, sysadmfile;
+type mplayer_etc_t, file_type, sysadmfile;
+
+# Everything else is in the mplayer_domain macro in
+# macros/program/mplayer_macros.te.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mta.te policy-1.21.12/domains/program/unused/mta.te
--- nsapolicy/domains/program/unused/mta.te	2005-02-09 15:01:28.000000000 -0500
+++ policy-1.21.12/domains/program/unused/mta.te	2005-02-10 15:21:08.000000000 -0500
@@ -20,7 +20,9 @@
 # "mail user@domain"
 mail_domain(system)
 
-ifdef(`targeted_policy', `', `
+ifdef(`targeted_policy', `
+ifdef(`postfix.te', `', `can_exec_any(system_mail_t)')
+', `
 ifdef(`sendmail.te', `
 # sendmail has an ugly design, the one process parses input from the user and
 # then does system things with it.
@@ -73,11 +75,11 @@
 # targeted policy.  We could move these rules permanantly here.
 ifdef(`targeted_policy', `
 allow system_mail_t self:dir { search };
-allow system_mail_t proc_t:dir search;
-allow system_mail_t proc_t:{ file lnk_file } { getattr read };
+r_dir_file(system_mail_t, { proc_t proc_net_t })
 allow system_mail_t fs_t:filesystem getattr;
 allow system_mail_t { var_t var_spool_t }:dir getattr;
 create_dir_file( system_mail_t, mqueue_spool_t)
+allow system_mail_t mail_spool_t:fifo_file rw_file_perms;
 ')
 allow system_mail_t etc_runtime_t:file { getattr read };
 allow system_mail_t urandom_device_t:chr_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.21.12/domains/program/unused/named.te
--- nsapolicy/domains/program/unused/named.te	2005-02-10 14:48:39.000000000 -0500
+++ policy-1.21.12/domains/program/unused/named.te	2005-02-10 15:21:08.000000000 -0500
@@ -42,6 +42,10 @@
 # for secondary zone files
 type named_cache_t, file_type, sysadmfile;
 
+# for DNSSEC key files
+type dnssec_t, file_type, sysadmfile, secure_file_type;
+allow { ndc_t named_t } dnssec_t:file { getattr read };
+
 # Use capabilities. Surplus capabilities may be allowed.
 allow named_t self:capability { chown dac_override fowner setgid setuid net_bind_service sys_chroot sys_nice sys_resource };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.21.12/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2005-02-10 14:48:39.000000000 -0500
+++ policy-1.21.12/domains/program/unused/nscd.te	2005-02-10 15:21:08.000000000 -0500
@@ -72,4 +72,4 @@
 allow nscd_t self:netlink_route_socket r_netlink_socket_perms;
 allow nscd_t tmp_t:dir { search getattr };
 allow nscd_t tmp_t:lnk_file read;
-allow nscd_t urandom_device_t:chr_file { getattr read };
+allow nscd_t { urandom_device_t random_device_t }:chr_file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.21.12/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2005-02-10 14:48:40.000000000 -0500
+++ policy-1.21.12/domains/program/unused/samba.te	2005-02-10 15:21:08.000000000 -0500
@@ -164,9 +164,8 @@
 r_dir_file(smbmount_t, proc_t)
 
 # Fork smbmnt 
-# FIXME: label bin_t as more restricted type?
 allow smbmount_t bin_t:dir r_dir_perms;
-can_exec(smbmount_t,bin_t)
+can_exec(smbmount_t, smbmount_exec_t)
 allow smbmount_t self:process { fork signal_perms };
 
 # Mount 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/traceroute.te policy-1.21.12/domains/program/unused/traceroute.te
--- nsapolicy/domains/program/unused/traceroute.te	2005-02-09 15:01:29.000000000 -0500
+++ policy-1.21.12/domains/program/unused/traceroute.te	2005-02-10 15:21:08.000000000 -0500
@@ -39,8 +39,8 @@
 
 # for lft
 allow traceroute_t self:packet_socket create_socket_perms;
-allow traceroute_t proc_t:dir search;
-allow traceroute_t proc_t:file { getattr read };
+r_dir_file(traceroute_t, proc_t)
+r_dir_file(traceroute_t, proc_net_t)
 
 # Access the terminal.
 allow traceroute_t admin_tty_type:chr_file rw_file_perms;
@@ -58,3 +58,8 @@
 	allow traceroute_t { ttyfile ptyfile }:chr_file rw_file_perms;
 }
 ')
+#rules needed for nmap
+allow traceroute_t { urandom_device_t random_device_t }:chr_file r_file_perms;
+allow traceroute_t usr_t:file { getattr read };
+read_locale(traceroute_t)
+dontaudit traceroute_t userdomain:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/distros.fc policy-1.21.12/file_contexts/distros.fc
--- nsapolicy/file_contexts/distros.fc	2005-02-09 15:01:44.000000000 -0500
+++ policy-1.21.12/file_contexts/distros.fc	2005-02-10 17:31:57.000000000 -0500
@@ -36,6 +36,7 @@
 /usr/share/texmf/web2c/mktexnam	--	system_u:object_r:bin_t
 /usr/share/texmf/web2c/mktexupd	--	system_u:object_r:bin_t
 /usr/share/ssl/certs(/.*)?		system_u:object_r:cert_t
+/usr/share/ssl/private(/.*)?		system_u:object_r:cert_t
 /usr/share/ssl/misc(/.*)?		system_u:object_r:bin_t
 #
 # /emul/ia32-linux/usr
@@ -64,8 +65,81 @@
 /var/run/dbus(/.*)?            system_u:object_r:system_dbusd_var_run_t
 ')
 
-/usr/lib/.*/plugins/libflashplayer\.so.* -- system_u:object_r:texrel_shlib_t
-/usr/X11R6/lib/modules/dri/.*\.so -- system_u:object_r:texrel_shlib_t
+# The following are libraries with text relocations in need of execmod permissions
+# Some of them should be fixed and removed from this list
+
+# Fedora Core packages: gstreamer-plugins, compat-libstdc++, Glide3, libdv
+# 	HelixPlayer, SDL, xorg-x11, xorg-x11-libs, Hermes, valgrind, openoffice.org-libs
+/usr/lib/gstreamer-.*/libgstffmpeg\.so.*  -- system_u:object_r:texrel_shlib_t
+/usr/lib/gstreamer-.*/libgsthermescolorspace\.so -- system_u:object_r:texrel_shlib_t
+/usr/lib/gstreamer-.*/libgstmms\.so 	 -- system_u:object_r:texrel_shlib_t
+/usr/lib/libstdc\+\+\.so\.2\.7\.2\.8 		-- system_u:object_r:texrel_shlib_t
+/usr/lib/libg\+\+\.so\.2\.7\.2\.8		-- system_u:object_r:texrel_shlib_t
+/usr/lib/libglide3\.so.* 			-- system_u:object_r:texrel_shlib_t
+/usr/lib/libdv\.so.* 				-- system_u:object_r:texrel_shlib_t
+/usr/lib/helix/plugins/oggfformat\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/helix/plugins/theorarend\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/helix/plugins/vorbisrend\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/helix/codecs/colorcvt\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/helix/codecs/cvt1\.so			-- system_u:object_r:texrel_shlib_t
+/usr/lib/libSDL-.*\.so.*			-- system_u:object_r:texrel_shlib_t
+/usr/X11R6/lib/modules/dri/.*\.so		-- system_u:object_r:texrel_shlib_t
+/usr/X11R6/lib/libOSMesa\.so.*			-- system_u:object_r:texrel_shlib_t
+/usr/lib/libHermes\.so.*			-- system_u:object_r:texrel_shlib_t
+/usr/lib/valgrind/libpthread\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/valgrind/vgpreload_addrcheck\.so	-- system_u:object_r:texrel_shlib_t
+/usr/lib/valgrind/vgpreload_memcheck\.so	-- system_u:object_r:texrel_shlib_t
+/usr/lib/valgrind/vgskin_addrcheck\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/valgrind/vgskin_cachegrind\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/valgrind/vgskin_callgrind\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/valgrind/vgskin_corecheck\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/valgrind/vgskin_helgrind\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/valgrind/vgskin_lackey\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/valgrind/vgskin_massif\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/valgrind/vgskin_memcheck\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/valgrind/vgskin_none\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/ooo-.*/program/libicudata\.so.*	-- system_u:object_r:texrel_shlib_t
+/usr/lib/ooo-.*/program/libsts645li\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/ooo-.*/program/libvclplug_gen645li\.so	-- system_u:object_r:texrel_shlib_t
+/usr/lib/ooo-.*/program/libwrp645li\.so		-- system_u:object_r:texrel_shlib_t
+# Fedora Extras packages: ladspa, imlib2, ocaml
+/usr/lib/ladspa/analogue_osc_1416\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/ladspa/bandpass_a_iir_1893\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/ladspa/bandpass_iir_1892\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/ladspa/butterworth_1902\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/ladspa/fm_osc_1415\.so			-- system_u:object_r:texrel_shlib_t
+/usr/lib/ladspa/gsm_1215\.so			-- system_u:object_r:texrel_shlib_t
+/usr/lib/ladspa/gverb_1216\.so			-- system_u:object_r:texrel_shlib_t
+/usr/lib/ladspa/hermes_filter_1200\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/ladspa/highpass_iir_1890\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/ladspa/lowpass_iir_1891\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/ladspa/notch_iir_1894\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/ladspa/pitch_scale_1193\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/ladspa/pitch_scale_1194\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/ladspa/sc1_1425\.so			-- system_u:object_r:texrel_shlib_t
+/usr/lib/ladspa/sc2_1426\.so			-- system_u:object_r:texrel_shlib_t
+/usr/lib/ladspa/sc3_1427\.so			-- system_u:object_r:texrel_shlib_t
+/usr/lib/ladspa/sc4_1882\.so			-- system_u:object_r:texrel_shlib_t
+/usr/lib/ladspa/se4_1883\.so			-- system_u:object_r:texrel_shlib_t
+/usr/lib/libImlib2\.so.* 			-- system_u:object_r:texrel_shlib_t
+/usr/lib/ocaml/stublibs/dllnums\.so		-- system_u:object_r:texrel_shlib_t
+
+# Livna.org packages: xmms-mp3, ffmpeg, xvidcore, xine-lib, gsm, lame
+/usr/lib/xmms/Input/libmpg123\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/libpostproc\.so.*			-- system_u:object_r:texrel_shlib_t
+/usr/lib/libavformat-.*\.so			-- system_u:object_r:texrel_shlib_t
+/usr/lib/libavcodec-.*\.so			-- system_u:object_r:texrel_shlib_t
+/usr/lib/libxvidcore\.so.*			-- system_u:object_r:texrel_shlib_t
+/usr/lib/xine/plugins/.*\.so			-- system_u:object_r:texrel_shlib_t
+/usr/lib/libgsm\.so.*				-- system_u:object_r:texrel_shlib_t
+/usr/lib/libmp3lame\.so.*			-- system_u:object_r:texrel_shlib_t
+
+# Flash plugin, Macromedia
+HOME_DIR/.*/plugins/libflashplayer\.so.*	-- system_u:object_r:texrel_shlib_t
+/usr/lib/.*/plugins/libflashplayer\.so.*	-- system_u:object_r:texrel_shlib_t
+
+# Jai, Sun Microsystems (Jpackage SPRM)
+/usr/lib/libmlib_jai\.so			-- system_u:object_r:texrel_shlib_t
 
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/java.fc policy-1.21.12/file_contexts/program/java.fc
--- nsapolicy/file_contexts/program/java.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.12/file_contexts/program/java.fc	2005-02-10 15:21:08.000000000 -0500
@@ -0,0 +1,2 @@
+#  java
+/usr(/.*)?/bin/java.* --	system_u:object_r:java_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mozilla.fc policy-1.21.12/file_contexts/program/mozilla.fc
--- nsapolicy/file_contexts/program/mozilla.fc	2005-02-09 15:01:30.000000000 -0500
+++ policy-1.21.12/file_contexts/program/mozilla.fc	2005-02-10 15:21:08.000000000 -0500
@@ -7,6 +7,7 @@
 HOME_DIR/\.gconf(/.*)?		system_u:object_r:ROLE_mozilla_rw_t
 HOME_DIR/\.gnome2/epiphany(/.*)? system_u:object_r:ROLE_mozilla_rw_t
 HOME_DIR/My.Downloads(/.*)?	system_u:object_r:ROLE_mozilla_rw_t
+HOME_DIR/\.java(/.*)?		system_u:object_r:ROLE_mozilla_rw_t
 /usr/bin/netscape	--	system_u:object_r:mozilla_exec_t
 /usr/bin/mozilla	--	system_u:object_r:mozilla_exec_t
 /usr/bin/mozilla-snapshot --	system_u:object_r:mozilla_exec_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mplayer.fc policy-1.21.12/file_contexts/program/mplayer.fc
--- nsapolicy/file_contexts/program/mplayer.fc	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.12/file_contexts/program/mplayer.fc	2005-02-10 15:21:08.000000000 -0500
@@ -0,0 +1,6 @@
+# mplayer
+/usr/bin/mplayer	--	   	system_u:object_r:mplayer_exec_t
+/usr/bin/mencoder	--	   	system_u:object_r:mencoder_exec_t
+
+/etc/mplayer(/.*)?		system_u:object_r:mplayer_etc_t
+HOME_DIR/\.mplayer(/.*)?        system_u:object_r:ROLE_mplayer_rw_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/mta.fc policy-1.21.12/file_contexts/program/mta.fc
--- nsapolicy/file_contexts/program/mta.fc	2005-02-09 15:01:29.000000000 -0500
+++ policy-1.21.12/file_contexts/program/mta.fc	2005-02-10 15:21:08.000000000 -0500
@@ -5,3 +5,8 @@
 /etc/aliases\.db	--	system_u:object_r:etc_aliases_t
 /var/spool/mail(/.*)?		system_u:object_r:mail_spool_t
 /var/mail(/.*)?			system_u:object_r:mail_spool_t
+ifdef(`postfix.te', `', `
+/usr/sbin/sendmail.postfix --	system_u:object_r:sendmail_exec_t
+/var/spool/postfix(/.*)?		system_u:object_r:mail_spool_t
+')
+
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/named.fc policy-1.21.12/file_contexts/program/named.fc
--- nsapolicy/file_contexts/program/named.fc	2005-02-09 15:01:30.000000000 -0500
+++ policy-1.21.12/file_contexts/program/named.fc	2005-02-10 15:21:08.000000000 -0500
@@ -14,6 +14,7 @@
 ') dnl distro_debian
 
 /etc/rndc.*		--	system_u:object_r:named_conf_t
+/etc/rndc.key  		-- 	system_u:object_r:dnssec_t
 /usr/sbin/named      	--	system_u:object_r:named_exec_t
 /usr/sbin/r?ndc		--	system_u:object_r:ndc_exec_t
 /var/run/ndc		-s	system_u:object_r:named_var_run_t
@@ -26,8 +27,8 @@
 /var/named/chroot/dev/null   -c	system_u:object_r:null_device_t
 /var/named/chroot/dev/random -c	system_u:object_r:random_device_t
 /var/named/chroot/dev/zero -c	system_u:object_r:zero_device_t
-/var/named/chroot/etc/named\.conf -- system_u:object_r:named_conf_t
-/var/named/chroot/etc/rndc.* -- system_u:object_r:named_conf_t
+/var/named/chroot/etc(/.*)? 	system_u:object_r:named_conf_t
+/var/named/chroot/etc/rndc.key  -- system_u:object_r:dnssec_t
 /var/named/chroot/var/run/named.* system_u:object_r:named_var_run_t
 /var/named/chroot/var/tmp(/.*)? system_u:object_r:named_cache_t
 /var/named/chroot/var/named(/.*)?	system_u:object_r:named_zone_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/postfix.fc policy-1.21.12/file_contexts/program/postfix.fc
--- nsapolicy/file_contexts/program/postfix.fc	2005-02-09 15:01:30.000000000 -0500
+++ policy-1.21.12/file_contexts/program/postfix.fc	2005-02-10 15:21:08.000000000 -0500
@@ -28,17 +28,12 @@
 /usr/sbin/postsuper	--	system_u:object_r:postfix_master_exec_t
 /usr/sbin/rmail		--	system_u:object_r:sendmail_exec_t
 /usr/sbin/sendmail.postfix --	system_u:object_r:sendmail_exec_t
-/var/spool/postfix(/[^/]+)?	system_u:object_r:postfix_spool_t
-/var/spool/postfix/active(/.*)?	system_u:object_r:postfix_spool_t
-/var/spool/postfix/hold(/.*)?	system_u:object_r:postfix_spool_t
-/var/spool/postfix/incoming(/.*)? system_u:object_r:postfix_spool_t
-/var/spool/postfix/corrupt(/.*)? system_u:object_r:postfix_spool_t
+/var/spool/postfix(/.*)?	system_u:object_r:postfix_spool_t
 /var/spool/postfix/maildrop(/.*)? system_u:object_r:postfix_spool_maildrop_t
 /var/spool/postfix/pid	-d	system_u:object_r:var_run_t
 /var/spool/postfix/pid/.*	system_u:object_r:postfix_var_run_t
 /var/spool/postfix/private(/.*)? system_u:object_r:postfix_private_t
 /var/spool/postfix/public(/.*)? system_u:object_r:postfix_public_t
-/var/spool/postfix/defer(red)?(/.*)? system_u:object_r:postfix_spool_t
 /var/spool/postfix/bounce(/.*)? system_u:object_r:postfix_spool_bounce_t
 /var/spool/postfix/flush(/.*)?	system_u:object_r:postfix_spool_flush_t
 /var/spool/postfix/etc(/.*)?	system_u:object_r:etc_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/samba.fc policy-1.21.12/file_contexts/program/samba.fc
--- nsapolicy/file_contexts/program/samba.fc	2005-02-09 15:01:45.000000000 -0500
+++ policy-1.21.12/file_contexts/program/samba.fc	2005-02-10 15:21:08.000000000 -0500
@@ -20,5 +20,6 @@
 /var/run/samba/nmbd\.pid --	system_u:object_r:nmbd_var_run_t
 /var/spool/samba(/.*)?		system_u:object_r:samba_var_t
 ifdef(`mount.te', `
-/usr/bin/smbmount		system_u:object_r:smbmount_exec_t
+/usr/bin/smbmount	--	system_u:object_r:smbmount_exec_t
+/usr/bin/smbmnt		--	system_u:object_r:smbmount_exec_t
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/udev.fc policy-1.21.12/file_contexts/program/udev.fc
--- nsapolicy/file_contexts/program/udev.fc	2005-02-09 15:01:30.000000000 -0500
+++ policy-1.21.12/file_contexts/program/udev.fc	2005-02-10 15:21:08.000000000 -0500
@@ -6,6 +6,7 @@
 /usr/bin/udevinfo --	system_u:object_r:udev_exec_t
 /etc/dev\.d/.+	--	system_u:object_r:udev_helper_exec_t
 /etc/udev/scripts/.+	-- system_u:object_r:udev_helper_exec_t
+/etc/udev/devices/.*    system_u:object_r:device_t
 /etc/hotplug\.d/default/udev.* -- system_u:object_r:udev_helper_exec_t
 /dev/udev\.tbl	--	system_u:object_r:udev_tbl_t
 /dev/\.udev\.tdb(/.*)?	--	system_u:object_r:udev_tdb_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.21.12/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2005-02-10 14:48:40.000000000 -0500
+++ policy-1.21.12/file_contexts/types.fc	2005-02-10 15:21:08.000000000 -0500
@@ -357,6 +357,9 @@
 /usr(/.*)?/nvidia/.*\.so(\..*)?	-- system_u:object_r:texrel_shlib_t
 /usr/X11R6/lib/libXvMCNVIDIA\.so.* 	-- system_u:object_r:texrel_shlib_t
 
+# libGL
+/usr/X11R6/lib/libGL\.so.* 	-- system_u:object_r:texrel_shlib_t
+
 ifdef(`distro_debian', `
 /usr/share/selinux(/.*)?	system_u:object_r:policy_src_t
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/local.users policy-1.21.12/local.users
--- nsapolicy/local.users	2005-02-10 14:48:33.000000000 -0500
+++ policy-1.21.12/local.users	2005-02-10 17:07:17.000000000 -0500
@@ -14,4 +14,8 @@
 # The MLS default level and allowed range should only be specified if 
 # MLS was enabled in the policy.
 
+# sample for administrative user
+# user jadmin roles { staff_r sysadm_r system_r };
 
+# sample for regular user
+#user jdoe roles { user_r }; 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.21.12/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2005-02-10 14:48:42.000000000 -0500
+++ policy-1.21.12/macros/base_user_macros.te	2005-02-10 15:21:08.000000000 -0500
@@ -54,15 +54,15 @@
 # for eject
 allow $1_t fixed_disk_device_t:blk_file getattr;
 
-allow $1_t fs_type:dir { getattr };
+allow $1_t fs_type:dir getattr;
+
+allow $1_t event_device_t:chr_file { getattr read ioctl };
 
 # open office is looking for the following
 allow $1_t dri_device_t:chr_file getattr;
 dontaudit $1_t dri_device_t:chr_file rw_file_perms;
-# Do not flood message log, if the user does ls -lR /
-dontaudit $1_t dev_fs:dir_file_class_set getattr;
-dontaudit $1_t sysadmfile:file getattr;
-dontaudit $1_t sysadmfile:dir read;
+
+file_browse_domain($1_t)
 
 # allow ptrace
 can_ptrace($1_t, $1_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.21.12/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2005-02-09 15:01:45.000000000 -0500
+++ policy-1.21.12/macros/global_macros.te	2005-02-10 17:16:28.000000000 -0500
@@ -157,6 +157,19 @@
 ')
 
 
+###################################
+#
+# access_terminal(domain, typeprefix)
+#
+# Permissions for accessing the terminal
+#
+define(`access_terminal', `
+allow $1 $2_tty_device_t:chr_file { read write getattr };
+allow $1 devtty_t:chr_file { read write getattr };
+allow $1 devpts_t:dir { read search getattr };
+allow $1 $2_devpts_t:chr_file { read write getattr };
+') 
+
 #
 # general_proc_read_access(domain)
 #
@@ -491,6 +504,43 @@
 allow $1_t etc_t:dir r_dir_perms;
 ')
 
+# Do not flood message log, if the user does a browse
+define(`file_browse_domain', `
+
+# Regular files/directories that are not security sensitive
+dontaudit $1 file_type - secure_file_type:dir_file_class_set getattr; 
+dontaudit $1 file_type - secure_file_type:dir { read search };
+
+cc# /dev
+dontaudit $1 dev_fs:dir_file_class_set getattr;
+dontaudit $1 dev_fs:dir { read search };
+
+# /proc
+dontaudit $1 sysctl_t:dir_file_class_set getattr;
+dontaudit $1 proc_fs:dir { read search };
+
+')dnl end file_browse_domain
+
+
+# Define legacy_domain  for legacy binaries (java)
+# "legacy" binary == lacks PT_GNU_STACK header, i.e. built with an old
+# toolchain.  They cause the kernel to automatically start translating all
+# read protection requests to read|execute for backward compatibility on
+# x86.  They will all need execmem and execmod, including execmod to
+# shlib_t and ld_so_t unlike non-legacy binaries.
+
+define(`legacy_domain', `
+bool allow_$1_legacy false;
+if (allow_$1_legacy && allow_execmem) {
+allow $1_t self:process { execmem };
+}
+if (allow_$1_legacy && allow_execmod) {
+#Required when starting with /lib/tls/libc-
+allow $1_t { texrel_shlib_t shlib_t }:file execmod;
+allow $1_t ld_so_t:file execmod;
+}
+')
+
 # 
 # Define a domain that can do anything, so that it is
 # effectively unconfined by the SELinux policy.  This
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.21.12/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2005-02-09 15:01:45.000000000 -0500
+++ policy-1.21.12/macros/program/apache_macros.te	2005-02-10 15:21:09.000000000 -0500
@@ -128,12 +128,16 @@
 #
 # If a user starts a script by hand it gets the proper context
 #
+if (httpd_enable_cgi ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
 domain_auto_trans(sysadm_t, httpd_$1_script_exec_t, httpd_$1_script_t)
+}
 role sysadm_r types httpd_$1_script_t;
 ', `
 
+if (httpd_enable_cgi ifdef(`targeted_policy', ` && ! httpd_disable_trans')) {
 # If a user starts a script by hand it gets the proper context
 domain_auto_trans($1_t, httpd_$1_script_exec_t, httpd_$1_script_t)
+}
 role $1_r types httpd_$1_script_t;
 
 #######################################
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/cdrecord_macros.te policy-1.21.12/macros/program/cdrecord_macros.te
--- nsapolicy/macros/program/cdrecord_macros.te	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.12/macros/program/cdrecord_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -17,8 +17,7 @@
 allow $1_t $1_cdrecord_t:process signal;
 
 # write to the user domain tty.
-allow $1_cdrecord_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_cdrecord_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_cdrecord_t, $1)
 allow $1_cdrecord_t privfd:fd use;
 
 allow $1_cdrecord_t $1_t:unix_stream_socket { getattr read write ioctl };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/chkpwd_macros.te policy-1.21.12/macros/program/chkpwd_macros.te
--- nsapolicy/macros/program/chkpwd_macros.te	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.12/macros/program/chkpwd_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -43,8 +43,7 @@
 role $1_r types $1_chkpwd_t;
 
 # Write to the user domain tty.
-allow $1_chkpwd_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_chkpwd_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_chkpwd_t, $1)
 
 allow $1_chkpwd_t privfd:fd use;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/clamav_macros.te policy-1.21.12/macros/program/clamav_macros.te
--- nsapolicy/macros/program/clamav_macros.te	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.12/macros/program/clamav_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -48,8 +48,7 @@
 clamscan_domain($1)
 role $1_r types $1_clamscan_t;
 domain_auto_trans($1_t, clamscan_exec_t, $1_clamscan_t)
-allow $1_clamscan_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_clamscan_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_clamscan_t, $1)
 r_dir_file($1_clamscan_t,$1_home_t);
 r_dir_file($1_clamscan_t,$1_home_dir_t);
 allow $1_clamscan_t $1_home_t:file r_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/crontab_macros.te policy-1.21.12/macros/program/crontab_macros.te
--- nsapolicy/macros/program/crontab_macros.te	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.12/macros/program/crontab_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -87,8 +87,7 @@
 
 # Access terminals.
 allow $1_crontab_t device_t:dir search;
-allow $1_crontab_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_crontab_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_crontab_t, $1);
 
 allow $1_crontab_t fs_t:filesystem getattr;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gpg_agent_macros.te policy-1.21.12/macros/program/gpg_agent_macros.te
--- nsapolicy/macros/program/gpg_agent_macros.te	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.12/macros/program/gpg_agent_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -25,9 +25,7 @@
 allow $1_gpg_agent_t xdm_t:fd use;
 
 # Write to the user domain tty.
-allow $1_gpg_agent_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_gpg_agent_t $1_devpts_t:chr_file rw_file_perms;
-allow $1_gpg_agent_t devtty_t:chr_file { read write };
+access_terminal($1_gpg_agent_t, $1)
 
 # Allow the user shell to signal the gpg-agent program.
 allow $1_t $1_gpg_agent_t:process { signal sigkill };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gpg_macros.te policy-1.21.12/macros/program/gpg_macros.te
--- nsapolicy/macros/program/gpg_macros.te	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.12/macros/program/gpg_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -43,8 +43,7 @@
 allow $1_gpg_t self:unix_stream_socket create_stream_socket_perms;
 allow $1_gpg_t self:tcp_socket create_stream_socket_perms;
 
-allow $1_gpg_t devpts_t:dir search;
-allow $1_gpg_t { $1_devpts_t $1_tty_device_t }:chr_file rw_file_perms;
+access_terminal($1_gpg_t, $1)
 ifdef(`gnome-pty-helper.te', `allow $1_gpg_t $1_gph_t:fd use;')
 
 # Inherit and use descriptors
@@ -84,7 +83,6 @@
 }
 
 allow $1_gpg_t self:capability { ipc_lock setuid };
-allow $1_gpg_t devtty_t:chr_file rw_file_perms;
 rw_dir_create_file($1_gpg_t, $1_file_type)
 
 allow $1_gpg_t { etc_t usr_t }:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/irc_macros.te policy-1.21.12/macros/program/irc_macros.te
--- nsapolicy/macros/program/irc_macros.te	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.12/macros/program/irc_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -47,14 +47,13 @@
 
 allow $1_irc_t usr_t:file { getattr read };
 
+access_terminal($1_irc_t, $1)
 uses_shlib($1_irc_t)
 allow $1_irc_t etc_t:file { read getattr };
 read_locale($1_irc_t)
 allow $1_irc_t fs_t:filesystem getattr;
 allow $1_irc_t var_t:dir search;
-allow $1_irc_t devpts_t:dir { getattr read search };
 allow $1_irc_t device_t:dir search;
-allow $1_irc_t devtty_t:chr_file rw_file_perms;
 allow $1_irc_t self:unix_stream_socket create_stream_socket_perms;
 allow $1_irc_t privfd:fd use;
 allow $1_irc_t proc_t:dir search;
@@ -62,10 +61,6 @@
 allow $1_irc_t self:dir search;
 dontaudit $1_irc_t var_run_t:dir search;
 
-# Write to the user domain tty.
-allow $1_irc_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_irc_t $1_devpts_t:chr_file rw_file_perms;
-
 # allow utmp access
 allow $1_irc_t initrc_var_run_t:file read;
 dontaudit $1_irc_t initrc_var_run_t:file lock;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/java_macros.te policy-1.21.12/macros/program/java_macros.te
--- nsapolicy/macros/program/java_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.12/macros/program/java_macros.te	2005-02-10 15:21:09.000000000 -0500
@@ -0,0 +1,117 @@
+#
+# Macros for java/java (or other browser) domains.
+#
+
+#
+# Authors:  Dan Walsh <dwalsh@redhat.com> and Timothy Fraser 
+#
+
+#
+# java_domain(domain_prefix, user)
+#
+# Define a derived domain for the java/java program when executed by
+# a web browser.  
+#
+# The type declaration for the executable type for this program is
+# provided separately in domains/program/java.te. 
+#
+define(`java_domain',`
+type $1_java_t, domain, privlog , nscd_client_domain, transitionbool;
+
+# The user role is authorized for this domain.
+role $2_r types $1_java_t;
+domain_auto_trans($1_t, java_exec_t, $1_java_t)
+
+allow $1_java_t sound_device_t:chr_file rw_file_perms;
+# Unrestricted inheritance from the caller.
+allow $1_t $1_java_t:process { noatsecure siginh rlimitinh };
+allow $1_java_t $1_t:process signull;
+
+can_unix_connect($1_java_t, $1_t)
+allow $1_java_t $1_t:unix_stream_socket { read write };
+
+# This domain is granted permissions common to most domains (including can_net)
+can_network_client($1_java_t)
+can_ypbind($1_java_t)
+allow $1_java_t self:process { fork signal_perms getsched setsched };
+allow $1_java_t self:unix_stream_socket { connectto create_stream_socket_perms };
+allow $1_java_t self:fifo_file rw_file_perms;
+allow $1_java_t etc_runtime_t:file { getattr read };
+allow $1_java_t fs_t:filesystem getattr;
+read_locale($1_java_t)
+r_dir_file($1_java_t, { proc_t proc_net_t })
+allow $1_java_t self:dir search;
+allow $1_java_t self:lnk_file read;
+allow $1_java_t self:file { getattr read };
+
+read_sysctl($1_java_t)
+
+tmp_domain($1_java)
+r_dir_file($1_java_t,{ fonts_t usr_t etc_t })
+
+# Search bin directory under java for java executable
+allow $1_java_t bin_t:dir search;
+can_exec($1_java_t, java_exec_t)
+
+# Allow connections to X server.
+ifdef(`xserver.te', `
+
+ifdef(`xdm.te', `
+# for when /tmp/.X11-unix is created by the system
+allow $1_java_t xdm_xserver_tmp_t:dir search;
+allow $1_java_t xdm_t:fifo_file rw_file_perms;
+allow $1_java_t xdm_tmp_t:dir search;
+allow $1_java_t xdm_tmp_t:sock_file write;
+')
+
+ifdef(`startx.te', `
+# for when /tmp/.X11-unix is created by the X server
+allow $1_java_t $2_xserver_tmp_t:dir search;
+
+# for /tmp/.X0-lock
+allow $1_java_t $2_xserver_tmp_t:file getattr;
+
+allow $1_java_t $2_xserver_tmp_t:sock_file rw_file_perms;
+can_unix_connect($1_java_t, $2_xserver_t)
+')dnl end startx
+
+can_unix_connect($1_java_t, xdm_xserver_t)
+allow xdm_xserver_t $1_java_t:fd use;
+allow xdm_xserver_t $1_java_t:shm { associate getattr read unix_read };
+dontaudit xdm_xserver_t $1_java_t:shm { unix_write write };
+
+')dnl end xserver
+
+allow $1_java_t self:shm create_shm_perms;
+
+legacy_domain($1_java)
+
+uses_shlib($1_java_t)
+read_locale($1_java_t)
+rw_dir_file($1_java_t, $1_rw_t)
+
+allow $1_java_t ld_so_cache_t:file execute;
+allow $1_java_t lib_t:file execute;
+allow $1_java_t locale_t:file execute;
+allow $1_java_t $1_java_tmp_t:file execute;
+
+allow $1_java_t { random_device_t urandom_device_t }:chr_file ra_file_perms;
+
+allow $1_java_t home_root_t:dir { getattr search };
+file_type_auto_trans($1_java_t, $2_home_dir_t, $1_rw_t)
+allow $1_java_t $2_home_xauth_t:file { getattr read };
+allow $1_java_t $2_tmp_t:sock_file write;
+allow $1_java_t $2_t:fd use;
+
+allow $1_java_t var_t:dir getattr;
+allow $1_java_t var_lib_t:dir { getattr search };
+
+dontaudit $1_java_t fonts_t:file execute;
+dontaudit $1_java_t sound_device_t:chr_file execute;
+dontaudit $1_java_t $2_devpts_t:chr_file { read write };
+dontaudit $1_java_t sysadm_devpts_t:chr_file { read write };
+dontaudit $1_java_t devtty_t:chr_file { read write };
+dontaudit $1_java_t tmpfs_t:file { execute read write };
+dontaudit $1_java_t $1_rw_t:file { execute setattr };
+
+')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/lockdev_macros.te policy-1.21.12/macros/program/lockdev_macros.te
--- nsapolicy/macros/program/lockdev_macros.te	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.12/macros/program/lockdev_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -36,7 +36,7 @@
 
 allow $1_lockdev_t device_t:dir search;
 allow $1_lockdev_t null_device_t:chr_file rw_file_perms;
-allow $1_lockdev_t { $1_tty_device_t $1_devpts_t }:chr_file rw_file_perms;
+access_terminal($1_lockdev_t, $1)
 dontaudit $1_lockdev_t root_t:dir search;
 
 uses_shlib($1_lockdev_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/lpr_macros.te policy-1.21.12/macros/program/lpr_macros.te
--- nsapolicy/macros/program/lpr_macros.te	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.12/macros/program/lpr_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -64,8 +64,7 @@
 allow $1_lpr_t device_t:dir search;
 
 # Access the terminal.
-allow $1_lpr_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_lpr_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_lpr_t, $1)
 
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_lpr_t $1_gph_t:fd use;')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mount_macros.te policy-1.21.12/macros/program/mount_macros.te
--- nsapolicy/macros/program/mount_macros.te	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.12/macros/program/mount_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -62,8 +62,7 @@
 allow $2_t sbin_t:dir search;
 
 # Access the terminal.
-allow $2_t $1_tty_device_t:chr_file { getattr read write ioctl };
-allow $2_t $1_devpts_t:chr_file { getattr read write };
+access_terminal($2_t, $1)
 ifdef(`gnome-pty-helper.te', `allow $2_t $1_gph_t:fd use;')
 allow $2_t var_t:dir search;
 allow $2_t var_run_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.21.12/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2005-02-09 15:01:45.000000000 -0500
+++ policy-1.21.12/macros/program/mozilla_macros.te	2005-02-10 15:21:09.000000000 -0500
@@ -18,6 +18,9 @@
 define(`mozilla_domain',`
 x_client_domain($1, mozilla, `, web_client_domain, privlog, transitionbool')
 
+# Allow mozilla to browse files
+file_browse_domain($1_mozilla_t)
+
 allow $1_mozilla_t sound_device_t:chr_file rw_file_perms;
 
 # Unrestricted inheritance from the caller.
@@ -50,18 +53,16 @@
 allow $1_mozilla_t devpts_t:dir r_dir_perms;
 allow $1_mozilla_t proc_t:file { getattr read };
 r_dir_file($1_mozilla_t, proc_net_t)
-dontaudit $1_mozilla_t tty_device_t:chr_file getattr;
-
-dontaudit $1_mozilla_t proc_t:dir read;
 
 allow $1_mozilla_t { var_t var_lib_t }:dir search;
-dontaudit $1_mozilla_t var_run_t:dir { getattr search };
+
+# interacting with gstreamer
+r_dir_file($1_mozilla_t, var_t)
 
 # Execute downloaded programs.
 can_exec($1_mozilla_t, $1_mozilla_rw_t)
 
-dontaudit $1_mozilla_t tmpfile:dir { setattr getattr search };
-dontaudit $1_mozilla_t tmpfile:{ file fifo_file sock_file } getattr;
+dontaudit $1_mozilla_t tmpfile:dir setattr;
 
 # Use printer
 ifdef(`lpr.te', `
@@ -78,14 +79,13 @@
 # access to the users home directories.
 #
 if (mozilla_readhome || mozilla_writehome) {
-r_dir_file($1_mozilla_t, $1_home_t)
-dontaudit $1_mozilla_t $1_file_type:{ file dir } getattr;
-file_type_auto_trans($1_mozilla_t, tmp_t, $1_tmp_t)
+r_dir_file($1_mozilla_t, { $1_home_t $1_tmp_t })
 } else {
-file_type_auto_trans($1_mozilla_t, tmp_t, $1_mozilla_rw_t)
-dontaudit $1_mozilla_t $1_home_t:dir { setattr read search getattr };
-dontaudit $1_mozilla_t $1_home_t:file { setattr getattr };
+dontaudit $1_mozilla_t $1_home_t:dir setattr;
+dontaudit $1_mozilla_t $1_home_t:file setattr;
 }
+file_type_auto_trans($1_mozilla_t, tmp_t, $1_mozilla_rw_t)
+file_type_auto_trans($1_mozilla_t, $1_tmp_t, $1_mozilla_rw_t)
 
 if (mozilla_writehome) {
 file_type_auto_trans($1_mozilla_t, $1_home_t, $1_mozilla_rw_t)
@@ -96,7 +96,6 @@
 allow $1_mozilla_t $1_t:unix_stream_socket connectto;
 allow $1_mozilla_t sysctl_net_t:dir search;
 allow $1_mozilla_t sysctl_t:dir search;
-dontaudit $1_mozilla_t boot_t:dir getattr;
 ifdef(`cups.te', `
 allow $1_mozilla_t cupsd_etc_t:dir search;
 allow $1_mozilla_t cupsd_rw_etc_t:file { getattr read };
@@ -104,32 +103,25 @@
 allow $1_mozilla_t $1_t:tcp_socket { read write };
 
 allow $1_mozilla_t mozilla_conf_t:file r_file_perms;
-dontaudit $1_mozilla_t bin_t:dir getattr;
 dontaudit $1_mozilla_t port_type:tcp_socket name_bind;
 dontaudit $1_mozilla_t dri_device_t:chr_file rw_file_perms;
-# running mplayer within firefox asks for this
-allow $1_mozilla_t clock_device_t:chr_file r_file_perms;
 # Mozilla tries to delete .fonts.cache-1
 dontaudit $1_mozilla_t $1_home_t:file unlink;
-dontaudit $1_mozilla_t tmpfile:file getattr;
-#
-# Eliminate errors from scanning with the 
-#
-dontaudit $1_mozilla_t file_type:dir getattr;
 allow $1_mozilla_t self:sem create_sem_perms;
 
-dontaudit $1_mozilla_t selinux_config_t:dir search;
-
 #
 # Rules needed to run java apps
-#
-allow $1_mozilla_t ld_so_cache_t:file execute;
-allow $1_mozilla_t locale_t:file execute;
-dontaudit $1_mozilla_t device_type:{ chr_file file } execute;
-dontaudit $1_t ld_so_cache_t:file execute;
-dontaudit $1_t locale_t:file execute;
 
-dontaudit $1_mozilla_t selinux_config_t:dir search;
+java_domain($1_mozilla, $1)
+
+# Mplayer plugin
+ifdef(`mplayer.te', `
+domain_auto_trans($1_mozilla_t, mplayer_exec_t, $1_mplayer_t)
+# Read temporary content - mozilla saves stuff there
+r_dir_file($1_mplayer_t, $1_mozilla_rw_t);
+dontaudit $1_mplayer_t $1_mozilla_rw_t:file write;
+allow $1_mplayer_t $1_mozilla_t:unix_stream_socket { read write };
+')dnl end if mplayer.te  
 
 ifdef(`xdm.te', `
 allow $1_mozilla_t xdm_t:fifo_file { write read };
@@ -137,5 +129,13 @@
 allow $1_mozilla_t xdm_tmp_t:file { getattr read };
 allow $1_mozilla_t xdm_tmp_t:sock_file write;
 ')dnl end if xdm.te
+if (allow_execmem) {
+allow $1_mozilla_t self:process { execmem };
+}
+if (allow_execmod) {
+allow $1_mozilla_t texrel_shlib_t:file execmod;
+}
+dbusd_client(system, $1_mozilla)
+
 ')dnl end mozilla macro
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mplayer_macros.te policy-1.21.12/macros/program/mplayer_macros.te
--- nsapolicy/macros/program/mplayer_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.21.12/macros/program/mplayer_macros.te	2005-02-10 17:18:57.000000000 -0500
@@ -0,0 +1,115 @@
+#
+# Macros for mplayer
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+#
+# mplayer_domain(domain_prefix)
+# mencoder_domain(domain_prefix)
+
+################################################
+#    mplayer_common(prefix, mplayer domain)    #
+################################################
+
+define(`mplayer_common',`
+
+# Home directory stuff
+if (use_nfs_home_dirs) {
+create_dir_file($1_$2_t, nfs_t)
+}
+if (use_samba_home_dirs) {
+create_dir_file($1_$2_t, cifs_t)
+}
+allow $1_$2_t autofs_t:dir { search getattr };
+
+# Read local config
+r_dir_file($1_$2_t, $1_mplayer_rw_t)
+
+# Read global config
+r_dir_file($1_$2_t, mplayer_etc_t)
+
+# Read data in /usr/share (fonts, icons..)
+r_dir_file($1_$2_t, usr_t)
+
+# Read /proc files and directories
+# Necessary for /proc/meminfo, /proc/cpuinfo, etc..
+allow $1_$2_t proc_t:dir search;
+allow $1_$2_t proc_t:file { getattr read };
+
+# Sysctl on kernel version 
+allow $1_$2_t sysctl_kernel_t:dir search;
+allow $1_$2_t sysctl_kernel_t:file { getattr read };
+
+# Allow ps, shared libs, locale, terminal access
+can_ps($1_t, $1_$2_t)
+uses_shlib($1_$2_t)
+read_locale($1_$2_t)
+access_terminal($1_$2_t, $1)
+
+# Required for win32 binary loader 
+allow $1_$2_t zero_device_t:chr_file { read write execute };
+if (allow_execmem) {
+allow $1_$2_t self:process execmem;
+}
+
+if (allow_execmod) {
+allow $1_$2_t zero_device_t:chr_file execmod;
+allow $1_$2_t texrel_shlib_t:file execmod;
+}
+
+# Access to DVD/CD/V4L
+allow $1_$2_t device_t:dir r_dir_perms;
+allow $1_$2_t device_t:lnk_file { getattr read };
+allow $1_$2_t removable_device_t:blk_file { getattr read };
+allow $1_$2_t v4l_device_t:chr_file { getattr read };
+')
+
+##############################
+#  mplayer_domain(prefix)    #
+##############################
+
+define(`mplayer_domain',`
+
+# Derive from X client domain
+x_client_domain($1, `mplayer', `')
+
+# Allow mplayer to browse files
+file_browse_domain($1_mplayer_t)
+
+# Mplayer common stuff
+mplayer_common($1, mplayer)
+
+# Additional rules for search /tmp/.X11-unix
+ifdef(`xdm.te', `
+allow $1_mplayer_t xdm_tmp_t:dir search;
+')dnl end if xdm.te
+
+# Audio
+allow $1_mplayer_t sound_device_t:chr_file rw_file_perms;
+
+# RTC clock 
+allow $1_mplayer_t clock_device_t:chr_file { ioctl read };
+
+# Read home directory content
+r_dir_file($1_mplayer_t, $1_home_t);
+
+') dnl end mplayer_domain
+
+##############################
+#  mencoder_domain(prefix)   #
+##############################
+
+define(`mencoder_domain',`
+
+# Privhome type transitions to $1_home_t in home dir.
+type $1_mencoder_t, domain, privhome;
+
+# Transition
+domain_auto_trans($1_t, mencoder_exec_t, $1_mencoder_t)
+can_exec($1_mencoder_t, mencoder_exec_t)
+role $1_r types $1_mencoder_t;
+
+# Mplayer common stuff
+mplayer_common($1, mencoder)
+
+') dnl end mencoder_domain
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mta_macros.te policy-1.21.12/macros/program/mta_macros.te
--- nsapolicy/macros/program/mta_macros.te	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.12/macros/program/mta_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -87,10 +87,9 @@
 
 allow mta_user_agent $1_tmp_t:file { read getattr };
 
-allow mta_user_agent { $1_devpts_t $1_tty_device_t }:chr_file { getattr read write };
-
 # Write to the user domain tty.
-allow $1_mail_t { $1_tty_device_t $1_devpts_t devtty_t }:chr_file rw_file_perms;
+access_terminal(mta_user_agent, $1)
+access_terminal($1_mail_t, $1)
 
 # Inherit and use descriptors from gnome-pty-helper.
 ifdef(`gnome-pty-helper.te', `allow $1_mail_t $1_gph_t:fd use;')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/samba_macros.te policy-1.21.12/macros/program/samba_macros.te
--- nsapolicy/macros/program/samba_macros.te	2005-02-10 14:48:42.000000000 -0500
+++ policy-1.21.12/macros/program/samba_macros.te	2005-02-10 15:21:09.000000000 -0500
@@ -21,6 +21,7 @@
 if ( samba_enable_home_dirs ) {
 allow smbd_t home_root_t:dir r_dir_perms;
 file_type_auto_trans(smbd_t, $1_home_dir_t, $1_home_t)
+dontaudit smbd_t $1_file_type:dir_file_class_set getattr;
 }
 ')
 ', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/slocate_macros.te policy-1.21.12/macros/program/slocate_macros.te
--- nsapolicy/macros/program/slocate_macros.te	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.12/macros/program/slocate_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -47,10 +47,7 @@
 allow $1_t $1_locate_t:process signal;
 
 uses_shlib($1_locate_t)
-
-# Write to the user domain tty.
-allow $1_locate_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_locate_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_locate_t, $1)
 
 allow $1_locate_t { home_root_t $1_home_dir_t $1_file_type }:dir { getattr search };
 allow $1_locate_t $1_file_type:{ file lnk_file } { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_agent_macros.te policy-1.21.12/macros/program/ssh_agent_macros.te
--- nsapolicy/macros/program/ssh_agent_macros.te	2005-02-09 15:01:45.000000000 -0500
+++ policy-1.21.12/macros/program/ssh_agent_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -27,9 +27,7 @@
 allow $1_ssh_agent_t privfd:fd use;
 
 # Write to the user domain tty.
-allow $1_ssh_agent_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_ssh_agent_t $1_devpts_t:chr_file rw_file_perms;
-allow $1_ssh_agent_t devtty_t:chr_file { read write };
+access_terminal($1_ssh_agent_t, $1)
 
 # Allow the user shell to signal the ssh program.
 allow $1_t $1_ssh_agent_t:process signal;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_macros.te policy-1.21.12/macros/program/ssh_macros.te
--- nsapolicy/macros/program/ssh_macros.te	2005-02-09 15:01:45.000000000 -0500
+++ policy-1.21.12/macros/program/ssh_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -52,9 +52,6 @@
 
 base_file_read_access($1_ssh_t)
 
-# Read the devpts root directory.
-allow $1_ssh_t devpts_t:dir r_dir_perms;
-
 # Read /var.
 allow $1_ssh_t var_t:dir r_dir_perms;
 allow $1_ssh_t var_t:notdevfile_class_set r_file_perms;
@@ -77,8 +74,7 @@
 # Read /dev/urandom.
 allow $1_ssh_t urandom_device_t:chr_file r_file_perms;
 
-# Read and write /dev/tty and /dev/null.
-allow $1_ssh_t devtty_t:chr_file rw_file_perms;
+# Read and write /dev/null.
 allow $1_ssh_t { null_device_t zero_device_t }:chr_file rw_file_perms;
 
 # Grant permissions needed to create TCP and UDP sockets and
@@ -127,8 +123,7 @@
 ifdef(`gnome-pty-helper.te', `allow $1_ssh_t $1_gph_t:fd use;')
 
 # Write to the user domain tty.
-allow $1_ssh_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_ssh_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_ssh_t, $1)
 
 # Allow the user shell to signal the ssh program.
 allow $1_t $1_ssh_t:process signal;
@@ -151,6 +146,11 @@
 ssh_agent_domain($1)
 ')dnl end if ssh_agent.te
 
+#allow ssh to access keys stored on removable media
+# Should we have a boolean around this?
+allow $1_ssh_t mnt_t:dir search;
+r_dir_file($1_ssh_t, removable_t) 
+
 ifdef(`xdm.te', `
 # should be able to remove these two later
 allow $1_ssh_t xdm_xserver_tmp_t:sock_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/su_macros.te policy-1.21.12/macros/program/su_macros.te
--- nsapolicy/macros/program/su_macros.te	2005-02-09 15:01:45.000000000 -0500
+++ policy-1.21.12/macros/program/su_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -99,7 +99,7 @@
 }
 
 # Relabel ttys and ptys.
-allow $1_su_t { device_t devpts_t }:dir { getattr read search };
+allow $1_su_t device_t:dir { getattr read search };
 allow $1_su_t { ttyfile ptyfile }:chr_file { relabelfrom relabelto };
 
 # Close and re-open ttys and ptys to get the fd into the correct domain.
@@ -121,9 +121,8 @@
 role $1_r types $1_su_t;
 
 # Write to the user domain tty.
-allow $1_su_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_su_t $1_devpts_t:chr_file rw_file_perms;
-allow $1_su_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { getattr ioctl };
+access_terminal($1_su_t, $1)
+allow $1_su_t { $1_devpts_t $1_tty_device_t }:chr_file ioctl;
 
 allow $1_su_t { home_root_t $1_home_dir_t }:dir search;
 allow $1_su_t $1_home_t:file create_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/uml_macros.te policy-1.21.12/macros/program/uml_macros.te
--- nsapolicy/macros/program/uml_macros.te	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.12/macros/program/uml_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -110,7 +110,6 @@
 dontaudit $1_uml_t initrc_var_run_t:file { write lock };
 
 allow $1_uml_t device_t:dir search;
-allow $1_uml_t devtty_t:chr_file rw_file_perms;
 allow $1_uml_t self:unix_stream_socket create_stream_socket_perms;
 allow $1_uml_t self:unix_dgram_socket create_socket_perms;
 allow $1_uml_t privfd:fd use;
@@ -121,8 +120,7 @@
 allow $1_uml_t proc_t:file write;
 
 # Write to the user domain tty.
-allow $1_uml_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_uml_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_uml_t, $1)
 
 # access config files
 allow $1_uml_t home_root_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xauth_macros.te policy-1.21.12/macros/program/xauth_macros.te
--- nsapolicy/macros/program/xauth_macros.te	2005-02-09 15:01:45.000000000 -0500
+++ policy-1.21.12/macros/program/xauth_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -66,8 +66,7 @@
 allow $1_xauth_t fs_t:filesystem getattr;
 
 # Write to the user domain tty.
-allow $1_xauth_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_xauth_t $1_devpts_t:chr_file rw_file_perms;
+access_terminal($1_xauth_t, $1)
 
 # Scan /var/run.
 allow $1_xauth_t var_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/x_client_macros.te policy-1.21.12/macros/program/x_client_macros.te
--- nsapolicy/macros/program/x_client_macros.te	2005-02-09 15:01:45.000000000 -0500
+++ policy-1.21.12/macros/program/x_client_macros.te	2005-02-10 17:17:06.000000000 -0500
@@ -57,9 +57,9 @@
 allow $1_$2_t etc_runtime_t:file { getattr read };
 allow $1_$2_t etc_t:lnk_file read;
 allow $1_$2_t fs_t:filesystem getattr;
+access_terminal($1_$2_t, $1)
 read_locale($1_$2_t)
 r_dir_file($1_$2_t, readable_t)
-allow $1_$2_t devtty_t:chr_file { read write };
 allow $1_$2_t proc_t:dir search;
 allow $1_$2_t proc_t:lnk_file read;
 allow $1_$2_t self:dir search;
@@ -143,11 +143,6 @@
 can_tcp_connect($1_$2_t, sshd_t)
 ')
 
-# Access the terminal.
-allow $1_$2_t devpts_t:dir search;
-allow $1_$2_t $1_tty_device_t:chr_file rw_file_perms;
-allow $1_$2_t $1_devpts_t:chr_file rw_file_perms;
-
 # Read the home directory, e.g. for .Xauthority and to get to config files
 allow $1_$2_t home_root_t:dir { search getattr };
 file_type_auto_trans($1_$2_t, $1_home_dir_t, $1_$2_rw_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xserver_macros.te policy-1.21.12/macros/program/xserver_macros.te
--- nsapolicy/macros/program/xserver_macros.te	2005-02-09 15:01:45.000000000 -0500
+++ policy-1.21.12/macros/program/xserver_macros.te	2005-02-10 15:21:09.000000000 -0500
@@ -51,6 +51,11 @@
 can_exec($1_xserver_t, xserver_exec_t)
 
 uses_shlib($1_xserver_t)
+
+if (allow_execmod) {
+allow $1_xserver_t texrel_shlib_t:file execmod;
+}
+
 can_network($1_xserver_t)
 can_ypbind($1_xserver_t)
 allow $1_xserver_t xserver_port_t:tcp_socket name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.21.12/macros/user_macros.te
--- nsapolicy/macros/user_macros.te	2005-02-09 15:01:45.000000000 -0500
+++ policy-1.21.12/macros/user_macros.te	2005-02-10 15:21:09.000000000 -0500
@@ -34,21 +34,11 @@
 # do not allow privhome access to sysadm_home_dir_t
 file_type_auto_trans(privhome, $1_home_dir_t, $1_home_t)
 
-# for ifconfig which is run all the time
-dontaudit $1_t sysctl_t:dir search;
-
-# for ls -l /proc
-dontaudit $1_t { sysctl_irq_t sysctl_t }:dir getattr;
-dontaudit $1_t proc_fs:file getattr;
-
 allow $1_t boot_t:dir { getattr search };
-dontaudit $1_t boot_t:dir read;
-dontaudit $1_t boot_t:lnk_file { getattr read };
-dontaudit $1_t boot_t:file { getattr read };
+dontaudit $1_t boot_t:lnk_file read;
+dontaudit $1_t boot_t:file read;
 allow $1_t system_map_t:file { getattr read };
 
-dontaudit $1_t security_t:dir getattr;
-
 # Instantiate derived domains for a number of programs.
 # These derived domains encode both information about the calling
 # user domain and the program, and allow us to maintain separation
@@ -94,11 +84,8 @@
 dontaudit $1_t initrc_var_run_t:file write;
 
 
-# do not audit getattr on tmpfile, otherwise ls -l /tmp fills the logs
-dontaudit $1_t tmpfile:dir_file_class_set getattr;
-
-# do not audit getattr on disk devices, otherwise KDE fills the logs
-dontaudit $1_t { removable_device_t fixed_disk_device_t }:blk_file {getattr read};
+# do not audit read on disk devices
+dontaudit $1_t { removable_device_t fixed_disk_device_t }:blk_file read;
 
 ifdef(`xdm.te', `
 allow xdm_t $1_home_t:lnk_file read;
@@ -193,12 +180,7 @@
 # $1_t is also granted permissions specific to user domains.
 user_domain($1)
 
-dontaudit $1_t sysadm_home_t:dir { read search getattr };
-dontaudit $1_t sysadm_home_t:file { read getattr append };
-ifdef(`distro_redhat', `
-# gam_server fires off these when exploring with mozilla/nautilous
-dontaudit $1_t file_type:dir getattr;
-')
+dontaudit $1_t sysadm_home_t:file { read append };
 
 ifdef(`syslogd.te', `
 # Some programs that are left in $1_t will try to connect
@@ -208,8 +190,6 @@
 dontaudit $1_t syslogd_t:unix_dgram_socket sendto;
 ')
 
-# stop warnings about "ls -l" on directories with unlabelled files
-dontaudit $1_t default_t:{ dir file lnk_file } getattr;
 # Stop warnings about access to /dev/console
 dontaudit $1_t init_t:fd use;
 dontaudit $1_t initrc_t:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.21.12/Makefile
--- nsapolicy/Makefile	2005-02-10 14:48:31.000000000 -0500
+++ policy-1.21.12/Makefile	2005-02-10 17:03:19.000000000 -0500
@@ -36,6 +36,7 @@
 CONTEXTPATH = $(INSTALLDIR)/contexts
 LOADPATH = $(POLICYPATH)/$(POLICYVER)
 FCPATH = $(CONTEXTPATH)/files/file_contexts
+HOMEDIRPATH = $(CONTEXTPATH)/files/homedir_template
 
 ALL_PROGRAM_MACROS := $(wildcard macros/program/*.te)
 ALL_MACROS := $(ALL_PROGRAM_MACROS) $(wildcard macros/*.te)
@@ -50,16 +51,19 @@
 POLICYFILES += mls
 CHECKPOLMLS += -M
 endif
+DEFCONTEXTFILES = initial_sid_contexts fs_use genfs_contexts net_contexts
 POLICYFILES += $(ALL_TUNABLES) $(TE_RBAC_FILES)
 POLICYFILES += $(USER_FILES)
 POLICYFILES += $(wildcard $(USERPATH)/local.users)
 POLICYFILES += constraints
-POLICYFILES += initial_sid_contexts fs_use genfs_contexts net_contexts
-CONTEXTFILES = initial_sid_contexts fs_use genfs_contexts net_contexts
+POLICYFILES += $(DEFCONTEXTFILES)
+CONTEXTFILES = $(DEFCONTEXTFILES)
+POLICY_DIRS = domains/program domains/misc
 
 UNUSED_TE_FILES := $(wildcard domains/program/unused/*.te)
 
 FC = file_contexts/file_contexts
+HOMEDIR_TEMPLATE = file_contexts/homedir_template
 FCFILES=file_contexts/types.fc $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te)) file_contexts/distros.fc $(wildcard file_contexts/misc/*.fc)
 CONTEXTFILES += $(FCFILES)
 
@@ -170,9 +174,9 @@
 	grep -v dontaudit policy.conf > policy.audit
 	mv policy.audit policy.conf
 
-policy.conf: $(POLICYFILES) 
+policy.conf: $(POLICYFILES) $(POLICY_DIRS)
 	mkdir -p tmp
-	m4 $(M4PARAM) -Imacros -s $^ > $@.tmp
+	m4 $(M4PARAM) -Imacros -s $(POLICYFILES) > $@.tmp
 	mv $@.tmp $@
 
 install-src: 
@@ -204,14 +208,15 @@
 $(FCPATH): $(FC) 
 	@mkdir -p $(CONTEXTPATH)/files
 	install -m 644 $(FC) $(FCPATH)
+	install -m 644 $(HOMEDIR_TEMPLATE) $(HOMEDIRPATH)
+	genhomedircon
 
 $(FC): $(ALL_TUNABLES) tmp/program_used_flags.te $(FCFILES) domains/program domains/misc file_contexts/program file_contexts/misc users /etc/passwd
 	@echo "Building file_contexts ..."
 	@m4 $(M4PARAM) $(ALL_TUNABLES) tmp/program_used_flags.te $(FCFILES) > $@.tmp
-	@grep -v "^/root" $@.tmp > $@.root
-	@/usr/sbin/genhomedircon . $@.root  > $@
-	@grep "^/root" $@.tmp >> $@
-	@-rm $@.tmp $@.root
+	@grep -v -e HOME -e ROLE $@.tmp > $@
+	@grep -e HOME -e ROLE $@.tmp  > $(HOMEDIR_TEMPLATE)
+	@-rm $@.tmp
 
 # Create a tags-file for the policy:
 # we need exuberant ctags; unfortunately it is named differently on different distros, sigh...
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.21.12/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2005-02-09 15:01:45.000000000 -0500
+++ policy-1.21.12/targeted/domains/unconfined.te	2005-02-10 16:23:56.000000000 -0500
@@ -9,6 +9,8 @@
 role user_r types unconfined_t;
 role sysadm_r types unconfined_t;
 unconfined_domain(unconfined_t)
+allow domain $1:fd use;
+allow domain $1:process sigchld;
 
 # Define some type aliases to help with compatibility with
 # macros and domains from the "strict" policy.
@@ -37,6 +39,9 @@
 user_typealias(sysadm)
 user_typealias(staff)
 user_typealias(user)
+attribute user_file_type;
+attribute staff_file_type;
+attribute sysadm_file_type;
 
 allow unconfined_t unlabeled_t:filesystem *;
 allow unlabeled_t self:filesystem associate;
@@ -45,14 +50,18 @@
 bool use_nfs_home_dirs false;
 
 # Allow execution of anonymous mappings, e.g. executable stack.
-bool allow_execmem false;
+bool allow_execmem true;
 
 # Support Share libraries with Text Relocation
-bool allow_execmod false;
+bool allow_execmod true;
 
 # Support SAMBA home directories
 bool use_samba_home_dirs false;
 
+if (allow_execmod) {
+allow $1 shlib_t:file execmod;
+}
+
 ifdef(`samba.te', `samba_domain(user)')
 
 # Allow system to run with NIS
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.21.12/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.12/tunables/distro.tun	2005-02-10 15:21:09.000000000 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.21.12/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.12/tunables/tunable.tun	2005-02-10 15:21:09.000000000 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.21.12/types/file.te
--- nsapolicy/types/file.te	2005-02-09 15:01:45.000000000 -0500
+++ policy-1.21.12/types/file.te	2005-02-10 15:21:09.000000000 -0500
@@ -87,7 +87,7 @@
 #
 # shadow_t is the type of the /etc/shadow file
 #
-type shadow_t, file_type;
+type shadow_t, file_type, secure_file_type;
 allow auth shadow_t:file { getattr read };
 
 #
@@ -151,7 +151,7 @@
 #
 # cert_t is the type of files in the system certs directories.
 #
-type cert_t, file_type, sysadmfile;
+type cert_t, file_type, sysadmfile, secure_file_type;
 
 #
 # ls_exec_t is the type of the ls program.
@@ -192,8 +192,8 @@
 type var_lock_t, file_type, sysadmfile, lockfile;
 type var_lib_t, file_type, sysadmfile;
 # for /var/{spool,lib}/texmf index files
-type tetex_data_t, file_type, sysadmfile;
-type var_spool_t, file_type, sysadmfile;
+type tetex_data_t, file_type, sysadmfile, tmpfile;
+type var_spool_t, file_type, sysadmfile, tmpfile;
 type var_yp_t, file_type, sysadmfile;
 
 # Type for /var/log/ksyms.
@@ -223,7 +223,7 @@
 #
 # print_spool_t is the type for /var/spool/lpd and /var/spool/cups.
 #
-type print_spool_t, file_type, sysadmfile;
+type print_spool_t, file_type, sysadmfile, tmpfile;
 
 #
 # mail_spool_t is the type for /var/spool/mail.

--------------090404060104030607000706--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
