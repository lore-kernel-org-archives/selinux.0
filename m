Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBFDJ0Ee003530
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 08:19:00 -0500
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBFDJXgh005854
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 13:19:33 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8) with ESMTP id kBFDFqMS026651
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 08:15:52 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.8/8.13.8/Submit) id kBFDFqdC026650
	for selinux@tycho.nsa.gov; Fri, 15 Dec 2006 08:15:52 -0500
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBF1sHWB016922
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:54:17 -0500
Received: from e1.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBF1sn9T013945
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 01:54:49 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBF1smYl000751
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:54:48 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kBF1smnT306524
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:54:48 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kBF1slhd008015
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:54:48 -0500
Date: Thu, 14 Dec 2006 19:40:56 -0600
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200612150140.kBF1euWZ002764@faith.austin.ibm.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/7] labeled ipsec policy changes
Cc: cpebenito@tresys.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch allows networking programs to
sendto and recvfrom using ipsec associations.

Networking programs such as ping, have a socket
and SA with same type, ping_t, so only
require the sendto and recvfrom for itself.
So, I have added sendto and recvfrom for self
to the networking programs.

I have also added an interface to each networking
module such that a sysadm can specify which subjects
may recvfrom with SAs of the network module's type.

Signed-off-by; Joy Latten <latten@austin.ibm.com>

 afs.if            |   90 ++++++++++++++++++++++++++++++++++++++++++++
 afs.te            |    5 ++
 amavis.if         |   18 ++++++++
 amavis.te         |    1 
 apache.if         |   56 +++++++++++++++++++++++++++
 apache.te         |    1 
 arpwatch.if       |   18 ++++++++
 arpwatch.te       |    1 
 asterisk.if       |   18 ++++++++
 asterisk.te       |    1 
 automount.if      |   18 ++++++++
 automount.te      |    1 
 avahi.if          |   18 ++++++++
 avahi.te          |    1 
 bind.if           |   36 +++++++++++++++++
 bind.te           |    2 
 bluetooth.if      |   18 ++++++++
 bluetooth.te      |    1 
 canna.if          |   18 ++++++++
 canna.te          |    1 
 ccs.if            |   18 ++++++++
 ccs.te            |    1 
 cipe.if           |   18 ++++++++
 cipe.te           |    1 
 clamav.if         |   36 +++++++++++++++++
 clamav.te         |    1 
 clockspeed.if     |   36 +++++++++++++++++
 clockspeed.te     |    2 
 comsat.if         |   18 ++++++++
 comsat.te         |    1 
 courier.if        |  110 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 cups.if           |   56 +++++++++++++++++++++++++++
 cups.te           |    5 ++
 cvs.if            |   17 ++++++++
 cvs.te            |    1 
 cyrus.if          |   18 ++++++++
 cyrus.te          |    1 
 dante.if          |   18 ++++++++
 dante.te          |    1 
 dbskk.if          |   18 ++++++++
 dbskk.te          |    1 
 dbus.if           |   19 +++++++++
 dcc.if            |  108 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 dcc.te            |    6 ++
 ddclient.if       |   18 ++++++++
 ddclient.te       |    1 
 dhcp.if           |   18 ++++++++
 dhcp.te           |    1 
 dictd.if          |   18 ++++++++
 dictd.te          |    1 
 distcc.if         |   18 ++++++++
 distcc.te         |    1 
 djbdns.if         |   55 +++++++++++++++++++++++++++
 dnsmasq.if        |   18 ++++++++
 dnsmasq.te        |    1 
 dovecot.if        |   18 ++++++++
 dovecot.te        |    1 
 fetchmail.if      |   18 ++++++++
 fetchmail.te      |    1 
 finger.if         |   18 ++++++++
 finger.te         |    1 
 ftp.if            |   18 ++++++++
 ftp.te            |    1 
 gatekeeper.if     |   18 ++++++++
 gatekeeper.te     |    1 
 hal.if            |   18 ++++++++
 hal.te            |    1 
 howl.if           |   18 ++++++++
 howl.te           |    1 
 i18n_input.if     |   18 ++++++++
 i18n_input.te     |    1 
 imaze.if          |   18 ++++++++
 imaze.te          |    1 
 inetd.if          |   36 +++++++++++++++++
 inetd.te          |    2 
 inn.if            |   17 ++++++++
 inn.te            |    1 
 ircd.if           |   18 ++++++++
 ircd.te           |    1 
 jabber.if         |   18 ++++++++
 jabber.te         |    1 
 kerberos.if       |   37 ++++++++++++++++++
 kerberos.te       |    2 
 ktalk.if          |   18 ++++++++
 ktalk.te          |    1 
 ldap.if           |   18 ++++++++
 ldap.te           |    1 
 lpd.if            |   54 ++++++++++++++++++++++++++
 lpd.te            |    2 
 mailman.if        |   72 +++++++++++++++++++++++++++++++++++
 monop.if          |   18 ++++++++
 monop.te          |    1 
 mta.if            |   19 +++++++++
 munin.if          |   18 ++++++++
 munin.te          |    1 
 mysql.if          |   18 ++++++++
 mysql.te          |    1 
 nagios.if         |   18 ++++++++
 nagios.te         |    1 
 nessus.if         |   18 ++++++++
 nessus.te         |    1 
 networkmanager.if |   18 ++++++++
 networkmanager.te |    1 
 nis.if            |   73 +++++++++++++++++++++++++++++++++++
 nis.te            |    4 +
 nscd.if           |   17 ++++++++
 nscd.te           |    1 
 nsd.if            |   36 +++++++++++++++++
 nsd.te            |    2 
 ntop.if           |   18 ++++++++
 ntop.te           |    1 
 ntp.if            |   18 ++++++++
 ntp.te            |    1 
 nx.if             |   18 ++++++++
 nx.te             |    1 
 oav.if            |   36 +++++++++++++++++
 oav.te            |    2 
 117 files changed, 1815 insertions(+)

---------------------------------------------------------------------------

diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/afs.if serefpolicy-2.4.6.patchbox2/policy/modules/services/afs.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/afs.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/afs.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,91 @@
 ## <summary>Andrew Filesystem server</summary>
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`afs_recv_labeledipsec_bosserver',`
+	gen_require(`
+		type afs_bosserver_t;
+	')
+	allow $1 afs_bosserver_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`afs_recv_labeledipsec_fsserver',`
+	gen_require(`
+		type afs_fsserver_t;
+	')
+	allow $1 afs_fsserver_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`afs_recv_labeledipsec_kaserver',`
+	gen_require(`
+		type afs_kaserver_t;
+	')
+	allow $1 afs_kaserver_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`afs_recv_labeledipsec_ptserver',`
+	gen_require(`
+		type afs_ptserver_t;
+	')
+	allow $1 afs_ptserver_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`afs_recv_labeledipsec_vlserver',`
+	gen_require(`
+		type afs_vlserver_t;
+	')
+	allow $1 afs_vlserver_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/afs.te serefpolicy-2.4.6.patchbox2/policy/modules/services/afs.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/afs.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/afs.te	2006-12-14 11:40:21.000000000 -0600
@@ -64,6 +64,7 @@ role system_r types afs_vlserver_t;
 allow afs_bosserver_t self:process { setsched signal_perms };
 allow afs_bosserver_t self:tcp_socket create_stream_socket_perms;
 allow afs_bosserver_t self:udp_socket create_socket_perms;
+allow afs_bosserver_t self:association { sendto recvfrom };
 
 can_exec(afs_bosserver_t,afs_bosserver_exec_t)
 
@@ -136,6 +137,7 @@ allow afs_fsserver_t self:process { sets
 allow afs_fsserver_t self:fifo_file rw_file_perms;
 allow afs_fsserver_t self:tcp_socket create_stream_socket_perms;
 allow afs_fsserver_t self:udp_socket create_socket_perms;
+allow afs_fsserver_t self:association { sendto recvfrom };
 
 allow afs_fsserver_t afs_config_t:file r_file_perms;
 allow afs_fsserver_t afs_config_t:dir r_dir_perms;
@@ -208,6 +210,7 @@ userdom_dontaudit_use_sysadm_ptys(afs_fs
 allow afs_kaserver_t self:unix_stream_socket create_stream_socket_perms;
 allow afs_kaserver_t self:tcp_socket create_stream_socket_perms;
 allow afs_kaserver_t self:udp_socket create_socket_perms;
+allow afs_kaserver_t self:association { sendto recvfrom };
 
 allow afs_kaserver_t afs_config_t:file manage_file_perms;
 allow afs_kaserver_t afs_config_t:dir rw_dir_perms;
@@ -258,6 +261,7 @@ userdom_dontaudit_use_sysadm_ptys(afs_ka
 allow afs_ptserver_t self:unix_stream_socket create_stream_socket_perms;
 allow afs_ptserver_t self:tcp_socket create_stream_socket_perms;
 allow afs_ptserver_t self:udp_socket create_socket_perms;
+allow afs_ptserver_t self:association { sendto recvfrom };
 
 allow afs_ptserver_t afs_config_t:file r_file_perms;
 allow afs_ptserver_t afs_config_t:dir r_dir_perms;
@@ -300,6 +304,7 @@ userdom_dontaudit_use_sysadm_ptys(afs_pt
 allow afs_vlserver_t self:unix_stream_socket create_stream_socket_perms;
 allow afs_vlserver_t self:tcp_socket create_stream_socket_perms;
 allow afs_vlserver_t self:udp_socket create_socket_perms;
+allow afs_vlserver_t self:association { sendto recvfrom };
 
 allow afs_vlserver_t afs_config_t:file r_file_perms;
 allow afs_vlserver_t afs_config_t:dir r_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/amavis.if serefpolicy-2.4.6.patchbox2/policy/modules/services/amavis.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/amavis.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/amavis.if	2006-12-14 11:40:21.000000000 -0600
@@ -174,3 +174,21 @@ interface(`amavis_setattr_pid_files',`
 	allow $1 amavis_var_run_t:file setattr;
 	files_search_pids($1)
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`amavis_recv_labeledipsec',`
+	gen_require(`
+		type amavis_t;
+	')
+	allow $1 amavis_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/amavis.te serefpolicy-2.4.6.patchbox2/policy/modules/services/amavis.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/amavis.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/amavis.te	2006-12-14 11:40:21.000000000 -0600
@@ -50,6 +50,7 @@ allow amavis_t self:fifo_file rw_file_pe
 allow amavis_t self:unix_stream_socket create_stream_socket_perms;
 allow amavis_t self:unix_dgram_socket create_socket_perms;
 allow amavis_t self:tcp_socket { listen accept };
+allow amavis_t self:association { sendto recvfrom };
 
 # configuration files
 allow amavis_t amavis_etc_t:dir r_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/apache.if serefpolicy-2.4.6.patchbox2/policy/modules/services/apache.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/apache.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/apache.if	2006-12-14 11:40:21.000000000 -0600
@@ -191,6 +191,7 @@ template(`apache_content_template',`
 	tunable_policy(`httpd_enable_cgi && httpd_can_network_connect_db',`
 		allow httpd_$1_script_t self:tcp_socket create_stream_socket_perms;
 		allow httpd_$1_script_t self:udp_socket create_socket_perms;
+		allow httpd_$1_script_t self:association { sendto recvfrom };
 
 		corenet_non_ipsec_sendrecv(httpd_$1_script_t)
 		corenet_tcp_sendrecv_all_if(httpd_$1_script_t)
@@ -210,6 +211,7 @@ template(`apache_content_template',`
 	tunable_policy(`httpd_enable_cgi && httpd_can_network_connect',`
 		allow httpd_$1_script_t self:tcp_socket create_stream_socket_perms;
 		allow httpd_$1_script_t self:udp_socket create_socket_perms;
+		allow httpd_$1_script_t self:association { sendto recvfrom };
 
 		corenet_non_ipsec_sendrecv(httpd_$1_script_t)
 		corenet_tcp_sendrecv_all_if(httpd_$1_script_t)
@@ -1031,3 +1033,57 @@ interface(`apache_search_sys_script_stat
 
 	allow $1 httpd_sys_script_t:dir search;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`apache_recv_labeledipsec',`
+	gen_require(`
+		type httpd_t;
+	')
+	allow $1 httpd_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`apache_recv_labeledipsec_script_sys',`
+	gen_require(`
+		type httpd_sys_script_t;
+	')
+	allow $1 httpd_sys_script_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`apache_recv_labeledipsec_script_role',`
+	gen_require(`
+		type httpd_$1_script_t;
+	')
+	allow $2 httpd_$1_script_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/apache.te serefpolicy-2.4.6.patchbox2/policy/modules/services/apache.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/apache.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/apache.te	2006-12-14 11:40:21.000000000 -0600
@@ -143,6 +143,7 @@ allow httpd_t self:unix_dgram_socket { c
 allow httpd_t self:unix_stream_socket { create_stream_socket_perms connectto };
 allow httpd_t self:tcp_socket create_stream_socket_perms;
 allow httpd_t self:udp_socket create_socket_perms;
+allow httpd_t self:association { sendto recvfrom };
 # Signal self for shutdown
 corenet_tcp_connect_http_port(httpd_t)
 
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/arpwatch.if serefpolicy-2.4.6.patchbox2/policy/modules/services/arpwatch.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/arpwatch.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/arpwatch.if	2006-12-14 11:40:21.000000000 -0600
@@ -91,3 +91,21 @@ interface(`arpwatch_dontaudit_rw_packet_
 
 	dontaudit $1 arpwatch_t:packet_socket { read write };
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`arpwatch_recv_labeledipsec',`
+	gen_require(`
+		type arpwatch_t;
+	')
+	allow $1 arpwatch_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/arpwatch.te serefpolicy-2.4.6.patchbox2/policy/modules/services/arpwatch.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/arpwatch.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/arpwatch.te	2006-12-14 11:40:21.000000000 -0600
@@ -32,6 +32,7 @@ allow arpwatch_t self:netlink_route_sock
 allow arpwatch_t self:tcp_socket { connect create_stream_socket_perms };
 allow arpwatch_t self:udp_socket create_socket_perms;
 allow arpwatch_t self:packet_socket create_socket_perms;
+allow arpwatch_t self:association { sendto recvfrom };
 
 allow arpwatch_t arpwatch_data_t:dir create_dir_perms;
 allow arpwatch_t arpwatch_data_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/asterisk.if serefpolicy-2.4.6.patchbox2/policy/modules/services/asterisk.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/asterisk.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/asterisk.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Asterisk IP telephony server</summary>
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`asterisk_recv_labeledipsec',`
+	gen_require(`
+		type asterisk_t;
+	')
+	allow $1 asterisk_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/asterisk.te serefpolicy-2.4.6.patchbox2/policy/modules/services/asterisk.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/asterisk.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/asterisk.te	2006-12-14 11:40:21.000000000 -0600
@@ -45,6 +45,7 @@ allow asterisk_t self:sem create_sem_per
 allow asterisk_t self:shm create_shm_perms;
 allow asterisk_t self:tcp_socket create_stream_socket_perms;
 allow asterisk_t self:udp_socket create_socket_perms;
+allow asterisk_t self:association { sendto recvfrom };
 
 allow asterisk_t asterisk_etc_t:file r_file_perms;
 allow asterisk_t asterisk_etc_t:dir r_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/automount.if serefpolicy-2.4.6.patchbox2/policy/modules/services/automount.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/automount.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/automount.if	2006-12-14 11:40:21.000000000 -0600
@@ -81,3 +81,21 @@ interface(`automount_dontaudit_getattr_t
 
 	dontaudit $1 automount_tmp_t:dir getattr;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`autotmount_recv_labeledipsec',`
+	gen_require(`
+		type automount_t;
+	')
+	allow $1 automoun_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/automount.te serefpolicy-2.4.6.patchbox2/policy/modules/services/automount.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/automount.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/automount.te	2006-12-14 11:40:21.000000000 -0600
@@ -37,6 +37,7 @@ allow automount_t self:unix_dgram_socket
 allow automount_t self:tcp_socket create_stream_socket_perms;
 allow automount_t self:udp_socket create_socket_perms;
 allow automount_t self:rawip_socket create_socket_perms;
+allow automount_t self:association { sendto recvfrom };
 
 allow automount_t self:netlink_route_socket r_netlink_socket_perms;
 
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/avahi.if serefpolicy-2.4.6.patchbox2/policy/modules/services/avahi.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/avahi.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/avahi.if	2006-12-14 11:40:21.000000000 -0600
@@ -41,3 +41,21 @@ interface(`avahi_stream_connect',`
 	allow $1 avahi_var_run_t:sock_file rw_file_perms;
 	allow $1 avahi_t:unix_stream_socket connectto;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`avahi_recv_labeledipsec',`
+	gen_require(`
+		type avahi_t;
+	')
+	allow $1 avahi_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/avahi.te serefpolicy-2.4.6.patchbox2/policy/modules/services/avahi.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/avahi.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/avahi.te	2006-12-14 11:40:21.000000000 -0600
@@ -27,6 +27,7 @@ allow avahi_t self:unix_dgram_socket cre
 allow avahi_t self:netlink_route_socket r_netlink_socket_perms;
 allow avahi_t self:tcp_socket create_stream_socket_perms;
 allow avahi_t self:udp_socket create_socket_perms;
+allow avahi_t self:association { sendto recvfrom };
 
 allow avahi_t avahi_var_run_t:sock_file create_file_perms;
 allow avahi_t avahi_var_run_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/bind.if serefpolicy-2.4.6.patchbox2/policy/modules/services/bind.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/bind.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/bind.if	2006-12-14 11:40:21.000000000 -0600
@@ -268,3 +268,39 @@ interface(`bind_read_zone',`
 interface(`bind_udp_chat_named',`
 	refpolicywarn(`$0($*) has been deprecated.')
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`bind_recv_labeledipsec_named',`
+	gen_require(`
+		type named_t;
+	')
+	allow $1 named_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`bind_recv_labeledipsec_ndc',`
+	gen_require(`
+		type ndc_t;
+	')
+	allow $1 ndc_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/bind.te serefpolicy-2.4.6.patchbox2/policy/modules/services/bind.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/bind.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/bind.te	2006-12-14 11:40:21.000000000 -0600
@@ -59,6 +59,7 @@ allow named_t self:unix_dgram_socket cre
 allow named_t self:tcp_socket create_stream_socket_perms;
 allow named_t self:udp_socket create_socket_perms;
 allow named_t self:netlink_route_socket r_netlink_socket_perms;
+allow named_t self:association { sendto recvfrom };
 
 allow named_t dnssec_t:file { getattr read };
 
@@ -216,6 +217,7 @@ allow ndc_t self:fifo_file { read write 
 allow ndc_t self:unix_stream_socket { connect create_stream_socket_perms };
 allow ndc_t self:tcp_socket create_socket_perms;
 allow ndc_t self:netlink_route_socket r_netlink_socket_perms;
+allow ndc_t self:association { sendto recvfrom };
 
 allow ndc_t dnssec_t:file { getattr read };
 allow ndc_t dnssec_t:lnk_file { getattr read };
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/bluetooth.if serefpolicy-2.4.6.patchbox2/policy/modules/services/bluetooth.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/bluetooth.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/bluetooth.if	2006-12-14 11:40:21.000000000 -0600
@@ -133,3 +133,21 @@ interface(`bluetooth_dontaudit_read_help
 	dontaudit $1 bluetooth_helper_t:dir search;
 	dontaudit $1 bluetooth_helper_t:file { read getattr };
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`bluetooth_recv_labeledipsec',`
+	gen_require(`
+		type bluetooth_t;
+	')
+	allow $1 bluetooth_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/bluetooth.te serefpolicy-2.4.6.patchbox2/policy/modules/services/bluetooth.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/bluetooth.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/bluetooth.te	2006-12-14 11:40:21.000000000 -0600
@@ -51,6 +51,7 @@ allow bluetooth_t self:unix_dgram_socket
 allow bluetooth_t self:unix_stream_socket create_stream_socket_perms;
 allow bluetooth_t self:tcp_socket create_stream_socket_perms;
 allow bluetooth_t self:udp_socket create_socket_perms;
+allow bluetooth_t self:association { sendto recvfrom };
 
 allow bluetooth_t bluetooth_conf_t:dir rw_dir_perms;
 allow bluetooth_t bluetooth_conf_t:file { getattr read ioctl };
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/canna.if serefpolicy-2.4.6.patchbox2/policy/modules/services/canna.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/canna.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/canna.if	2006-12-14 11:40:21.000000000 -0600
@@ -20,3 +20,21 @@ interface(`canna_stream_connect',`
 	allow $1 canna_var_run_t:sock_file write;
 	allow $1 canna_t:unix_stream_socket connectto;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`canna_recv_labeledipsec',`
+	gen_require(`
+		type canna_t;
+	')
+	allow $1 canna_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/canna.te serefpolicy-2.4.6.patchbox2/policy/modules/services/canna.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/canna.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/canna.te	2006-12-14 11:40:21.000000000 -0600
@@ -30,6 +30,7 @@ allow canna_t self:process signal_perms;
 allow canna_t self:unix_stream_socket { connectto create_stream_socket_perms};
 allow canna_t self:unix_dgram_socket create_stream_socket_perms;
 allow canna_t self:tcp_socket create_stream_socket_perms;
+allow canna_t self:association { sendto recvfrom };
 
 allow canna_t canna_log_t:file create_file_perms;
 allow canna_t canna_log_t:dir { rw_dir_perms setattr };
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ccs.if serefpolicy-2.4.6.patchbox2/policy/modules/services/ccs.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ccs.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ccs.if	2006-12-14 11:40:21.000000000 -0600
@@ -79,3 +79,21 @@ interface(`ccs_manage_config',`
 	allow $1 cluster_conf_t:dir manage_dir_perms;
 	allow $1 cluster_conf_t:file manage_file_perms;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`ccs_recv_labeledipsec',`
+	gen_require(`
+		type ccs_t;
+	')
+	allow $1 ccs_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ccs.te serefpolicy-2.4.6.patchbox2/policy/modules/services/ccs.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ccs.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ccs.te	2006-12-14 11:40:21.000000000 -0600
@@ -37,6 +37,7 @@ allow ccs_t self:tcp_socket create_strea
 allow ccs_t self:udp_socket { create_socket_perms listen recv_msg send_msg };
 # cjp: this needs to be fixed to be specific
 allow ccs_t self:socket create_socket_perms;
+allow ccs_t self:association { sendto recvfrom };
 
 allow ccs_t cluster_conf_t:dir rw_dir_perms;
 allow ccs_t cluster_conf_t:file manage_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/cipe.if serefpolicy-2.4.6.patchbox2/policy/modules/services/cipe.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/cipe.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/cipe.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Encrypted tunnel daemon</summary>
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`cipe_recv_labeledipsec',`
+	gen_require(`
+		type ciped_t;
+	')
+	allow $1 ciped_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/cipe.te serefpolicy-2.4.6.patchbox2/policy/modules/services/cipe.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/cipe.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/cipe.te	2006-12-14 11:40:21.000000000 -0600
@@ -22,6 +22,7 @@ allow ciped_t self:fifo_file rw_file_per
 allow ciped_t self:unix_dgram_socket create_socket_perms;
 allow ciped_t self:unix_stream_socket create_socket_perms;
 allow ciped_t self:udp_socket create_socket_perms;
+allow ciped_t self:association { sendto recvfrom };
 
 kernel_read_kernel_sysctls(ciped_t)
 kernel_read_system_state(ciped_t)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/clamav.if serefpolicy-2.4.6.patchbox2/policy/modules/services/clamav.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/clamav.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/clamav.if	2006-12-14 11:40:21.000000000 -0600
@@ -102,3 +102,39 @@ interface(`clamav_domtrans_clamscan',`
 	allow clamscan_t $1:fifo_file rw_file_perms;
 	allow clamscan_t $1:process sigchld;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`clamav_recv_labeledipsec',`
+	gen_require(`
+		type clamd_t;
+	')
+	allow $1 clamd_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`clamav_recv_labeledipsec_freshclam',`
+	gen_require(`
+		type freshclam_t;
+	')
+	allow $1 freshclam_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/clamav.te serefpolicy-2.4.6.patchbox2/policy/modules/services/clamav.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/clamav.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/clamav.te	2006-12-14 11:40:21.000000000 -0600
@@ -58,6 +58,7 @@ allow clamd_t self:fifo_file rw_file_per
 allow clamd_t self:unix_stream_socket create_stream_socket_perms;
 allow clamd_t self:unix_dgram_socket create_socket_perms;
 allow clamd_t self:tcp_socket { listen accept };
+allow clamd_t self:association { sendto recvfrom };
 
 # configuration files
 allow clamd_t clamd_etc_t:dir r_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/clockspeed.if serefpolicy-2.4.6.patchbox2/policy/modules/services/clockspeed.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/clockspeed.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/clockspeed.if	2006-12-14 11:40:21.000000000 -0600
@@ -52,3 +52,39 @@ template(`clockspeed_run_cli',`
 	allow clockspeed_cli_t $3:chr_file { getattr read write ioctl };
 
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`clockspeed_recv_labeledipsec_cli',`
+	gen_require(`
+		type clockpeed_cli_t;
+	')
+	allow $1 clockspeed_cli_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`clockspeed_recv_labeledipsec_srv',`
+	gen_require(`
+		type clockspeed_srv_t;
+	')
+	allow $1 clockspeed_srv_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/clockspeed.te serefpolicy-2.4.6.patchbox2/policy/modules/services/clockspeed.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/clockspeed.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/clockspeed.te	2006-12-14 11:40:21.000000000 -0600
@@ -25,6 +25,7 @@ files_type(clockspeed_var_lib_t)
 
 allow clockspeed_cli_t self:capability sys_time;
 allow clockspeed_cli_t self:udp_socket create_socket_perms;
+allow clockspeed_cli_t self:association { sendto recvfrom };
 allow clockspeed_cli_t clockspeed_var_lib_t:dir search;
 allow clockspeed_cli_t clockspeed_var_lib_t:file { getattr read };
 
@@ -51,6 +52,7 @@ allow clockspeed_srv_t self:capability {
 allow clockspeed_srv_t self:udp_socket create_socket_perms;
 allow clockspeed_srv_t self:unix_dgram_socket create_socket_perms;
 allow clockspeed_srv_t self:unix_stream_socket create_socket_perms;
+allow clockspeed_srv_t self:association { sendto recvfrom };
 
 allow clockspeed_srv_t clockspeed_var_lib_t:dir rw_dir_perms;
 allow clockspeed_srv_t clockspeed_var_lib_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/comsat.if serefpolicy-2.4.6.patchbox2/policy/modules/services/comsat.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/comsat.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/comsat.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Comsat, a biff server.</summary>
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`comsat_recv_labeledipsec',`
+	gen_require(`
+		type comsat_t;
+	')
+	allow $1 comsat_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/comsat.te serefpolicy-2.4.6.patchbox2/policy/modules/services/comsat.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/comsat.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/comsat.te	2006-12-14 11:40:21.000000000 -0600
@@ -30,6 +30,7 @@ allow comsat_t self:{ lnk_file file } { 
 allow comsat_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
 allow comsat_t self:tcp_socket connected_stream_socket_perms;
 allow comsat_t self:udp_socket create_socket_perms;
+allow comsat_t self:association { sendto recvfrom };
 
 allow comsat_t comsat_tmp_t:dir create_dir_perms;
 allow comsat_t comsat_tmp_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/courier.if serefpolicy-2.4.6.patchbox2/policy/modules/services/courier.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/courier.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/courier.if	2006-12-14 11:40:21.000000000 -0600
@@ -32,6 +32,7 @@ template(`courier_domain_template',`
 	allow courier_$1_t self:fifo_file { read write getattr };
 	allow courier_$1_t self:tcp_socket create_stream_socket_perms;
 	allow courier_$1_t self:udp_socket create_socket_perms;
+	allow courier_$1_t self:association { sendto recvfrom };
 
 	can_exec(courier_$1_t, courier_$1_exec_t)
 
@@ -140,3 +141,112 @@ interface(`courier_domtrans_pop',`
 	allow courier_pop_t $1:fifo_file rw_file_perms;
 	allow courier_pop_t $1:process sigchld;
 ')
+
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`courier_recv_labeledipsec_auth',`
+	gen_require(`
+		type courier_authdaemon_t;
+	')
+	allow $1 courier_authdaemon_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`courier_recv_labeledipsec_pcp',`
+	gen_require(`
+		type courier_pcp_t;
+	')
+	allow $1 courier_pcp_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`courier_recv_labeledipsec_pop',`
+	gen_require(`
+		type courier_pop_t;
+	')
+	allow $1 courier_pop_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`courier_recv_labeledipsec_tcpd',`
+	gen_require(`
+		type courier_tcpd_t;
+	')
+	allow $1 courier_tcpd_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`courier_recv_labeledipsec_sqwebmail',`
+	gen_require(`
+		type courier_sqwebmail_t;
+	')
+	allow $1 courier_sqwebmail_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`courier_recv_labeledipsec_tmpl',`
+	gen_require(`
+		type courier_$1_t;
+	')
+	allow $2 courier_$1_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/cups.if serefpolicy-2.4.6.patchbox2/policy/modules/services/cups.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/cups.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/cups.if	2006-12-14 11:40:21.000000000 -0600
@@ -263,3 +263,59 @@ interface(`cups_stream_connect_ptal',`
 	allow $1 ptal_var_run_t:sock_file write;
 	allow $1 ptal_t:unix_stream_socket connectto;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`cups_recv_labeledipsec',`
+	gen_require(`
+		type cupsd_t;
+	')
+	allow $1 cupsd_t:association recvfrom;
+	allow $1 cupsd_config_t:association recvfrom;
+	allow $1 cupsd_lpd_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`cups_recv_labeledipsec_ptal',`
+	gen_require(`
+		type ptal_t;
+	')
+	allow $1 ptal_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`cups_recv_labeledipsec_hplip',`
+	gen_require(`
+		type hplip_t;
+	')
+	allow $1 hplip_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/cups.te serefpolicy-2.4.6.patchbox2/policy/modules/services/cups.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/cups.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/cups.te	2006-12-14 11:40:21.000000000 -0600
@@ -94,6 +94,7 @@ allow cupsd_t self:udp_socket create_soc
 allow cupsd_t self:appletalk_socket create_socket_perms;
 # generic socket here until appletalk socket is available in kernels
 allow cupsd_t self:socket create_socket_perms;
+allow cupsd_t self:association { sendto recvfrom };
 
 allow cupsd_t cupsd_etc_t:file { r_file_perms setattr };
 allow cupsd_t cupsd_etc_t:dir { rw_dir_perms setattr };
@@ -321,6 +322,7 @@ allow cupsd_config_t self:unix_stream_so
 allow cupsd_config_t self:unix_dgram_socket create_socket_perms;
 allow cupsd_config_t self:tcp_socket create_stream_socket_perms;
 allow cupsd_config_t self:netlink_route_socket r_netlink_socket_perms;
+allow cupsd_config_t self:association { sendto recvfrom };
 
 # old can_ps() on cupsd_t:
 allow cupsd_config_t cupsd_t:process { signal };
@@ -481,6 +483,7 @@ allow cupsd_lpd_t self:fifo_file rw_file
 allow cupsd_lpd_t self:tcp_socket connected_stream_socket_perms;
 allow cupsd_lpd_t self:udp_socket create_socket_perms;
 allow cupsd_lpd_t self:netlink_route_socket r_netlink_socket_perms;
+allow cupsd_lpd_t self:association { sendto recvfrom };
 
 # for identd
 # cjp: this should probably only be inetd_child rules?
@@ -569,6 +572,7 @@ allow hplip_t self:netlink_route_socket 
 allow hplip_t self:tcp_socket create_stream_socket_perms;
 allow hplip_t self:udp_socket create_socket_perms;
 allow hplip_t self:rawip_socket create_socket_perms;
+allow hplip_t self:association { sendto recvfrom };
 
 allow hplip_t cupsd_etc_t:dir search;
 
@@ -672,6 +676,7 @@ allow ptal_t self:fifo_file rw_file_perm
 allow ptal_t self:unix_dgram_socket create_socket_perms;
 allow ptal_t self:unix_stream_socket create_stream_socket_perms;
 allow ptal_t self:tcp_socket create_stream_socket_perms;
+allow ptal_t self:association { sendto recvfrom };
 
 allow ptal_t ptal_etc_t:file r_file_perms;
 allow ptal_t ptal_etc_t:dir r_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/cvs.if serefpolicy-2.4.6.patchbox2/policy/modules/services/cvs.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/cvs.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/cvs.if	2006-12-14 11:40:21.000000000 -0600
@@ -37,3 +37,20 @@ interface(`cvs_exec',`
 	can_exec($1,cvs_exec_t)
 ')
 
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`cvs_recv_labeledipsec',`
+	gen_require(`
+		type cvs_t;
+	')
+	allow $1 cvs_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/cvs.te serefpolicy-2.4.6.patchbox2/policy/modules/services/cvs.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/cvs.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/cvs.te	2006-12-14 11:40:21.000000000 -0600
@@ -32,6 +32,7 @@ allow cvs_t self:tcp_socket connected_st
 # for identd; cjp: this should probably only be inetd_child rules?
 allow cvs_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
 allow cvs_t self:capability { setuid setgid };
+allow cvs_t self:association { sendto recvfrom };
 
 allow cvs_t cvs_data_t:dir create_dir_perms;
 allow cvs_t cvs_data_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/cyrus.if serefpolicy-2.4.6.patchbox2/policy/modules/services/cyrus.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/cyrus.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/cyrus.if	2006-12-14 11:40:21.000000000 -0600
@@ -42,3 +42,21 @@ interface(`cyrus_stream_connect',`
 	allow $1 cyrus_var_lib_t:sock_file write;
 	allow $1 cyrus_t:unix_stream_socket connectto;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`cyrus_recv_labeledipsec',`
+	gen_require(`
+		type cyrus_t;
+	')
+	allow $1 cyrus_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/cyrus.te serefpolicy-2.4.6.patchbox2/policy/modules/services/cyrus.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/cyrus.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/cyrus.te	2006-12-14 11:40:21.000000000 -0600
@@ -42,6 +42,7 @@ allow cyrus_t self:unix_stream_socket co
 allow cyrus_t self:tcp_socket create_stream_socket_perms;
 allow cyrus_t self:udp_socket create_socket_perms;
 allow cyrus_t self:netlink_route_socket r_netlink_socket_perms;
+allow cyrus_t self:association { sendto recvfrom };
 
 allow cyrus_t cyrus_tmp_t:dir create_dir_perms;
 allow cyrus_t cyrus_tmp_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/dante.if serefpolicy-2.4.6.patchbox2/policy/modules/services/dante.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/dante.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/dante.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Dante msproxy and socks4/5 proxy server</summary>
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dante_recv_labeledipsec',`
+	gen_require(`
+		type dante_t;
+	')
+	allow $1 dante_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/dante.te serefpolicy-2.4.6.patchbox2/policy/modules/services/dante.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/dante.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/dante.te	2006-12-14 11:40:21.000000000 -0600
@@ -27,6 +27,7 @@ allow dante_t self:process signal_perms;
 allow dante_t self:fifo_file { read write };
 allow dante_t self:tcp_socket create_stream_socket_perms;
 allow dante_t self:udp_socket create_socket_perms;
+allow dante_t self:association { sendto recvfrom };
 
 allow dante_t dante_conf_t:dir r_dir_perms;
 allow dante_t dante_conf_t:file r_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/dbskk.if serefpolicy-2.4.6.patchbox2/policy/modules/services/dbskk.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/dbskk.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/dbskk.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Dictionary server for the SKK Japanese input method system.</summary>
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dbskk_recv_labeledipsec',`
+	gen_require(`
+		type dbskkd_t;
+	')
+	allow $1 dbskkd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/dbskk.te serefpolicy-2.4.6.patchbox2/policy/modules/services/dbskk.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/dbskk.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/dbskk.te	2006-12-14 11:40:21.000000000 -0600
@@ -26,6 +26,7 @@ allow dbskkd_t self:process signal_perms
 allow dbskkd_t self:fifo_file rw_file_perms;
 allow dbskkd_t self:tcp_socket connected_stream_socket_perms;
 allow dbskkd_t self:udp_socket create_socket_perms;
+allow dbskkd_t self:association { sendto recvfrom };
 
 # for identd
 # cjp: this should probably only be inetd_child rules?
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/dbus.if serefpolicy-2.4.6.patchbox2/policy/modules/services/dbus.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/dbus.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/dbus.if	2006-12-14 11:40:21.000000000 -0600
@@ -78,6 +78,7 @@ template(`dbus_per_role_template',`
 	allow $1_dbusd_t self:tcp_socket create_stream_socket_perms;
 	allow $1_dbusd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 	allow $1_dbusd_t self:netlink_selinux_socket create_socket_perms;
+	allow $1_dbusd_t self:association { sendto recvfrom };
 
 	# For connecting to the bus
 	allow $2 $1_dbusd_t:unix_stream_socket connectto;
@@ -353,3 +354,21 @@ interface(`dbus_system_bus_unconfined',`
 
 	allow $1 system_dbusd_t:dbus *;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dbus_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_dbusd_t;
+	')
+	allow $2 $1_dbusd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/dcc.if serefpolicy-2.4.6.patchbox2/policy/modules/services/dcc.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/dcc.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/dcc.if	2006-12-14 11:40:21.000000000 -0600
@@ -182,3 +182,111 @@ interface(`dcc_stream_connect_dccifd',`
 	allow $1 dccifd_var_run_t:sock_file { getattr write };
 	allow $1 dccifd_t:unix_stream_socket connectto;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dcc_recv_labeledipsec_cdcc',`
+	gen_require(`
+		type cdcc_t;
+	')
+	allow $1 cdcc_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dcc_recv_labeledipsec_client',`
+	gen_require(`
+		type dcc_client_t;
+	')
+	allow $1 dcc_client_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dcc_recv_labeledipsec_dbclean',`
+	gen_require(`
+		type dcc_dbclean_t;
+	')
+	allow $1 dcc_dbclean_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dcc_recv_labeledipsec_dccd',`
+	gen_require(`
+		type dccd_t;
+	')
+	allow $1 dccd_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dcc_recv_labeledipsec_dccifd',`
+	gen_require(`
+		type dccifd_t;
+	')
+	allow $1 dccifd_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dcc_recv_labeledipsec_dccm',`
+	gen_require(`
+		type dccm_t;
+	')
+	allow $1 dccm_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/dcc.te serefpolicy-2.4.6.patchbox2/policy/modules/services/dcc.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/dcc.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/dcc.te	2006-12-14 11:40:21.000000000 -0600
@@ -87,6 +87,7 @@ files_pid_file(dccm_var_run_t)
 allow cdcc_t self:capability setuid;
 allow cdcc_t self:unix_dgram_socket create_socket_perms;
 allow cdcc_t self:udp_socket create_socket_perms;
+allow cdcc_t self:association { sendto recvfrom };
 
 allow cdcc_t cdcc_tmp_t:dir manage_dir_perms;
 allow cdcc_t cdcc_tmp_t:file create_file_perms;
@@ -129,6 +130,7 @@ optional_policy(`
 allow dcc_client_t self:capability setuid;
 allow dcc_client_t self:unix_dgram_socket create_socket_perms;
 allow dcc_client_t self:udp_socket create_socket_perms;
+allow dcc_client_t self:association { sendto recvfrom };
 
 allow dcc_client_t dcc_client_map_t:file rw_file_perms;
 
@@ -170,6 +172,7 @@ optional_policy(`
 
 allow dcc_dbclean_t self:unix_dgram_socket create_socket_perms;
 allow dcc_dbclean_t self:udp_socket create_socket_perms;
+allow dcc_dbclean_t self:association { sendto recvfrom };
 
 allow dcc_dbclean_t dcc_client_map_t:file rw_file_perms;
 
@@ -216,6 +219,7 @@ allow dccd_t self:process signal_perms;
 allow dccd_t self:unix_stream_socket create_socket_perms;
 allow dccd_t self:netlink_route_socket { bind create getattr nlmsg_read read write };
 allow dccd_t self:udp_socket create_socket_perms;
+allow dccd_t self:association { sendto recvfrom };
 
 allow dccd_t dcc_client_map_t:file rw_file_perms;
 
@@ -311,6 +315,7 @@ allow dccifd_t self:process signal_perms
 allow dccifd_t self:unix_stream_socket create_stream_socket_perms;
 allow dccifd_t self:unix_dgram_socket create_socket_perms;
 allow dccifd_t self:udp_socket create_socket_perms;
+allow dccifd_t self:association { sendto recvfrom };
 
 allow dccifd_t dcc_client_map_t:file rw_file_perms;
 
@@ -396,6 +401,7 @@ allow dccm_t self:process signal_perms;
 allow dccm_t self:unix_stream_socket create_stream_socket_perms;
 allow dccm_t self:unix_dgram_socket create_socket_perms;
 allow dccm_t self:udp_socket create_socket_perms;
+allow dccm_t self:association { sendto recvfrom };
 
 allow dccm_t dcc_client_map_t:file rw_file_perms;
 
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ddclient.if serefpolicy-2.4.6.patchbox2/policy/modules/services/ddclient.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ddclient.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ddclient.if	2006-12-14 11:40:21.000000000 -0600
@@ -23,3 +23,21 @@ interface(`ddclient_domtrans',`
 	allow ddclient_t $1:fifo_file rw_file_perms;
 	allow ddclient_t $1:process sigchld;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`ddclient_recv_labeledipsec',`
+	gen_require(`
+		type ddclient_t;
+	')
+	allow $1 ddclient_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ddclient.te serefpolicy-2.4.6.patchbox2/policy/modules/services/ddclient.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ddclient.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ddclient.te	2006-12-14 11:40:21.000000000 -0600
@@ -35,6 +35,7 @@ allow ddclient_t self:process signal_per
 allow ddclient_t self:fifo_file rw_file_perms;
 allow ddclient_t self:tcp_socket create_socket_perms;
 allow ddclient_t self:udp_socket create_socket_perms;
+allow ddclient_t self:association { sendto recvfrom };
 
 allow ddclient_t ddclient_etc_t:file r_file_perms;
 
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/dhcp.if serefpolicy-2.4.6.patchbox2/policy/modules/services/dhcp.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/dhcp.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/dhcp.if	2006-12-14 11:40:21.000000000 -0600
@@ -19,3 +19,21 @@ interface(`dhcpd_setattr_state_files',`
 	sysnet_search_dhcp_state($1)
 	allow $1 dhcpd_state_t:file setattr;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dhcpd_recv_labeledipsec',`
+	gen_require(`
+		type dhcpd_t;
+	')
+	allow $1 dhcpd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/dhcp.te serefpolicy-2.4.6.patchbox2/policy/modules/services/dhcp.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/dhcp.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/dhcp.te	2006-12-14 11:40:21.000000000 -0600
@@ -36,6 +36,7 @@ allow dhcpd_t self:udp_socket create_soc
 # Allow dhcpd_t to use packet sockets
 allow dhcpd_t self:packet_socket create_socket_perms;
 allow dhcpd_t self:rawip_socket create_socket_perms;
+allow dhcpd_t self:association { sendto recvfrom };
 
 can_exec(dhcpd_t,dhcpd_exec_t)
 
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/dictd.if serefpolicy-2.4.6.patchbox2/policy/modules/services/dictd.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/dictd.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/dictd.if	2006-12-14 11:40:21.000000000 -0600
@@ -14,3 +14,21 @@
 interface(`dictd_tcp_connect',`
 	refpolicywarn(`$0($*) has been deprecated.')
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dictd_recv_labeledipsec',`
+	gen_require(`
+		type dictd_t;
+	')
+	allow $1 dictd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/dictd.te serefpolicy-2.4.6.patchbox2/policy/modules/services/dictd.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/dictd.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/dictd.te	2006-12-14 11:40:21.000000000 -0600
@@ -27,6 +27,7 @@ allow dictd_t self:process { signal_perm
 allow dictd_t self:unix_stream_socket create_stream_socket_perms;
 allow dictd_t self:tcp_socket create_stream_socket_perms;
 allow dictd_t self:udp_socket create_socket_perms;
+allow dictd_t self:association { sendto recvfrom };
 
 allow dictd_t dictd_etc_t:file r_file_perms;
 files_search_etc(dictd_t)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/distcc.if serefpolicy-2.4.6.patchbox2/policy/modules/services/distcc.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/distcc.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/distcc.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Distributed compiler daemon</summary>
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`distcc_recv_labeledipsec',`
+	gen_require(`
+		type distccd_t;
+	')
+	allow $1 distccd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/distcc.te serefpolicy-2.4.6.patchbox2/policy/modules/services/distcc.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/distcc.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/distcc.te	2006-12-14 11:40:21.000000000 -0600
@@ -30,6 +30,7 @@ allow distccd_t self:process { signal_pe
 allow distccd_t self:fifo_file { read write getattr };
 allow distccd_t self:tcp_socket create_stream_socket_perms;
 allow distccd_t self:udp_socket create_socket_perms;
+allow distccd_t self:association { sendto recvfrom };
 
 allow distccd_t distccd_log_t:file create_file_perms;
 logging_log_filetrans(distccd_t,distccd_log_t,file)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/djbdns.if serefpolicy-2.4.6.patchbox2/policy/modules/services/djbdns.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/djbdns.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/djbdns.if	2006-12-14 11:40:21.000000000 -0600
@@ -28,6 +28,7 @@ template(`djbdns_daemontools_domain_temp
 	allow djbdns_$1_t self:capability { net_bind_service setgid setuid sys_chroot };
 	allow djbdns_$1_t self:tcp_socket create_stream_socket_perms;
 	allow djbdns_$1_t self:udp_socket create_socket_perms;
+	allow djbdns_$1_t self:association { sendto recvfrom };
 
 	allow djbdns_$1_t djbdns_$1_conf_t:dir r_dir_perms;
 	allow djbdns_$1_t djbdns_$1_conf_t:file r_file_perms;
@@ -52,3 +53,57 @@ template(`djbdns_daemontools_domain_temp
 	libs_use_ld_so(djbdns_$1_t)
 	libs_use_shared_libs(djbdns_$1_t)
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`djbdns_recv_labeledipsec_dnscache',`
+	gen_require(`
+		type djbdns_dnscache_t;
+	')
+	allow $1 djbdns_dnscache_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`djbdns_recv_labeledipsec_tinydns',`
+	gen_require(`
+		type djbdns_tinydns_t;
+	')
+	allow $1 djbdns_tinydns_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`djbdns_recv_labeledipsec_domain',`
+	gen_require(`
+		type djbdns_$1_t;
+	')
+	allow $2 djbdns_$1_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/dnsmasq.if serefpolicy-2.4.6.patchbox2/policy/modules/services/dnsmasq.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/dnsmasq.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/dnsmasq.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>dnsmasq DNS forwarder and DHCP server</summary>
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dnsmasq_recv_labeledipsec',`
+	gen_require(`
+		type dnsmasq_t;
+	')
+	allow $1 dnsmasq_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/dnsmasq.te serefpolicy-2.4.6.patchbox2/policy/modules/services/dnsmasq.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/dnsmasq.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/dnsmasq.te	2006-12-14 11:40:21.000000000 -0600
@@ -30,6 +30,7 @@ allow dnsmasq_t self:tcp_socket create_s
 allow dnsmasq_t self:udp_socket create_socket_perms;
 allow dnsmasq_t self:packet_socket create_socket_perms;
 allow dnsmasq_t self:rawip_socket create_socket_perms;
+allow dnsmasq_t self:association { sendto recvfrom };
 
 # dhcp leases
 allow dnsmasq_t dnsmasq_lease_t:file manage_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/dovecot.if serefpolicy-2.4.6.patchbox2/policy/modules/services/dovecot.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/dovecot.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/dovecot.if	2006-12-14 11:40:21.000000000 -0600
@@ -19,3 +19,21 @@ interface(`dovecot_manage_spool',`
 	allow $1 dovecot_spool_t:file create_file_perms;
 	allow $1 dovecot_spool_t:lnk_file create_lnk_perms;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`dovecot_recv_labeledipsec',`
+	gen_require(`
+		type dovecot_t;
+	')
+	allow $1 dovecot_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/dovecot.te serefpolicy-2.4.6.patchbox2/policy/modules/services/dovecot.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/dovecot.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/dovecot.te	2006-12-14 11:40:21.000000000 -0600
@@ -46,6 +46,7 @@ allow dovecot_t self:fifo_file rw_file_p
 allow dovecot_t self:tcp_socket create_stream_socket_perms;
 allow dovecot_t self:unix_dgram_socket create_socket_perms;
 allow dovecot_t self:unix_stream_socket { create_stream_socket_perms connectto };
+allow dovecot_t self:association { sendto recvfrom };
 
 domain_auto_trans(dovecot_t, dovecot_auth_exec_t, dovecot_auth_t)
 allow dovecot_t dovecot_auth_t:fd use;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/fetchmail.if serefpolicy-2.4.6.patchbox2/policy/modules/services/fetchmail.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/fetchmail.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/fetchmail.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Remote-mail retrieval and forwarding utility</summary>
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`fetchmail_recv_labeledipsec',`
+	gen_require(`
+		type mrtg_t;
+	')
+	allow $1 fetchmail_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/fetchmail.te serefpolicy-2.4.6.patchbox2/policy/modules/services/fetchmail.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/fetchmail.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/fetchmail.te	2006-12-14 11:40:21.000000000 -0600
@@ -31,6 +31,7 @@ allow fetchmail_t self:unix_stream_socke
 allow fetchmail_t self:netlink_route_socket r_netlink_socket_perms;
 allow fetchmail_t self:tcp_socket create_socket_perms;
 allow fetchmail_t self:udp_socket create_socket_perms;
+allow fetchmail_t self:association { sendto recvfrom };
 
 allow fetchmail_t fetchmail_etc_t:file r_file_perms;
 
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/finger.if serefpolicy-2.4.6.patchbox2/policy/modules/services/finger.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/finger.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/finger.if	2006-12-14 11:40:21.000000000 -0600
@@ -36,3 +36,21 @@ interface(`finger_domtrans',`
 interface(`finger_tcp_connect',`
 	refpolicywarn(`$0($*) has been deprecated.')
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`finger_recv_labeledipsec',`
+	gen_require(`
+		type fingerd_t;
+	')
+	allow $1 fingerd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/finger.te serefpolicy-2.4.6.patchbox2/policy/modules/services/finger.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/finger.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/finger.te	2006-12-14 11:40:21.000000000 -0600
@@ -33,6 +33,7 @@ allow fingerd_t self:tcp_socket connecte
 allow fingerd_t self:udp_socket create_socket_perms;
 allow fingerd_t self:unix_dgram_socket create_socket_perms;
 allow fingerd_t self:unix_stream_socket create_socket_perms;
+allow fingerd_t self:association { sendto recvfrom };
 
 allow fingerd_t fingerd_var_run_t:file create_file_perms;
 allow fingerd_t fingerd_var_run_t:dir rw_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ftp.if serefpolicy-2.4.6.patchbox2/policy/modules/services/ftp.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ftp.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ftp.if	2006-12-14 11:40:21.000000000 -0600
@@ -126,3 +126,21 @@ interface(`ftp_domtrans_ftpdctl',`
 	allow ftpdctl_t $1:fifo_file rw_file_perms;
 	allow ftpdctl_t $1:process sigchld;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`ftp_recv_labeledipsec',`
+	gen_require(`
+		type ftpd_t;
+	')
+	allow $1 ftpd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ftp.te serefpolicy-2.4.6.patchbox2/policy/modules/services/ftp.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ftp.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ftp.te	2006-12-14 11:40:21.000000000 -0600
@@ -50,6 +50,7 @@ allow ftpd_t self:unix_dgram_socket { se
 allow ftpd_t self:unix_stream_socket create_stream_socket_perms;
 allow ftpd_t self:tcp_socket create_stream_socket_perms;
 allow ftpd_t self:udp_socket create_socket_perms;
+allow ftpd_t self:association { sendto recvfrom };
 
 allow ftpd_t ftpd_etc_t:file r_file_perms;
 
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/gatekeeper.if serefpolicy-2.4.6.patchbox2/policy/modules/services/gatekeeper.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/gatekeeper.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/gatekeeper.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>OpenH.323 Voice-Over-IP Gatekeeper</summary>
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`gatekeeper_recv_labeledipsec',`
+	gen_require(`
+		type gatekeeper_t;
+	')
+	allow $1 gatekeeper_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/gatekeeper.te serefpolicy-2.4.6.patchbox2/policy/modules/services/gatekeeper.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/gatekeeper.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/gatekeeper.te	2006-12-14 11:40:21.000000000 -0600
@@ -33,6 +33,7 @@ allow gatekeeper_t self:process { setsch
 allow gatekeeper_t self:fifo_file rw_file_perms;
 allow gatekeeper_t self:tcp_socket create_stream_socket_perms;
 allow gatekeeper_t self:udp_socket create_socket_perms;
+allow gatekeeper_t self:association { sendto recvfrom };
 
 allow gatekeeper_t gatekeeper_etc_t:lnk_file { getattr read };
 allow gatekeeper_t gatekeeper_etc_t:file { getattr read };
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/hal.if serefpolicy-2.4.6.patchbox2/policy/modules/services/hal.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/hal.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/hal.if	2006-12-14 11:40:21.000000000 -0600
@@ -177,3 +177,21 @@ interface(`hal_dontaudit_append_var_lib_
 	files_search_pids($1)
 	dontaudit $1 hald_var_lib_t:file ra_file_perms;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`hal_recv_labeledipsec',`
+	gen_require(`
+		type hald_t;
+	')
+	allow $1 hald_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/hal.te serefpolicy-2.4.6.patchbox2/policy/modules/services/hal.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/hal.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/hal.te	2006-12-14 11:40:21.000000000 -0600
@@ -37,6 +37,7 @@ allow hald_t self:tcp_socket create_stre
 allow hald_t self:udp_socket create_socket_perms;
 # For backwards compatibility with older kernels
 allow hald_t self:netlink_socket create_socket_perms;
+allow hald_t self:association { sendto recvfrom };
 
 allow hald_t hald_tmp_t:dir create_dir_perms;
 allow hald_t hald_tmp_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/howl.if serefpolicy-2.4.6.patchbox2/policy/modules/services/howl.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/howl.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/howl.if	2006-12-14 11:40:21.000000000 -0600
@@ -17,3 +17,21 @@ interface(`howl_signal',`
 
 	allow $1 howl_t:process signal;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`howl_recv_labeledipsec',`
+	gen_require(`
+		type howl_t;
+	')
+	allow $1 howl_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/howl.te serefpolicy-2.4.6.patchbox2/policy/modules/services/howl.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/howl.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/howl.te	2006-12-14 11:40:21.000000000 -0600
@@ -24,6 +24,7 @@ allow howl_t self:process signal_perms;
 allow howl_t self:fifo_file rw_file_perms;
 allow howl_t self:tcp_socket create_stream_socket_perms;
 allow howl_t self:udp_socket create_socket_perms;
+allow howl_t self:association { sendto recvfrom };
 
 allow howl_t howl_var_run_t:file create_file_perms;
 allow howl_t howl_var_run_t:dir rw_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/i18n_input.if serefpolicy-2.4.6.patchbox2/policy/modules/services/i18n_input.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/i18n_input.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/i18n_input.if	2006-12-14 11:40:21.000000000 -0600
@@ -13,3 +13,21 @@
 interface(`i18n_use',`
 	refpolicywarn(`$0($*) has been deprecated.')
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`i18n_recv_labeledipsec',`
+	gen_require(`
+		type i18n_input_t;
+	')
+	allow $1 i18n_input_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/i18n_input.te serefpolicy-2.4.6.patchbox2/policy/modules/services/i18n_input.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/i18n_input.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/i18n_input.te	2006-12-14 11:40:21.000000000 -0600
@@ -26,6 +26,7 @@ allow i18n_input_t self:unix_dgram_socke
 allow i18n_input_t self:unix_stream_socket create_stream_socket_perms;
 allow i18n_input_t self:tcp_socket create_stream_socket_perms;
 allow i18n_input_t self:udp_socket create_socket_perms;
+allow i18n_input_t self:association { sendto recvfrom };
 
 allow i18n_input_t i18n_input_var_run_t:dir create_dir_perms;
 allow i18n_input_t i18n_input_var_run_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/imaze.if serefpolicy-2.4.6.patchbox2/policy/modules/services/imaze.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/imaze.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/imaze.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>iMaze game server</summary>
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`imaze_recv_labeledipsec',`
+	gen_require(`
+		type imazesrv_t;
+	')
+	allow $1 imazesrv_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/imaze.te serefpolicy-2.4.6.patchbox2/policy/modules/services/imaze.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/imaze.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/imaze.te	2006-12-14 11:40:21.000000000 -0600
@@ -39,6 +39,7 @@ allow imazesrv_t self:msgq create_msgq_p
 allow imazesrv_t self:msg { send receive };
 allow imazesrv_t self:tcp_socket create_stream_socket_perms;
 allow imazesrv_t self:udp_socket create_socket_perms;
+allow imazesrv_t self:association { sendto recvfrom };
 
 allow imazesrv_t imazesrv_data_t:dir list_dir_perms;
 allow imazesrv_t imazesrv_data_t:file read_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/inetd.if serefpolicy-2.4.6.patchbox2/policy/modules/services/inetd.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/inetd.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/inetd.if	2006-12-14 11:40:21.000000000 -0600
@@ -236,3 +236,39 @@ interface(`inetd_rw_tcp_sockets',`
 
 	allow $1 inetd_t:tcp_socket rw_stream_socket_perms;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`inetd_recv_labeledipsec',`
+	gen_require(`
+		type inetd_t;
+	')
+	allow $1 inetd_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`inetd_recv_labeledipsec_child',`
+	gen_require(`
+		type inetd_child_t;
+	')
+	allow $1 inetd_child_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/inetd.te serefpolicy-2.4.6.patchbox2/policy/modules/services/inetd.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/inetd.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/inetd.te	2006-12-14 11:40:21.000000000 -0600
@@ -41,6 +41,7 @@ allow inetd_t self:process setsched;
 allow inetd_t self:fifo_file rw_file_perms;
 allow inetd_t self:tcp_socket create_stream_socket_perms;
 allow inetd_t self:udp_socket create_socket_perms;
+allow inetd_t self:association { sendto recvfrom };
 
 allow inetd_t inetd_log_t:file create_file_perms;
 logging_log_filetrans(inetd_t,inetd_log_t,file)
@@ -175,6 +176,7 @@ allow inetd_child_t self:netlink_tcpdiag
 allow inetd_child_t self:capability { setuid setgid };
 allow inetd_child_t self:dir search;
 allow inetd_child_t self:{ lnk_file file } { getattr read };
+allow inetd_child_t self:association { sendto recvfrom };
 files_search_home(inetd_child_t)
 
 allow inetd_child_t inetd_child_tmp_t:dir create_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/inn.if serefpolicy-2.4.6.patchbox2/policy/modules/services/inn.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/inn.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/inn.if	2006-12-14 11:40:21.000000000 -0600
@@ -182,3 +182,20 @@ interface(`inn_domtrans',`
 	allow innd_t $1:process sigchld;
 ')
 
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`inn_recv_labeledipsec',`
+	gen_require(`
+		type innd_t;
+	')
+	allow $1 innd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/inn.te serefpolicy-2.4.6.patchbox2/policy/modules/services/inn.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/inn.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/inn.te	2006-12-14 11:40:21.000000000 -0600
@@ -37,6 +37,7 @@ allow innd_t self:unix_stream_socket { c
 allow innd_t self:tcp_socket create_stream_socket_perms;
 allow innd_t self:udp_socket create_socket_perms;
 allow innd_t self:netlink_route_socket r_netlink_socket_perms;
+allow innd_t self:association { sendto recvfrom };
 
 allow innd_t innd_etc_t:file r_file_perms;
 allow innd_t innd_etc_t:dir r_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ircd.if serefpolicy-2.4.6.patchbox2/policy/modules/services/ircd.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ircd.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ircd.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>IRC server</summary>
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`ircd_recv_labeledipsec',`
+	gen_require(`
+		type ircd_t;
+	')
+	allow $1 ircd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ircd.te serefpolicy-2.4.6.patchbox2/policy/modules/services/ircd.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ircd.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ircd.te	2006-12-14 11:40:21.000000000 -0600
@@ -31,6 +31,7 @@ dontaudit ircd_t self:capability sys_tty
 allow ircd_t self:process signal_perms;
 allow ircd_t self:tcp_socket create_stream_socket_perms;
 allow ircd_t self:udp_socket create_socket_perms;
+allow ircd_t self:association { sendto recvfrom };
 
 allow ircd_t ircd_etc_t:file r_file_perms;
 allow ircd_t ircd_etc_t:dir r_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/jabber.if serefpolicy-2.4.6.patchbox2/policy/modules/services/jabber.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/jabber.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/jabber.if	2006-12-14 11:40:21.000000000 -0600
@@ -13,3 +13,21 @@
 interface(`jabber_tcp_connect',`
 	refpolicywarn(`$0($*) has been deprecated.')
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`jabber_recv_labeledipsec',`
+	gen_require(`
+		type jabberd_t;
+	')
+	allow $1 jabberd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/jabber.te serefpolicy-2.4.6.patchbox2/policy/modules/services/jabber.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/jabber.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/jabber.te	2006-12-14 11:40:21.000000000 -0600
@@ -30,6 +30,7 @@ allow jabberd_t self:process signal_perm
 allow jabberd_t self:fifo_file { read write getattr };
 allow jabberd_t self:tcp_socket create_stream_socket_perms;
 allow jabberd_t self:udp_socket create_socket_perms;
+allow jabberd_t self:association { sendto recvfrom };
 
 allow jabberd_t jabberd_var_lib_t:file create_file_perms;
 allow jabberd_t jabberd_var_lib_t:dir rw_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/kerberos.if serefpolicy-2.4.6.patchbox2/policy/modules/services/kerberos.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/kerberos.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/kerberos.if	2006-12-14 11:40:21.000000000 -0600
@@ -45,6 +45,7 @@ interface(`kerberos_use',`
 	tunable_policy(`allow_kerberos',`
 		allow $1 self:tcp_socket create_socket_perms;
 		allow $1 self:udp_socket create_socket_perms;
+		allow $1 self:association { sendto recvfrom };
 
 		corenet_non_ipsec_sendrecv($1)
 		corenet_tcp_sendrecv_all_if($1)
@@ -142,3 +143,39 @@ interface(`kerberos_read_keytab',`
 	files_search_etc($1)
 	allow $1 krb5_keytab_t:file r_file_perms;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kerberos_recv_labeledipsec_kadmind',`
+	gen_require(`
+		type kadmind_t;
+	')
+	allow $1 kadmind_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kerberos_recv_labeledipsec_krb5kdc',`
+	gen_require(`
+		type krb5kdc_t;
+	')
+	allow $1 krb5kdc_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/kerberos.te serefpolicy-2.4.6.patchbox2/policy/modules/services/kerberos.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/kerberos.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/kerberos.te	2006-12-14 11:40:21.000000000 -0600
@@ -60,6 +60,7 @@ allow kadmind_t self:netlink_route_socke
 allow kadmind_t self:unix_dgram_socket { connect create write };
 allow kadmind_t self:tcp_socket connected_stream_socket_perms;
 allow kadmind_t self:udp_socket create_socket_perms;
+allow kadmind_t self:association { sendto recvfrom };
 
 allow kadmind_t kadmind_log_t:file create_file_perms;
 logging_log_filetrans(kadmind_t,kadmind_log_t,file)
@@ -160,6 +161,7 @@ allow krb5kdc_t self:process { getsched 
 allow krb5kdc_t self:netlink_route_socket r_netlink_socket_perms;
 allow krb5kdc_t self:tcp_socket create_stream_socket_perms;
 allow krb5kdc_t self:udp_socket create_socket_perms;
+allow krb5kdc_t self:association { sendto recvfrom };
 
 files_read_usr_symlinks(krb5kdc_t)
 files_read_var_files(krb5kdc_t)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ktalk.if serefpolicy-2.4.6.patchbox2/policy/modules/services/ktalk.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ktalk.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ktalk.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>KDE Talk daemon</summary>
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`ktalk_recv_labeledipsec',`
+	gen_require(`
+		type ktalkd_t;
+	')
+	allow $1 ktalkd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ktalk.te serefpolicy-2.4.6.patchbox2/policy/modules/services/ktalk.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ktalk.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ktalk.te	2006-12-14 11:40:21.000000000 -0600
@@ -35,6 +35,7 @@ allow ktalkd_t self:netlink_tcpdiag_sock
 allow ktalkd_t self:capability { setuid setgid };
 allow ktalkd_t self:dir search;
 allow ktalkd_t self:{ lnk_file file } { getattr read };
+allow ktalkd_t self:association { sendto recvfrom };
 files_search_home(ktalkd_t)
 optional_policy(`
 	kerberos_use(ktalkd_t)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ldap.if serefpolicy-2.4.6.patchbox2/policy/modules/services/ldap.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ldap.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ldap.if	2006-12-14 11:40:21.000000000 -0600
@@ -73,3 +73,21 @@ interface(`ldap_stream_connect',`
 	allow $1 slapd_var_run_t:sock_file write;
 	allow $1 slapd_t:unix_stream_socket connectto;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`ldap_recv_labeledipsec',`
+	gen_require(`
+		type slapd_t;
+	')
+	allow $1 slapd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ldap.te serefpolicy-2.4.6.patchbox2/policy/modules/services/ldap.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ldap.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ldap.te	2006-12-14 11:40:21.000000000 -0600
@@ -46,6 +46,7 @@ allow slapd_t self:netlink_route_socket 
 allow slapd_t self:udp_socket create_socket_perms;
 #slapd needs to listen and accept needed by ldapsearch (slapd needs to accept from ldapseach)
 allow slapd_t self:tcp_socket create_stream_socket_perms;
+allow slapd_t self:association { sendto recvfrom };
 
 allow slapd_t slapd_cert_t:dir r_dir_perms;
 allow slapd_t slapd_cert_t:file r_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/lpd.if serefpolicy-2.4.6.patchbox2/policy/modules/services/lpd.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/lpd.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/lpd.if	2006-12-14 11:40:21.000000000 -0600
@@ -63,6 +63,7 @@ template(`lpd_per_role_template',`
 	allow $1_lpr_t self:tcp_socket create_socket_perms;
 	allow $1_lpr_t self:udp_socket create_socket_perms;
 	allow $1_lpr_t self:netlink_route_socket r_netlink_socket_perms;
+	allow $1_lpr_t self:association { sendto recvfrom };
 	
 	can_exec($1_lpr_t,lpr_exec_t)
 
@@ -406,3 +407,56 @@ template(`lpd_domtrans_user_lpr',`
 	allow $1_lpr_t $2:process sigchld;
 ')
 
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`lpd_recv_labeledipsec',`
+	gen_require(`
+		type lpd_t;
+	')
+	allow $1 lpd_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`lpd_recv_labeledipsec_checkpc',`
+	gen_require(`
+		type checkpc_t;
+	')
+	allow $1 checkpc_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`lpd_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_lpr_t;
+	')
+	allow $2 $1_lpr_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/lpd.te serefpolicy-2.4.6.patchbox2/policy/modules/services/lpd.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/lpd.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/lpd.te	2006-12-14 11:40:21.000000000 -0600
@@ -49,6 +49,7 @@ allow checkpc_t self:process signal_perm
 allow checkpc_t self:unix_stream_socket create_socket_perms;
 allow checkpc_t self:tcp_socket create_socket_perms;
 allow checkpc_t self:udp_socket create_socket_perms;
+allow checkpc_t self:association { sendto recvfrom };
 
 allow checkpc_t checkpc_log_t:file create_file_perms;
 logging_log_filetrans(checkpc_t,checkpc_log_t,file)
@@ -126,6 +127,7 @@ allow lpd_t self:unix_stream_socket crea
 allow lpd_t self:unix_dgram_socket create_socket_perms;
 allow lpd_t self:tcp_socket create_stream_socket_perms;
 allow lpd_t self:udp_socket create_stream_socket_perms;
+allow lpd_t self:association { sendto recvfrom };
 
 allow lpd_t lpd_tmp_t:dir create_dir_perms;
 allow lpd_t lpd_tmp_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/mailman.if serefpolicy-2.4.6.patchbox2/policy/modules/services/mailman.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/mailman.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/mailman.if	2006-12-14 11:40:21.000000000 -0600
@@ -30,6 +30,7 @@ template(`mailman_domain_template', `
 	allow mailman_$1_t self:{ unix_stream_socket unix_dgram_socket } create_socket_perms;
 	allow mailman_$1_t self:tcp_socket create_stream_socket_perms;
 	allow mailman_$1_t self:udp_socket create_socket_perms;
+	allow mailman_$1_t self:association { sendto recvfrom };
 
 	allow mailman_$1_t mailman_data_t:dir create_dir_perms;
 	allow mailman_$1_t mailman_data_t:file create_file_perms;
@@ -333,3 +334,74 @@ interface(`mailman_domtrans_queue',`
 	allow mailman_queue_t $1:process sigchld;
 ')
 
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mailman_recv_labeledipsec_cgi',`
+	gen_require(`
+		type mailman_cgi_t;
+	')
+	allow $1 mailman_cgi_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mailman_recv_labeledipsec_mail',`
+	gen_require(`
+		type mailman_mail_t;
+	')
+	allow $1 mailman_mail_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mailman_recv_labeledipsec_queue',`
+	gen_require(`
+		type mailman_queue_t;
+	')
+	allow $1 mailman_queue_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mailman_recv_labeledipsec_tmpl',`
+	gen_require(`
+		type mailman_$1_t;
+	')
+	allow $2 mailman_$1_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/monop.if serefpolicy-2.4.6.patchbox2/policy/modules/services/monop.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/monop.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/monop.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Monopoly daemon</summary>
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`monop_recv_labeledipsec',`
+	gen_require(`
+		type monopd_t;
+	')
+	allow $1 monopd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/monop.te serefpolicy-2.4.6.patchbox2/policy/modules/services/monop.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/monop.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/monop.te	2006-12-14 11:40:21.000000000 -0600
@@ -28,6 +28,7 @@ dontaudit monopd_t self:capability sys_t
 allow monopd_t self:process signal_perms;
 allow monopd_t self:tcp_socket create_stream_socket_perms;
 allow monopd_t self:udp_socket create_socket_perms;
+allow monopd_t self:association { sendto recvfrom };
 
 allow monopd_t monopd_etc_t:file { getattr read };
 files_search_etc(monopd_t)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/mta.if serefpolicy-2.4.6.patchbox2/policy/modules/services/mta.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/mta.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/mta.if	2006-12-14 11:40:21.000000000 -0600
@@ -60,6 +60,7 @@ template(`mta_base_mail_template',`
 	allow $1_mail_t self:capability { setuid setgid chown };
 	allow $1_mail_t self:process { signal_perms setrlimit };
 	allow $1_mail_t self:tcp_socket create_socket_perms;
+	allow $1_mail_t self:association { sendto recvfrom };
 
 	# re-exec itself
 	can_exec($1_mail_t, sendmail_exec_t)
@@ -882,3 +883,21 @@ interface(`mta_rw_user_mail_stream_socke
 
 	allow $1 user_mail_domain:unix_stream_socket rw_socket_perms;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mta_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_mail_t;
+	')
+	allow $2 $_mail_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/munin.if serefpolicy-2.4.6.patchbox2/policy/modules/services/munin.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/munin.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/munin.if	2006-12-14 11:40:21.000000000 -0600
@@ -61,3 +61,21 @@ interface(`munin_search_lib',`
 	allow $1 munin_var_lib_t:dir search_dir_perms;
 	files_search_var_lib($1)
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`munin_recv_labeledipsec',`
+	gen_require(`
+		type munin_t;
+	')
+	allow $1 munin_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/munin.te serefpolicy-2.4.6.patchbox2/policy/modules/services/munin.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/munin.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/munin.te	2006-12-14 11:40:21.000000000 -0600
@@ -37,6 +37,7 @@ allow munin_t self:unix_stream_socket { 
 allow munin_t self:unix_dgram_socket { create_socket_perms sendto };
 allow munin_t self:tcp_socket create_stream_socket_perms;
 allow munin_t self:udp_socket create_socket_perms;
+allow munin_t self:association { sendto recvfrom };
 
 allow munin_t munin_etc_t:file r_file_perms;
 allow munin_t munin_etc_t:dir r_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/mysql.if serefpolicy-2.4.6.patchbox2/policy/modules/services/mysql.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/mysql.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/mysql.if	2006-12-14 11:40:21.000000000 -0600
@@ -159,3 +159,21 @@ interface(`mysql_write_log',`
 	logging_search_logs($1)
 	allow $1 mysqld_log_t:file { write append setattr ioctl };
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mysql_recv_labeledipsec',`
+	gen_require(`
+		type mysqld_t;
+	')
+	allow $1 mysqld_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/mysql.te serefpolicy-2.4.6.patchbox2/policy/modules/services/mysql.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/mysql.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/mysql.te	2006-12-14 11:40:21.000000000 -0600
@@ -37,6 +37,7 @@ allow mysqld_t self:fifo_file { read wri
 allow mysqld_t self:unix_stream_socket create_stream_socket_perms;
 allow mysqld_t self:tcp_socket create_stream_socket_perms;
 allow mysqld_t self:udp_socket create_socket_perms;
+allow mysqld_t self:association { sendto recvfrom };
 
 allow mysqld_t mysqld_db_t:dir create_dir_perms;
 allow mysqld_t mysqld_db_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/nagios.if serefpolicy-2.4.6.patchbox2/policy/modules/services/nagios.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/nagios.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/nagios.if	2006-12-14 11:40:21.000000000 -0600
@@ -85,3 +85,21 @@ interface(`nagios_domtrans_nrpe',`
 	allow nrpe_t $1:fifo_file rw_file_perms;
 	allow nrpe_t $1:process sigchld;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`nagios_recv_labeledipsec',`
+	gen_require(`
+		type nagios_t;
+	')
+	allow $1 nagios_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/nagios.te serefpolicy-2.4.6.patchbox2/policy/modules/services/nagios.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/nagios.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/nagios.te	2006-12-14 11:40:21.000000000 -0600
@@ -44,6 +44,7 @@ allow nagios_t self:process { setpgid si
 allow nagios_t self:fifo_file rw_file_perms;
 allow nagios_t self:tcp_socket create_stream_socket_perms;
 allow nagios_t self:udp_socket create_socket_perms;
+allow nagios_t self:association { sendto recvfrom };
 
 allow nagios_t nagios_etc_t:file r_file_perms;
 allow nagios_t nagios_etc_t:dir r_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/nessus.if serefpolicy-2.4.6.patchbox2/policy/modules/services/nessus.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/nessus.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/nessus.if	2006-12-14 11:40:21.000000000 -0600
@@ -13,3 +13,21 @@
 interface(`nessus_tcp_connect',`
 	refpolicywarn(`$0($*) has been deprecated.')
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`nessus_recv_labeledipsec',`
+	gen_require(`
+		type nessus_t;
+	')
+	allow $1 nessus_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/nessus.te serefpolicy-2.4.6.patchbox2/policy/modules/services/nessus.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/nessus.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/nessus.te	2006-12-14 11:40:21.000000000 -0600
@@ -35,6 +35,7 @@ allow nessusd_t self:tcp_socket create_s
 allow nessusd_t self:udp_socket create_socket_perms;
 allow nessusd_t self:rawip_socket create_socket_perms;
 allow nessusd_t self:packet_socket create_socket_perms;
+allow nessusd_t self:association { sendto recvfrom };
 
 # Allow access to the nessusd authentication database
 allow nessusd_t nessusd_db_t:dir create_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/networkmanager.if serefpolicy-2.4.6.patchbox2/policy/modules/services/networkmanager.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/networkmanager.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/networkmanager.if	2006-12-14 11:40:21.000000000 -0600
@@ -78,3 +78,21 @@ interface(`networkmanager_dbus_chat',`
 	allow $1 NetworkManager_t:dbus send_msg;
 	allow NetworkManager_t $1:dbus send_msg;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`networkmanager_recv_labeledipsec',`
+	gen_require(`
+		type mrtg_t;
+	')
+	allow $1 NetworkManager_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/networkmanager.te serefpolicy-2.4.6.patchbox2/policy/modules/services/networkmanager.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/networkmanager.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/networkmanager.te	2006-12-14 11:40:21.000000000 -0600
@@ -30,6 +30,7 @@ allow NetworkManager_t self:netlink_rout
 allow NetworkManager_t self:tcp_socket create_stream_socket_perms;
 allow NetworkManager_t self:udp_socket create_socket_perms;
 allow NetworkManager_t self:packet_socket create_socket_perms;
+allow NetworkManager_t self:association { sendto recvfrom };
 
 allow NetworkManager_t NetworkManager_var_run_t:file create_file_perms;
 allow NetworkManager_t NetworkManager_var_run_t:dir create_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/nis.if serefpolicy-2.4.6.patchbox2/policy/modules/services/nis.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/nis.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/nis.if	2006-12-14 11:40:21.000000000 -0600
@@ -32,6 +32,7 @@ interface(`nis_use_ypbind_uncond',`
 
 	allow $1 self:tcp_socket create_stream_socket_perms;
 	allow $1 self:udp_socket create_socket_perms;
+	allow $1 self:association { sendto recvfrom };
 
 	allow $1 var_yp_t:dir r_dir_perms;
 	allow $1 var_yp_t:lnk_file { getattr read };
@@ -252,3 +253,75 @@ interface(`nis_domtrans_ypxfr',`
 	allow ypxfr_t $1:fifo_file rw_file_perms;
 	allow ypxfr_t $1:process sigchld;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`nis_recv_labeledipsec_ypbind',`
+	gen_require(`
+		type ypbind_t;
+	')
+	allow $1 ypbind_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`nis_recv_labeledipsec_yppasswdd',`
+	gen_require(`
+		type yppasswdd_t;
+	')
+	allow $1 yppasswd_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`nis_recv_labeledipsec_ypserv',`
+	gen_require(`
+		type ypserv_t;
+	')
+	allow $1 ypserv_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`nis_recv_labeledipsec_ypxfr',`
+	gen_require(`
+		type ypxfr_t;
+	')
+	allow $1 ypxfr_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/nis.te serefpolicy-2.4.6.patchbox2/policy/modules/services/nis.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/nis.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/nis.te	2006-12-14 11:40:21.000000000 -0600
@@ -55,6 +55,7 @@ allow ypbind_t self:{ unix_dgram_socket 
 allow ypbind_t self:netlink_route_socket r_netlink_socket_perms;
 allow ypbind_t self:tcp_socket create_stream_socket_perms;
 allow ypbind_t self:udp_socket create_socket_perms;
+allow ypbind_t self:association { sendto recvfrom };
 
 allow ypbind_t ypbind_tmp_t:dir create_dir_perms;
 allow ypbind_t ypbind_tmp_t:file create_file_perms;
@@ -147,6 +148,7 @@ allow yppasswdd_t self:unix_stream_socke
 allow yppasswdd_t self:netlink_route_socket r_netlink_socket_perms;
 allow yppasswdd_t self:tcp_socket create_stream_socket_perms;
 allow yppasswdd_t self:udp_socket create_socket_perms;
+allow yppasswdd_t self:association { sendto recvfrom };
 
 allow yppasswdd_t yppasswdd_var_run_t:file create_file_perms;
 allow yppasswdd_t yppasswdd_var_run_t:dir rw_dir_perms;
@@ -246,6 +248,7 @@ allow ypserv_t self:unix_stream_socket c
 allow ypserv_t self:netlink_route_socket r_netlink_socket_perms;
 allow ypserv_t self:tcp_socket connected_stream_socket_perms;
 allow ypserv_t self:udp_socket create_socket_perms;
+allow ypserv_t self:association { sendto recvfrom };
 
 allow ypserv_t var_yp_t:dir rw_dir_perms;
 allow ypserv_t var_yp_t:file create_file_perms;
@@ -336,6 +339,7 @@ allow ypxfr_t ypserv_t:tcp_socket { read
 allow ypxfr_t ypserv_t:udp_socket { read write };
 
 allow ypxfr_t self:unix_stream_socket create_stream_socket_perms;
+allow ypxfr_t self:association { sendto recvfrom };
 
 corenet_non_ipsec_sendrecv(ypxfr_t)
 corenet_tcp_sendrecv_all_if(ypxfr_t)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/nscd.if serefpolicy-2.4.6.patchbox2/policy/modules/services/nscd.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/nscd.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/nscd.if	2006-12-14 11:40:21.000000000 -0600
@@ -201,3 +201,20 @@ interface(`nscd_role',`
 	role $1 types nscd_t;
 ')
 
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`nscd_recv_labeledipsec',`
+	gen_require(`
+		type nscd_t;
+	')
+	allow $1 nscd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/nscd.te serefpolicy-2.4.6.patchbox2/policy/modules/services/nscd.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/nscd.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/nscd.te	2006-12-14 11:40:21.000000000 -0600
@@ -38,6 +38,7 @@ allow nscd_t self:netlink_selinux_socket
 allow nscd_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 allow nscd_t self:tcp_socket create_socket_perms;
 allow nscd_t self:udp_socket create_socket_perms;
+allow nscd_t self:association { sendto recvfrom };
 
 # For client program operation, invoked from sysadm_t.
 # Transition occurs to nscd_t due to direct_sysadm_daemon. 
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/nsd.if serefpolicy-2.4.6.patchbox2/policy/modules/services/nsd.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/nsd.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/nsd.if	2006-12-14 11:40:21.000000000 -0600
@@ -27,3 +27,39 @@ interface(`nsd_udp_chat',`
 interface(`nsd_tcp_connect',`
 	refpolicywarn(`$0($*) has been deprecated.')
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`nsd_recv_labeledipsec',`
+	gen_require(`
+		type nsd_t;
+	')
+	allow $1 nsd_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`nsd_recv_labeledipsec_cron',`
+	gen_require(`
+		type nsd_crond_t;
+	')
+	allow $1 nsd_crond_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/nsd.te serefpolicy-2.4.6.patchbox2/policy/modules/services/nsd.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/nsd.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/nsd.te	2006-12-14 11:40:21.000000000 -0600
@@ -40,6 +40,7 @@ dontaudit nsd_t self:capability sys_tty_
 allow nsd_t self:process signal_perms;
 allow nsd_t self:tcp_socket create_stream_socket_perms;
 allow nsd_t self:udp_socket create_socket_perms;
+allow nsd_t self:association { sendto recvfrom };
 
 allow nsd_t nsd_conf_t:dir r_dir_perms;
 allow nsd_t nsd_conf_t:file r_file_perms;
@@ -134,6 +135,7 @@ allow nsd_crond_t self:process { setsche
 allow nsd_crond_t self:fifo_file rw_file_perms;
 allow nsd_crond_t self:tcp_socket create_socket_perms;
 allow nsd_crond_t self:udp_socket create_socket_perms;
+allow nsd_crond_t self:association sendto;
 
 allow nsd_crond_t nsd_conf_t:file { getattr read ioctl };
 
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ntop.if serefpolicy-2.4.6.patchbox2/policy/modules/services/ntop.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ntop.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ntop.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Network Top</summary>
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`ntop_recv_labeledipsec',`
+	gen_require(`
+		type ntop_t;
+	')
+	allow $1 ntop_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ntop.te serefpolicy-2.4.6.patchbox2/policy/modules/services/ntop.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ntop.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ntop.te	2006-12-14 11:40:21.000000000 -0600
@@ -37,6 +37,7 @@ allow ntop_t self:fifo_file { read write
 allow ntop_t self:tcp_socket create_stream_socket_perms;
 allow ntop_t self:udp_socket create_socket_perms;
 allow ntop_t self:packet_socket create_socket_perms;
+allow ntop_t self:association { sendto recvfrom };
 
 allow ntop_t ntop_etc_t:file r_file_perms;
 allow ntop_t ntop_etc_t:dir r_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ntp.if serefpolicy-2.4.6.patchbox2/policy/modules/services/ntp.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ntp.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ntp.if	2006-12-14 11:40:21.000000000 -0600
@@ -63,3 +63,21 @@ interface(`ntp_domtrans_ntpdate',`
 	allow ntpd_t $1:fifo_file rw_file_perms;
 	allow ntpd_t $1:process sigchld;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`ntp_recv_labeledipsec',`
+	gen_require(`
+		type ntpd_t;
+	')
+	allow $1 ntpd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ntp.te serefpolicy-2.4.6.patchbox2/policy/modules/services/ntp.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ntp.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ntp.te	2006-12-14 11:40:21.000000000 -0600
@@ -40,6 +40,7 @@ allow ntpd_t self:unix_dgram_socket crea
 allow ntpd_t self:unix_stream_socket create_socket_perms;
 allow ntpd_t self:tcp_socket create_stream_socket_perms;
 allow ntpd_t self:udp_socket create_socket_perms;
+allow ntpd_t self:association { sendto recvfrom };
 
 allow ntpd_t ntp_drift_t:dir rw_dir_perms;
 allow ntpd_t ntp_drift_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/nx.if serefpolicy-2.4.6.patchbox2/policy/modules/services/nx.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/nx.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/nx.if	2006-12-14 11:40:21.000000000 -0600
@@ -20,3 +20,21 @@ interface(`nx_spec_domtrans_server',`
 	allow nx_server_t $1:fifo_file rw_file_perms;
 	allow nx_server_t $1:process sigchld;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`nx_spec_recv_labeledipsec',`
+	gen_require(`
+		type nx_server_t;
+	')
+	allow $1 nx_server_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/nx.te serefpolicy-2.4.6.patchbox2/policy/modules/services/nx.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/nx.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/nx.te	2006-12-14 11:40:21.000000000 -0600
@@ -33,6 +33,7 @@ files_pid_file(nx_server_var_run_t)
 allow nx_server_t self:fifo_file { getattr ioctl read write };
 allow nx_server_t self:tcp_socket create_socket_perms;
 allow nx_server_t self:udp_socket create_socket_perms;
+allow nx_server_t self:association { sendto recvfrom };
 
 allow nx_server_t nx_server_devpts_t:chr_file { rw_file_perms setattr };
 term_create_pty(nx_server_t,nx_server_devpts_t)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/oav.if serefpolicy-2.4.6.patchbox2/policy/modules/services/oav.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/oav.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/oav.if	2006-12-14 11:40:21.000000000 -0600
@@ -55,3 +55,39 @@ interface(`oav_run_update',`
 	role $2 types oav_update_t;
 	allow oav_update_t $3:chr_file rw_term_perms;
 ')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`oav_recv_labeledipsec_update',`
+	gen_require(`
+		type oav_update_t;
+	')
+	allow $1 oav_update_t:association recvfrom;
+')
+
+########################################
+## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`oav_recv_labeledipsec_scannerdaemon',`
+	gen_require(`
+		type scannerdaemon_t;
+	')
+	allow $1 scannerdaemon_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/oav.te serefpolicy-2.4.6.patchbox2/policy/modules/services/oav.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/oav.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/oav.te	2006-12-14 11:40:21.000000000 -0600
@@ -38,6 +38,7 @@ files_pid_file(scannerdaemon_var_run_t)
 
 allow oav_update_t self:tcp_socket create_stream_socket_perms;
 allow oav_update_t self:udp_socket create_socket_perms;
+allow oav_update_t self:association { sendto recvfrom };
 
 # Can read /etc/oav-update/* files
 allow oav_update_t oav_update_etc_t:dir r_dir_perms;
@@ -85,6 +86,7 @@ allow scannerdaemon_t self:process signa
 allow scannerdaemon_t self:fifo_file { read write };
 allow scannerdaemon_t self:tcp_socket create_stream_socket_perms;
 allow scannerdaemon_t self:udp_socket create_socket_perms;
+allow scannerdaemon_t self:association { sendto recvfrom };
 
 allow scannerdaemon_t oav_update_var_lib_t:dir r_dir_perms;
 allow scannerdaemon_t oav_update_var_lib_t:file r_file_perms;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
