From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: patch for new domains
Date: Mon, 20 Jan 2003 01:21:20 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AE0K+QKYn0kB0ub"
Message-Id: <200301200121.20459.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_AE0K+QKYn0kB0ub
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've attached a patch with policy for Perdition, nessus, nsd, and UML.  Also 
it has a new file auth-net.te with the policy for doing network 
authentication (LDAP etc).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_AE0K+QKYn0kB0ub
Content-Type: text/x-diff;
  charset="us-ascii";
  name="new.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="new.diff"

diff -ruwN /tmp/policy/domains/misc/auth-net.te policy/domains/misc/auth-net.te
--- /tmp/policy/domains/misc/auth-net.te	1970-01-01 01:00:00.000000000 +0100
+++ policy/domains/misc/auth-net.te	2003-01-18 12:01:19.000000000 +0100
@@ -0,0 +1,4 @@
+#DESC Policy for using network servers for authenticating users (IE PAM-LDAP)
+
+can_network(auth)
+allow auth resolv_conf_t:file { getattr read };
diff -ruwN /tmp/policy/domains/program/nessusd.te policy/domains/program/nessusd.te
--- /tmp/policy/domains/program/nessusd.te	1970-01-01 01:00:00.000000000 +0100
+++ policy/domains/program/nessusd.te	2003-01-19 12:27:06.000000000 +0100
@@ -0,0 +1,58 @@
+#DESC Nessus network scanning daemon
+#
+# Author:  Russell Coker <russell@coker.com.au>
+#
+
+#################################
+#
+# Rules for the nessusd_t domain.
+#
+# nessusd_exec_t is the type of the nessusd executable.
+#
+daemon_domain(nessusd)
+
+type etc_nessusd_t, file_type, sysadmfile;
+type nessusd_db_t, file_type, sysadmfile;
+
+type nessus_port_t, port_type;
+allow nessusd_t nessus_port_t:tcp_socket name_bind;
+
+#tmp_domain(nessusd)
+
+# Use the network.
+can_network(nessusd_t)
+allow nessusd_t self:unix_stream_socket create_socket_perms;
+#allow nessusd_t self:unix_dgram_socket create_socket_perms;
+
+# why ioctl on /dev/urandom?
+allow nessusd_t random_device_t:chr_file { getattr read ioctl };
+allow nessusd_t self:{ rawip_socket packet_socket } create_socket_perms;
+allow nessusd_t any_socket_t:rawip_socket sendto;
+allow nessusd_t self:capability net_raw;
+
+# for nmap etc
+allow nessusd_t { bin_t sbin_t }:dir search;
+allow nessusd_t bin_t:lnk_file read;
+can_exec(nessusd_t, bin_t)
+allow nessusd_t self:fifo_file { getattr read write };
+
+# allow appropriate domains to connect to nessusd
+can_tcp_connect(domain, nessusd_t)
+
+allow nessusd_t self:process setsched;
+
+allow nessusd_t proc_t:file { getattr read };
+
+# Allow access to the nessusd authentication database
+create_dir_file(nessusd_t, nessusd_db_t)
+allow nessusd_t var_lib_t:dir r_dir_perms;
+
+# read config files
+allow nessusd_t { etc_t etc_nessusd_t resolv_conf_t etc_runtime_t }:{ file lnk_file } r_file_perms;
+
+#allow nessusd_t etc_t:dir r_dir_perms;
+
+#allow nessusd_t sysctl_kernel_t:dir search;
+#allow nessusd_t sysctl_kernel_t:file read;
+
+log_domain(nessusd)
diff -ruwN /tmp/policy/domains/program/nsd.te policy/domains/program/nsd.te
--- /tmp/policy/domains/program/nsd.te	1970-01-01 01:00:00.000000000 +0100
+++ policy/domains/program/nsd.te	2003-01-18 14:47:39.000000000 +0100
@@ -0,0 +1,51 @@
+#DESC Authoritative only name server
+#
+# Author: Russell Coker
+# 
+#
+
+#################################
+#
+# Rules for the nsd_t domain.
+#
+ifdef(`named.te', `', `
+type named_port_t, port_type;
+')
+
+daemon_domain(nsd)
+
+# A type for configuration files of nsd
+type nsd_conf_t, file_type, sysadmfile;
+# A type for zone files
+type nsd_zone_t, file_type, sysadmfile;
+
+r_dir_file(nsd_t, { nsd_conf_t nsd_zone_t })
+r_dir_file(initrc_t, nsd_conf_t)
+
+# Use capabilities. Surplus capabilities may be allowed.
+allow nsd_t self:capability { setuid setgid net_bind_service };
+
+allow nsd_t etc_t:{ file lnk_file } { getattr read };
+allow nsd_t resolv_conf_t:file { getattr read };
+
+# nsd can use network
+can_network(nsd_t)
+# allow client access from caching BIND
+ifdef(`named.te', `
+can_udp_send(named_t, nsd_t)
+can_udp_send(nsd_t, named_t)
+can_tcp_connect(named_t, nsd_t)
+')
+
+# if you want to allow all programs to contact the primary name server
+#can_udp_send(domain, nsd_t)
+#can_udp_send(nsd_t, domain)
+#can_tcp_connect(domain, nsd_t)
+
+# Bind to the named port.
+allow nsd_t named_port_t:udp_socket name_bind;
+allow nsd_t named_port_t:tcp_socket name_bind;
+
+allow nsd_t self:unix_stream_socket create_stream_socket_perms;
+allow nsd_t self:unix_dgram_socket create_socket_perms;
+
diff -ruwN /tmp/policy/domains/program/perdition.te policy/domains/program/perdition.te
--- /tmp/policy/domains/program/perdition.te	1970-01-01 01:00:00.000000000 +0100
+++ policy/domains/program/perdition.te	2003-01-18 14:51:19.000000000 +0100
@@ -0,0 +1,34 @@
+#DESC Perdition POP and IMAP proxy
+#
+# Author:  Russell Coker <russell@coker.com.au>
+#
+
+#################################
+#
+# Rules for the perdition_t domain.
+#
+daemon_domain(perdition)
+
+ifdef(`courier.te', `', `
+type pop_port_t, port_type;
+')
+allow perdition_t pop_port_t:tcp_socket name_bind;
+
+type etc_perdition_t, file_type, sysadmfile;
+
+# Use the network.
+can_network(perdition_t)
+allow perdition_t self:unix_stream_socket create_socket_perms;
+allow perdition_t self:unix_dgram_socket create_socket_perms;
+
+# allow any domain to connect to the proxy
+can_tcp_connect(domain, perdition_t)
+
+# Use capabilities
+allow perdition_t self:capability { setgid setuid net_bind_service };
+
+# read config files
+allow perdition_t etc_perdition_t:dir r_dir_perms;
+allow perdition_t { etc_t etc_perdition_t resolv_conf_t }:file r_file_perms;
+allow perdition_t etc_t:lnk_file read;
+
diff -ruwN /tmp/policy/domains/program/uml.te policy/domains/program/uml.te
--- /tmp/policy/domains/program/uml.te	1970-01-01 01:00:00.000000000 +0100
+++ policy/domains/program/uml.te	2003-01-18 14:59:45.000000000 +0100
@@ -0,0 +1,7 @@
+
+# Author: Russell Coker <russell@coker.com.au>
+#
+type uml_exec_t, file_type, sysadmfile, exec_type;
+
+# the main code is in macros/program/uml_macros.te
+
diff -ruwN /tmp/policy/domains/program/uml_net.te policy/domains/program/uml_net.te
--- /tmp/policy/domains/program/uml_net.te	1970-01-01 01:00:00.000000000 +0100
+++ policy/domains/program/uml_net.te	2003-01-18 14:59:51.000000000 +0100
@@ -0,0 +1,36 @@
+#DESC uml_net helper program for user-mode Linux
+#
+# Author: Russell Coker <russell@coker.com.au>
+#
+
+type uml_net_t, domain, privlog;
+type uml_net_exec_t, file_type, sysadmfile, exec_type;
+in_user_role(uml_net_t)
+allow uml_net_t self:process { fork signal_perms };
+allow uml_net_t { bin_t sbin_t }:dir search;
+allow uml_net_t self:fifo_file { read write };
+allow uml_net_t device_t:dir search;
+allow uml_net_t self:udp_socket { create ioctl };
+uses_shlib(uml_net_t)
+allow uml_net_t devtty_t:chr_file { read write };
+allow uml_net_t etc_runtime_t:file { getattr read };
+allow uml_net_t etc_t:file read;
+allow uml_net_t { proc_t sysctl_t sysctl_net_t }:dir search;
+allow uml_net_t proc_t:file { getattr read };
+
+# if you want ip_forward to be set then you should set it yourself
+dontaudit uml_net_t { sysctl_t sysctl_net_t }:dir search;
+dontaudit uml_net_t sysctl_net_t:file write;
+
+dontaudit { insmod_t ifconfig_t } uml_net_t:udp_socket { read write };
+dontaudit uml_net_t self:capability { sys_module };
+
+domain_auto_trans_read(uml_net_t, insmod_exec_t, insmod_t)
+domain_auto_trans_read(uml_net_t, ifconfig_exec_t, ifconfig_t)
+allow uml_net_t tun_tap_device_t:chr_file { read write getattr ioctl };
+can_exec(uml_net_t, { shell_exec_t sbin_t })
+
+
+# this is really bad for security!
+in_user_role({ insmod_t ifconfig_t })
+
diff -ruwN /tmp/policy/file_contexts/program/nessusd.fc policy/file_contexts/program/nessusd.fc
--- /tmp/policy/file_contexts/program/nessusd.fc	1970-01-01 01:00:00.000000000 +0100
+++ policy/file_contexts/program/nessusd.fc	2003-01-19 12:27:38.000000000 +0100
@@ -0,0 +1,6 @@
+# nessusd - network scanning server
+/usr/sbin/nessusd		system_u:object_r:nessusd_exec_t
+/usr/lib/nessus/plugins/.*	system_u:object_r:nessusd_exec_t
+/var/lib/nessus(/.*)?		system_u:object_r:nessusd_db_t
+/var/log/nessus(/.*)?		system_u:object_r:nessusd_log_t
+/etc/nessus/nessusd.conf	system_u:object_r:etc_nessusd_t
diff -ruwN /tmp/policy/file_contexts/program/nsd.fc policy/file_contexts/program/nsd.fc
--- /tmp/policy/file_contexts/program/nsd.fc	1970-01-01 01:00:00.000000000 +0100
+++ policy/file_contexts/program/nsd.fc	2003-01-18 15:05:28.000000000 +0100
@@ -0,0 +1,4 @@
+# nsd
+/etc/nsd(/.*)?       		system_u:object_r:nsd_conf_t
+/usr/sbin/nsd      		system_u:object_r:nsd_exec_t
+/var/run/nsd.pid		system_u:object_r:var_run_nsd_t
diff -ruwN /tmp/policy/file_contexts/program/perdition.fc policy/file_contexts/program/perdition.fc
--- /tmp/policy/file_contexts/program/perdition.fc	1970-01-01 01:00:00.000000000 +0100
+++ policy/file_contexts/program/perdition.fc	2003-01-18 15:05:34.000000000 +0100
@@ -0,0 +1,3 @@
+# perdition POP and IMAP proxy
+/usr/sbin/perdition		system_u:object_r:perdition_exec_t
+/etc/perdition(/.*)?		system_u:object_r:etc_perdition_t
diff -ruwN /tmp/policy/file_contexts/program/uml_net.fc policy/file_contexts/program/uml_net.fc
--- /tmp/policy/file_contexts/program/uml_net.fc	1970-01-01 01:00:00.000000000 +0100
+++ policy/file_contexts/program/uml_net.fc	2003-01-18 15:06:20.000000000 +0100
@@ -0,0 +1,2 @@
+# User Mode Linux
+/usr/lib/uml/uml_net	system_u:object_r:uml_net_exec_t
diff -ruwN /tmp/policy/macros/program/uml_macros.te policy/macros/program/uml_macros.te
--- /tmp/policy/macros/program/uml_macros.te	1970-01-01 01:00:00.000000000 +0100
+++ policy/macros/program/uml_macros.te	2003-01-18 15:12:22.000000000 +0100
@@ -0,0 +1,129 @@
+#
+# Macros for uml domains.
+#
+
+#
+# Author:  Russell Coker <russell@coker.com.au>
+#
+
+#
+# uml_domain(domain_prefix)
+#
+# Define a derived domain for the uml program when executed
+# by a user domain.
+#
+# The type declaration for the executable type for this program is
+# provided separately in domains/program/uml.te. 
+#
+undefine(`uml_domain')
+ifdef(`uml.te', `
+define(`uml_domain',`
+# Derived domain based on the calling user domain and the program.
+type $1_uml_t, domain;
+type $1_uml_exec_t, file_type, sysadmfile;
+type $1_uml_ro_t, file_type, sysadmfile;
+type $1_uml_rw_t, file_type, sysadmfile;
+
+allow $1_t { $1_uml_ro_t $1_uml_rw_t $1_uml_exec_t }:file_class_set { relabelfrom relabelto create_file_perms };
+allow $1_t { $1_uml_ro_t $1_uml_rw_t $1_uml_exec_t }:dir { relabelfrom relabelto create_dir_perms };
+
+# Transition from the user domain to this domain.
+domain_auto_trans($1_t, { uml_exec_t $1_uml_exec_t }, $1_uml_t)
+can_exec($1_uml_t, { uml_exec_t $1_uml_exec_t })
+
+# The user role is authorized for this domain.
+role $1_r types $1_uml_t;
+
+# Inherit and use descriptors from gnome-pty-helper.
+ifdef(`gnome-pty-helper.te',
+`allow $1_uml_t $1_gph_t:fd use;
+allow $1_t $1_gph_t:fd use;')
+
+# Inherit and use descriptors from newrole.
+ifdef(`newrole.te', `allow $1_uml_t newrole_t:fd use;')
+
+# allow ps to show uml
+allow $1_t $1_uml_t:dir { search getattr read };
+allow $1_t $1_uml_t:{ file lnk_file } { read getattr };
+allow $1_t $1_uml_t:process signal_perms;
+
+# allow the UML thing to happen
+allow $1_uml_t self:process { fork signal_perms ptrace };
+can_create_pty($1_uml)
+allow $1_uml_t root_t:dir search;
+tmp_domain($1_uml)
+can_exec($1_uml_t, $1_uml_tmp_t)
+create_dir_file($1_t, $1_uml_tmp_t)
+allow $1_uml_t self:fifo_file rw_file_perms;
+
+allow $1_uml_t tun_tap_device_t:chr_file { read write ioctl };
+
+ifdef(`uml_net.te', `
+# for uml_net
+domain_auto_trans_read($1_uml_t, uml_net_exec_t, uml_net_t)
+allow uml_net_t $1_uml_t:unix_stream_socket { read write };
+allow uml_net_t $1_uml_t:unix_dgram_socket { read write };
+dontaudit uml_net_t privfd:fd use;
+allow uml_net_t $1_uml_devpts_t:chr_file { read write };
+dontaudit uml_net_t $1_uml_rw_t:dir { getattr search };
+
+dontaudit uml_net_t $1_uml_ro_t:file read;
+dontaudit uml_net_t $1_uml_rw_t:file { read write };
+dontaudit { insmod_t ifconfig_t } $1_uml_t:fd { use };
+')
+
+# for mconsole
+allow { $1_t $1_uml_t } $1_uml_t:unix_dgram_socket sendto;
+allow $1_uml_t $1_t:unix_dgram_socket sendto;
+
+# Use the network.
+can_network($1_uml_t)
+
+# for xterm
+uses_shlib($1_uml_t)
+can_exec($1_uml_t, { bin_t sbin_t lib_t })
+allow $1_uml_t bin_t:dir search;
+dontaudit $1_uml_t sbin_t:dir search;
+allow $1_uml_t etc_t:file { getattr read };
+dontaudit $1_uml_t { etc_runtime_t resolv_conf_t }:file read;
+can_tcp_connect($1_uml_t, sshd_t)
+allow $1_uml_t $1_home_xauth_t:file { getattr read };
+allow $1_uml_t initrc_var_run_t:file { getattr read lock };
+dontaudit $1_uml_t initrc_var_run_t:file write;
+
+#allow $1_uml_t { etc_t resolv_conf_t }:file { read getattr };
+#allow $1_uml_t etc_t:lnk_file read;
+#allow $1_uml_t fs_t:filesystem getattr;
+#allow $1_uml_t var_t:dir search;
+allow $1_uml_t devpts_t:dir { getattr read search };
+allow $1_uml_t device_t:dir search;
+allow $1_uml_t devtty_t:chr_file rw_file_perms;
+allow $1_uml_t self:unix_stream_socket create_stream_socket_perms;
+allow $1_uml_t self:unix_dgram_socket create_socket_perms;
+allow $1_uml_t privfd:fd use;
+allow $1_uml_t proc_t:dir search;
+allow $1_uml_t proc_t:file { getattr read };
+#allow $1_uml_t { self proc_t }:lnk_file read;
+#allow $1_uml_t self:dir search;
+#dontaudit $1_uml_t var_run_t:dir search;
+
+# Write to the user domain tty.
+allow $1_uml_t $1_tty_device_t:chr_file rw_file_perms;
+allow $1_uml_t $1_devpts_t:chr_file rw_file_perms;
+
+# allow utmp access
+#allow $1_uml_t initrc_var_run_t:file read;
+#dontaudit $1_uml_t initrc_var_run_t:file lock;
+
+# access config files
+allow $1_uml_t home_root_t:dir search;
+file_type_auto_trans($1_uml_t, $1_home_dir_t, $1_uml_rw_t)
+r_dir_file($1_uml_t, $1_uml_ro_t)
+
+')
+
+', `
+
+define(`uml_domain',`')
+
+')

--Boundary-00=_AE0K+QKYn0kB0ub--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
