Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2TIgvDo007939
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 13:42:57 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2TIdIa7023010
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 18:39:18 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j2TIhKhC020954
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 13:43:20 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j2TIhKQC020953
	for selinux@tycho.nsa.gov; Tue, 29 Mar 2005 13:43:20 -0500
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2TGpbDo006693
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 11:51:38 -0500 (EST)
Message-ID: <42498685.8000109@redhat.com>
Date: Tue, 29 Mar 2005 11:47:01 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Policy Patch
References: <41E57081.4090500@redhat.com> <1106339767.25125.31.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1106339767.25125.31.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------010106040800050802060801"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010106040800050802060801
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Major cleanup of Makefile.  Probably still needs some sanity checks to 
it.  Added better echo messages, made sure
customizable file gets replaced on make load.

Added policy ssh_keysign_exec_t for /usr/libexec/openssh/ssh-keysign

Better handling of syslog-ng

Whole bunch of changes from Ivan, for desktop apps.

Allow named and nscd to write logs to /var/log

Lots of name_connect fixes.

New bool for squid to connect to any port or just http ports.




-- 



--------------010106040800050802060801
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.23.5/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2005-03-24 08:58:25.000000000 -0500
+++ policy-1.23.5/domains/program/ssh.te	2005-03-28 10:21:45.000000000 -0500
@@ -220,6 +220,7 @@
 
 # Type for the ssh executable.
 type ssh_exec_t, file_type, exec_type, sysadmfile;
+type ssh_keysign_exec_t, file_type, exec_type, sysadmfile;
 
 # Everything else is in the ssh_domain macro in
 # macros/program/ssh_macros.te.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.23.5/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2005-03-21 22:32:18.000000000 -0500
+++ policy-1.23.5/domains/program/syslogd.te	2005-03-28 10:21:45.000000000 -0500
@@ -79,16 +79,10 @@
 dontaudit syslogd_t initrc_var_run_t:file write;
 allow syslogd_t ttyfile:chr_file { getattr write };
 
