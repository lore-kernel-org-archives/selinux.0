Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2MJnnDo016647
	for <selinux@tycho.nsa.gov>; Tue, 22 Mar 2005 14:49:49 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2MJnwlc013840
	for <selinux@tycho.nsa.gov>; Tue, 22 Mar 2005 19:49:58 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j2MJpQoO002465
	for <selinux@tycho.nsa.gov>; Tue, 22 Mar 2005 14:51:26 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j2MJpQIL002464
	for selinux@tycho.nsa.gov; Tue, 22 Mar 2005 14:51:26 -0500
Message-ID: <424062D4.8090708@redhat.com>
Date: Tue, 22 Mar 2005 13:24:20 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Latest diff.
Content-Type: multipart/mixed;
 boundary="------------080706010807080804030607"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080706010807080804030607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixed assert.te to allow unrestricted domains full access.

Added httpd_unconfined_t so that if a user has a script that can not run 
under SELinux protection, he can label just this script
with httpd_unconfined_script_t and it will run in an unconfined domain.  
The rest of the scripts and httpd itself will run under
normal apache policy. I am not sure if we want this protected via a 
boolean or not.  The user has to set httpd_unconfined_script_t on
a script for it to take place.  Maybe should be placed under a boolean.  
This is better than the current solution which is to turn off
protection for all of apache.

Merged in changes to get ready for name_connect.

Also added liberal allow rules for all domains that
have can_network or can_network_tcp.  Allowing them to connect to port_type.
I need help from people to go through these network controls and tighten 
them up.   IE we need to specify the only ports that
dhcp, or named or xserver etc can connect to.

Alot of port_type definitions need to be moved out of their individual 
te files into types/network.te

I also changed can_kerberos, can_portmap, can_resolv, can_ldap to use 
the named ports.

Dan

-- 



--------------080706010807080804030607
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/assert.te policy-1.23.4/assert.te
--- nsapolicy/assert.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.4/assert.te	2005-03-22 12:36:49.000000000 -0500
@@ -30,56 +30,56 @@
 # Verify that only the insmod_t and kernel_t domains 
 # have the sys_module capability.
 #
