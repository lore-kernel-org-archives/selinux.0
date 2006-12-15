Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBF1n3hv016646
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:49:03 -0500
Received: from e2.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBF1na9T012910
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 01:49:36 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBF1nZ8J008542
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:49:35 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kBF1na4g294100
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:49:36 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kBF1nZlB030002
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:49:35 -0500
Date: Thu, 14 Dec 2006 19:35:44 -0600
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200612150135.kBF1Zis2002716@faith.austin.ibm.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/7] labeled ipsec policy changes
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

 amanda.if    |   36 ++++++++++++++++++++++++++++++++++++
 amanda.te    |    2 ++
 apt.if       |   18 ++++++++++++++++++
 apt.te       |    1 +
 backup.if    |   18 ++++++++++++++++++
 backup.te    |    1 +
 dpkg.if      |   19 +++++++++++++++++++
 dpkg.te      |    1 +
 firstboot.if |   18 ++++++++++++++++++
 firstboot.te |    1 +
 mrtg.if      |   18 ++++++++++++++++++
 mrtg.te      |    1 +
 netutils.if  |   55 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 netutils.te  |    3 +++
 portage.if   |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 rpm.if       |   18 ++++++++++++++++++
 rpm.te       |    1 +
 sxid.if      |   18 ++++++++++++++++++
 sxid.te      |    1 +
 vpn.if       |   18 ++++++++++++++++++
 vpn.te       |    2 ++

