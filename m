Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAOGMrIi020733
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 11:22:53 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAOGMrCA000222
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 16:22:56 GMT
Message-ID: <41A4B54F.3070709@redhat.com>
Date: Wed, 24 Nov 2004 11:22:39 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: Russell Coker <russell@coker.com.au>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: can_network patch.
References: <41741A2C.8040408@redhat.com>	 <200410260138.19426.russell@coker.com.au>	 <20041025213122.GA2535@jmh.mhn.de>	 <200410270036.14935.russell@coker.com.au>	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>	 <4192A029.5050909@redhat.com>	 <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil>	 <419CB2A8.7020504@redhat.com> <1101235934.7273.24.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1101235934.7273.24.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------050700000400070100010202"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050700000400070100010202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

    *   This patch includes the ugliness to get sun's jre plugin to work
      in Mozilla.  (otherwize mozilla crashes).
    * Removed distro_gentoo checks around proc_net since we want these also.
    * Futzed around with userhelper so that mozilla can run it.
    * Cleaned up stunnel.te so it should be usable for gentoo and other
      distributions.
    * Some cleanup of apache to allow starting of apache with ssl keys
    * Includes modification to global_macros to extract out
      network_macros.te


network_macros.te includes

can_network - with all the current functionaility

I added

can_network_server (Has listen and accept, both udp and tcp)
can_network_server_udp
can_network_server_tcp

can_network_client (Has connect, both udp and tcp)
can_network_client_tcp
can_network_client_udp

can_network_udp  - Same as can_network but only for udp
can_network_tcp - Same as can_network but only for tcp


--------------050700000400070100010202
Content-Type: text/x-patch;
 name="policy-small.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-small.patch"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ifconfig.te policy-1.19.5/domains/program/ifconfig.te
--- nsapolicy/domains/program/ifconfig.te	2004-11-20 22:29:08.000000000 -0500
+++ policy-1.19.5/domains/program/ifconfig.te	2004-11-24 10:57:51.317336099 -0500
@@ -38,12 +38,8 @@
 allow ifconfig_t { kernel_t init_t }:fd use;
 
 # Access /proc
