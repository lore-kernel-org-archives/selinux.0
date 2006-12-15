Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBF1tmVc016985
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:55:48 -0500
Received: from e3.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBF1uL9T014434
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 01:56:21 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBF1uHdC016477
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:56:17 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kBF1uHZC201382
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:56:17 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kBF1uHqc002240
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:56:17 -0500
Date: Thu, 14 Dec 2006 19:42:26 -0600
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200612150142.kBF1gQwM002782@faith.austin.ibm.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 6/7] labeled ipsec policy changes
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

 hotplug.if    |   18 ++++++++++++++++++
 hotplug.te    |    1 +
 init.if       |   18 ++++++++++++++++++
 init.te       |    1 +
 iscsi.if      |   18 ++++++++++++++++++
 iscsi.te      |    1 +
 logging.if    |   18 ++++++++++++++++++
 logging.te    |    1 +
 lvm.if        |   17 +++++++++++++++++
 lvm.te        |    1 +
 sysnetwork.if |   18 ++++++++++++++++++
 sysnetwork.te |    1 +
 xen.if        |   18 ++++++++++++++++++
 xen.te        |    1 +
 14 files changed, 132 insertions(+)

-------------------------------------------------------------------

diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/system/hotplug.if serefpolicy-2.4.6.patchbox2/policy/modules/system/hotplug.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/system/hotplug.if	2006-12-14 11:43:26.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/system/hotplug.if	2006-12-14 11:40:21.000000000 -0600
@@ -178,3 +178,21 @@ interface(`hotplug_search_pids',`
 	allow $1 hotplug_var_run_t:dir search_dir_perms;
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
+interface(`hotplug_recv_labeledipsec',`
+	gen_require(`
+		type hotplug_t;
+	')
+	allow $1 hotplug_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/system/hotplug.te serefpolicy-2.4.6.patchbox2/policy/modules/system/hotplug.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/system/hotplug.te	2006-12-14 11:43:26.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/system/hotplug.te	2006-12-14 11:40:21.000000000 -0600
@@ -32,6 +32,7 @@ allow hotplug_t self:fifo_file rw_file_p
 allow hotplug_t self:netlink_route_socket r_netlink_socket_perms;
 allow hotplug_t self:udp_socket create_socket_perms;
 allow hotplug_t self:tcp_socket connected_stream_socket_perms;
+allow hotplug_t self:association { sendto recvfrom };
 
 allow hotplug_t hotplug_etc_t:file r_file_perms;
 allow hotplug_t hotplug_etc_t:dir r_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/system/init.if serefpolicy-2.4.6.patchbox2/policy/modules/system/init.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/system/init.if	2006-12-14 11:43:26.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/system/init.if	2006-12-14 11:40:21.000000000 -0600
@@ -1311,3 +1311,21 @@ interface(`init_manage_utmp',`
 	files_search_pids($1)
 	allow $1 initrc_var_run_t:file create_file_perms;
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
+interface(`init_recv_labeledipsec',`
+	gen_require(`
+		type initrc_t;
+	')
+	allow $1 initrc_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/system/init.te serefpolicy-2.4.6.patchbox2/policy/modules/system/init.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/system/init.te	2006-12-14 11:43:26.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/system/init.te	2006-12-14 11:40:21.000000000 -0600
@@ -201,6 +201,7 @@ allow initrc_t self:tcp_socket create_st
 allow initrc_t self:udp_socket create_socket_perms;
 allow initrc_t self:fifo_file rw_file_perms;
 allow initrc_t self:netlink_route_socket r_netlink_socket_perms;
+allow initrc_t self:association { sendto recvfrom };
 
 allow initrc_t initrc_devpts_t:chr_file rw_term_perms;
 term_create_pty(initrc_t,initrc_devpts_t)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/system/iscsi.if serefpolicy-2.4.6.patchbox2/policy/modules/system/iscsi.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/system/iscsi.if	2006-12-14 11:43:26.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/system/iscsi.if	2006-12-14 11:40:21.000000000 -0600
@@ -20,3 +20,21 @@ interface(`iscsid_domtrans',`
 	allow iscsid_t $1:fifo_file rw_file_perms;
 	allow iscsid_t $1:process sigchld;
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
+interface(`iscsid_recv_labeledipsec',`
+	gen_require(`
+		type iscsid_t;
+	')
+	allow $1 iscsid_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/system/iscsi.te serefpolicy-2.4.6.patchbox2/policy/modules/system/iscsi.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/system/iscsi.te	2006-12-14 11:43:26.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/system/iscsi.te	2006-12-14 11:40:21.000000000 -0600
@@ -38,6 +38,7 @@ allow iscsid_t self:shm create_shm_perms
 allow iscsid_t self:netlink_socket create_socket_perms;
 allow iscsid_t self:netlink_route_socket rw_netlink_socket_perms;
 allow iscsid_t self:tcp_socket create_stream_socket_perms;
+allow iscsid_t self:association { sendto recvfrom };
 
 allow iscsid_t iscsi_lock_t:file manage_file_perms;
 files_lock_filetrans(iscsid_t,iscsi_lock_t,file)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/system/logging.if serefpolicy-2.4.6.patchbox2/policy/modules/system/logging.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/system/logging.if	2006-12-14 11:43:26.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/system/logging.if	2006-12-14 11:40:21.000000000 -0600
@@ -583,3 +583,21 @@ interface(`logging_manage_generic_logs',
 	allow $1 var_log_t:dir rw_dir_perms;
 	allow $1 var_log_t:file create_file_perms;
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
+interface(`logging_recv_labeledipsec',`
+	gen_require(`
+		type syslogd_t;
+	')
+	allow $1 syslogd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/system/logging.te serefpolicy-2.4.6.patchbox2/policy/modules/system/logging.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/system/logging.te	2006-12-14 11:43:26.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/system/logging.te	2006-12-14 11:40:21.000000000 -0600
@@ -276,6 +276,7 @@ allow syslogd_t self:unix_stream_socket 
 allow syslogd_t self:unix_dgram_socket sendto;
 allow syslogd_t self:fifo_file rw_file_perms;
 allow syslogd_t self:udp_socket create_socket_perms;
+allow syslogd_t self:association { sendto recvfrom };
 
 # Create and bind to /dev/log or /var/run/log.
 allow syslogd_t devlog_t:sock_file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/system/lvm.if serefpolicy-2.4.6.patchbox2/policy/modules/system/lvm.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/system/lvm.if	2006-12-14 11:43:26.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/system/lvm.if	2006-12-14 11:40:21.000000000 -0600
@@ -76,3 +76,20 @@ interface(`lvm_read_config',`
 	allow $1 lvm_etc_t:file r_file_perms;
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
+interface(`lvm_recv_labeledipsec',`
+	gen_require(`
+		type lvm_t;
+	')
+	allow $1 lvm_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/system/lvm.te serefpolicy-2.4.6.patchbox2/policy/modules/system/lvm.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/system/lvm.te	2006-12-14 11:43:26.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/system/lvm.te	2006-12-14 11:40:21.000000000 -0600
@@ -53,6 +53,7 @@ allow clvmd_t self:fifo_file rw_file_per
 allow clvmd_t self:unix_stream_socket { connectto create_stream_socket_perms };
 allow clvmd_t self:tcp_socket create_stream_socket_perms;
 allow clvmd_t self:udp_socket create_socket_perms;
+allow clvmd_t self:association { sendto recvfrom };
 
 allow clvmd_t clvmd_var_run_t:file create_file_perms;
 allow clvmd_t clvmd_var_run_t:dir rw_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/system/sysnetwork.if serefpolicy-2.4.6.patchbox2/policy/modules/system/sysnetwork.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/system/sysnetwork.if	2006-12-14 11:43:26.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/system/sysnetwork.if	2006-12-14 11:40:21.000000000 -0600
@@ -565,3 +565,21 @@ interface(`sysnet_use_portmap',`
 	files_search_etc($1)
 	allow $1 net_conf_t:file r_file_perms;
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
+interface(`sysnet_recv_labeledipsec_dhcpc',`
+	gen_require(`
+		type dhcpc_t;
+	')
+	allow $1 dhcpc_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/system/sysnetwork.te serefpolicy-2.4.6.patchbox2/policy/modules/system/sysnetwork.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/system/sysnetwork.te	2006-12-14 11:43:26.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/system/sysnetwork.te	2006-12-14 11:40:21.000000000 -0600
@@ -51,6 +51,7 @@ allow dhcpc_t self:tcp_socket create_str
 allow dhcpc_t self:udp_socket create_socket_perms;
 allow dhcpc_t self:packet_socket create_socket_perms;
 allow dhcpc_t self:netlink_route_socket { create_socket_perms nlmsg_read };
+allow dhcpc_t self:association { sendto recvfrom };
 
 allow dhcpc_t dhcp_etc_t:dir r_dir_perms;
 allow dhcpc_t dhcp_etc_t:lnk_file r_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/system/xen.if serefpolicy-2.4.6.patchbox2/policy/modules/system/xen.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/system/xen.if	2006-12-14 11:43:26.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/system/xen.if	2006-12-14 11:40:21.000000000 -0600
@@ -163,3 +163,21 @@ interface(`xen_domtrans_xm',`
 	allow xm_t $1:fifo_file rw_file_perms;
 	allow xm_t $1:process sigchld;
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
+interface(`xen_recv_labeledipsec',`
+	gen_require(`
+		type xend_t;
+	')
+	allow $1 xend_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/system/xen.te serefpolicy-2.4.6.patchbox2/policy/modules/system/xen.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/system/xen.te	2006-12-14 11:43:26.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/system/xen.te	2006-12-14 11:40:21.000000000 -0600
@@ -85,6 +85,7 @@ allow xend_t self:unix_dgram_socket crea
 allow xend_t self:netlink_route_socket r_netlink_socket_perms;
 allow xend_t self:tcp_socket create_stream_socket_perms;
 allow xend_t self:packet_socket create_socket_perms;
+allow xend_t self:association { sendto recvfrom };
 
 allow xend_t xen_image_t:dir create_dir_perms;
 allow xend_t xen_image_t:file create_file_perms;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