-ifdef(`klogd.te', `', `
-# Allow access to /proc/kmsg for syslog-ng
-allow syslogd_t proc_t:dir search;
-allow syslogd_t proc_kmsg_t:file { getattr read };
-allow syslogd_t kernel_t:system { syslog_mod syslog_console };
-')
 #
 # Special case to handle crashes
 #
-allow syslogd_t { device_t file_t }:sock_file unlink;
+allow syslogd_t { device_t file_t }:sock_file { getattr unlink };
 
 # Allow syslog to a terminal
 allow syslogd_t tty_device_t:chr_file { getattr write ioctl append };
@@ -111,6 +105,10 @@
 bool use_syslogng false;
 
 if (use_syslogng) {
-allow syslogd_t proc_kmsg_t:file write;
-allow syslogd_t self:capability { sys_admin chown };
+# Allow access to /proc/kmsg for syslog-ng
+allow syslogd_t proc_t:dir search;
+allow syslogd_t proc_kmsg_t:file { getattr read };
+allow syslogd_t kernel_t:system { syslog_mod syslog_console };
+allow syslogd_t self:capability { sys_admin chown fsetid };
+allow syslogd_t var_log_t:dir { create setattr };
 }
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.23.5/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-03-24 08:58:25.000000000 -0500
+++ policy-1.23.5/domains/program/unused/apache.te	2005-03-28 10:21:45.000000000 -0500
@@ -152,7 +152,9 @@
 allow httpd_t bin_t:lnk_file read;
 
 can_network(httpd_t)
+if (httpd_can_network_connect) {
 allow httpd_t port_type:tcp_socket name_connect;
+}
 can_ypbind(httpd_t)
 
 ###################
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/canna.te policy-1.23.5/domains/program/unused/canna.te
--- nsapolicy/domains/program/unused/canna.te	2005-03-24 08:58:25.000000000 -0500
+++ policy-1.23.5/domains/program/unused/canna.te	2005-03-28 10:21:45.000000000 -0500
@@ -42,3 +42,5 @@
 can_unix_connect(i18n_input_t, canna_t)
 ')
 
+dontaudit canna_t kernel_t:fd use;
+dontaudit canna_t root_t:file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.23.5/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2005-03-24 08:58:26.000000000 -0500
+++ policy-1.23.5/domains/program/unused/cups.te	2005-03-28 10:21:45.000000000 -0500
@@ -143,8 +143,8 @@
 # PTAL
 daemon_domain(ptal)
 etcdir_domain(ptal)
-allow ptal_t ptal_var_run_t:fifo_file create_file_perms;
-allow ptal_t ptal_var_run_t:sock_file create_file_perms;
+
+file_type_auto_trans(ptal_t, var_run_t, ptal_var_run_t)
 allow ptal_t self:capability chown;
 allow ptal_t self:{ unix_dgram_socket unix_stream_socket } create_socket_perms;
 allow ptal_t self:unix_stream_socket { listen accept };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.23.5/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.5/domains/program/unused/hald.te	2005-03-29 10:44:55.000000000 -0500
@@ -31,6 +31,7 @@
 allow hald_t usr_t:file { getattr read };
 
 allow hald_t bin_t:file getattr;
+allow hald_t self:netlink_socket create_socket_perms;
 allow hald_t self:netlink_route_socket r_netlink_socket_perms;
 allow hald_t self:capability { net_admin sys_admin dac_override dac_read_search mknod };
 can_network_server(hald_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mailman.te policy-1.23.5/domains/program/unused/mailman.te
--- nsapolicy/domains/program/unused/mailman.te	2005-03-24 08:58:26.000000000 -0500
+++ policy-1.23.5/domains/program/unused/mailman.te	2005-03-28 10:21:45.000000000 -0500
@@ -30,7 +30,7 @@
 allow mailman_$1_t mailman_lock_t:dir rw_dir_perms;
 allow mailman_$1_t fs_t:filesystem getattr;
 can_network(mailman_$1_t)
-allow mailman_$1_t port_type:tcp_socket name_connect;
+allow mailman_$1_t smtp_port_t:tcp_socket name_connect;
 can_ypbind(mailman_$1_t)
 allow mailman_$1_t self:{ unix_stream_socket unix_dgram_socket } create_socket_perms;
 allow mailman_$1_t var_t:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mta.te policy-1.23.5/domains/program/unused/mta.te
--- nsapolicy/domains/program/unused/mta.te	2005-03-21 22:32:19.000000000 -0500
+++ policy-1.23.5/domains/program/unused/mta.te	2005-03-28 10:21:45.000000000 -0500
@@ -13,8 +13,6 @@
 ifdef(`sendmail.te', `', `
 type sendmail_exec_t, file_type, exec_type, sysadmfile;
 ')
-type smtp_port_t, port_type, reserved_port_type;
-
 
 # create a system_mail_t domain for daemons, init scripts, etc when they run
 # "mail user@domain"
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.23.5/domains/program/unused/named.te
--- nsapolicy/domains/program/unused/named.te	2005-03-24 08:58:26.000000000 -0500
+++ policy-1.23.5/domains/program/unused/named.te	2005-03-28 10:21:45.000000000 -0500
@@ -60,6 +60,7 @@
 can_udp_send(domain, named_t)
 can_udp_send(named_t, domain)
 can_tcp_connect(domain, named_t)
+log_domain(named)
 
 # Bind to the named port.
 allow named_t dns_port_t:udp_socket name_bind;
@@ -104,7 +105,7 @@
 domain_auto_trans({ sysadm_t initrc_t }, ndc_exec_t, ndc_t)
 uses_shlib(ndc_t)
 can_network_client_tcp(ndc_t)
-allow ndc_t port_type:tcp_socket name_connect;
+allow ndc_t rndc_port_t:tcp_socket name_connect;
 can_ypbind(ndc_t)
 can_resolve(ndc_t)
 read_locale(ndc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.23.5/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2005-03-24 08:58:27.000000000 -0500
+++ policy-1.23.5/domains/program/unused/nscd.te	2005-03-28 10:21:45.000000000 -0500
@@ -73,3 +73,4 @@
 allow nscd_t tmp_t:dir { search getattr };
 allow nscd_t tmp_t:lnk_file read;
 allow nscd_t { urandom_device_t random_device_t }:chr_file { getattr read };
+log_domain(nscd)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pamconsole.te policy-1.23.5/domains/program/unused/pamconsole.te
--- nsapolicy/domains/program/unused/pamconsole.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.5/domains/program/unused/pamconsole.te	2005-03-28 10:21:45.000000000 -0500
@@ -10,6 +10,12 @@
 allow pam_console_t etc_t:file { getattr read ioctl };
 allow pam_console_t self:unix_stream_socket create_stream_socket_perms;
 
+# Read /etc/mtab
+allow pam_console_t etc_runtime_t:file { read getattr };
+
+# Read /proc/meminfo
+allow pam_console_t proc_t:file { read getattr };
+
 allow pam_console_t self:capability { chown fowner fsetid };
 
 # Allow access to /dev/console through the fd:
@@ -24,7 +30,7 @@
 allow pam_console_t device_t:dir { getattr read };
 allow pam_console_t device_t:lnk_file { getattr read };
 # mouse_device_t is for joy sticks
-allow pam_console_t { framebuf_device_t v4l_device_t apm_bios_t sound_device_t misc_device_t tty_device_t scanner_device_t mouse_device_t power_device_t removable_device_t scsi_generic_device_t }:chr_file { getattr setattr };
+allow pam_console_t { xserver_misc_device_t framebuf_device_t v4l_device_t apm_bios_t sound_device_t misc_device_t tty_device_t scanner_device_t mouse_device_t power_device_t removable_device_t scsi_generic_device_t }:chr_file { getattr setattr };
 allow pam_console_t { removable_device_t fixed_disk_device_t }:blk_file { getattr setattr };
 
 allow pam_console_t mnt_t:dir r_dir_perms;
@@ -36,7 +42,6 @@
 dontaudit pam_console_t hotplug_etc_t:dir search;
 allow pam_console_t hotplug_t:fd use;
 ')
-allow pam_console_t proc_t:file read;
 ifdef(`xdm.te', `
 allow pam_console_t xdm_var_run_t:file { getattr read };
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.23.5/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2005-03-24 08:58:27.000000000 -0500
+++ policy-1.23.5/domains/program/unused/samba.te	2005-03-28 10:21:45.000000000 -0500
@@ -41,7 +41,6 @@
 general_domain_access(smbd_t)
 general_proc_read_access(smbd_t)
 
-type smbd_port_t, port_type, reserved_port_type;
 allow smbd_t smbd_port_t:tcp_socket name_bind;
 
 # Use capabilities.
@@ -88,7 +87,6 @@
 general_domain_access(nmbd_t)
 general_proc_read_access(nmbd_t)
 
-type nmbd_port_t, port_type, reserved_port_type;
 allow nmbd_t nmbd_port_t:udp_socket name_bind;
 
 # Use capabilities.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/squid.te policy-1.23.5/domains/program/unused/squid.te
--- nsapolicy/domains/program/unused/squid.te	2005-03-24 08:58:27.000000000 -0500
+++ policy-1.23.5/domains/program/unused/squid.te	2005-03-28 10:21:45.000000000 -0500
@@ -12,7 +12,7 @@
 ifdef(`apache.te',`
 can_tcp_connect(squid_t, httpd_t)
 ')
-
+bool squid_connect_any false;
 daemon_domain(squid, `, web_client_domain, nscd_client_domain')
 type squid_conf_t, file_type, sysadmfile;
 general_domain_access(squid_t)
@@ -53,13 +53,16 @@
 
 # Use the network
 can_network(squid_t)
+if (squid_connect_any) {
 allow squid_t port_type:tcp_socket name_connect;
+} else {
+allow squid_t { http_port_t http_cache_port_t }:tcp_socket name_connect;
+}
 can_ypbind(squid_t)
 can_tcp_connect(web_client_domain, squid_t)
 
 # tcp port 8080 and udp port 3130 is http_cache_port_t (see net_contexts)
-allow squid_t http_cache_port_t:tcp_socket name_bind;
-allow squid_t http_cache_port_t:udp_socket name_bind;
+allow squid_t http_cache_port_t:{ tcp_socket udp_socket } name_bind;
 
 # to allow running programs from /usr/lib/squid (IE unlinkd)
 # also allow exec()ing itself
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.23.5/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.5/domains/program/unused/udev.te	2005-03-28 10:21:45.000000000 -0500
@@ -29,7 +29,7 @@
 type udev_tdb_t, file_type, sysadmfile, dev_fs;
 typealias udev_tdb_t alias udev_tbl_t;
 file_type_auto_trans(udev_t, device_t, udev_tdb_t, file)
-allow udev_t self:capability { chown dac_override dac_read_search fowner fsetid sys_admin mknod net_raw net_admin };
+allow udev_t self:capability { chown dac_override dac_read_search fowner fsetid sys_admin sys_nice mknod net_raw net_admin };
 allow udev_t self:file { getattr read };
 allow udev_t self:unix_stream_socket {connectto create_stream_socket_perms};
 allow udev_t self:unix_dgram_socket create_socket_perms;
@@ -71,6 +71,7 @@
 
 allow udev_t kernel_t:fd use;
 allow udev_t kernel_t:unix_dgram_socket { sendto ioctl read write };
+allow udev_t kernel_t:process signal;
 
 allow udev_t initrc_var_run_t:file r_file_perms;
 dontaudit udev_t initrc_var_run_t:file write;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/winbind.te policy-1.23.5/domains/program/unused/winbind.te
--- nsapolicy/domains/program/unused/winbind.te	2005-03-24 08:58:27.000000000 -0500
+++ policy-1.23.5/domains/program/unused/winbind.te	2005-03-28 10:21:45.000000000 -0500
@@ -13,7 +13,9 @@
 allow winbind_t etc_t:file r_file_perms;
 allow winbind_t etc_t:lnk_file read;
 can_network(winbind_t)
-allow winbind_t port_type:tcp_socket name_connect;
+allow winbind_t smbd_port_t:tcp_socket name_connect;
+can_resolve(winbind_t)
+
 ifdef(`samba.te', `', `
 type samba_etc_t, file_type, sysadmfile, usercanread;
 type samba_log_t, file_type, sysadmfile, logfile;
@@ -28,7 +30,6 @@
 allow winbind_t urandom_device_t:chr_file { getattr read };
 allow winbind_t self:fifo_file { read write };
 rw_dir_create_file(winbind_t, samba_var_t)
-allow winbind_t krb5_conf_t:file { getattr read };
-dontaudit winbind_t krb5_conf_t:file { write };
+can_kerberos(winbind_t)
 allow winbind_t self:netlink_route_socket r_netlink_socket_perms;
 allow winbind_t winbind_var_run_t:sock_file create_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.23.5/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2005-03-24 08:58:27.000000000 -0500
+++ policy-1.23.5/domains/program/unused/xdm.te	2005-03-28 10:21:45.000000000 -0500
@@ -311,6 +311,7 @@
 allow xdm_t pam_var_run_t:dir create_dir_perms;
 allow xdm_t pam_var_run_t:file create_file_perms;
 allow pam_t xdm_t:fifo_file { getattr ioctl write };
+can_exec(xdm_t, pam_console_exec_t)
 can_exec(xdm_t, pam_exec_t)
 # For pam_console
 rw_dir_create_file(xdm_t, pam_var_console_t)
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/distros.fc policy-1.23.5/file_contexts/distros.fc
--- nsapolicy/file_contexts/distros.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.5/file_contexts/distros.fc	2005-03-28 10:21:45.000000000 -0500
@@ -98,10 +98,10 @@
 /usr/lib/valgrind/vgskin_massif\.so		-- system_u:object_r:texrel_shlib_t
 /usr/lib/valgrind/vgskin_memcheck\.so		-- system_u:object_r:texrel_shlib_t
 /usr/lib/valgrind/vgskin_none\.so		-- system_u:object_r:texrel_shlib_t
-/usr/lib/ooo-.*/program/libicudata\.so.*	-- system_u:object_r:texrel_shlib_t
-/usr/lib/ooo-.*/program/libsts645li\.so		-- system_u:object_r:texrel_shlib_t
-/usr/lib/ooo-.*/program/libvclplug_gen645li\.so	-- system_u:object_r:texrel_shlib_t
-/usr/lib/ooo-.*/program/libwrp645li\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/.*/program/libicudata\.so.*	-- system_u:object_r:texrel_shlib_t
+/usr/lib/.*/program/libsts645li\.so		-- system_u:object_r:texrel_shlib_t
+/usr/lib/.*/program/libvclplug_gen645li\.so	-- system_u:object_r:texrel_shlib_t
+/usr/lib/.*/program/libwrp645li\.so		-- system_u:object_r:texrel_shlib_t
 # Fedora Extras packages: ladspa, imlib2, ocaml
 /usr/lib/ladspa/analogue_osc_1416\.so		-- system_u:object_r:texrel_shlib_t
 /usr/lib/ladspa/bandpass_a_iir_1893\.so		-- system_u:object_r:texrel_shlib_t
@@ -140,6 +140,11 @@
 
 # Jai, Sun Microsystems (Jpackage SPRM)
 /usr/lib/libmlib_jai\.so			-- system_u:object_r:texrel_shlib_t
+/usr/lib/libdivxdecore.so.0			-- system_u:object_r:texrel_shlib_t
+
+/usr(/.*)?/Acrobat5/Reader/intellinux/plug_ins/.*\.api	-- system_u:object_r:shlib_t
+/usr(/.*)?/Acrobat5/Reader/intellinux/plug_ins/AcroForm\.api	-- system_u:object_r:texrel_shlib_t
+/usr(/.*)?/Acrobat5/Reader/intellinux/plug_ins/EScript\.api	-- system_u:object_r:texrel_shlib_t
 
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/apache.fc policy-1.23.5/file_contexts/program/apache.fc
--- nsapolicy/file_contexts/program/apache.fc	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.5/file_contexts/program/apache.fc	2005-03-29 09:07:33.000000000 -0500
@@ -44,3 +44,4 @@
 /usr/share/htdig(/.*)?		system_u:object_r:httpd_sys_content_t
 /var/lib/htdig(/.*)?		system_u:object_r:httpd_sys_content_t
 /etc/htdig(/.*)?		system_u:object_r:httpd_sys_content_t
+/var/spool/gosa(/.*)?		system_u:object_r:httpd_sys_script_rw_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/named.fc policy-1.23.5/file_contexts/program/named.fc
--- nsapolicy/file_contexts/program/named.fc	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.5/file_contexts/program/named.fc	2005-03-28 10:21:45.000000000 -0500
@@ -21,6 +21,8 @@
 /var/run/bind(/.*)?		system_u:object_r:named_var_run_t
 /var/run/named(/.*)?		system_u:object_r:named_var_run_t
 /usr/sbin/lwresd	--	system_u:object_r:named_exec_t
+/var/log/named.* 	--  system_u:object_r:named_log_t
+
 ifdef(`distro_redhat', `
 /var/named/named\.ca	--	system_u:object_r:named_conf_t
 /var/named/chroot(/.*)?		system_u:object_r:named_conf_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/nscd.fc policy-1.23.5/file_contexts/program/nscd.fc
--- nsapolicy/file_contexts/program/nscd.fc	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.5/file_contexts/program/nscd.fc	2005-03-28 10:21:45.000000000 -0500
@@ -4,3 +4,4 @@
 /var/run/nscd\.pid	--	system_u:object_r:nscd_var_run_t
 /var/db/nscd(/.*)?		system_u:object_r:nscd_var_run_t
 /var/run/nscd(/.*)?		system_u:object_r:nscd_var_run_t
+/var/log/nscd\.log.*	--	system_u:object_r:nscd_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/ssh.fc policy-1.23.5/file_contexts/program/ssh.fc
--- nsapolicy/file_contexts/program/ssh.fc	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.5/file_contexts/program/ssh.fc	2005-03-28 10:21:45.000000000 -0500
@@ -1,5 +1,6 @@
 # ssh
 /usr/bin/ssh		--	system_u:object_r:ssh_exec_t
+/usr/libexec/openssh/ssh-keysign -- system_u:object_r:ssh_keysign_exec_t
 /usr/bin/ssh-keygen	--	system_u:object_r:ssh_keygen_exec_t
 # sshd
 /etc/ssh/primes		--	system_u:object_r:sshd_key_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.23.5/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2005-03-24 08:58:29.000000000 -0500
+++ policy-1.23.5/macros/program/apache_macros.te	2005-03-28 10:21:45.000000000 -0500
@@ -3,10 +3,11 @@
 
 #This type is for webpages
 #
-type httpd_$1_content_t, file_type, ifelse($1, sys, `', `$1_file_type, ') httpdcontent, sysadmfile, customizable;
+type httpd_$1_content_t, file_type, httpdcontent, sysadmfile, customizable;
 ifelse($1, sys, `
 typealias httpd_sys_content_t alias httpd_sysadm_content_t;
 ')
+ifelse($1, sys, `',`typeattribute httpd_$1_content_t $1_file_type;') 
 
 # This type is used for .htaccess files
 #
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/games_domain.te policy-1.23.5/macros/program/games_domain.te
--- nsapolicy/macros/program/games_domain.te	2005-03-21 22:32:19.000000000 -0500
+++ policy-1.23.5/macros/program/games_domain.te	2005-03-28 10:21:45.000000000 -0500
@@ -19,10 +19,18 @@
 }
 role $1_r types $1_games_t;
 
-# X access, Private tmp
+# X access, /tmp files
 x_client_domain($1, games)
 tmp_domain($1_games)
 
+uses_shlib($1_games_t)
+read_locale($1_games_t)
+read_sysctl($1_games_t)
+access_terminal($1_games_t, $1)
+
+# Fork
+allow $1_games_t self:process { fork signal_perms getsched };
+
 # Games seem to need this
 if (allow_execmem) {
 allow $1_games_t self:process execmem;
@@ -37,7 +45,7 @@
 
 # Access /home/user/.gnome2
 create_dir_file($1_games_t, $1_home_t)
-allow $1_games_t $1_home_dir_t:dir search;
+allow $1_games_t $1_home_dir_t:dir { read getattr search };
 allow $1_games_t $1_home_t:dir { read getattr };
 
 create_dir_file($1_games_t, $1_tmp_t)
@@ -57,6 +65,7 @@
 
 allow $1_games_t var_lib_t:dir search;
 r_dir_file($1_games_t, man_t)
+allow $1_games_t proc_t:dir search;
 allow $1_games_t proc_t:file { read getattr };
 ifdef(`mozilla.te', ` 
 dontaudit $1_games_t $1_mozilla_t:unix_stream_socket connectto;
@@ -64,10 +73,17 @@
 allow $1_games_t event_device_t:chr_file getattr;
 allow $1_games_t mouse_device_t:chr_file getattr;
 allow $1_games_t self:file { getattr read };
+allow $1_games_t self:fifo_file rw_file_perms;
 
 # kpat spews errors
 dontaudit $1_games_t bin_t:dir getattr;
 dontaudit $1_games_t var_run_t:dir search;
 
+# Allow games to read /etc/mtab and /etc/nsswitch.conf
+allow $1_games_t etc_t:file { getattr read };
+allow $1_games_t etc_runtime_t:file { getattr read };
+
+# 
+
 ')dnl end macro definition
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gift_macros.te policy-1.23.5/macros/program/gift_macros.te
--- nsapolicy/macros/program/gift_macros.te	2005-03-24 08:58:29.000000000 -0500
+++ policy-1.23.5/macros/program/gift_macros.te	2005-03-28 10:21:45.000000000 -0500
@@ -17,10 +17,15 @@
 domain_auto_trans($1_t, gift_exec_t, $1_gift_t)
 role $1_r types $1_gift_t;
 
-# X access, Home access
+# X access, Home files 
 x_client_domain($1, gift)
 home_domain($1, gift)
 
+uses_shlib($1_gift_t)
+read_locale($1_gift_t)
+read_sysctl($1_gift_t)
+access_terminal($1_gift_t, $1)
+
 # Self permissions
 allow $1_gift_t self:process getsched;
 
@@ -29,7 +34,8 @@
 r_dir_file($1_gift_t, fonts_t)
 
 # Launch gift daemon
-allow $1_gift_t self:process fork;
+allow $1_gift_t bin_t:dir search;
+allow $1_gift_t self:process { fork signal_perms getsched };
 domain_auto_trans($1_gift_t, giftd_exec_t, $1_giftd_t)
 
 # Connect to gift daemon
@@ -40,6 +46,10 @@
 allow $1_gift_t proc_t:dir search;
 allow $1_gift_t proc_t:file { getattr read };
 
+# Read /etc/mtab, /etc/nsswitch.conf
+allow $1_gift_t etc_t:file { getattr read };
+allow $1_gift_t etc_runtime_t:file { getattr read };
+
 # Tmp/ORBit
 tmp_domain($1_gift)
 file_type_auto_trans($1_gift_t, $1_tmp_t, $1_gift_tmp_t)
@@ -78,6 +88,7 @@
 read_sysctl($1_giftd_t)
 read_locale($1_giftd_t)
 uses_shlib($1_giftd_t)
+access_terminal($1_giftd_t, $1)
 
 # Access home domain
 home_domain_access($1_giftd_t, $1, gift)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.23.5/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2005-03-21 22:32:19.000000000 -0500
+++ policy-1.23.5/macros/program/mozilla_macros.te	2005-03-28 10:21:45.000000000 -0500
@@ -24,33 +24,52 @@
 }
 role $1_r types $1_mozilla_t;
 
+# X access, Home files
 home_domain($1, mozilla)
 x_client_domain($1, mozilla)
+
+# Browse files
 file_browse_domain($1_mozilla_t)
 
+can_network($1_mozilla_t)
+uses_shlib($1_mozilla_t)
+read_locale($1_mozilla_t)
+read_sysctl($1_mozilla_t)
+access_terminal($1_mozilla_t, $1)
+
 allow $1_mozilla_t sound_device_t:chr_file rw_file_perms;
 
 # Unrestricted inheritance from the caller.
 allow $1_t $1_mozilla_t:process { noatsecure siginh rlimitinh };
 allow $1_mozilla_t $1_t:process signull;
 
-# Set resource limits and scheduling info.
-allow $1_mozilla_t self:process { setrlimit setsched };
+# Fork, set resource limits and scheduling info.
+allow $1_mozilla_t self:process { fork signal_perms setrlimit setsched getsched };
 
 allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
 allow $1_mozilla_t var_lib_t:file { getattr read };
 allow $1_mozilla_t { random_device_t urandom_device_t }:chr_file { getattr ioctl read };
 allow $1_mozilla_t self:socket create_socket_perms;
 allow $1_mozilla_t self:file { getattr read };
+allow $1_mozilla_t self:fifo_file rw_file_perms;
 
-# for bash
+# for bash - old mozilla binary
+can_exec($1_mozilla_t, mozilla_exec_t)
+can_exec($1_mozilla_t, bin_t)
+allow $1_mozilla_t bin_t:lnk_file read;
 allow $1_mozilla_t device_t:dir r_dir_perms;
-allow $1_mozilla_t devpts_t:dir r_dir_perms;
 allow $1_mozilla_t proc_t:file { getattr read };
+allow $1_mozilla_t proc_t:lnk_file read;
+allow $1_mozilla_t self:dir search;
+allow $1_mozilla_t self:lnk_file read;
 r_dir_file($1_mozilla_t, proc_net_t)
 
 allow $1_mozilla_t { var_t var_lib_t }:dir search;
 
+# Allow mozilla to read /etc/mtab, /etc/nsswitch.conf
+allow $1_mozilla_t etc_t:file { getattr read };
+allow $1_mozilla_t etc_runtime_t:file { getattr read };
+
 # interacting with gstreamer
 r_dir_file($1_mozilla_t, var_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_macros.te policy-1.23.5/macros/program/ssh_macros.te
--- nsapolicy/macros/program/ssh_macros.te	2005-03-24 08:58:29.000000000 -0500
+++ policy-1.23.5/macros/program/ssh_macros.te	2005-03-28 10:21:45.000000000 -0500
@@ -80,7 +80,7 @@
 # Grant permissions needed to create TCP and UDP sockets and
 # to access the network.
 can_network_client_tcp($1_ssh_t)
-allow $1_ssh_t port_type:tcp_socket name_connect;
+allow $1_ssh_t ssh_port_t:tcp_socket name_connect;
 can_resolve($1_ssh_t)
 can_ypbind($1_ssh_t)
 can_kerberos($1_ssh_t)
@@ -153,6 +153,22 @@
 allow $1_ssh_t mnt_t:dir search;
 r_dir_file($1_ssh_t, removable_t) 
 
+type $1_ssh_keysign_t, domain, nscd_client_domain;
+role $1_r types $1_ssh_keysign_t;
+domain_auto_trans($1_t, ssh_keysign_exec_t, $1_ssh_keysign_t)
+allow $1_ssh_keysign_t sshd_key_t:file { getattr read };
+allow $1_ssh_keysign_t self:capability { setgid setuid };
+allow $1_ssh_keysign_t urandom_device_t:chr_file r_file_perms;
+uses_shlib($1_ssh_keysign_t)
+dontaudit $1_ssh_keysign_t selinux_config_t:dir search;
+dontaudit $1_ssh_keysign_t proc_t:dir search;
+dontaudit $1_ssh_keysign_t proc_t:{ lnk_file file } { getattr read };
+allow $1_ssh_keysign_t usr_t:dir search;
+allow $1_ssh_keysign_t etc_t:file { getattr read };
+allow $1_ssh_keysign_t self:dir search;
+allow $1_ssh_keysign_t self:file { getattr read };
+allow $1_ssh_keysign_t self:unix_stream_socket create_socket_perms;
+
 ifdef(`xdm.te', `
 # should be able to remove these two later
 allow $1_ssh_t xdm_xserver_tmp_t:sock_file { read write };
@@ -164,7 +180,6 @@
 allow $1_ssh_t xdm_t:fd use;
 ')dnl end if xdm.te
 ')dnl end macro definition
-
 ', `
 
 define(`ssh_domain',`')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/tvtime_macros.te policy-1.23.5/macros/program/tvtime_macros.te
--- nsapolicy/macros/program/tvtime_macros.te	2005-03-21 22:32:20.000000000 -0500
+++ policy-1.23.5/macros/program/tvtime_macros.te	2005-03-28 10:21:45.000000000 -0500
@@ -24,11 +24,21 @@
 domain_auto_trans($1_t, tvtime_exec_t, $1_tvtime_t)
 role $1_r types $1_tvtime_t;
 
-# Home access, X access
+# X access, Home files
 home_domain($1, tvtime)
-tmp_domain($1_tvtime, `', `{ file dir fifo_file }')
 x_client_domain($1, tvtime)
 
+uses_shlib($1_tvtime_t)
+read_locale($1_tvtime_t)
+read_sysctl($1_tvtime_t)
+access_terminal($1_tvtime_t, $1)
+
+# Read /etc/tvtime
+allow $1_tvtime_t etc_t:file { getattr read };
+
+# Tmp files
+tmp_domain($1_tvtime, `', `{ file dir fifo_file }')
+
 allow $1_tvtime_t urandom_device_t:chr_file read;
 allow $1_tvtime_t clock_device_t:chr_file { ioctl read };
 allow $1_tvtime_t kernel_t:system ipc_info;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/x_client_macros.te policy-1.23.5/macros/program/x_client_macros.te
--- nsapolicy/macros/program/x_client_macros.te	2005-03-24 08:58:29.000000000 -0500
+++ policy-1.23.5/macros/program/x_client_macros.te	2005-03-28 10:21:45.000000000 -0500
@@ -43,54 +43,17 @@
 #
 define(`x_client_domain',`
 
-# This domain is granted permissions common to most domains (including can_net)
-can_network($1_$2_t)
-allow $1_$2_t port_type:tcp_socket name_connect;
-can_ypbind($1_$2_t)
-allow $1_$2_t self:process { fork signal_perms getsched };
 allow $1_$2_t self:unix_dgram_socket create_socket_perms;
 allow $1_$2_t self:unix_stream_socket { connectto create_stream_socket_perms };
-allow $1_$2_t self:fifo_file rw_file_perms;
-allow $1_$2_t etc_runtime_t:file { getattr read };
-allow $1_$2_t etc_t:lnk_file read;
-allow $1_$2_t fs_t:filesystem getattr;
-access_terminal($1_$2_t, $1)
-read_locale($1_$2_t)
-r_dir_file($1_$2_t, readable_t)
-allow $1_$2_t proc_t:dir search;
-allow $1_$2_t proc_t:lnk_file read;
-allow $1_$2_t self:dir search;
-allow $1_$2_t self:lnk_file read;
-read_sysctl($1_$2_t)
 
 ifdef(`xauth.te',`
 allow $1_$2_t $1_xauth_home_t:file { getattr read };
 ')
 
 # Allow the user domain to send any signal to the $2 process.
+can_ps($1_t, $1_$2_t)
 allow $1_t $1_$2_t:process signal_perms;
 
-# Allow the user domain to read the /proc/PID directory for 
-# the $2 process.
-allow $1_t $1_$2_t:dir r_dir_perms;
-allow $1_t $1_$2_t:notdevfile_class_set r_file_perms;
-
-# Allow use of /dev/zero by ld.so.
-allow $1_$2_t device_t:dir search;
-allow $1_$2_t zero_device_t:chr_file rw_file_perms;
-allow $1_$2_t zero_device_t:chr_file x_file_perms;
-
-# allow using shared libraries and running programs
-uses_shlib($1_$2_t)
-allow $1_$2_t { bin_t sbin_t }:dir search;
-allow $1_$2_t bin_t:lnk_file read;
-can_exec($1_$2_t, { shell_exec_t bin_t })
-allow $1_$2_t etc_t:file { getattr read };
-
-# Inherit and use descriptors from gnome-pty-helper.
-ifdef(`gnome-pty-helper.te', `allow $1_$2_t $1_gph_t:fd use;')
-allow $1_$2_t privfd:fd use;
-
 # for .xsession-errors
 dontaudit $1_$2_t $1_home_t:file write;
 
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.23.5/Makefile
--- nsapolicy/Makefile	2005-03-15 08:02:23.000000000 -0500
+++ policy-1.23.5/Makefile	2005-03-29 11:37:15.000000000 -0500
@@ -77,12 +77,12 @@
 
 all:  policy
 
-tmp/valid_fc: $(APPFILES) $(ROOTFILES) $(LOADPATH) $(FCPATH) 
-	@echo "Validating file_contexts ..."	
-	$(SETFILES) -q -c $(LOADPATH) $(FCPATH)
+tmp/valid_fc: $(LOADPATH) $(FC) 
+	@echo "Validating file contexts files ..."	
+	$(SETFILES) -q -c $(LOADPATH) $(FC)
 	@touch tmp/valid_fc
 
-install: tmp/valid_fc $(USERPATH)/local.users
+install: $(FCPATH) $(APPFILES) $(ROOTFILES) $(USERPATH)/local.users
 
 $(USERPATH)/system.users: $(ALL_TUNABLES) $(USER_FILES) policy.conf
 	@mkdir -p $(USERPATH)
@@ -91,56 +91,57 @@
 	@echo "# This file is replaced on reinstalls of this policy." >> tmp/system.users
 	@echo "# Please edit local.users to make local changes." >> tmp/system.users
 	@echo "#" >> tmp/system.users
-	m4 $(ALL_TUNABLES) tmp/program_used_flags.te $(USER_FILES) | grep -v "^#" >> tmp/system.users
+	@m4 $(ALL_TUNABLES) tmp/program_used_flags.te $(USER_FILES) | grep -v "^#" >> tmp/system.users
 	install -m 644 tmp/system.users $@
 
 $(USERPATH)/local.users: local.users
 	@mkdir -p $(USERPATH)
-	install -C -b -m 644 $< $@
+	install -b -m 644 $< $@
 
 $(CONTEXTPATH)/files/media: appconfig/media
-	mkdir -p $(CONTEXTPATH)/files/
+	@mkdir -p $(CONTEXTPATH)/files/
 	install -m 644 $< $@
 
 $(APPDIR)/default_contexts: appconfig/default_contexts
-	mkdir -p $(APPDIR)
+	@mkdir -p $(APPDIR)
 	install -m 644 $< $@
 
 $(APPDIR)/removable_context: appconfig/removable_context
-	mkdir -p $(APPDIR)
+	@mkdir -p $(APPDIR)
 	install -m 644 $< $@
 
 $(APPDIR)/customizable_types: policy.conf
-	mkdir -p $(APPDIR)
+	@mkdir -p $(APPDIR)
 	@grep "^type .*customizable" $< | cut -d',' -f1 | cut -d' ' -f2 > tmp/customizable_types
 	install -m 644 tmp/customizable_types $@ 
 
 $(APPDIR)/default_type: appconfig/default_type
-	mkdir -p $(APPDIR)
+	@mkdir -p $(APPDIR)
 	install -m 644 $< $@
 
 $(APPDIR)/userhelper_context: appconfig/userhelper_context
-	mkdir -p $(APPDIR)
+	@mkdir -p $(APPDIR)
 	install -m 644 $< $@
 
 $(APPDIR)/initrc_context: appconfig/initrc_context
-	mkdir -p $(APPDIR)
+	@mkdir -p $(APPDIR)
 	install -m 644 $< $@
 
 $(APPDIR)/failsafe_context: appconfig/failsafe_context
-	mkdir -p $(APPDIR)
+	@mkdir -p $(APPDIR)
 	install -m 644 $< $@
 
 $(APPDIR)/dbus_contexts: appconfig/dbus_contexts
-	mkdir -p $(APPDIR)
+	@mkdir -p $(APPDIR)
 	install -m 644 $< $@
 
 $(APPDIR)/users/root: appconfig/root_default_contexts
-	mkdir -p $(APPDIR)/users
+	@mkdir -p $(APPDIR)/users
 	install -m 644 $< $@
 
-$(LOADPATH):  policy.conf $(CHECKPOLICY)
-	mkdir -p $(POLICYPATH)
+$(LOADPATH): policy.conf $(CHECKPOLICY) 
+	@echo "Compiling policy ..."
+	@mkdir -p $(POLICYPATH)
 	$(CHECKPOLICY) $(CHECKPOLMLS) -o $@ policy.conf
 ifneq ($(MLS),y)
 ifneq ($(VERS),18)
@@ -159,10 +160,11 @@
 	$(CHECKPOLICY) -c 18 -o policy.18 policy.conf
 endif
 endif
-	@echo "Validating file_contexts ..."
+	@echo "Validating file contexts files ..."
 	$(SETFILES) -q -c $(POLICYVER) $(FC)
 
 reload tmp/load: $(FCPATH) $(LOADPATH)
+	@echo "Loading Policy ..."
 ifeq ($(VERS), $(KERNVERS))
 	$(LOADPOLICY) $(LOADPATH)
 else
@@ -177,18 +179,19 @@
 	mv policy.audit policy.conf
 
 policy.conf: $(POLICYFILES) $(POLICY_DIRS)
-	mkdir -p tmp
+	@echo "Building policy.conf ..."
+	@mkdir -p tmp
 	m4 $(M4PARAM) -Imacros -s $(POLICYFILES) > $@.tmp
-	mv $@.tmp $@
+	@mv $@.tmp $@
 
 install-src: 
 	rm -rf $(SRCPATH)/policy.old
 	-mv $(SRCPATH)/policy $(SRCPATH)/policy.old
-	mkdir -p $(SRCPATH)/policy
+	@mkdir -p $(SRCPATH)/policy
 	cp -R . $(SRCPATH)/policy
 
 tmp/program_used_flags.te: $(wildcard domains/program/*.te) domains/program
-	mkdir -p tmp
+	@mkdir -p tmp
 	( cd domains/program/ ; for n in *.te ; do echo "define(\`$$n')"; done ) > $@.tmp
 	( cd domains/misc/ ; for n in *.te ; do echo "define(\`$$n')"; done ) >> $@.tmp
 	mv $@.tmp $@
@@ -205,17 +208,17 @@
 	$(SETFILES) $(FC) $(FILESYSTEMS)
 
 file_contexts/misc:
-	mkdir -p file_contexts/misc
-
+	@mkdir -p file_contexts/misc
 
-$(FCPATH): $(FC) $(USERPATH)/system.users 
+$(FCPATH): tmp/valid_fc $(USERPATH)/system.users  $(APPDIR)/customizable_types
+	@echo "Installing file contexts files..."
 	@mkdir -p $(CONTEXTPATH)/files
 	install -m 644 $(FC) $(FCPATH)
 	install -m 644 $(HOMEDIR_TEMPLATE) $(HOMEDIRPATH)
 	@$(GENHOMEDIRCON) -d $(TOPDIR) -t $(TYPE) $(USEPWD)
 
 $(FC): $(ALL_TUNABLES) tmp/program_used_flags.te $(FCFILES) domains/program domains/misc file_contexts/program file_contexts/misc users /etc/passwd
-	@echo "Building file_contexts ..."
+	@echo "Building file contexts files..."
 	@m4 $(M4PARAM) $(ALL_TUNABLES) tmp/program_used_flags.te $(FCFILES) > $@.tmp
 	@grep -v -e HOME -e ROLE $@.tmp > $@
 	@grep -e HOME -e ROLE $@.tmp  > $(HOMEDIR_TEMPLATE)
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.23.5/net_contexts
--- nsapolicy/net_contexts	2005-03-24 08:58:25.000000000 -0500
+++ policy-1.23.5/net_contexts	2005-03-28 10:21:45.000000000 -0500
@@ -44,11 +44,11 @@
 ')
 ifdef(`ssh.te', `portcon tcp 22 system_u:object_r:ssh_port_t')
 ifdef(`inetd.te', `portcon tcp 23 system_u:object_r:telnetd_port_t')
-ifdef(`mta.te', `
+
 portcon tcp 25 system_u:object_r:smtp_port_t
 portcon tcp 465 system_u:object_r:smtp_port_t
 portcon tcp 587 system_u:object_r:smtp_port_t
-')
+
 portcon udp 53 system_u:object_r:dns_port_t
 portcon tcp 53 system_u:object_r:dns_port_t
 
@@ -56,10 +56,10 @@
 ifdef(`dhcpc.te', `portcon udp 68  system_u:object_r:dhcpc_port_t')
 ifdef(`tftpd.te', `portcon udp 69  system_u:object_r:tftp_port_t')
 ifdef(`fingerd.te', `portcon tcp 79  system_u:object_r:fingerd_port_t')
-ifdef(`use_http', `
+
 portcon tcp 80  system_u:object_r:http_port_t
 portcon tcp 443  system_u:object_r:http_port_t
-')
+
 ifdef(`use_pop', `
 portcon tcp 106 system_u:object_r:pop_port_t
 portcon tcp 109 system_u:object_r:pop_port_t
@@ -70,7 +70,7 @@
 
 ifdef(`innd.te', `portcon tcp 119 system_u:object_r:innd_port_t')
 ifdef(`ntpd.te', `portcon udp 123 system_u:object_r:ntp_port_t')
-ifdef(`samba.te', `
+
 portcon tcp 137 system_u:object_r:smbd_port_t
 portcon udp 137 system_u:object_r:nmbd_port_t
 portcon tcp 138 system_u:object_r:smbd_port_t
@@ -78,7 +78,7 @@
 portcon tcp 139 system_u:object_r:smbd_port_t
 portcon udp 139 system_u:object_r:nmbd_port_t
 portcon tcp 445 system_u:object_r:smbd_port_t
-')
+
 ifdef(`use_pop', `
 portcon tcp 143 system_u:object_r:pop_port_t
 portcon tcp 220 system_u:object_r:pop_port_t
@@ -208,11 +208,10 @@
 # 9433 is for YIFF
 portcon tcp 9433 system_u:object_r:soundd_port_t
 ')
-ifdef(`use_http_cache', `
 portcon tcp 3128  system_u:object_r:http_cache_port_t
 portcon tcp 8080  system_u:object_r:http_cache_port_t
 portcon udp 3130  system_u:object_r:http_cache_port_t
-')
+
 ifdef(`clockspeed.te', `portcon udp 4041 system_u:object_r:clockspeed_port_t')
 ifdef(`transproxy.te', `portcon tcp 8081 system_u:object_r:transproxy_port_t')
 ifdef(`amanda.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/program/ssh.te policy-1.23.5/targeted/domains/program/ssh.te
--- nsapolicy/targeted/domains/program/ssh.te	2005-02-24 14:51:10.000000000 -0500
+++ policy-1.23.5/targeted/domains/program/ssh.te	2005-03-29 11:16:20.000000000 -0500
@@ -13,6 +13,7 @@
 type sshd_exec_t, file_type, sysadmfile, exec_type;
 type ssh_exec_t, file_type, sysadmfile, exec_type;
 type ssh_keygen_exec_t, file_type, sysadmfile, exec_type;
+type ssh_keysign_exec_t, file_type, sysadmfile, exec_type;
 type sshd_key_t, file_type, sysadmfile;
 type sshd_var_run_t, file_type, sysadmfile;
 type ssh_port_t, port_type;
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.23.5/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.5/tunables/distro.tun	2005-03-28 10:21:45.000000000 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.23.5/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.5/tunables/tunable.tun	2005-03-28 10:21:45.000000000 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.23.5/types/file.te
--- nsapolicy/types/file.te	2005-03-24 08:58:30.000000000 -0500
+++ policy-1.23.5/types/file.te	2005-03-28 10:21:45.000000000 -0500
@@ -277,8 +277,9 @@
 
 type tmpfs_t, file_type, sysadmfile, fs_type;
 allow { tmpfs_t tmpfile } tmpfs_t:filesystem associate;
+allow tmpfile tmp_t:filesystem associate;
 ifdef(`distro_redhat', `
-allow { dev_fs ttyfile } tmpfs_t:filesystem associate;
+allow { dev_fs ttyfile } { tmpfs_t tmp_t }:filesystem associate;
 ')
 
 type autofs_t, fs_type, noexattrfile, sysadmfile;
diff --exclude-from=exclude -N -u -r nsapolicy/types/network.te policy-1.23.5/types/network.te
--- nsapolicy/types/network.te	2005-03-24 08:58:30.000000000 -0500
+++ policy-1.23.5/types/network.te	2005-03-28 10:21:45.000000000 -0500
@@ -22,13 +22,11 @@
 #
 # Defines used by the te files need to be defined outside of net_constraints
 #
-type dns_port_t, port_type;
-
-ifdef(`dhcpd.te', `define(`use_dhcpd')')
-ifdef(`dnsmasq.te', `define(`use_dhcpd')')
-ifdef(`use_dhcpd', `
-type dhcpd_port_t, port_type;
-')
+type dns_port_t, port_type, reserved_port_type;
+type smtp_port_t, port_type, reserved_port_type;
+type dhcpd_port_t, port_type, reserved_port_type;
+type smbd_port_t, port_type, reserved_port_type;
+type nmbd_port_t, port_type, reserved_port_type;
 
 ifdef(`cyrus.te', `define(`use_pop')')
 ifdef(`courier.te', `define(`use_pop')')
@@ -38,21 +36,13 @@
 ifdef(`use_pop', `
 type pop_port_t, port_type, reserved_port_type;
 ')
-ifdef(`apache.te', `
-define(`use_http_cache')
-define(`use_http')
-')
 ifdef(`ftpd.te', `
 define(`use_ftpd')
 ')
 ifdef(`publicfile.te', `
-define(`use_http')
 define(`use_ftpd')
 ')
-ifdef(`squid.te', `define(`use_http_cache')')
-ifdef(`use_http_cache', `
 type http_cache_port_t, port_type;
-')
 
 ifdef(`dhcpd.te', `define(`use_pxe')')
 ifdef(`pxe.te', `define(`use_pxe')')

--------------010106040800050802060801--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