-allow ifconfig_t proc_t:dir r_dir_perms;
-allow ifconfig_t proc_t:file r_file_perms;
-ifdef(`distro_gentoo', `
-allow ifconfig_t proc_net_t:dir r_dir_perms;
-allow ifconfig_t proc_net_t:file r_file_perms;
-')
+r_dir_file(ifconfig_t, proc_t)
+r_dir_file(ifconfig_t, proc_net_t)
 
 allow ifconfig_t privfd:fd use;
 allow ifconfig_t run_init_t:fd use;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.19.5/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2004-11-24 07:00:50.000000000 -0500
+++ policy-1.19.5/domains/program/unused/apache.te	2004-11-24 10:57:51.318335986 -0500
@@ -322,14 +322,13 @@
 application_domain(httpd_helper)
 role system_r types httpd_helper_t;
 domain_auto_trans(httpd_t, httpd_helper_exec_t, httpd_helper_t)
-
-allow httpd_helper_t devpts_t:dir { search };
-allow httpd_helper_t devtty_t:chr_file rw_file_perms;
 allow httpd_helper_t httpd_config_t:file { getattr read };
 allow httpd_helper_t httpd_log_t:file { append };
+
 if (httpd_tty_comm) {
+allow { httpd_t httpd_helper_t } devpts_t:dir { search };
 ifdef(`targeted_policy', `
-allow { httpd_helper_t httpd_t } devpts_t:chr_file { read write };
+allow { httpd_helper_t httpd_t } { devtty_t devpts_t }:chr_file { read write };
 ')
 allow { httpd_t httpd_helper_t } admin_tty_type:chr_file { read write };
 }
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/iptables.te policy-1.19.5/domains/program/unused/iptables.te
--- nsapolicy/domains/program/unused/iptables.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.5/domains/program/unused/iptables.te	2004-11-24 10:57:51.319335873 -0500
@@ -54,10 +54,8 @@
 ifdef(`gnome-pty-helper.te', `allow iptables_t sysadm_gph_t:fd use;')
 
 allow iptables_t proc_t:file { getattr read };
-ifdef(`distro_gentoo', `
 allow iptables_t proc_net_t:dir { search };
 allow iptables_t proc_net_t:file { read getattr };
-')
 
 # system-config-network appends to /var/log
 allow iptables_t var_log_t:file append;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpcd.te policy-1.19.5/domains/program/unused/rpcd.te
--- nsapolicy/domains/program/unused/rpcd.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.5/domains/program/unused/rpcd.te	2004-11-24 10:59:38.728216864 -0500
@@ -72,9 +72,7 @@
 
 # for /proc/fs/nfs/exports - should we have a new type?
 allow nfsd_t proc_t:file r_file_perms;
-ifdef(`distro_gentoo', `
 allow nfsd_t proc_net_t:dir search;
-')
 allow nfsd_t exports_t:file { getattr read };
 
 allow nfsd_t nfsd_fs_t:filesystem mount;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/snmpd.te policy-1.19.5/domains/program/unused/snmpd.te
--- nsapolicy/domains/program/unused/snmpd.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.5/domains/program/unused/snmpd.te	2004-11-24 10:57:51.320335760 -0500
@@ -70,11 +70,9 @@
 ')
 allow snmpd_t var_lib_nfs_t:dir search;
 
-ifdef(`distro_gentoo', `
 # needed in order to retrieve net traffic data
 allow snmpd_t proc_net_t:dir search;
 allow snmpd_t proc_net_t:file r_file_perms;
-')
 
 dontaudit snmpd_t domain:dir { getattr search };
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/stunnel.te policy-1.19.5/domains/program/unused/stunnel.te
--- nsapolicy/domains/program/unused/stunnel.te	2004-11-24 08:36:21.000000000 -0500
+++ policy-1.19.5/domains/program/unused/stunnel.te	2004-11-24 10:57:51.322335534 -0500
@@ -2,6 +2,12 @@
 #
 # Author:   petre rodan <kaiowas@gentoo.org>
 #
+ifelse(`distro_gentoo', `', `
+
+inetd_child_domain(stunnel, tcp)
+allow stunnel_t self:capability sys_chroot;
+
+', `
 
 type stunnel_port_t, port_type;
 
@@ -9,14 +15,15 @@
 
 can_network(stunnel_t)
 
-type stunnel_etc_t, file_type, sysadmfile;
-
 allow stunnel_t self:capability { setgid setuid sys_chroot };
 allow stunnel_t self:fifo_file { read write };
 allow stunnel_t self:tcp_socket { read write };
 allow stunnel_t self:unix_stream_socket { connect create };
 
-allow stunnel_t stunnel_port_t:tcp_socket { name_bind };
+r_dir_file(stunnel_t, etc_t)
+')
 
+type stunnel_etc_t, file_type, sysadmfile;
 r_dir_file(stunnel_t, stunnel_etc_t)
-r_dir_file(stunnel_t, etc_t)
+allow stunnel_t stunnel_port_t:tcp_socket { name_bind };
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/watchdog.te policy-1.19.5/domains/program/unused/watchdog.te
--- nsapolicy/domains/program/unused/watchdog.te	2004-11-09 13:35:13.000000000 -0500
+++ policy-1.19.5/domains/program/unused/watchdog.te	2004-11-24 10:57:51.322335534 -0500
@@ -25,7 +25,6 @@
 allow watchdog_t self:unix_stream_socket create_socket_perms;
 can_network(watchdog_t)
 can_ypbind(watchdog_t)
-allow watchdog_t self:udp_socket create_socket_perms;
 allow watchdog_t bin_t:dir search;
 allow watchdog_t bin_t:lnk_file read;
 allow watchdog_t init_t:process signal;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/user.te policy-1.19.5/domains/user.te
--- nsapolicy/domains/user.te	2004-11-20 22:29:08.000000000 -0500
+++ policy-1.19.5/domains/user.te	2004-11-24 10:57:51.323335422 -0500
@@ -53,7 +53,6 @@
 # Reach sysadm_t via programs like userhelper/sudo/su
 undefine(`reach_sysadm')
 define(`reach_sysadm', `
-ifdef(`userhelper.te', `userhelper_domain($1)')
 ifdef(`sudo.te', `sudo_domain($1)')
 ifdef(`su.te', `
 su_domain($1)
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/types.fc policy-1.19.5/file_contexts/types.fc
--- nsapolicy/file_contexts/types.fc	2004-11-24 07:00:50.000000000 -0500
+++ policy-1.19.5/file_contexts/types.fc	2004-11-24 10:57:51.324335309 -0500
@@ -334,6 +334,9 @@
 /usr(/.*)?			system_u:object_r:usr_t
 /usr(/.*)?/lib(64)?(/.*)?	system_u:object_r:lib_t
 /usr(/.*)?/lib(64)?/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/usr(/.*)?/java/.*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
+/usr(/.*)?/java/.*\.jar	--	system_u:object_r:shlib_t
+/usr(/.*)?/java/.*\.jsa	--	system_u:object_r:shlib_t
 /usr(/.*)?/lib(64)?(/.*)?/ld-[^/]*\.so(\.[^/]*)* system_u:object_r:ld_so_t
 /usr(/.*)?/bin(/.*)?		system_u:object_r:bin_t
 /usr(/.*)?/Bin(/.*)?		system_u:object_r:bin_t
diff --exclude-from=exclude -N -u -r nsapolicy/genfs_contexts policy-1.19.5/genfs_contexts
--- nsapolicy/genfs_contexts	2004-11-20 22:29:08.000000000 -0500
+++ policy-1.19.5/genfs_contexts	2004-11-24 10:57:51.325335196 -0500
@@ -36,9 +36,7 @@
 genfscon proc /kcore			system_u:object_r:proc_kcore_t
 genfscon proc /mdstat			system_u:object_r:proc_mdstat_t
 genfscon proc /mtrr			system_u:object_r:mtrr_device_t
-ifdef(`distro_gentoo', `
 genfscon proc /net			system_u:object_r:proc_net_t
-')
 genfscon proc /sysvipc			system_u:object_r:proc_t
 genfscon proc /sys			system_u:object_r:sysctl_t
 genfscon proc /sys/kernel		system_u:object_r:sysctl_kernel_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/admin_macros.te policy-1.19.5/macros/admin_macros.te
--- nsapolicy/macros/admin_macros.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.5/macros/admin_macros.te	2004-11-24 10:57:51.325335196 -0500
@@ -33,7 +33,6 @@
 allow $1_t self:capability setuid;
 
 ifdef(`su.te', `su_domain($1)')
-ifdef(`userhelper.te', `userhelper_domain($1)')
 ifdef(`sudo.te', `sudo_domain($1)')
 
 # Violates the goal of limiting write access to checkpolicy.
diff --exclude-from=exclude -N -u -r nsapolicy/macros/base_user_macros.te policy-1.19.5/macros/base_user_macros.te
--- nsapolicy/macros/base_user_macros.te	2004-11-24 07:00:51.000000000 -0500
+++ policy-1.19.5/macros/base_user_macros.te	2004-11-24 10:57:51.326335083 -0500
@@ -160,6 +160,7 @@
 
 ifdef(`screen.te', `screen_domain($1)')
 ifdef(`tvtime.te', `tvtime_domain($1)')
+ifdef(`userhelper.te', `userhelper_domain($1)')
 ifdef(`mozilla.te', `mozilla_domain($1)')
 ifdef(`games.te', `games_domain($1)')
 ifdef(`gpg.te', `gpg_domain($1)')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.19.5/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.5/macros/global_macros.te	2004-11-24 10:57:51.327334970 -0500
@@ -118,64 +118,6 @@
 
 #################################
 #
-# can_network(domain)
-#
-# Permissions for accessing the network.
-# See types/network.te for the network types.
-# See net_contexts for security contexts for network entities.
-#
-define(`can_network',`
-#
-# Allow the domain to create and use UDP and TCP sockets.
-# Other kinds of sockets must be separately authorized for use.
-allow $1 self:udp_socket create_socket_perms;
-allow $1 self:tcp_socket create_stream_socket_perms;
-
-#
-# Allow the domain to send or receive using any network interface.
-# netif_type is a type attribute for all network interface types.
-#
-allow $1 netif_type:netif { tcp_send udp_send rawip_send };
-allow $1 netif_type:netif { tcp_recv udp_recv rawip_recv };
-
-#
-# Allow the domain to send to or receive from any node.
-# node_type is a type attribute for all node types.
-#
-allow $1 node_type:node { tcp_send udp_send rawip_send };
-allow $1 node_type:node { tcp_recv udp_recv rawip_recv };
-
-#
-# Allow the domain to send to or receive from any port.
-# port_type is a type attribute for all port types.
-#
-allow $1 port_type:{ tcp_socket udp_socket } { send_msg recv_msg };
-
-#
-# Allow the domain to send NFS client requests via the socket
-# created by mount.
-#
-allow $1 mount_t:udp_socket rw_socket_perms;
-
-#
-# Bind to the default port type.
-# Other port types must be separately authorized.
-#
-#allow $1 port_t:udp_socket name_bind;
-#allow $1 port_t:tcp_socket name_bind;
-
-# XXX Allow binding to any node type.  Remove once
-# individual rules have been added to all domains that 
-# bind sockets. 
-allow $1 node_type: { tcp_socket udp_socket } node_bind;
-#
-# Allow access to network files including /etc/resolv.conf
-#
-allow $1 net_conf_t:file r_file_perms;
-')dnl end can_network definition
-
-#################################
-#
 # can_sysctl(domain)
 #
 # Permissions for modifying sysctl parameters.
@@ -215,10 +157,7 @@
 allow $1 proc_t:dir r_dir_perms;
 allow $1 proc_t:notdevfile_class_set r_file_perms;
 allow $1 proc_mdstat_t:file r_file_perms;
-ifdef(`distro_gentoo', `
-allow $1 proc_net_t:dir r_dir_perms;
-allow $1 proc_net_t:file r_file_perms;
-')
+r_dir_file($1, proc_net_t)
 
 # Stat /proc/kmsg and /proc/kcore.
 allow $1 proc_fs:file stat_file_perms;
@@ -558,7 +497,7 @@
 # pseudo filesystem types that are applied to both the filesystem
 # and its files.
 allow $1 { unlabeled_t fs_type }:dir_file_class_set *;
-allow $1 proc_fs: file *;
+allow $1 proc_fs:{ dir file } *;
 
 # For /proc/pid
 r_dir_file($1,domain)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/network_macros.te policy-1.19.5/macros/network_macros.te
--- nsapolicy/macros/network_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.19.5/macros/network_macros.te	2004-11-24 10:57:51.328334858 -0500
@@ -0,0 +1,189 @@
+#################################
+#
+# can_network(domain)
+#
+# Permissions for accessing the network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`base_can_network',`
+#
+# Allow the domain to create and use $2 sockets.
+# Other kinds of sockets must be separately authorized for use.
+allow $1 self:$2_socket connected_socket_perms;
+
+#
+# Allow the domain to send or receive using any network interface.
+# netif_type is a type attribute for all network interface types.
+#
+allow $1 netif_type:netif { $2_send rawip_send };
+allow $1 netif_type:netif { $2_recv rawip_recv };
+
+#
+# Allow the domain to send to or receive from any node.
+# node_type is a type attribute for all node types.
+#
+allow $1 node_type:node { $2_send rawip_send };
+allow $1 node_type:node { $2_recv rawip_recv };
+
+#
+# Allow the domain to send to or receive from any port.
+# port_type is a type attribute for all port types.
+#
+ifelse($3, `', `
+allow $1 port_type:$2_socket { send_msg recv_msg };
+', `
+allow $1 $3:$2_socket { send_msg recv_msg };
+')
+
+# XXX Allow binding to any node type.  Remove once
+# individual rules have been added to all domains that 
+# bind sockets. 
+allow $1 node_type:$2_socket node_bind;
+#
+# Allow access to network files including /etc/resolv.conf
+#
+allow $1 net_conf_t:file r_file_perms;
+')dnl end can_network definition
+
+#################################
+#
+# can_network_server_tcp(domain)
+#
+# Permissions for accessing a tcp network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`can_network_server_tcp',`
+base_can_network($1, tcp, `$2')
+allow $1 self:tcp_socket { listen accept };
+')
+
+#################################
+#
+# can_network_server_udp(domain)
+#
+# Permissions for accessing a udp network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`can_network_server_udp',`
+base_can_network($1, udp, `$2')
+')
+
+#################################
+#
+# can_network_client_tcp(domain)
+#
+# Permissions for accessing a tcp network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`can_network_client_tcp',`
+base_can_network($1, tcp, `$2')
+allow $1 self:tcp_socket { connect };
+')
+
+#################################
+#
+# can_network_client_udp(domain)
+#
+# Permissions for accessing a udp network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`can_network_client_udp',`
+base_can_network($1, udp, `$2')
+allow $1 self:udp_socket { connect };
+')
+
+#################################
+#
+# can_network_tcp(domain)
+#
+# Permissions for accessing the network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`can_network_tcp',`
+
+can_network_server_tcp($1, `$2')
+can_network_client_tcp($1, `$2')
+
+')
+
+#################################
+#
+# can_network_udp(domain)
+#
+# Permissions for accessing the network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`can_network_udp',`
+
+can_network_client_udp($1, `$2')
+can_network_server_udp($1, `$2')
+
+')
+
+#################################
+#
+# can_network_server(domain)
+#
+# Permissions for accessing the network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`can_network_server',`
+
+can_network_server_tcp($1, `$2')
+can_network_server_udp($1, `$2')
+
+')dnl end can_network_server definition
+
+
+#################################
+#
+# can_network_client(domain)
+#
+# Permissions for accessing the network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`can_network_client',`
+
+can_network_client_tcp($1, `$2')
+can_network_client_udp($1, `$2')
+
+')dnl end can_network_client definition
+
+#################################
+#
+# can_network(domain)
+#
+# Permissions for accessing the network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`can_network',`
+
+can_network_tcp($1, `$2')
+can_network_udp($1, `$2')
+
+#
+# Allow the domain to send NFS client requests via the socket
+# created by mount.
+#
+allow $1 mount_t:udp_socket rw_socket_perms;
+
+')dnl end can_network definition
+
+define(`can_resolve',`
+can_network_client_udp($1, `dns_port_t')
+')
+
+define(`can_ldap',`
+can_network_client_tcp($1, `ldap_port_t')
+')
+
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/apache_macros.te policy-1.19.5/macros/program/apache_macros.te
--- nsapolicy/macros/program/apache_macros.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.5/macros/program/apache_macros.te	2004-11-24 10:57:51.329334745 -0500
@@ -42,6 +42,7 @@
 allow httpd_$1_script_t fs_t:filesystem getattr;
 allow httpd_$1_script_t self:unix_stream_socket create_socket_perms;
 allow httpd_$1_script_t proc_t:file { getattr read };
+allow httpd_$1_script_t httpd_t:unix_stream_socket { read write };
 
 allow httpd_$1_script_t { self proc_t }:dir r_dir_perms;
 allow httpd_$1_script_t { self proc_t }:lnk_file read;
@@ -89,9 +90,7 @@
 # Allow the script interpreters to run the scripts.  So
 # the perl executable will be able to run a perl script
 #########################################################################
-can_exec(httpd_$1_script_t, { bin_t shell_exec_t })
-allow httpd_$1_script_t { bin_t sbin_t }:dir { getattr search };
-allow httpd_$1_script_t { sbin_t bin_t }:lnk_file read;
+can_exec_any(httpd_$1_script_t)
 allow httpd_$1_script_t etc_t:file { getattr read };
 
 ############################################################################
@@ -117,10 +116,10 @@
 domain_auto_trans(sysadm_t, httpdcontent, httpd_sys_script_t)
 create_dir_file(httpd_t, httpdcontent)
 ', `
-create_dir_file(httpd_$1_script_t, httpdcontent)
 can_exec(httpd_$1_script_t, httpdcontent )
 domain_auto_trans($1_t, httpdcontent, httpd_$1_script_t)
 ')
+create_dir_file(httpd_$1_script_t, httpdcontent)
 }
 
 ifelse($1, sys, `
@@ -167,6 +166,9 @@
 }
 ')dnl end ifelse sys
 
+dontaudit httpd_$1_script_t sysctl_kernel_t:dir search;
+dontaudit httpd_$1_script_t sysctl_t:dir search;
+
 ################################################################
 # Allow the web server to run scripts and serve pages
 ##############################################################
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/chkpwd_macros.te policy-1.19.5/macros/program/chkpwd_macros.te
--- nsapolicy/macros/program/chkpwd_macros.te	2004-11-18 08:13:59.000000000 -0500
+++ policy-1.19.5/macros/program/chkpwd_macros.te	2004-11-24 10:57:51.330334632 -0500
@@ -22,6 +22,8 @@
 can_getcon($1_chkpwd_t)
 can_ypbind($1_chkpwd_t)
 can_kerberos($1_chkpwd_t)
+can_ldap($1_chkpwd_t)
+can_resolve($1_chkpwd_t)
 # Transition from the user domain to this domain.
 ifelse($1, system, `
 domain_auto_trans(auth_chkpwd, chkpwd_exec_t, system_chkpwd_t)
@@ -31,6 +33,8 @@
 dontaudit $1_chkpwd_t { user_tty_type tty_device_t }:chr_file rw_file_perms;
 can_ypbind(auth_chkpwd)
 can_kerberos(auth_chkpwd)
+can_ldap(auth_chkpwd)
+can_resolve(auth_chkpwd)
 ', `
 domain_auto_trans($1_t, chkpwd_exec_t, $1_chkpwd_t)
 allow $1_t sbin_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/kerberos_macros.te policy-1.19.5/macros/program/kerberos_macros.te
--- nsapolicy/macros/program/kerberos_macros.te	2004-11-20 22:29:09.000000000 -0500
+++ policy-1.19.5/macros/program/kerberos_macros.te	2004-11-24 10:57:51.331334519 -0500
@@ -1,7 +1,8 @@
 define(`can_kerberos',`
 ifdef(`kerberos.te',`
 if (allow_kerberos) {
-can_network($1)
+can_network_client($1, `kerberos_port_t')
+can_resolve($1)
 dontaudit $1 krb5_conf_t:file write;
 allow $1 krb5_conf_t:file { getattr read };
 }
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.19.5/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2004-11-24 07:00:51.000000000 -0500
+++ policy-1.19.5/macros/program/mozilla_macros.te	2004-11-24 10:57:51.332334406 -0500
@@ -29,7 +29,8 @@
 
 allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
 allow $1_mozilla_t var_lib_t:file { getattr read };
-allow $1_mozilla_t urandom_device_t:chr_file { getattr ioctl read };
+allow $1_mozilla_t { random_device_t urandom_device_t }:chr_file { getattr ioctl read append };
+
 allow $1_mozilla_t self:socket create_socket_perms;
 allow $1_mozilla_t self:file { getattr read };
 
@@ -117,8 +118,20 @@
 dontaudit $1_mozilla_t file_type:dir getattr;
 allow $1_mozilla_t self:sem create_sem_perms;
 
+ifdef(`userhelper.te', `
+domain_auto_trans($1_mozilla_t, userhelper_exec_t, $1_userhelper_t)
+')
 dontaudit $1_mozilla_t selinux_config_t:dir search;
 
+#
+# Rules needed to run java apps
+#
+allow $1_mozilla_t ld_so_cache_t:file execute;
+allow $1_mozilla_t locale_t:file execute;
+dontaudit $1_mozilla_t *:{ chr_file file } execute;
+dontaudit $1_t ld_so_cache_t:file execute;
+dontaudit $1_t locale_t:file execute;
+
 ifdef(`xdm.te', `
 allow $1_mozilla_t xdm_t:fifo_file { write read };
 allow $1_mozilla_t xdm_tmp_t:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/userhelper_macros.te policy-1.19.5/macros/program/userhelper_macros.te
--- nsapolicy/macros/program/userhelper_macros.te	2004-11-24 07:00:51.000000000 -0500
+++ policy-1.19.5/macros/program/userhelper_macros.te	2004-11-24 10:57:51.332334406 -0500
@@ -143,8 +143,4 @@
 allow $1_userhelper_t pam_var_console_t:dir { search };
 ')
 
-ifdef(`mozilla.te', `
-domain_auto_trans($1_mozilla_t, userhelper_exec_t, $1_userhelper_t)
-')
-
 ')dnl end userhelper macro
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/vmware_macros.te policy-1.19.5/macros/program/vmware_macros.te
--- nsapolicy/macros/program/vmware_macros.te	2004-11-20 22:29:10.000000000 -0500
+++ policy-1.19.5/macros/program/vmware_macros.te	2004-11-24 10:57:51.333334293 -0500
@@ -55,10 +55,8 @@
 
 # Access /proc
 r_dir_file($1_vmware_t, proc_t)
-ifdef(`distro_gentoo', `
 allow $1_vmware_t proc_net_t:dir search;
 allow $1_vmware_t proc_net_t:file { getattr read };
-')
 
 # Access to some files in the user home directory
 r_dir_file($1_vmware_t, $1_home_t)
diff --exclude-from=exclude -N -u -r nsapolicy/types/procfs.te policy-1.19.5/types/procfs.te
--- nsapolicy/types/procfs.te	2004-11-20 22:29:10.000000000 -0500
+++ policy-1.19.5/types/procfs.te	2004-11-24 10:57:51.334334181 -0500
@@ -12,14 +12,13 @@
 # proc_kmsg_t is the type of /proc/kmsg.
 # proc_kcore_t is the type of /proc/kcore.
 # proc_mdstat_t is the type of /proc/mdstat.
+# proc_net_t is the type of /proc/net.
 #
 type proc_t, fs_type, proc_fs, root_dir_type;
 type proc_kmsg_t, proc_fs;
 type proc_kcore_t, proc_fs;
 type proc_mdstat_t, proc_fs;
-ifdef(`distro_gentoo', `
 type proc_net_t, proc_fs;
-')
 
 #
 # sysctl_t is the type of /proc/sys.

--------------050700000400070100010202--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