-neverallow {domain -unrestricted -insmod_t -kernel_t ifdef(`howl.te', `-howl_t') } self:capability sys_module;
+neverallow {domain -insmod_t -kernel_t ifdef(`howl.te', `-howl_t') -unrestricted } self:capability sys_module;
 
 #
 # Verify that executable types, the system dynamic loaders, and the
 # system shared libraries can only be modified by administrators.
 #
-neverallow {domain  -kernel_t ifdef(`ldconfig.te', `-ldconfig_t') -admin} { exec_type ld_so_t shlib_t }:file { write append unlink rename };
-neverallow {domain  ifdef(`ldconfig.te', `-ldconfig_t') -change_context -admin } { exec_type ld_so_t shlib_t }:file relabelto;
+neverallow {domain  -kernel_t ifdef(`ldconfig.te', `-ldconfig_t') -admin -unrestricted } { exec_type ld_so_t shlib_t }:file { write append unlink rename };
+neverallow {domain  ifdef(`ldconfig.te', `-ldconfig_t') -change_context -admin -unrestricted } { exec_type ld_so_t shlib_t }:file relabelto;
 
 #
 # Verify that only appropriate domains can access /etc/shadow
-neverallow { domain -auth -auth_write } shadow_t:file ~getattr;
-neverallow { domain -auth_write } shadow_t:file ~r_file_perms;
+neverallow { domain -auth -auth_write -unrestricted } shadow_t:file ~getattr;
+neverallow { domain -auth_write -unrestricted } shadow_t:file ~r_file_perms;
 
 #
 # Verify that only appropriate domains can write to /etc (IE mess with
 # /etc/passwd)
-neverallow {domain -auth_write -etc_writer } etc_t:dir ~rw_dir_perms;
-neverallow {domain -auth_write -etc_writer } etc_t:lnk_file ~r_file_perms;
-neverallow {domain -auth_write -etc_writer } etc_t:file ~{ execute_no_trans rx_file_perms };
+neverallow {domain -auth_write -etc_writer -unrestricted } etc_t:dir ~rw_dir_perms;
+neverallow {domain -auth_write -etc_writer -unrestricted } etc_t:lnk_file ~r_file_perms;
+neverallow {domain -auth_write -etc_writer -unrestricted } etc_t:file ~{ execute_no_trans rx_file_perms };
 
 #
 # Verify that other system software can only be modified by administrators.
 #
-neverallow {domain -kernel_t ifdef(`ldconfig.te', `-ldconfig_t') -admin } { lib_t bin_t sbin_t }:dir { add_name remove_name rename };
-neverallow { domain -kernel_t -admin } { lib_t bin_t sbin_t }:file { write append unlink rename };
+neverallow {domain -kernel_t ifdef(`ldconfig.te', `-ldconfig_t') -admin -unrestricted } { lib_t bin_t sbin_t }:dir { add_name remove_name rename };
+neverallow { domain -kernel_t -admin -unrestricted } { lib_t bin_t sbin_t }:file { write append unlink rename };
 
 #
 # Verify that only certain domains have access to the raw disk devices.
 #
-neverallow { domain -fs_domain } fixed_disk_device_t:devfile_class_set { read write append };
+neverallow { domain -fs_domain -unrestricted } fixed_disk_device_t:devfile_class_set { read write append };
 
 #
 # Verify that only the X server and klogd have access to memory devices.
 #
-neverallow { domain -privmem } memory_device_t:devfile_class_set { read write append };
+neverallow { domain -privmem -unrestricted } memory_device_t:devfile_class_set { read write append };
 
 #
 # Verify that only domains with the privlog attribute can actually syslog
 #
-neverallow { domain -unrestricted -privlog } devlog_t:sock_file { read write append };
+neverallow { domain -privlog -unrestricted } devlog_t:sock_file { read write append };
 
 #
 # Verify that /proc/kmsg is only accessible to klogd.
 #
 ifdef(`klogd.te', `
-neverallow {domain -unrestricted -klogd_t } proc_kmsg_t:file ~stat_file_perms;
+neverallow {domain -klogd_t -unrestricted } proc_kmsg_t:file ~stat_file_perms;
 ', `
 ifdef(`syslogd.te', `
-neverallow {domain -unrestricted -syslogd_t } proc_kmsg_t:file ~stat_file_perms;
+neverallow {domain -syslogd_t -unrestricted } proc_kmsg_t:file ~stat_file_perms;
 ')dnl end if syslogd
 ')dnl end if klogd
 
@@ -93,14 +93,14 @@
 # Verify that sysctl variables are only changeable
 # by initrc and administrators.
 #
-neverallow { domain -initrc_t -admin -kernel_t -insmod_t } sysctl_t:file { write append };
-neverallow { domain -initrc_t -admin } sysctl_fs_t:file { write append };
-neverallow { domain -admin -sysctl_kernel_writer } sysctl_kernel_t:file { write append };
-neverallow { domain -initrc_t -admin -sysctl_net_writer } sysctl_net_t:file { write append };
-neverallow { domain -initrc_t -admin } sysctl_net_unix_t:file { write append };
-neverallow { domain -initrc_t -admin } sysctl_vm_t:file { write append };
-neverallow { domain -initrc_t -admin } sysctl_dev_t:file { write append };
-neverallow { domain -initrc_t -admin } sysctl_modprobe_t:file { write append };
+neverallow { domain -initrc_t -admin -kernel_t -insmod_t -unrestricted } sysctl_t:file { write append };
+neverallow { domain -initrc_t -admin -unrestricted } sysctl_fs_t:file { write append };
+neverallow { domain -admin -sysctl_kernel_writer -unrestricted } sysctl_kernel_t:file { write append };
+neverallow { domain -initrc_t -admin -sysctl_net_writer -unrestricted } sysctl_net_t:file { write append };
+neverallow { domain -initrc_t -admin -unrestricted } sysctl_net_unix_t:file { write append };
+neverallow { domain -initrc_t -admin -unrestricted } sysctl_vm_t:file { write append };
+neverallow { domain -initrc_t -admin -unrestricted } sysctl_dev_t:file { write append };
+neverallow { domain -initrc_t -admin -unrestricted } sysctl_modprobe_t:file { write append };
 
 #
 # Verify that certain domains are limited to only being
@@ -146,13 +146,13 @@
 #
 # Verify that only the admin domains and initrc_t have setenforce.
 #
-neverallow { domain -admin -initrc_t } security_t:security setenforce;
+neverallow { domain -admin -initrc_t -unrestricted } security_t:security setenforce;
 
 #
 # Verify that only the kernel and load_policy_t have load_policy.
 #
 
-neverallow { domain -unrestricted -kernel_t -load_policy_t } security_t:security load_policy;
+neverallow { domain -kernel_t -load_policy_t -unrestricted } security_t:security load_policy;
 
 #
 # for gross mistakes in policy
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te policy-1.23.4/domains/program/initrc.te
--- nsapolicy/domains/program/initrc.te	2005-03-15 08:02:23.000000000 -0500
+++ policy-1.23.4/domains/program/initrc.te	2005-03-22 12:36:49.000000000 -0500
@@ -17,6 +17,7 @@
 role system_r types initrc_t;
 uses_shlib(initrc_t);
 can_network(initrc_t)
+allow initrc_t port_type:tcp_socket name_connect;
 can_ypbind(initrc_t)
 type initrc_exec_t, file_type, sysadmfile, exec_type;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/mount.te policy-1.23.4/domains/program/mount.te
--- nsapolicy/domains/program/mount.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.4/domains/program/mount.te	2005-03-22 13:15:17.428871544 -0500
@@ -62,9 +62,12 @@
 
 allow mount_t root_t:filesystem unmount;
 
+can_portmap(mount_t)
+
 ifdef(`portmap.te', `
 # for nfs
 can_network(mount_t)
+allow mount_t port_type:tcp_socket name_connect;
 can_ypbind(mount_t)
 allow mount_t port_t:{ tcp_socket udp_socket } name_bind;
 allow mount_t reserved_port_t:{ tcp_socket udp_socket } name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/netutils.te policy-1.23.4/domains/program/netutils.te
--- nsapolicy/domains/program/netutils.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.4/domains/program/netutils.te	2005-03-22 12:36:49.000000000 -0500
@@ -16,6 +16,7 @@
 
 uses_shlib(netutils_t)
 can_network(netutils_t)
+allow netutils_t port_type:tcp_socket name_connect;
 can_ypbind(netutils_t)
 tmp_domain(netutils)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ssh.te policy-1.23.4/domains/program/ssh.te
--- nsapolicy/domains/program/ssh.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.4/domains/program/ssh.te	2005-03-22 12:36:49.000000000 -0500
@@ -69,6 +69,7 @@
 allow $1_t urandom_device_t:chr_file { getattr read };
 
 can_network($1_t)
+allow $1_t port_type:tcp_socket name_connect;
 
 allow $1_t self:capability { kill sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
 allow $1_t { home_root_t home_dir_type }:dir { search getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/amavis.te policy-1.23.4/domains/program/unused/amavis.te
--- nsapolicy/domains/program/unused/amavis.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.4/domains/program/unused/amavis.te	2005-03-22 12:36:49.000000000 -0500
@@ -27,6 +27,7 @@
 
 # networking
 can_network(amavisd_t)
+allow amavisd_t port_type:tcp_socket name_connect;
 can_ypbind(amavisd_t);
 can_tcp_connect(mail_server_sender, amavisd_t);
 can_tcp_connect(amavisd_t, mail_server_domain)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.23.4/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-03-15 08:02:23.000000000 -0500
+++ policy-1.23.4/domains/program/unused/apache.te	2005-03-22 12:36:49.000000000 -0500
@@ -42,6 +42,9 @@
 # Allow http daemon to communicate with the TTY
 bool httpd_tty_comm false;
 
+# Allow http daemon to tcp connect 
+bool httpd_can_network_connect false;
+
 #########################################################
 # Apache types
 #########################################################
@@ -119,7 +122,11 @@
 allow httpd_suexec_t bin_t:lnk_file read;
 can_exec(httpd_suexec_t, { bin_t shell_exec_t })
 
+if (httpd_can_network_connect) {
 can_network(httpd_suexec_t)
+allow httpd_suexec_t port_type:tcp_socket name_connect;
+}
+
 can_ypbind(httpd_suexec_t)
 allow httpd_suexec_t { usr_t lib_t }:file { getattr read ioctl };
 
@@ -145,6 +152,7 @@
 allow httpd_t bin_t:lnk_file read;
 
 can_network(httpd_t)
+allow httpd_t port_type:tcp_socket name_connect;
 can_ypbind(httpd_t)
 
 ###################
@@ -352,3 +360,8 @@
 allow httpd_sys_script_t var_lib_t:dir search;
 dontaudit httpd_t selinux_config_t:dir search;
 r_dir_file(httpd_t, cert_t)
+
+type httpd_unconfined_script_exec_t, file_type, sysadmfile, customizable;
+type httpd_unconfined_t, domain;
+unconfined_domain(httpd_unconfined_t)
+domain_auto_trans(httpd_t, httpd_unconfined_script_exec_t, httpd_unconfined_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/backup.te policy-1.23.4/domains/program/unused/backup.te
--- nsapolicy/domains/program/unused/backup.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.4/domains/program/unused/backup.te	2005-03-22 12:36:49.000000000 -0500
@@ -27,6 +27,7 @@
 allow backup_t urandom_device_t:chr_file read;
 
 can_network_client(backup_t)
+allow backup_t port_type:tcp_socket name_connect;
 can_ypbind(backup_t)
 uses_shlib(backup_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/canna.te policy-1.23.4/domains/program/unused/canna.te
--- nsapolicy/domains/program/unused/canna.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.4/domains/program/unused/canna.te	2005-03-22 12:36:49.000000000 -0500
@@ -29,6 +29,7 @@
 rw_dir_create_file(canna_t, canna_var_lib_t)
 
 can_network_tcp(canna_t)
+allow canna_t port_type:tcp_socket name_connect;
 can_ypbind(canna_t)
 
 allow userdomain canna_var_run_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/clockspeed.te policy-1.23.4/domains/program/unused/clockspeed.te
--- nsapolicy/domains/program/unused/clockspeed.te	2005-03-15 12:54:54.000000000 -0500
+++ policy-1.23.4/domains/program/unused/clockspeed.te	2005-03-22 12:36:49.000000000 -0500
@@ -8,6 +8,7 @@
 daemon_base_domain(clockspeed)
 var_lib_domain(clockspeed)
 can_network(clockspeed_t)
+allow clockspeed_t port_type:tcp_socket name_connect;
 read_locale(clockspeed_t)
 
 allow clockspeed_t self:capability { sys_time net_bind_service };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.23.4/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2005-03-21 22:32:18.000000000 -0500
+++ policy-1.23.4/domains/program/unused/cups.te	2005-03-22 12:36:49.000000000 -0500
@@ -19,6 +19,7 @@
 typealias cupsd_rw_etc_t alias etc_cupsd_rw_t;
 
 can_network(cupsd_t)
+allow cupsd_t port_type:tcp_socket name_connect;
 logdir_domain(cupsd)
 
 tmp_domain(cupsd)
@@ -200,6 +201,7 @@
 file_type_auto_trans(cupsd_config_t, cupsd_etc_t, cupsd_rw_etc_t, file)
 
 can_network_tcp(cupsd_config_t)
+allow cupsd_config_t port_type:tcp_socket name_connect;
 can_tcp_connect(cupsd_config_t, cupsd_t)
 allow cupsd_config_t self:fifo_file rw_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cyrus.te policy-1.23.4/domains/program/unused/cyrus.te
--- nsapolicy/domains/program/unused/cyrus.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.4/domains/program/unused/cyrus.te	2005-03-22 12:36:49.000000000 -0500
@@ -18,6 +18,7 @@
 allow initrc_su_t cyrus_var_lib_t:dir search;
 
 can_network(cyrus_t)
+allow cyrus_t port_type:tcp_socket name_connect;
 can_ypbind(cyrus_t)
 can_exec(cyrus_t, bin_t)
 allow cyrus_t cyrus_var_lib_t:dir create_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ddclient.te policy-1.23.4/domains/program/unused/ddclient.te
--- nsapolicy/domains/program/unused/ddclient.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.4/domains/program/unused/ddclient.te	2005-03-22 12:36:49.000000000 -0500
@@ -32,6 +32,7 @@
 
 # network-related goodies
 can_network_client(ddclient_t)
+allow ddclient_t port_type:tcp_socket name_connect;
 allow ddclient_t self:unix_dgram_socket create_socket_perms;
 allow ddclient_t self:unix_stream_socket create_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/devfsd.te policy-1.23.4/domains/program/unused/devfsd.te
--- nsapolicy/domains/program/unused/devfsd.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.4/domains/program/unused/devfsd.te	2005-03-22 12:36:49.000000000 -0500
@@ -90,4 +90,5 @@
 
 # for nss-ldap etc
 can_network_client_tcp(devfsd_t)
+allow devfsd_t port_type:tcp_socket name_connect;
 can_ypbind(devfsd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpc.te policy-1.23.4/domains/program/unused/dhcpc.te
--- nsapolicy/domains/program/unused/dhcpc.te	2005-03-21 22:32:18.000000000 -0500
+++ policy-1.23.4/domains/program/unused/dhcpc.te	2005-03-22 12:36:49.000000000 -0500
@@ -23,6 +23,7 @@
 allow dhcpc_t urandom_device_t:chr_file read;
 
 can_network(dhcpc_t)
+allow dhcpc_t port_type:tcp_socket name_connect;
 can_ypbind(dhcpc_t)
 allow dhcpc_t self:unix_dgram_socket create_socket_perms;
 allow dhcpc_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpd.te policy-1.23.4/domains/program/unused/dhcpd.te
--- nsapolicy/domains/program/unused/dhcpd.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.4/domains/program/unused/dhcpd.te	2005-03-22 12:36:49.000000000 -0500
@@ -30,6 +30,7 @@
 
 # Use the network.
 can_network(dhcpd_t)
+allow dhcpd_t port_type:tcp_socket name_connect;
 can_ypbind(dhcpd_t)
 allow dhcpd_t self:unix_dgram_socket create_socket_perms;
 allow dhcpd_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/djbdns.te policy-1.23.4/domains/program/unused/djbdns.te
--- nsapolicy/domains/program/unused/djbdns.te	2005-03-15 12:54:54.000000000 -0500
+++ policy-1.23.4/domains/program/unused/djbdns.te	2005-03-22 12:36:49.000000000 -0500
@@ -15,6 +15,7 @@
 domain_auto_trans( svc_run_t, djbdns_$1_exec_t, djbdns_$1_t)
 svc_ipc_domain(djbdns_$1_t)
 can_network(djbdns_$1_t)
+allow djbdns_$1_t port_type:tcp_socket name_connect;
 allow djbdns_$1_t dns_port_t:{ udp_socket tcp_socket } name_bind;
 allow djbdns_$1_t port_t:udp_socket name_bind;
 r_dir_file(djbdns_$1_t, djbdns_$1_conf_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dovecot.te policy-1.23.4/domains/program/unused/dovecot.te
--- nsapolicy/domains/program/unused/dovecot.te	2005-03-21 22:32:18.000000000 -0500
+++ policy-1.23.4/domains/program/unused/dovecot.te	2005-03-22 12:36:49.000000000 -0500
@@ -20,6 +20,7 @@
 allow dovecot_t self:capability { dac_override dac_read_search chown net_bind_service setgid setuid sys_chroot };
 allow dovecot_t self:process setrlimit;
 can_network_tcp(dovecot_t)
+allow dovecot_t port_type:tcp_socket name_connect;
 can_ypbind(dovecot_t)
 allow dovecot_t self:unix_dgram_socket create_socket_perms;
 allow dovecot_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dpkg.te policy-1.23.4/domains/program/unused/dpkg.te
--- nsapolicy/domains/program/unused/dpkg.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.4/domains/program/unused/dpkg.te	2005-03-22 12:36:49.000000000 -0500
@@ -322,6 +322,7 @@
 allow apt_t self:process { signal sigchld fork };
 allow apt_t sysadm_t:process sigchld;
 can_network({ apt_t dpkg_t })
+allow { apt_t dpkg_t } port_type:tcp_socket name_connect;
 can_ypbind({ apt_t dpkg_t })
 
 allow { apt_t dpkg_t } var_t:dir { search getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/fetchmail.te policy-1.23.4/domains/program/unused/fetchmail.te
--- nsapolicy/domains/program/unused/fetchmail.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.4/domains/program/unused/fetchmail.te	2005-03-22 12:36:49.000000000 -0500
@@ -18,6 +18,8 @@
 
 # network-related goodies
 can_network(fetchmail_t)
+allow fetchmail_t port_type:tcp_socket name_connect;
+
 allow fetchmail_t self:unix_dgram_socket create_socket_perms;
 allow fetchmail_t self:unix_stream_socket create_stream_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ftpd.te policy-1.23.4/domains/program/unused/ftpd.te
--- nsapolicy/domains/program/unused/ftpd.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.4/domains/program/unused/ftpd.te	2005-03-22 12:36:49.000000000 -0500
@@ -16,6 +16,7 @@
 typealias ftpd_etc_t alias etc_ftpd_t;
 
 can_network(ftpd_t)
+allow ftpd_t port_type:tcp_socket name_connect;
 allow ftpd_t self:unix_dgram_socket { sendto create_socket_perms };
 allow ftpd_t self:unix_stream_socket create_socket_perms;
 allow ftpd_t self:process { getcap setcap setsched setrlimit };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/i18n_input.te policy-1.23.4/domains/program/unused/i18n_input.te
--- nsapolicy/domains/program/unused/i18n_input.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.4/domains/program/unused/i18n_input.te	2005-03-22 12:36:49.000000000 -0500
@@ -10,6 +10,7 @@
 
 can_exec(i18n_input_t, i18n_input_exec_t)
 can_network(i18n_input_t)
+allow i18n_input_t port_type:tcp_socket name_connect;
 can_ypbind(i18n_input_t)
 
 can_tcp_connect(userdomain, i18n_input_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/inetd.te policy-1.23.4/domains/program/unused/inetd.te
--- nsapolicy/domains/program/unused/inetd.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.4/domains/program/unused/inetd.te	2005-03-22 12:36:49.000000000 -0500
@@ -20,6 +20,7 @@
 daemon_domain(inetd, `ifdef(`unlimitedInetd', `,admin, etc_writer, fs_domain, auth_write, privmem')' )
 
 can_network(inetd_t)
+allow inetd_t port_type:tcp_socket name_connect;
 allow inetd_t self:unix_dgram_socket create_socket_perms;
 allow inetd_t self:unix_stream_socket create_socket_perms;
 allow inetd_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/innd.te policy-1.23.4/domains/program/unused/innd.te
--- nsapolicy/domains/program/unused/innd.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.4/domains/program/unused/innd.te	2005-03-22 12:36:49.000000000 -0500
@@ -29,6 +29,7 @@
 allow innd_t var_spool_t:dir { getattr search };
 
 can_network(innd_t)
+allow innd_t port_type:tcp_socket name_connect;
 can_ypbind(innd_t)
 
 can_unix_send( { innd_t sysadm_t }, { innd_t sysadm_t } )
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/lpd.te policy-1.23.4/domains/program/unused/lpd.te
--- nsapolicy/domains/program/unused/lpd.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.4/domains/program/unused/lpd.te	2005-03-22 12:36:49.000000000 -0500
@@ -37,6 +37,7 @@
 role system_r types checkpc_t;
 uses_shlib(checkpc_t)
 can_network_client(checkpc_t)
+allow checkpc_t port_type:tcp_socket name_connect;
 can_ypbind(checkpc_t)
 log_domain(checkpc)
 type checkpc_exec_t, file_type, sysadmfile, exec_type;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mailman.te policy-1.23.4/domains/program/unused/mailman.te
--- nsapolicy/domains/program/unused/mailman.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.4/domains/program/unused/mailman.te	2005-03-22 12:36:49.000000000 -0500
@@ -30,6 +30,7 @@
 allow mailman_$1_t mailman_lock_t:dir rw_dir_perms;
 allow mailman_$1_t fs_t:filesystem getattr;
 can_network(mailman_$1_t)
+allow mailman_$1_t port_type:tcp_socket name_connect;
 can_ypbind(mailman_$1_t)
 allow mailman_$1_t self:{ unix_stream_socket unix_dgram_socket } create_socket_perms;
 allow mailman_$1_t var_t:dir r_dir_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mrtg.te policy-1.23.4/domains/program/unused/mrtg.te
--- nsapolicy/domains/program/unused/mrtg.te	2005-03-21 22:32:19.000000000 -0500
+++ policy-1.23.4/domains/program/unused/mrtg.te	2005-03-22 12:36:49.000000000 -0500
@@ -32,6 +32,7 @@
 
 # Use the network.
 can_network_client(mrtg_t)
+allow mrtg_t port_type:tcp_socket name_connect;
 can_ypbind(mrtg_t)
 
 allow mrtg_t self:fifo_file { getattr read write ioctl };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.23.4/domains/program/unused/named.te
--- nsapolicy/domains/program/unused/named.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.4/domains/program/unused/named.te	2005-03-22 12:36:49.000000000 -0500
@@ -54,6 +54,7 @@
 
 #Named can use network
 can_network(named_t)
+allow named_t port_type:tcp_socket name_connect;
 can_ypbind(named_t)
 # allow UDP transfer to/from any program
 can_udp_send(domain, named_t)
@@ -103,6 +104,7 @@
 domain_auto_trans({ sysadm_t initrc_t }, ndc_exec_t, ndc_t)
 uses_shlib(ndc_t)
 can_network_client_tcp(ndc_t)
+allow ndc_t port_type:tcp_socket name_connect;
 can_ypbind(ndc_t)
 can_resolve(ndc_t)
 read_locale(ndc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nessusd.te policy-1.23.4/domains/program/unused/nessusd.te
--- nsapolicy/domains/program/unused/nessusd.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.4/domains/program/unused/nessusd.te	2005-03-22 12:36:49.000000000 -0500
@@ -23,6 +23,7 @@
 
 # Use the network.
 can_network(nessusd_t)
+allow nessusd_t port_type:tcp_socket name_connect;
 can_ypbind(nessusd_t)
 allow nessusd_t self:unix_stream_socket create_socket_perms;
 #allow nessusd_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.23.4/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.4/domains/program/unused/nscd.te	2005-03-22 12:36:49.000000000 -0500
@@ -23,6 +23,7 @@
 allow nscd_t etc_t:file r_file_perms;
 allow nscd_t etc_t:lnk_file read;
 can_network_client(nscd_t)
+allow nscd_t port_type:tcp_socket name_connect;
 can_ypbind(nscd_t)
 
 file_type_auto_trans(nscd_t, var_run_t, nscd_var_run_t, sock_file)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nsd.te policy-1.23.4/domains/program/unused/nsd.te
--- nsapolicy/domains/program/unused/nsd.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.4/domains/program/unused/nsd.te	2005-03-22 12:36:49.000000000 -0500
@@ -20,6 +20,7 @@
 role system_r types nsd_crond_t;
 uses_shlib(nsd_crond_t)
 can_network_client(nsd_crond_t)
+allow nsd_crond_t port_type:tcp_socket name_connect;
 can_ypbind(nsd_crond_t)
 allow nsd_crond_t self:unix_dgram_socket create_socket_perms;
 allow nsd_crond_t self:process { fork signal_perms };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ntpd.te policy-1.23.4/domains/program/unused/ntpd.te
--- nsapolicy/domains/program/unused/ntpd.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.4/domains/program/unused/ntpd.te	2005-03-22 12:36:49.000000000 -0500
@@ -41,6 +41,7 @@
 
 # Use the network.
 can_network(ntpd_t)
+allow ntpd_t port_type:tcp_socket name_connect;
 can_ypbind(ntpd_t)
 allow ntpd_t ntp_port_t:udp_socket name_bind;
 allow ntpd_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nx_server.te policy-1.23.4/domains/program/unused/nx_server.te
--- nsapolicy/domains/program/unused/nx_server.te	2005-03-15 12:54:54.000000000 -0500
+++ policy-1.23.4/domains/program/unused/nx_server.te	2005-03-22 12:36:49.000000000 -0500
@@ -46,6 +46,7 @@
 ssh_domain(nx_server)
 
 can_network_client(nx_server_t)
+allow nx_server_t port_type:tcp_socket name_connect;
 
 allow nx_server_t devtty_t:chr_file { read write };
 allow nx_server_t sysctl_kernel_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ping.te policy-1.23.4/domains/program/unused/ping.te
--- nsapolicy/domains/program/unused/ping.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.4/domains/program/unused/ping.te	2005-03-22 12:36:49.000000000 -0500
@@ -32,6 +32,7 @@
 
 uses_shlib(ping_t)
 can_network_client(ping_t)
+allow ping_t port_type:tcp_socket name_connect;
 can_ypbind(ping_t)
 allow ping_t etc_t:file { getattr read };
 allow ping_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/portmap.te policy-1.23.4/domains/program/unused/portmap.te
--- nsapolicy/domains/program/unused/portmap.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.4/domains/program/unused/portmap.te	2005-03-22 12:36:49.000000000 -0500
@@ -14,12 +14,11 @@
 daemon_domain(portmap, `, nscd_client_domain')
 
 can_network(portmap_t)
+allow portmap_t port_type:tcp_socket name_connect;
 can_ypbind(portmap_t)
 allow portmap_t self:unix_dgram_socket create_socket_perms;
 allow portmap_t self:unix_stream_socket create_stream_socket_perms;
 
-type portmap_port_t, port_type, reserved_port_type;
-
 tmp_domain(portmap)
 
 allow portmap_t portmap_port_t:{ udp_socket tcp_socket } name_bind;
@@ -62,6 +61,7 @@
 allow portmap_helper_t { var_run_t initrc_var_run_t } :file rw_file_perms;
 allow portmap_helper_t self:netlink_route_socket r_netlink_socket_perms;
 can_network(portmap_helper_t)
+allow portmap_helper_t port_type:tcp_socket name_connect;
 can_ypbind(portmap_helper_t)
 dontaudit portmap_helper_t admin_tty_type:chr_file rw_file_perms;
 allow portmap_helper_t etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postfix.te policy-1.23.4/domains/program/unused/postfix.te
--- nsapolicy/domains/program/unused/postfix.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.4/domains/program/unused/postfix.te	2005-03-22 12:36:49.000000000 -0500
@@ -120,6 +120,7 @@
 allow postfix_master_t postfix_private_t:sock_file create_file_perms;
 allow postfix_master_t postfix_private_t:fifo_file create_file_perms;
 can_network(postfix_master_t)
+allow postfix_master_t port_type:tcp_socket name_connect;
 can_ypbind(postfix_master_t)
 allow postfix_master_t smtp_port_t:tcp_socket name_bind;
 allow postfix_master_t postfix_spool_maildrop_t:dir rw_dir_perms;
@@ -155,6 +156,7 @@
 allow postfix_$1_t postfix_master_t:unix_stream_socket { connectto rw_stream_socket_perms };
 allow postfix_$1_t self:capability { setuid setgid dac_override };
 can_network_client(postfix_$1_t)
+allow postfix_$1_t port_type:tcp_socket name_connect;
 can_ypbind(postfix_$1_t)
 ')
 
@@ -345,5 +347,6 @@
 allow postfix_map_t self:unix_dgram_socket create_socket_perms;
 dontaudit postfix_map_t var_t:dir search;
 can_network_server(postfix_map_t)
+allow postfix_map_t port_type:tcp_socket name_connect;
 allow postfix_local_t mail_spool_t:dir { remove_name };
 allow postfix_local_t mail_spool_t:file { unlink };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/privoxy.te policy-1.23.4/domains/program/unused/privoxy.te
--- nsapolicy/domains/program/unused/privoxy.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.4/domains/program/unused/privoxy.te	2005-03-22 12:36:49.000000000 -0500
@@ -17,6 +17,7 @@
 
 # Use the network.
 can_network(privoxy_t)
+allow privoxy_t port_type:tcp_socket name_connect;
 allow privoxy_t port_t:{ tcp_socket udp_socket } name_bind;
 allow privoxy_t etc_t:file { getattr read };
 allow privoxy_t self:capability { setgid setuid };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rhgb.te policy-1.23.4/domains/program/unused/rhgb.te
--- nsapolicy/domains/program/unused/rhgb.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.4/domains/program/unused/rhgb.te	2005-03-22 12:36:49.000000000 -0500
@@ -40,6 +40,7 @@
 dontaudit rhgb_t var_run_t:dir search;
 
 can_network_client(rhgb_t)
+allow rhgb_t port_type:tcp_socket name_connect;
 can_ypbind(rhgb_t)
 
 # for fonts
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpcd.te policy-1.23.4/domains/program/unused/rpcd.te
--- nsapolicy/domains/program/unused/rpcd.te	2005-03-15 08:02:23.000000000 -0500
+++ policy-1.23.4/domains/program/unused/rpcd.te	2005-03-22 12:36:49.000000000 -0500
@@ -13,6 +13,7 @@
 define(`rpc_domain', `
 daemon_base_domain($1)
 can_network($1_t)
+allow $1_t port_type:tcp_socket name_connect;
 can_ypbind($1_t)
 allow $1_t etc_t:file { getattr read };
 read_locale($1_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpm.te policy-1.23.4/domains/program/unused/rpm.te
--- nsapolicy/domains/program/unused/rpm.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.4/domains/program/unused/rpm.te	2005-03-22 12:36:49.000000000 -0500
@@ -31,6 +31,7 @@
 log_domain(rpm)
 
 can_network(rpm_t)
+allow rpm_t port_type:tcp_socket name_connect;
 can_ypbind(rpm_t)
 
 # Allow the rpm domain to execute other programs
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.23.4/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.4/domains/program/unused/samba.te	2005-03-22 12:36:49.000000000 -0500
@@ -153,6 +153,7 @@
 
 # Networking
 can_network(smbmount_t)
+allow smbmount_t port_type:tcp_socket name_connect;
 can_ypbind(smbmount_t)
 allow smbmount_t self:unix_dgram_socket create_socket_perms;
 allow smbmount_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/sendmail.te policy-1.23.4/domains/program/unused/sendmail.te
--- nsapolicy/domains/program/unused/sendmail.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.4/domains/program/unused/sendmail.te	2005-03-22 12:36:49.000000000 -0500
@@ -26,6 +26,7 @@
 
 # Use the network.
 can_network(sendmail_t)
+allow sendmail_t port_type:tcp_socket name_connect;
 can_ypbind(sendmail_t)
 
 allow sendmail_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/slapd.te policy-1.23.4/domains/program/unused/slapd.te
--- nsapolicy/domains/program/unused/slapd.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.4/domains/program/unused/slapd.te	2005-03-22 13:20:35.314545576 -0500
@@ -12,7 +12,6 @@
 #
 daemon_domain(slapd)
 
-type ldap_port_t, port_type, reserved_port_type;
 allow slapd_t ldap_port_t:tcp_socket name_bind;
 
 etc_domain(slapd)
@@ -24,6 +23,7 @@
 
 # Use the network.
 can_network(slapd_t)
+allow slapd_t port_type:tcp_socket name_connect;
 can_ypbind(slapd_t)
 allow slapd_t self:fifo_file { read write };
 allow slapd_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/squid.te policy-1.23.4/domains/program/unused/squid.te
--- nsapolicy/domains/program/unused/squid.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.4/domains/program/unused/squid.te	2005-03-22 12:36:49.000000000 -0500
@@ -53,6 +53,7 @@
 
 # Use the network
 can_network(squid_t)
+allow squid_t port_type:tcp_socket name_connect;
 can_ypbind(squid_t)
 can_tcp_connect(web_client_domain, squid_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/stunnel.te policy-1.23.4/domains/program/unused/stunnel.te
--- nsapolicy/domains/program/unused/stunnel.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.4/domains/program/unused/stunnel.te	2005-03-22 12:36:49.000000000 -0500
@@ -8,6 +8,7 @@
 daemon_domain(stunnel)
 
 can_network(stunnel_t)
+allow stunnel_t port_type:tcp_socket name_connect;
 
 allow stunnel_t self:capability { setgid setuid sys_chroot };
 allow stunnel_t self:fifo_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/traceroute.te policy-1.23.4/domains/program/unused/traceroute.te
--- nsapolicy/domains/program/unused/traceroute.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.4/domains/program/unused/traceroute.te	2005-03-22 12:36:49.000000000 -0500
@@ -19,6 +19,7 @@
 in_user_role(traceroute_t)
 uses_shlib(traceroute_t)
 can_network_client(traceroute_t)
+allow traceroute_t port_type:tcp_socket name_connect;
 can_ypbind(traceroute_t)
 allow traceroute_t node_t:rawip_socket node_bind;
 type traceroute_exec_t, file_type, sysadmfile, exec_type;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ucspi-tcp.te policy-1.23.4/domains/program/unused/ucspi-tcp.te
--- nsapolicy/domains/program/unused/ucspi-tcp.te	2005-03-15 12:54:54.000000000 -0500
+++ policy-1.23.4/domains/program/unused/ucspi-tcp.te	2005-03-22 12:36:49.000000000 -0500
@@ -9,6 +9,7 @@
 
 daemon_base_domain(utcpserver)
 can_network(utcpserver_t)
+allow utcpserver_t port_type:tcp_socket name_connect;
 
 #reads /etc/nsswitch.conf and resolv.conf
 allow utcpserver_t etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/uwimapd.te policy-1.23.4/domains/program/unused/uwimapd.te
--- nsapolicy/domains/program/unused/uwimapd.te	2005-02-24 14:51:07.000000000 -0500
+++ policy-1.23.4/domains/program/unused/uwimapd.te	2005-03-22 12:36:49.000000000 -0500
@@ -9,6 +9,7 @@
 tmp_domain(imapd)
 
 can_network_server_tcp(imapd_t)
+allow imapd_t port_type:tcp_socket name_connect;
 
 #declare our own services
 allow imapd_t self:capability { dac_override net_bind_service setgid setuid sys_resource };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/vpnc.te policy-1.23.4/domains/program/unused/vpnc.te
--- nsapolicy/domains/program/unused/vpnc.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.4/domains/program/unused/vpnc.te	2005-03-22 12:36:49.000000000 -0500
@@ -16,6 +16,7 @@
 
 # Use the network.
 can_network(vpnc_t)
+allow vpnc_t port_type:tcp_socket name_connect;
 can_ypbind(vpnc_t)
 allow vpnc_t self:socket create_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/watchdog.te policy-1.23.4/domains/program/unused/watchdog.te
--- nsapolicy/domains/program/unused/watchdog.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.4/domains/program/unused/watchdog.te	2005-03-22 12:36:49.000000000 -0500
@@ -24,6 +24,7 @@
 allow watchdog_t self:fifo_file rw_file_perms;
 allow watchdog_t self:unix_stream_socket create_socket_perms;
 can_network(watchdog_t)
+allow watchdog_t port_type:tcp_socket name_connect;
 can_ypbind(watchdog_t)
 allow watchdog_t bin_t:dir search;
 allow watchdog_t bin_t:lnk_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/winbind.te policy-1.23.4/domains/program/unused/winbind.te
--- nsapolicy/domains/program/unused/winbind.te	2005-02-24 14:51:08.000000000 -0500
+++ policy-1.23.4/domains/program/unused/winbind.te	2005-03-22 12:36:49.000000000 -0500
@@ -13,6 +13,7 @@
 allow winbind_t etc_t:file r_file_perms;
 allow winbind_t etc_t:lnk_file read;
 can_network(winbind_t)
+allow winbind_t port_type:tcp_socket name_connect;
 ifdef(`samba.te', `', `
 type samba_etc_t, file_type, sysadmfile, usercanread;
 type samba_log_t, file_type, sysadmfile, logfile;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xdm.te policy-1.23.4/domains/program/unused/xdm.te
--- nsapolicy/domains/program/unused/xdm.te	2005-03-11 15:31:06.000000000 -0500
+++ policy-1.23.4/domains/program/unused/xdm.te	2005-03-22 12:36:49.000000000 -0500
@@ -46,6 +46,7 @@
 allow xdm_t default_context_t:{ file lnk_file } { read getattr };
 
 can_network(xdm_t)
+allow xdm_t port_type:tcp_socket name_connect;
 allow xdm_t self:unix_stream_socket { connectto create_stream_socket_perms };
 allow xdm_t self:unix_dgram_socket create_socket_perms;
 allow xdm_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ypbind.te policy-1.23.4/domains/program/unused/ypbind.te
--- nsapolicy/domains/program/unused/ypbind.te	2005-03-15 08:02:23.000000000 -0500
+++ policy-1.23.4/domains/program/unused/ypbind.te	2005-03-22 12:36:49.000000000 -0500
@@ -20,6 +20,7 @@
 
 # Use the network.
 can_network(ypbind_t)
+allow ypbind_t port_type:tcp_socket name_connect;
 allow ypbind_t port_t:{ tcp_socket udp_socket } name_bind;
 
 allow ypbind_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/flask/access_vectors policy-1.23.4/flask/access_vectors
--- nsapolicy/flask/access_vectors	2005-02-24 14:51:10.000000000 -0500
+++ policy-1.23.4/flask/access_vectors	2005-03-22 12:36:49.000000000 -0500
@@ -161,6 +161,7 @@
 	newconn
 	acceptfrom
 	node_bind
+	name_connect
 }
 
 class udp_socket
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.23.4/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2005-03-15 08:02:24.000000000 -0500
+++ policy-1.23.4/macros/base_user_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -213,6 +213,7 @@
 
 # Use the network.
 can_network($1_t)
+allow $1_t port_type:tcp_socket name_connect;
 can_ypbind($1_t)
 
 ifdef(`pamconsole.te', `
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.23.4/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.4/macros/global_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -679,6 +679,7 @@
 allow $1 node_type:node *;
 allow $1 netif_type:netif *;
 allow $1 port_type:{ tcp_socket udp_socket } { send_msg recv_msg };
+allow $1 port_type:tcp_socket name_connect;
 
 # Bind to any network address.
 allow $1 port_type:{ tcp_socket udp_socket } name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/network_macros.te policy-1.23.4/macros/network_macros.te
--- nsapolicy/macros/network_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.4/macros/network_macros.te	2005-03-22 13:16:42.530934064 -0500
@@ -155,14 +155,18 @@
 ')dnl end can_network definition
 
 define(`can_resolve',`
-ifdef(`use_dns',`
 can_network_udp($1, `dns_port_t')
 ')
+
+define(`can_portmap',`
+can_network_client($1, `portmap_port_t')
+allow $1 portmap_port_t:tcp_socket name_connect;
 ')
 
 define(`can_ldap',`
 ifdef(`slapd.te',`
 can_network_client_tcp($1, `ldap_port_t')
+allow $1 ldap_port_t:tcp_socket name_connect;
 ')
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.23.4/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.4/macros/program/apache_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -29,7 +29,6 @@
 allow httpd_$1_script_t httpd_t:fd use;
 allow httpd_$1_script_t httpd_t:process sigchld;
 
-can_network(httpd_$1_script_t)
 allow httpd_$1_script_t { usr_t lib_t }:file { getattr read ioctl };
 allow httpd_$1_script_t usr_t:lnk_file { getattr read };
 
@@ -49,6 +48,12 @@
 allow httpd_$1_script_t device_t:dir { getattr search };
 allow httpd_$1_script_t null_device_t:chr_file rw_file_perms;
 }
+
+if (httpd_enable_cgi && httpd_can_network_connect) {
+can_network(httpd_$1_script_t)
+allow httpd_$1_script_t port_type:tcp_socket name_connect;
+}
+
 ifdef(`ypbind.te', `
 if (httpd_enable_cgi && allow_ypbind) {
 uncond_can_ypbind(httpd_$1_script_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/chroot_macros.te policy-1.23.4/macros/program/chroot_macros.te
--- nsapolicy/macros/program/chroot_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.4/macros/program/chroot_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -119,6 +119,7 @@
 can_create_pty($2)
 can_create_pty($2_super)
 can_network({ $2_t $2_super_t })
+allow { $2_t $2_super_t } port_type:tcp_socket name_connect;
 allow { $2_t $2_super_t } null_device_t:chr_file rw_file_perms;
 allow $2_super_t { $2_rw_t $2_ro_t }:{ dir file } mounton;
 allow { $2_t $2_super_t } self:capability { dac_override kill };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/crond_macros.te policy-1.23.4/macros/program/crond_macros.te
--- nsapolicy/macros/program/crond_macros.te	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.4/macros/program/crond_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -67,6 +67,7 @@
 
 # This domain is granted permissions common to most domains.
 can_network($1_crond_t)
+allow $1_crond_t port_type:tcp_socket name_connect;
 can_ypbind($1_crond_t)
 r_dir_file($1_crond_t, self)
 allow $1_crond_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gift_macros.te policy-1.23.4/macros/program/gift_macros.te
--- nsapolicy/macros/program/gift_macros.te	2005-03-21 22:32:19.000000000 -0500
+++ policy-1.23.4/macros/program/gift_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -34,6 +34,7 @@
 
 # Connect to gift daemon
 can_network($1_gift_t)
+allow $1_gift_t port_type:tcp_socket name_connect;
 
 # Read /proc/meminfo
 allow $1_gift_t proc_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gpg_macros.te policy-1.23.4/macros/program/gpg_macros.te
--- nsapolicy/macros/program/gpg_macros.te	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.4/macros/program/gpg_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -25,6 +25,7 @@
 domain_auto_trans($1_t, gpg_exec_t, $1_gpg_t)
 
 can_network($1_gpg_t)
+allow $1_gpg_t port_type:tcp_socket name_connect;
 can_ypbind($1_gpg_t)
 
 # for a bug in kmail
@@ -130,6 +131,7 @@
 allow $1_gpg_helper_t $1_t:fifo_file write;
 # get keys from the network
 can_network_client($1_gpg_helper_t)
+allow $1_gpg_helper_t port_type:tcp_socket name_connect;
 allow $1_gpg_helper_t etc_t:file { getattr read };
 allow $1_gpg_helper_t urandom_device_t:chr_file read;
 allow $1_gpg_helper_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/irc_macros.te policy-1.23.4/macros/program/irc_macros.te
--- nsapolicy/macros/program/irc_macros.te	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.4/macros/program/irc_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -46,6 +46,7 @@
 
 # Use the network.
 can_network_client($1_irc_t)
+allow $1_irc_t port_type:tcp_socket name_connect;
 can_ypbind($1_irc_t)
 
 allow $1_irc_t usr_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/java_macros.te policy-1.23.4/macros/program/java_macros.te
--- nsapolicy/macros/program/java_macros.te	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.4/macros/program/java_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -29,6 +29,7 @@
 
 # This domain is granted permissions common to most domains (including can_net)
 can_network_client($1_javaplugin_t)
+allow $1_javaplugin_t port_type:tcp_socket name_connect;
 can_ypbind($1_javaplugin_t)
 allow $1_javaplugin_t self:process { fork signal_perms getsched setsched };
 allow $1_javaplugin_t self:unix_stream_socket { connectto create_stream_socket_perms };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/kerberos_macros.te policy-1.23.4/macros/program/kerberos_macros.te
--- nsapolicy/macros/program/kerberos_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.4/macros/program/kerberos_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -2,6 +2,7 @@
 ifdef(`kerberos.te',`
 if (allow_kerberos) {
 can_network_client($1, `kerberos_port_t')
+allow $1 kerberos_port_t:tcp_socket name_connect;
 can_resolve($1)
 }
 ') dnl kerberos.te
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/lpr_macros.te policy-1.23.4/macros/program/lpr_macros.te
--- nsapolicy/macros/program/lpr_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.4/macros/program/lpr_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -35,6 +35,7 @@
 
 # This domain is granted permissions common to most domains (including can_net)
 can_network_client($1_lpr_t)
+allow $1_lpr_t port_type:tcp_socket name_connect;
 can_ypbind($1_lpr_t)
 
 # Use capabilities.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mta_macros.te policy-1.23.4/macros/program/mta_macros.te
--- nsapolicy/macros/program/mta_macros.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.4/macros/program/mta_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -34,6 +34,7 @@
 
 uses_shlib($1_mail_t)
 can_network_client_tcp($1_mail_t)
+allow $1_mail_t port_type:tcp_socket name_connect;
 can_resolve($1_mail_t)
 can_ypbind($1_mail_t)
 allow $1_mail_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/screen_macros.te policy-1.23.4/macros/program/screen_macros.te
--- nsapolicy/macros/program/screen_macros.te	2005-03-21 22:32:20.000000000 -0500
+++ policy-1.23.4/macros/program/screen_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -81,6 +81,7 @@
 
 allow $1_screen_t tmp_t:dir search;
 can_network($1_screen_t)
+allow $1_screen_t port_type:tcp_socket name_connect;
 can_ypbind($1_screen_t)
 
 # get stats
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/spamassassin_macros.te policy-1.23.4/macros/program/spamassassin_macros.te
--- nsapolicy/macros/program/spamassassin_macros.te	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.4/macros/program/spamassassin_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -86,6 +86,7 @@
 # set tunable if you have spamassassin do DNS lookups
 if (spamassasin_can_network) {
 can_network($1_spamassassin_t)
+allow $1_spamassassin_t port_type:tcp_socket name_connect;
 }
 if (spamassasin_can_network && allow_ypbind) {
 uncond_can_ypbind($1_spamassassin_t)
@@ -96,6 +97,7 @@
 ifdef(`spamc.te',`
 spamassassin_program_domain($1, spamc)
 can_network($1_spamc_t)
+allow $1_spamc_t port_type:tcp_socket name_connect;
 can_ypbind($1_spamc_t)
 
 # Allow connecting to a local spamd
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_macros.te policy-1.23.4/macros/program/ssh_macros.te
--- nsapolicy/macros/program/ssh_macros.te	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.4/macros/program/ssh_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -80,6 +80,7 @@
 # Grant permissions needed to create TCP and UDP sockets and
 # to access the network.
 can_network_client_tcp($1_ssh_t)
+allow $1_ssh_t port_type:tcp_socket name_connect;
 can_resolve($1_ssh_t)
 can_ypbind($1_ssh_t)
 can_kerberos($1_ssh_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/uml_macros.te policy-1.23.4/macros/program/uml_macros.te
--- nsapolicy/macros/program/uml_macros.te	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.4/macros/program/uml_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -91,6 +91,7 @@
 
 # Use the network.
 can_network($1_uml_t)
+allow $1_uml_t port_type:tcp_socket name_connect;
 can_ypbind($1_uml_t)
 
 # for xterm
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/x_client_macros.te policy-1.23.4/macros/program/x_client_macros.te
--- nsapolicy/macros/program/x_client_macros.te	2005-03-21 22:32:20.000000000 -0500
+++ policy-1.23.4/macros/program/x_client_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -45,6 +45,7 @@
 
 # This domain is granted permissions common to most domains (including can_net)
 can_network($1_$2_t)
+allow $1_$2_t port_type:tcp_socket name_connect;
 can_ypbind($1_$2_t)
 allow $1_$2_t self:process { fork signal_perms getsched };
 allow $1_$2_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/xserver_macros.te policy-1.23.4/macros/program/xserver_macros.te
--- nsapolicy/macros/program/xserver_macros.te	2005-03-11 15:31:07.000000000 -0500
+++ policy-1.23.4/macros/program/xserver_macros.te	2005-03-22 12:36:49.000000000 -0500
@@ -57,6 +57,7 @@
 }
 
 can_network($1_xserver_t)
+allow $1_xserver_t port_type:tcp_socket name_connect;
 can_ypbind($1_xserver_t)
 allow $1_xserver_t xserver_port_t:tcp_socket name_bind;
 
diff --exclude-from=exclude -N -u -r nsapolicy/man/man8/httpd_selinux.8 policy-1.23.4/man/man8/httpd_selinux.8
--- nsapolicy/man/man8/httpd_selinux.8	2005-02-24 14:51:10.000000000 -0500
+++ policy-1.23.4/man/man8/httpd_selinux.8	2005-03-22 12:36:49.000000000 -0500
@@ -36,8 +36,13 @@
 httpd_sys_script_ra_t 
 .br
 - Set files with httpd_sys_script_ra_t if you want httpd_sys_script_exec_t scripts to read/append to the file, and disallow other non sys scripts from access.
-.SH NOTE
 
+httpd_unconfined_script_exec_t  
+.br 
+- Set cgi scripts with httpd_unconfined_script_exec_t to allow them to run without any SELinux protection. This should only be used for a very complex httpd scripts, after exhausting all other options.  It is better to use this script rather than turning off SELinux protection for httpd.
+.br
+
+.SH NOTE
 With certain policies you can define addional file contexts based on roles like user or staff.  httpd_user_script_exec_t can be defined where it would only have access to "user" contexts.
 
 .SH BOOLEANS
diff --exclude-from=exclude -N -u -r nsapolicy/net_contexts policy-1.23.4/net_contexts
--- nsapolicy/net_contexts	2005-03-17 10:18:56.000000000 -0500
+++ policy-1.23.4/net_contexts	2005-03-22 13:17:58.111444080 -0500
@@ -49,10 +49,9 @@
 portcon tcp 465 system_u:object_r:smtp_port_t
 portcon tcp 587 system_u:object_r:smtp_port_t
 ')
-ifdef(`use_dns', `
 portcon udp 53 system_u:object_r:dns_port_t
 portcon tcp 53 system_u:object_r:dns_port_t
-')
+
 ifdef(`use_dhcpd', `portcon udp 67  system_u:object_r:dhcpd_port_t')
 ifdef(`dhcpc.te', `portcon udp 68  system_u:object_r:dhcpc_port_t')
 ifdef(`tftpd.te', `portcon udp 69  system_u:object_r:tftp_port_t')
@@ -66,10 +65,9 @@
 portcon tcp 109 system_u:object_r:pop_port_t
 portcon tcp 110 system_u:object_r:pop_port_t
 ')
-ifdef(`portmap.te', `
 portcon udp 111 system_u:object_r:portmap_port_t
 portcon tcp 111 system_u:object_r:portmap_port_t
-')
+
 ifdef(`innd.te', `portcon tcp 119 system_u:object_r:innd_port_t')
 ifdef(`ntpd.te', `portcon udp 123 system_u:object_r:ntp_port_t')
 ifdef(`samba.te', `
@@ -93,12 +91,12 @@
 ifdef(`comsat.te', `
 portcon udp 512 system_u:object_r:comsat_port_t
 ')
-ifdef(`slapd.te', `
+
 portcon tcp 389 system_u:object_r:ldap_port_t
 portcon udp 389 system_u:object_r:ldap_port_t
 portcon tcp 636 system_u:object_r:ldap_port_t
 portcon udp 636 system_u:object_r:ldap_port_t
-')
+
 ifdef(`rlogind.te', `portcon tcp 513 system_u:object_r:rlogind_port_t')
 ifdef(`rshd.te', `portcon tcp 514 system_u:object_r:rsh_port_t')
 ifdef(`lpd.te', `portcon tcp 515 system_u:object_r:printer_port_t')
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.23.4/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.4/tunables/distro.tun	2005-03-22 12:36:49.000000000 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.23.4/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.4/tunables/tunable.tun	2005-03-22 12:36:49.000000000 -0500
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
diff --exclude-from=exclude -N -u -r nsapolicy/types/file.te policy-1.23.4/types/file.te
--- nsapolicy/types/file.te	2005-02-24 14:51:09.000000000 -0500
+++ policy-1.23.4/types/file.te	2005-03-22 12:36:49.000000000 -0500
@@ -271,15 +271,15 @@
 # the default file system type.
 #
 allow { file_type device_type ttyfile } fs_t:filesystem associate;
-ifdef(`distro_redhat', `
-allow { dev_fs ttyfile } tmpfs_t:filesystem associate;
-')
 
 # Allow the pty to be associated with the file system.
 allow devpts_t self:filesystem associate;
 
 type tmpfs_t, file_type, sysadmfile, fs_type;
-allow { tmpfs_t tmp_t } tmpfs_t:filesystem associate;
+allow { tmpfs_t tmpfile } tmpfs_t:filesystem associate;
+ifdef(`distro_redhat', `
+allow { dev_fs ttyfile } tmpfs_t:filesystem associate;
+')
 
 type autofs_t, fs_type, noexattrfile, sysadmfile;
 allow autofs_t self:filesystem associate;
diff --exclude-from=exclude -N -u -r nsapolicy/types/network.te policy-1.23.4/types/network.te
--- nsapolicy/types/network.te	2005-03-17 10:18:58.000000000 -0500
+++ policy-1.23.4/types/network.te	2005-03-22 13:21:11.619026456 -0500
@@ -22,14 +22,7 @@
 #
 # Defines used by the te files need to be defined outside of net_constraints
 #
-ifdef(`named.te', `define(`use_dns')')
-ifdef(`nsd.te', `define(`use_dns')')
-ifdef(`tinydns.te', `define(`use_dns')')
-ifdef(`dnsmasq.te', `define(`use_dns')')
-ifdef(`djbdns.te', `define(`use_dns')')
-ifdef(`use_dns', `
 type dns_port_t, port_type;
-')
 
 ifdef(`dhcpd.te', `define(`use_dhcpd')')
 ifdef(`dnsmasq.te', `define(`use_dhcpd')')
@@ -82,6 +75,16 @@
 type kerberos_master_port_t, port_type;
 
 #
+# Ports used to communicate with portmap server
+#
+type portmap_port_t, port_type, reserved_port_type;
+
+#
+# Ports used to communicate with ldap server
+#
+type ldap_port_t, port_type, reserved_port_type;
+
+#
 # port_t is the default type of INET port numbers.
 # The *_port_t types are used for specific port
 # numbers in net_contexts or net_contexts.mls.

--------------080706010807080804030607--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