--------------------------------------------------------------------------
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/amanda.if serefpolicy-2.4.6.patchbox2/policy/modules/admin/amanda.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/amanda.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/amanda.if	2006-12-14 11:40:21.000000000 -0600
@@ -145,3 +145,39 @@ interface(`amanda_manage_lib',`
 	allow $1 amanda_usr_lib_t:dir manage_dir_perms;
 	files_search_usr($1)
 ')
+
+########################################
+## <summary>
+##      Receive messages from a
+##      labeled ipsec association.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+#
+interface(`amanda_recv_labeledipsec',`
+	gen_require(`
+		type amanda_t;
+	')
+	allow $1 amanda_t:association recvfrom;
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
+interface(`amanda_recv_labeledipsec_recover',`
+	gen_require(`
+		type amanda_recover_t;
+	')
+	allow $1 amanda_recover_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/amanda.te serefpolicy-2.4.6.patchbox2/policy/modules/admin/amanda.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/amanda.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/amanda.te	2006-12-14 11:40:21.000000000 -0600
@@ -76,6 +76,7 @@ allow amanda_t self:unix_dgram_socket cr
 allow amanda_t self:tcp_socket create_stream_socket_perms;
 allow amanda_t self:udp_socket create_socket_perms;
 allow amanda_t self:netlink_route_socket r_netlink_socket_perms;
+allow amanda_t self:association { sendto recvfrom };
 
 # access to amanda_amandates_t
 allow amanda_t amanda_amandates_t:file { getattr lock read write };
@@ -179,6 +180,7 @@ allow amanda_recover_t self:fifo_file { 
 allow amanda_recover_t self:unix_stream_socket { connect create read write };
 allow amanda_recover_t self:tcp_socket create_stream_socket_perms;
 allow amanda_recover_t self:udp_socket create_socket_perms;
+allow amanda_recover_t self:association { sendto recvfrom };
 
 allow amanda_recover_t amanda_log_t:dir rw_dir_perms;
 allow amanda_recover_t amanda_log_t:file manage_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/apt.if serefpolicy-2.4.6.patchbox2/policy/modules/admin/apt.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/apt.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/apt.if	2006-12-14 11:40:21.000000000 -0600
@@ -177,3 +177,21 @@ interface(`apt_dontaudit_manage_db',`
 	dontaudit $1 apt_var_lib_t:file create_file_perms;
 	dontaudit $1 apt_var_lib_t:lnk_file create_lnk_perms;
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
+interface(`apt_recv_labeledipsec',`
+	gen_require(`
+		type apt_t;
+	')
+	allow $1 apt_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/apt.te serefpolicy-2.4.6.patchbox2/policy/modules/admin/apt.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/apt.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/apt.te	2006-12-14 11:40:21.000000000 -0600
@@ -45,6 +45,7 @@ allow apt_t self:shm create_shm_perms;
 allow apt_t self:sem create_sem_perms;
 allow apt_t self:msgq create_msgq_perms;
 allow apt_t self:msg { send receive };
+allow apt_t self:association { sendto recvfrom };
 
 # Access /var/cache/apt files
 allow apt_t apt_var_cache_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/backup.if serefpolicy-2.4.6.patchbox2/policy/modules/admin/backup.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/backup.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/backup.if	2006-12-14 11:40:21.000000000 -0600
@@ -52,3 +52,21 @@ interface(`backup_run',`
 	role $2 types backup_t;
 	allow backup_t $3:chr_file rw_term_perms;
 ')
+
+########################################
+## <summary>
+##      Receive messages from a
+##      labeled ipsec association.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+#
+interface(`backup_recv_labeledipsec',`
+	gen_require(`
+		type backup_t;
+	')
+	allow $1 backup_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/backup.te serefpolicy-2.4.6.patchbox2/policy/modules/admin/backup.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/backup.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/backup.te	2006-12-14 11:40:21.000000000 -0600
@@ -25,6 +25,7 @@ allow backup_t self:process signal;
 allow backup_t self:fifo_file rw_file_perms;
 allow backup_t self:tcp_socket create_socket_perms;
 allow backup_t self:udp_socket create_socket_perms;
+allow backup_t self:association { sendto recvfrom };
 
 allow backup_t backup_store_t:dir ra_dir_perms;
 allow backup_t backup_store_t:file { create rw_file_perms setattr };
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/dpkg.if serefpolicy-2.4.6.patchbox2/policy/modules/admin/dpkg.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/dpkg.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/dpkg.if	2006-12-14 11:40:21.000000000 -0600
@@ -239,3 +239,22 @@ interface(`dpkg_lock_db',`
 	allow $1 dpkg_var_lib_t:dir r_dir_perms;
 	allow $1 dpkg_lock_t:file { getattr create read write append unlink lock };
 ')
+
+########################################
+## <summary>
+##      Receive messages from a
+##      labeled ipsec association.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+#
+interface(`dpkg_recv_labeledipsec',`
+	gen_require(`
+		type dpkg_t;
+	')
+	allow $1 dpkg_t:association recvfrom;
+')
+
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/dpkg.te serefpolicy-2.4.6.patchbox2/policy/modules/admin/dpkg.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/dpkg.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/dpkg.te	2006-12-14 11:40:21.000000000 -0600
@@ -66,6 +66,7 @@ allow dpkg_t self:shm create_shm_perms;
 allow dpkg_t self:sem create_sem_perms;
 allow dpkg_t self:msgq create_msgq_perms;
 allow dpkg_t self:msg { send receive };
+allow dpkg_t self:association { sendto recvfrom };
 
 allow dpkg_t dpkg_lock_t:file manage_file_perms;
 
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/firstboot.if serefpolicy-2.4.6.patchbox2/policy/modules/admin/firstboot.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/firstboot.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/firstboot.if	2006-12-14 11:40:21.000000000 -0600
@@ -111,3 +111,21 @@ interface(`firstboot_rw_pipes',`
 
 	allow $1 firstboot_t:fifo_file { read write };
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
+interface(`firstboot_recv_labeledipsec',`
+	gen_require(`
+		type firstboot_t;
+	')
+	allow $1 firstboot_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/firstboot.te serefpolicy-2.4.6.patchbox2/policy/modules/admin/firstboot.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/firstboot.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/firstboot.te	2006-12-14 11:40:21.000000000 -0600
@@ -32,6 +32,7 @@ allow firstboot_t self:fifo_file { getat
 allow firstboot_t self:tcp_socket create_stream_socket_perms;
 allow firstboot_t self:unix_stream_socket { connect create };
 allow firstboot_t self:passwd rootok;
+allow firstboot_t self:association { sendto recvfrom };
 
 allow firstboot_t firstboot_etc_t:file { getattr read };
 
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/mrtg.if serefpolicy-2.4.6.patchbox2/policy/modules/admin/mrtg.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/mrtg.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/mrtg.if	2006-12-14 11:40:21.000000000 -0600
@@ -17,3 +17,21 @@ interface(`mrtg_append_create_logs',`
 	allow $1 mrtg_log_t:dir rw_dir_perms;
 	allow $1 mrtg_log_t:file { create append getattr };
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
+interface(`mrtg_recv_labeledipsec',`
+	gen_require(`
+		type mrtg_t;
+	')
+	allow $1 mrtg_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/mrtg.te serefpolicy-2.4.6.patchbox2/policy/modules/admin/mrtg.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/mrtg.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/mrtg.te	2006-12-14 11:40:21.000000000 -0600
@@ -37,6 +37,7 @@ allow mrtg_t self:fifo_file { getattr re
 allow mrtg_t self:unix_stream_socket create_socket_perms;
 allow mrtg_t self:tcp_socket create_socket_perms;
 allow mrtg_t self:udp_socket create_socket_perms;
+allow mrtg_t self:association { sendto recvfrom };
 
 allow mrtg_t mrtg_etc_t:file r_file_perms;
 allow mrtg_t mrtg_etc_t:dir r_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/netutils.if serefpolicy-2.4.6.patchbox2/policy/modules/admin/netutils.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/netutils.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/netutils.if	2006-12-14 11:40:21.000000000 -0600
@@ -73,6 +73,25 @@ interface(`netutils_exec',`
 	can_exec($1,netutils_exec_t)
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
+interface(`netutils_recv_labeledipsec',`
+	gen_require(`
+		type netutils_t;
+	')
+	allow $1 netutils_t:association recvfrom;
+')
+
 ########################################
 ## <summary>
 ##	Execute ping in the ping domain.
@@ -220,6 +239,24 @@ interface(`netutils_exec_ping',`
 
 ########################################
 ## <summary>
+##	Receive messages from a
+##	labeled ipsec association.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`netutils_recv_labeledipsec_ping',`
+	gen_require(`
+		type ping_t;
+	')
+	allow $1 ping_t:association recvfrom;
+')
+
+########################################
+## <summary>
 ##	Execute traceroute in the traceroute domain.
 ## </summary>
 ## <param name="domain">
@@ -326,3 +363,21 @@ interface(`netutils_exec_traceroute',`
 
 	can_exec($1,traceroute_exec_t)
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
+interface(`netutils_recv_labeledipsec_traceroute',`
+	gen_require(`
+		type traceroute_t;
+	')
+	allow $1 traceroute_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/netutils.te serefpolicy-2.4.6.patchbox2/policy/modules/admin/netutils.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/netutils.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/netutils.te	2006-12-14 11:40:21.000000000 -0600
@@ -38,6 +38,7 @@ allow netutils_t self:netlink_route_sock
 allow netutils_t self:packet_socket create_socket_perms;
 allow netutils_t self:udp_socket create_socket_perms;
 allow netutils_t self:tcp_socket create_stream_socket_perms;
+allow netutils_t self:association { sendto recvfrom };
 
 allow netutils_t netutils_tmp_t:dir create_dir_perms;
 allow netutils_t netutils_tmp_t:file create_file_perms;
@@ -104,6 +105,7 @@ dontaudit ping_t self:capability sys_tty
 allow ping_t self:tcp_socket create_socket_perms;
 allow ping_t self:rawip_socket { create ioctl read write bind getopt setopt };
 allow ping_t self:packet_socket { create ioctl read write bind getopt setopt };
+allow ping_t self:association { sendto recvfrom }; 
 
 corenet_non_ipsec_sendrecv(ping_t)
 corenet_tcp_sendrecv_all_if(ping_t)
@@ -169,6 +171,7 @@ allow traceroute_t self:rawip_socket cre
 allow traceroute_t self:packet_socket create_socket_perms;
 allow traceroute_t self:netlink_route_socket { bind create getattr nlmsg_read read write };
 allow traceroute_t self:udp_socket create_socket_perms;
+allow traceroute_t self:association { sendto recvfrom };
 
 kernel_read_system_state(traceroute_t)
 kernel_read_network_state(traceroute_t)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/portage.if serefpolicy-2.4.6.patchbox2/policy/modules/admin/portage.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/portage.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/portage.if	2006-12-14 11:40:21.000000000 -0600
@@ -119,6 +119,7 @@ interface(`portage_compile_domain',`
 	# needed for merging dbus:
 	allow $1 self:netlink_selinux_socket { bind create read };
 	allow $1 self:dbus send_msg;
+	allow $1 self:association { sendto recvfrom };
 
 	allow $1 portage_devpts_t:chr_file { rw_file_perms setattr };
 	term_create_pty($1,portage_devpts_t)
@@ -227,6 +228,7 @@ interface(`portage_fetch_domain',`
 	allow $1 self:process signal;
 	allow $1 self:unix_stream_socket create_socket_perms;
 	allow $1 self:tcp_socket create_stream_socket_perms;
+	allow $1 self:association { sendto recvfrom };
 
 	allow $1 portage_conf_t:dir list_dir_perms;
 	allow $1 portage_conf_t:file read_file_perms;
@@ -410,3 +412,57 @@ interface(`portage_run_gcc_config',`
 	role $2 types gcc_config_t;
 	allow gcc_config_t $3:chr_file rw_term_perms;
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
+interface(`portage_recv_labeledipsec',`
+	gen_require(`
+		type portage_t;
+	')
+	allow $1 portage_t:association recvfrom;
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
+interface(`portage_recv_labeledipsec_merge',`
+	gen_require(`
+		type portage_t.merge;
+	')
+	allow $1 portage_t.merge:association recvfrom;
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
+interface(`portage_recv_labeledipsec_sandbox',`
+	gen_require(`
+		type portage_t.sandbox;
+	')
+	allow $1 portage_t.sandbox:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/rpm.if serefpolicy-2.4.6.patchbox2/policy/modules/admin/rpm.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/rpm.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/rpm.if	2006-12-14 11:40:21.000000000 -0600
@@ -302,3 +302,21 @@ interface(`rpm_transition_script',`
 	allow rpm_script_t $1:fifo_file rw_file_perms;
 	allow rpm_script_t $1:process sigchld;
 ')
+
+########################################
+## <summary>
+##      Receive messages from a
+##      labeled ipsec association.
+## </summary>
+## <param name="domain">
+##      <summary>
+##      Domain allowed access.
+##      </summary>
+## </param>
+#
+interface(`rpm_recv_labeledipsec',`
+	gen_require(`
+		type rpm_t;
+	')
+	allow $1 rpm_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/rpm.te serefpolicy-2.4.6.patchbox2/policy/modules/admin/rpm.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/rpm.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/rpm.te	2006-12-14 11:40:21.000000000 -0600
@@ -72,6 +72,7 @@ allow rpm_t self:msgq create_msgq_perms;
 allow rpm_t self:msg { send receive };
 allow rpm_t self:dir search;
 allow rpm_t self:file rw_file_perms;;
+allow rpm_t self:association { sendto recvfrom };
 
 allow rpm_t rpm_tmp_t:dir create_dir_perms;
 allow rpm_t rpm_tmp_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/sxid.if serefpolicy-2.4.6.patchbox2/policy/modules/admin/sxid.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/sxid.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/sxid.if	2006-12-14 11:40:21.000000000 -0600
@@ -20,3 +20,21 @@ interface(`sxid_read_log',`
 	logging_search_logs($1)
 	allow $1 sxid_log_t:file r_file_perms;
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
+interface(`sxid_recv_labeledipsec',`
+	gen_require(`
+		type sxid_t;
+	')
+	allow $1 sxid_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/sxid.te serefpolicy-2.4.6.patchbox2/policy/modules/admin/sxid.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/sxid.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/sxid.te	2006-12-14 11:40:21.000000000 -0600
@@ -28,6 +28,7 @@ allow sxid_t self:process signal_perms;
 allow sxid_t self:fifo_file rw_file_perms;
 allow sxid_t self:tcp_socket create_stream_socket_perms;
 allow sxid_t self:udp_socket create_socket_perms;
+allow sxid_t self:association { sendto recvfrom };
 
 allow sxid_t sxid_log_t:file create_file_perms;
 logging_log_filetrans(sxid_t,sxid_log_t,file)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/vpn.if serefpolicy-2.4.6.patchbox2/policy/modules/admin/vpn.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/vpn.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/vpn.if	2006-12-14 11:40:21.000000000 -0600
@@ -72,3 +72,21 @@ interface(`vpn_signal',`
 
 	allow $1 vpnc_t:process signal;
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
+interface(`vpn_recv_labeledipsec',`
+	gen_require(`
+		type vpnc_t;
+	')
+	allow $1 vpnc_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/admin/vpn.te serefpolicy-2.4.6.patchbox2/policy/modules/admin/vpn.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/admin/vpn.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/admin/vpn.te	2006-12-14 11:40:21.000000000 -0600
@@ -36,6 +36,8 @@ allow vpnc_t self:unix_stream_socket cre
 # cjp: this needs to be fixed
 allow vpnc_t self:socket create_socket_perms;
 
+allow vpnc_t self:association { sendto recvfrom };
+
 allow vpnc_t vpnc_tmp_t:dir create_dir_perms;
 allow vpnc_t vpnc_tmp_t:file create_file_perms;
 files_tmp_filetrans(vpnc_t, vpnc_tmp_t, { file dir })


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
