Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBF1tHqf016962
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:55:17 -0500
Received: from e36.co.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBF1tm9T014336
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 01:55:48 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBF1tmXH025685
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 20:55:48 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kBF1tlVA541446
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 18:55:47 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kBF1tlZq004042
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 18:55:47 -0700
Date: Thu, 14 Dec 2006 19:41:56 -0600
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200612150141.kBF1fumq002774@faith.austin.ibm.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 5/7] labeled ipsec policy changes
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

 openvpn.if        |   18 +++
 openvpn.te        |    1 
 pcscd.if          |   18 +++
 pegasus.if        |   18 +++
 pegasus.te        |    1 
 perdition.if      |   18 +++
 perdition.te      |    1 
 portmap.if        |   36 +++++++
 portmap.te        |    2 
 portslave.if      |   18 +++
 portslave.te      |    1 
 postfix.if        |  254 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 postfix.te        |    2 
 postgresql.if     |   18 +++
 postgresql.te     |    1 
 postgrey.if       |   18 +++
 postgrey.te       |    1 
 ppp.if            |   36 +++++++
 ppp.te            |    2 
 privoxy.if        |   18 +++
 privoxy.te        |    1 
 procmail.if       |   18 +++
 procmail.te       |    1 
 pyzor.if          |   18 +++
 pyzor.te          |    1 
 qmail.if          |   18 +++
 qmail.te          |    1 
 radius.if         |   18 +++
 radius.te         |    1 
 radvd.if          |   18 +++
 radvd.te          |    1 
 razor.if          |   37 +++++++
 razor.te          |    1 
 rdisc.if          |   18 +++
 rdisc.te          |    1 
 rhgb.if           |   18 +++
 rhgb.te           |    1 
 ricci.if          |   18 +++
 ricci.te          |    1 
 rlogin.if         |   18 +++
 rlogin.te         |    1 
 roundup.if        |   18 +++
 roundup.te        |    1 
 rpc.if            |   55 +++++++++++
 rshd.if           |   18 +++
 rshd.te           |    1 
 rsync.if          |   18 +++
 rsync.te          |    1 
 samba.if          |  108 ++++++++++++++++++++++
 samba.te          |    6 +
 sasl.if           |   18 +++
 sasl.te           |    1 
 sendmail.if       |   18 +++
 sendmail.te       |    1 
 setroubleshoot.if |   18 +++
 setroubleshoot.te |    1 
 smartmon.if       |   18 +++
 smartmon.te       |    1 
 snmp.if           |   18 +++
 snmp.te           |    1 
 snort.if          |   18 +++
 snort.te          |    1 
 soundserver.if    |   18 +++
 soundserver.te    |    1 
 spamassassin.if   |   39 ++++++++
 spamassassin.te   |    1 
 squid.if          |   18 +++
 squid.te          |    1 
 ssh.if            |   36 +++++++
 stunnel.if        |   18 +++
 stunnel.te        |    1 
 tcpd.if           |   18 +++
 tcpd.te           |    1 
 telnet.if         |   18 +++
 telnet.te         |    1 
 tftp.if           |   18 +++
 tftp.te           |    1 
 timidity.if       |   18 +++
 timidity.te       |    1 
 tor.if            |   18 +++
 tor.te            |    1 
 transproxy.if     |   18 +++
 transproxy.te     |    1 
 ucspitcp.if       |   36 +++++++
 ucspitcp.te       |    1 
 uucp.if           |   36 +++++++
 uucp.te           |    1 
 uwimap.if         |   18 +++
 uwimap.te         |    1 
 watchdog.if       |   18 +++
 watchdog.te       |    1 
 xprint.if         |   18 +++
 xprint.te         |    1 
 xserver.if        |   36 +++++++
 xserver.te        |    1 
 zebra.if          |   18 +++
 zebra.te          |    1 
 97 files changed, 1466 insertions(+)

---------------------------------------------------------------------

diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/openvpn.if serefpolicy-2.4.6.patchbox2/policy/modules/services/openvpn.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/openvpn.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/openvpn.if	2006-12-14 11:40:21.000000000 -0600
@@ -22,3 +22,21 @@ interface(`openvpn_read_config',`
 	allow $1 openvpn_etc_t:file r_file_perms;
 	allow $1 openvpn_etc_t:lnk_file { getattr read };
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
+interface(`openvpn_recv_labeledipsec',`
+	gen_require(`
+		type openvpn_t;
+	')
+	allow $1 openvpn_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/openvpn.te serefpolicy-2.4.6.patchbox2/policy/modules/services/openvpn.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/openvpn.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/openvpn.te	2006-12-14 11:40:21.000000000 -0600
@@ -34,6 +34,7 @@ allow openvpn_t self:unix_stream_socket 
 allow openvpn_t self:udp_socket create_socket_perms;
 allow openvpn_t self:tcp_socket create_socket_perms;
 allow openvpn_t self:netlink_route_socket rw_netlink_socket_perms;
+allow openvpn_t self:association { sendto recvfrom };
 
 allow openvpn_t openvpn_etc_t:dir r_dir_perms;
 allow openvpn_t openvpn_etc_t:file r_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/pcscd.if serefpolicy-2.4.6.patchbox2/policy/modules/services/pcscd.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/pcscd.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/pcscd.if	2006-12-14 11:40:21.000000000 -0600
@@ -21,3 +21,21 @@ interface(`pcscd_domtrans',`
 	allow pcscd_t $1:fifo_file rw_file_perms;
 	allow pcscd_t $1:process sigchld;
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
+interface(`pcscd_recv_labeledipsec',`
+	gen_require(`
+		type pcscd_t;
+	')
+	allow $1 pcscd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/pegasus.if serefpolicy-2.4.6.patchbox2/policy/modules/services/pegasus.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/pegasus.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/pegasus.if	2006-12-14 11:40:21.000000000 -0600
@@ -30,3 +30,21 @@ interface(`pegasus_domtrans',`
 	allow pegasus_t $1:fifo_file rw_file_perms;
 	allow pegasus_t $1:process sigchld;
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
+interface(`pegasus_recv_labeledipsec',`
+	gen_require(`
+		type pegasus_t;
+	')
+	allow $1 pegasus_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/pegasus.te serefpolicy-2.4.6.patchbox2/policy/modules/services/pegasus.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/pegasus.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/pegasus.te	2006-12-14 11:40:21.000000000 -0600
@@ -38,6 +38,7 @@ allow pegasus_t self:unix_dgram_socket c
 allow pegasus_t self:unix_stream_socket create_stream_socket_perms;
 allow pegasus_t self:netlink_audit_socket { create_netlink_socket_perms nlmsg_relay };
 allow pegasus_t self:tcp_socket create_stream_socket_perms;
+allow pegasus_t self:association { sendto recvfrom };
 
 allow pegasus_t pegasus_conf_t:dir rw_dir_perms;
 allow pegasus_t pegasus_conf_t:file { r_file_perms link unlink };
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/perdition.if serefpolicy-2.4.6.patchbox2/policy/modules/services/perdition.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/perdition.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/perdition.if	2006-12-14 11:40:21.000000000 -0600
@@ -13,3 +13,21 @@
 interface(`perdition_tcp_connect',`
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
+interface(`perdition_recv_labeledipsec',`
+	gen_require(`
+		type perdition_t;
+	')
+	allow $1 perdition_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/perdition.te serefpolicy-2.4.6.patchbox2/policy/modules/services/perdition.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/perdition.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/perdition.te	2006-12-14 11:40:21.000000000 -0600
@@ -26,6 +26,7 @@ dontaudit perdition_t self:capability sy
 allow perdition_t self:process signal_perms;
 allow perdition_t self:tcp_socket create_stream_socket_perms;
 allow perdition_t self:udp_socket create_socket_perms;
+allow perdition_t self:association { sendto recvfrom };
 
 allow perdition_t perdition_etc_t:file { getattr read };
 files_search_etc(perdition_t)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/portmap.if serefpolicy-2.4.6.patchbox2/policy/modules/services/portmap.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/portmap.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/portmap.if	2006-12-14 11:40:21.000000000 -0600
@@ -98,3 +98,39 @@ interface(`portmap_udp_chat',`
 interface(`portmap_tcp_connect',`
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
+interface(`portmap_recv_labeledipsec',`
+	gen_require(`
+		type portmap_t;
+	')
+	allow $1 portmap_t:association recvfrom;
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
+interface(`portmap_recv_labeledipsec_helper',`
+	gen_require(`
+		type portmap_helper_t;
+	')
+	allow $1 portmap_helper_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/portmap.te serefpolicy-2.4.6.patchbox2/policy/modules/services/portmap.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/portmap.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/portmap.te	2006-12-14 11:40:21.000000000 -0600
@@ -33,6 +33,7 @@ allow portmap_t self:unix_dgram_socket c
 allow portmap_t self:unix_stream_socket create_stream_socket_perms;
 allow portmap_t self:tcp_socket create_stream_socket_perms;
 allow portmap_t self:udp_socket create_socket_perms;
+allow portmap_t self:association { sendto recvfrom };
 
 allow portmap_t portmap_tmp_t:dir create_dir_perms;
 allow portmap_t portmap_tmp_t:file create_file_perms;
@@ -125,6 +126,7 @@ dontaudit portmap_helper_t self:capabili
 allow portmap_helper_t self:netlink_route_socket r_netlink_socket_perms;
 allow portmap_helper_t self:tcp_socket create_stream_socket_perms;
 allow portmap_helper_t self:udp_socket create_socket_perms;
+allow portmap_helper_t self:association { sendto recvfrom };
 
 allow portmap_helper_t portmap_var_run_t:file create_file_perms;
 files_pid_filetrans(portmap_helper_t,portmap_var_run_t,file)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/portslave.if serefpolicy-2.4.6.patchbox2/policy/modules/services/portslave.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/portslave.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/portslave.if	2006-12-14 11:40:21.000000000 -0600
@@ -22,3 +22,21 @@ interface(`portslave_domtrans',`
 	allow portslave_t $1:fifo_file rw_file_perms;
 	allow portslave_t $1:process sigchld;
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
+interface(`portslave_recv_labeledipsec',`
+	gen_require(`
+		type portslave_t;
+	')
+	allow $1 portslave_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/portslave.te serefpolicy-2.4.6.patchbox2/policy/modules/services/portslave.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/portslave.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/portslave.te	2006-12-14 11:40:21.000000000 -0600
@@ -41,6 +41,7 @@ allow portslave_t self:msgq create_msgq_
 allow portslave_t self:msg { send receive };
 allow portslave_t self:tcp_socket create_stream_socket_perms;
 allow portslave_t self:udp_socket create_socket_perms;
+allow portslave_t self:association { sendto recvfrom };
 
 allow portslave_t portslave_etc_t:dir r_dir_perms;
 allow portslave_t portslave_etc_t:file r_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/postfix.if serefpolicy-2.4.6.patchbox2/policy/modules/services/postfix.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/postfix.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/postfix.if	2006-12-14 11:40:21.000000000 -0600
@@ -128,6 +128,7 @@ template(`postfix_server_domain_template
 	allow postfix_$1_t postfix_master_t:unix_stream_socket { connectto rw_stream_socket_perms };
 	allow postfix_$1_t self:tcp_socket create_socket_perms;
 	allow postfix_$1_t self:udp_socket create_socket_perms;
+	allow postfix_$1_t self:association { sendto recvfrom };
 
 	domain_auto_trans(postfix_master_t, postfix_$1_exec_t, postfix_$1_t)
 	allow postfix_master_t postfix_$1_t:fd use;
@@ -484,3 +485,256 @@ interface(`postfix_domtrans_user_mail_ha
 
 	typeattribute $1 postfix_user_domtrans;
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
+interface(`postfix_recv_labeledipsec_master',`
+	gen_require(`
+		type postfix_master_t;
+	')
+	allow $1 postfix_master_t:association recvfrom;
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
+interface(`postfix_recv_labeledipsec_map',`
+	gen_require(`
+		type postfix_map_t;
+	')
+	allow $1 postfix_map_t:association recvfrom;
+')
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
+interface(`postfix_recv_labeledipsec_postdrop',`
+	gen_require(`
+		type postfix_postdrop_t;
+	')
+	allow $1 postfix_postdrop_t:association recvfrom;
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
+interface(`postfix_recv_labeledipsec_postqueue',`
+	gen_require(`
+		type postfix_postqueue_t;
+	')
+	allow $1 postfix_postqueue_t:association recvfrom;
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
+interface(`postfix_recv_labeledipsec_showq',`
+	gen_require(`
+		type postfix_showq_t;
+	')
+	allow $1 postfix_showq_t:association recvfrom;
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
+interface(`postfix_recv_labeledipsec_bounce',`
+	gen_require(`
+		type postfix_bounce_t;
+	')
+	allow $1 postfix_bounce_t:association recvfrom;
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
+interface(`postfix_recv_labeledipsec_cleanup',`
+	gen_require(`
+		type postfix_cleanup_t;
+	')
+	allow $1 postfix_cleanup_t:association recvfrom;
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
+interface(`postfix_recv_labeledipsec_local',`
+	gen_require(`
+		type postfix_local_t;
+	')
+	allow $1 postfix_local_t:association recvfrom;
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
+interface(`postfix_recv_labeledipsec_pickup',`
+	gen_require(`
+		type postfix_pickup_t;
+	')
+	allow $1 postfix_pickup_t:association recvfrom;
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
+interface(`postfix_recv_labeledipsec_pipe',`
+	gen_require(`
+		type postfix_pipe_t;
+	')
+	allow $1 postfix_pipe_t:association recvfrom;
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
+interface(`postfix_recv_labeledipsec_qmgr',`
+	gen_require(`
+		type postfix_qmgr_t;
+	')
+	allow $1 postfix_qmgr_t:association recvfrom;
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
+interface(`postfix_recv_labeledipsec_smtp',`
+	gen_require(`
+		type postfix_smtp_t;
+	')
+	allow $1 postfix_smtp_t:association recvfrom;
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
+interface(`postfix_recv_labeledipsec_smtpd',`
+	gen_require(`
+		type postfix_smtpd_t;
+	')
+	allow $1 postfix_smtpd_t:association recvfrom;
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
+interface(`postfix_recv_labeledipsec_tmpl',`
+	gen_require(`
+		type postfix_$1_t;
+	')
+	allow $2 postfix_$1_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/postfix.te serefpolicy-2.4.6.patchbox2/policy/modules/services/postfix.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/postfix.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/postfix.te	2006-12-14 11:40:21.000000000 -0600
@@ -94,6 +94,7 @@ allow postfix_master_t self:capability {
 allow postfix_master_t self:fifo_file rw_file_perms;
 allow postfix_master_t self:tcp_socket create_stream_socket_perms;
 allow postfix_master_t self:udp_socket create_socket_perms;
+allow postfix_master_t self:association { sendto recvfrom };
 
 allow postfix_master_t postfix_etc_t:file rw_file_perms;
 
@@ -314,6 +315,7 @@ allow postfix_map_t self:unix_stream_soc
 allow postfix_map_t self:unix_dgram_socket create_socket_perms;
 allow postfix_map_t self:tcp_socket create_stream_socket_perms;
 allow postfix_map_t self:udp_socket create_socket_perms;
+allow postfix_map_t self:association { sendto recvfrom };
 
 allow postfix_map_t postfix_etc_t:dir create_dir_perms;
 allow postfix_map_t postfix_etc_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/postgresql.if serefpolicy-2.4.6.patchbox2/policy/modules/services/postgresql.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/postgresql.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/postgresql.if	2006-12-14 11:40:21.000000000 -0600
@@ -118,3 +118,21 @@ interface(`postgresql_stream_connect',`
         # Some versions of postgresql put the sock file in /tmp
 	allow $1 postgresql_tmp_t:sock_file write;
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
+interface(`postgresql_recv_labeledipsec',`
+	gen_require(`
+		type postgresql_t;
+	')
+	allow $1 postgresql_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/postgresql.te serefpolicy-2.4.6.patchbox2/policy/modules/services/postgresql.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/postgresql.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/postgresql.te	2006-12-14 11:40:21.000000000 -0600
@@ -43,6 +43,7 @@ allow postgresql_t self:udp_socket creat
 allow postgresql_t self:unix_dgram_socket create_socket_perms;
 allow postgresql_t self:unix_stream_socket create_stream_socket_perms;
 allow postgresql_t self:netlink_route_socket r_netlink_socket_perms;
+allow postgresql_t self:association { sendto recvfrom };
 
 allow postgresql_t postgresql_db_t:dir create_dir_perms;
 allow postgresql_t postgresql_db_t:fifo_file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/postgrey.if serefpolicy-2.4.6.patchbox2/policy/modules/services/postgrey.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/postgrey.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/postgrey.if	2006-12-14 11:40:21.000000000 -0600
@@ -19,3 +19,21 @@ interface(`postgrey_stream_connect',`
         allow $1 postgrey_var_run_t:sock_file write;
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
+interface(`postgrey_recv_labeledipsec',`
+	gen_require(`
+		type postgrey_t;
+	')
+	allow $1 postgrey_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/postgrey.te serefpolicy-2.4.6.patchbox2/policy/modules/services/postgrey.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/postgrey.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/postgrey.te	2006-12-14 11:40:21.000000000 -0600
@@ -28,6 +28,7 @@ allow postgrey_t self:capability { chown
 dontaudit postgrey_t self:capability sys_tty_config;
 allow postgrey_t self:process signal_perms;
 allow postgrey_t self:tcp_socket create_stream_socket_perms;
+allow postgrey_t self:association { sendto recvfrom };
 
 allow postgrey_t postgrey_etc_t:file r_file_perms;
 allow postgrey_t postgrey_etc_t:dir r_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ppp.if serefpolicy-2.4.6.patchbox2/policy/modules/services/ppp.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ppp.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ppp.if	2006-12-14 11:40:21.000000000 -0600
@@ -255,3 +255,39 @@ interface(`ppp_pid_filetrans',`
 
 	files_pid_filetrans($1,pppd_var_run_t,file)
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
+interface(`ppp_recv_labeledipsec',`
+	gen_require(`
+		type pppd_t;
+	')
+	allow $1 pppd_t:association recvfrom;
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
+interface(`ppp_recv_labeledipsec_pptp',`
+	gen_require(`
+		type pptp_t;
+	')
+	allow $1 pptp_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ppp.te serefpolicy-2.4.6.patchbox2/policy/modules/services/ppp.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ppp.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ppp.te	2006-12-14 11:40:21.000000000 -0600
@@ -68,6 +68,7 @@ allow pppd_t self:netlink_route_socket r
 allow pppd_t self:tcp_socket create_stream_socket_perms;
 allow pppd_t self:udp_socket { connect connected_socket_perms };
 allow pppd_t self:packet_socket create_socket_perms;
+allow pppd_t self:association { sendto recvfrom };
 
 domain_auto_trans(pppd_t, pptp_exec_t, pptp_t)
 allow pppd_t pptp_t:fd use;
@@ -240,6 +241,7 @@ allow pptp_t self:unix_dgram_socket crea
 allow pptp_t self:unix_stream_socket { connectto create_stream_socket_perms };
 allow pptp_t self:rawip_socket create_socket_perms;
 allow pptp_t self:tcp_socket create_socket_perms;
+allow pptp_t self:association { sendto recvfrom };
 
 allow pptp_t pppd_etc_t:dir { getattr read search };
 allow pptp_t pppd_etc_t:file { read getattr };
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/privoxy.if serefpolicy-2.4.6.patchbox2/policy/modules/services/privoxy.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/privoxy.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/privoxy.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Privacy enhancing web proxy.</summary>
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
+interface(`privoxy_recv_labeledipsec',`
+	gen_require(`
+		type privoxy_t;
+	')
+	allow $1 privoxy_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/privoxy.te serefpolicy-2.4.6.patchbox2/policy/modules/services/privoxy.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/privoxy.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/privoxy.te	2006-12-14 11:40:21.000000000 -0600
@@ -27,6 +27,7 @@ files_pid_file(privoxy_var_run_t)
 allow privoxy_t self:capability { setgid setuid };
 dontaudit privoxy_t self:capability sys_tty_config;
 allow privoxy_t self:tcp_socket create_stream_socket_perms;
+allow privoxy_t self:association { sendto recvfrom };
 
 allow privoxy_t privoxy_etc_rw_t:file rw_file_perms;
 
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/procmail.if serefpolicy-2.4.6.patchbox2/policy/modules/services/procmail.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/procmail.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/procmail.if	2006-12-14 11:40:21.000000000 -0600
@@ -44,3 +44,21 @@ interface(`procmail_exec',`
 	corecmd_search_bin($1)
 	can_exec($1,procmail_exec_t)
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
+interface(`procmail_recv_labeledipsec',`
+	gen_require(`
+		type procmail_t;
+	')
+	allow $1 procmail_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/procmail.te serefpolicy-2.4.6.patchbox2/policy/modules/services/procmail.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/procmail.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/procmail.te	2006-12-14 11:40:21.000000000 -0600
@@ -25,6 +25,7 @@ allow procmail_t self:unix_stream_socket
 allow procmail_t self:unix_dgram_socket create_socket_perms;
 allow procmail_t self:tcp_socket create_stream_socket_perms;
 allow procmail_t self:udp_socket create_socket_perms;
+allow procmail_t self:association { sendto recvfrom };
 
 kernel_read_system_state(procmail_t)
 kernel_read_kernel_sysctls(procmail_t)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/pyzor.if serefpolicy-2.4.6.patchbox2/policy/modules/services/pyzor.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/pyzor.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/pyzor.if	2006-12-14 11:40:21.000000000 -0600
@@ -78,3 +78,21 @@ template(`pyzor_per_role_template',`
 	userdom_search_user_home_dirs($1,pyzord_t)
 	userdom_user_home_dir_filetrans($1,pyzord_t,$1_pyzor_home_t,{ dir file lnk_file })
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
+interface(`pyzor_recv_labeledipsec',`
+	gen_require(`
+		type pyzord_t;
+	')
+	allow $1 pyzord_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/pyzor.te serefpolicy-2.4.6.patchbox2/policy/modules/services/pyzor.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/pyzor.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/pyzor.te	2006-12-14 11:40:21.000000000 -0600
@@ -75,6 +75,7 @@ optional_policy(`
 #
 
 allow pyzord_t self:udp_socket create_socket_perms;
+allow pyzord_t self:association { sendto recvfrom };
 
 allow pyzord_t pyzor_var_lib_t:file create_file_perms;
 allow pyzord_t pyzor_var_lib_t:dir { rw_dir_perms setattr };
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/qmail.if serefpolicy-2.4.6.patchbox2/policy/modules/services/qmail.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/qmail.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/qmail.if	2006-12-14 11:40:21.000000000 -0600
@@ -208,3 +208,21 @@ interface(`qmail_smtpd_service_domain',`
 	allow $1 qmail_smtpd_t:fifo_file { read write };
 	allow $1 qmail_smtpd_t:process sigchld;
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
+interface(`qmail_recv_labeledipsec',`
+	gen_require(`
+		type qmail_remote_t;
+	')
+	allow $1 qmail_remote_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/qmail.te serefpolicy-2.4.6.patchbox2/policy/modules/services/qmail.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/qmail.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/qmail.te	2006-12-14 11:40:21.000000000 -0600
@@ -171,6 +171,7 @@ optional_policy(`
 
 allow qmail_remote_t self:tcp_socket create_socket_perms;
 allow qmail_remote_t self:udp_socket create_socket_perms;
+allow qmail_remote_t self:association { sendto recvfrom };
 
 allow qmail_remote_t qmail_spool_t:dir search;
 allow qmail_remote_t qmail_spool_t:file rw_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/radius.if serefpolicy-2.4.6.patchbox2/policy/modules/services/radius.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/radius.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/radius.if	2006-12-14 11:40:21.000000000 -0600
@@ -13,3 +13,21 @@
 interface(`radius_use',`
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
+interface(`radius_recv_labeledipsec',`
+	gen_require(`
+		type radiusd_t;
+	')
+	allow $1 radiusd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/radius.te serefpolicy-2.4.6.patchbox2/policy/modules/services/radius.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/radius.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/radius.te	2006-12-14 11:40:21.000000000 -0600
@@ -36,6 +36,7 @@ allow radiusd_t self:fifo_file rw_file_p
 allow radiusd_t self:unix_stream_socket create_stream_socket_perms;
 allow radiusd_t self:tcp_socket create_stream_socket_perms;
 allow radiusd_t self:udp_socket create_socket_perms;
+allow radiusd_t self:association { sendto recvfrom };
 
 allow radiusd_t radiusd_etc_t:file r_file_perms;
 allow radiusd_t radiusd_etc_t:dir r_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/radvd.if serefpolicy-2.4.6.patchbox2/policy/modules/services/radvd.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/radvd.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/radvd.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>IPv6 router advertisement daemon</summary>
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
+interface(`radvd_recv_labeledipsec',`
+	gen_require(`
+		type radvd_t;
+	')
+	allow $1 radvd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/radvd.te serefpolicy-2.4.6.patchbox2/policy/modules/services/radvd.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/radvd.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/radvd.te	2006-12-14 11:40:21.000000000 -0600
@@ -27,6 +27,7 @@ allow radvd_t self:unix_stream_socket cr
 allow radvd_t self:rawip_socket create_socket_perms;
 allow radvd_t self:tcp_socket create_stream_socket_perms;
 allow radvd_t self:udp_socket create_socket_perms;
+allow radvd_t self:association { sendto recvfrom };
 
 allow radvd_t radvd_etc_t:file { getattr read };
 
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/razor.if serefpolicy-2.4.6.patchbox2/policy/modules/services/razor.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/razor.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/razor.if	2006-12-14 11:40:21.000000000 -0600
@@ -36,6 +36,7 @@ template(`razor_common_domain_template',
 	allow $1_t self:msgq create_msgq_perms;
 	allow $1_t self:msg { send receive };
 	allow $1_t self:tcp_socket create_socket_perms;
+	allow $1_t self:association { sendto recvfrom };
 
 	# Read system config file
 	allow $1_t razor_etc_t:dir list_dir_perms;
@@ -215,3 +216,39 @@ interface(`razor_domtrans',`
 	allow razor_t $1:fifo_file rw_file_perms;
 	allow razor_t $1:process sigchld;	
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
+interface(`razor_recv_labeledipsec',`
+	gen_require(`
+		type razor_t;
+	')
+	allow $1 razor_t:association recvfrom;
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
+interface(`razor_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_t;
+	')
+	allow $2 $1_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/razor.te serefpolicy-2.4.6.patchbox2/policy/modules/services/razor.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/razor.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/razor.te	2006-12-14 11:40:21.000000000 -0600
@@ -28,6 +28,7 @@ files_type(razor_var_lib_t)
 #
 
 allow razor_t self:tcp_socket create_socket_perms;
+allow razor_t self:association { sendto recvfrom };
 
 allow razor_t razor_etc_t:dir create_dir_perms;
 allow razor_t razor_etc_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/rdisc.if serefpolicy-2.4.6.patchbox2/policy/modules/services/rdisc.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/rdisc.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/rdisc.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Network router discovery daemon</summary>
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
+interface(`rdisc_recv_labeledipsec',`
+	gen_require(`
+		type rdisc_t;
+	')
+	allow $1 rdisc_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/rdisc.te serefpolicy-2.4.6.patchbox2/policy/modules/services/rdisc.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/rdisc.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/rdisc.te	2006-12-14 11:40:21.000000000 -0600
@@ -21,6 +21,7 @@ allow rdisc_t self:process signal_perms;
 allow rdisc_t self:unix_stream_socket create_stream_socket_perms;
 allow rdisc_t self:udp_socket create_socket_perms;
 allow rdisc_t self:rawip_socket create_socket_perms;
+allow rdisc_t self:association { sendto recvfrom };
 
 kernel_list_proc(rdisc_t)
 kernel_read_proc_symlinks(rdisc_t)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/rhgb.if serefpolicy-2.4.6.patchbox2/policy/modules/services/rhgb.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/rhgb.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/rhgb.if	2006-12-14 11:40:21.000000000 -0600
@@ -124,3 +124,21 @@ interface(`rhgb_rw_tmpfs_files',`
 
 	allow $1 rhgb_tmpfs_t:file { read write };
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
+interface(`rhgb_recv_labeledipsec',`
+	gen_require(`
+		type rhgb_t;
+	')
+	allow $1 rhgb_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/rhgb.te serefpolicy-2.4.6.patchbox2/policy/modules/services/rhgb.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/rhgb.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/rhgb.te	2006-12-14 11:40:21.000000000 -0600
@@ -30,6 +30,7 @@ allow rhgb_t self:fifo_file rw_file_perm
 allow rhgb_t self:tcp_socket create_socket_perms;
 allow rhgb_t self:udp_socket create_socket_perms;
 allow rhgb_t self:netlink_route_socket r_netlink_socket_perms;
+allow rhgb_t self:association { sendto recvfrom };
 
 allow rhgb_t rhgb_tmpfs_t:dir manage_dir_perms;
 allow rhgb_t rhgb_tmpfs_t:file manage_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ricci.if serefpolicy-2.4.6.patchbox2/policy/modules/services/ricci.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ricci.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ricci.if	2006-12-14 11:40:21.000000000 -0600
@@ -183,3 +183,21 @@ interface(`ricci_domtrans_modstorage',`
 	allow ricci_modstorage_t $1:fifo_file rw_file_perms;
 	allow ricci_modstorage_t $1:process sigchld;
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
+interface(`ricci_recv_labeledipsec',`
+	gen_require(`
+		type ricci_t;
+	')
+	allow $1 ricci_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ricci.te serefpolicy-2.4.6.patchbox2/policy/modules/services/ricci.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ricci.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ricci.te	2006-12-14 11:40:21.000000000 -0600
@@ -84,6 +84,7 @@ allow ricci_t self:process setsched;
 allow ricci_t self:fifo_file { read write };
 allow ricci_t self:unix_stream_socket { create_stream_socket_perms connectto };
 allow ricci_t self:tcp_socket create_stream_socket_perms;
+allow ricci_t self:association { sendto recvfrom };
 
 domain_auto_trans(ricci_t,ricci_modcluster_exec_t,ricci_modcluster_t)
 domain_auto_trans(ricci_t,ricci_modlog_exec_t,ricci_modlog_t)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/rlogin.if serefpolicy-2.4.6.patchbox2/policy/modules/services/rlogin.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/rlogin.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/rlogin.if	2006-12-14 11:40:21.000000000 -0600
@@ -23,3 +23,21 @@ interface(`rlogin_domtrans',`
 	allow rlogind_t $1:fifo_file rw_file_perms;
 	allow rlogind_t $1:process sigchld;
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
+interface(`rlogin_recv_labeledipsec',`
+	gen_require(`
+		type rlogind_t;
+	')
+	allow $1 rlogind_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/rlogin.te serefpolicy-2.4.6.patchbox2/policy/modules/services/rlogin.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/rlogin.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/rlogin.te	2006-12-14 11:40:21.000000000 -0600
@@ -32,6 +32,7 @@ allow rlogind_t self:tcp_socket connecte
 # for identd; cjp: this should probably only be inetd_child rules?
 allow rlogind_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
 allow rlogind_t self:capability { setuid setgid };
+allow rlogind_t self:association { sendto recvfrom };
 
 allow rlogind_t rlogind_devpts_t:chr_file { rw_file_perms setattr };
 term_create_pty(rlogind_t,rlogind_devpts_t)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/roundup.if serefpolicy-2.4.6.patchbox2/policy/modules/services/roundup.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/roundup.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/roundup.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Roundup Issue Tracking System policy</summary>
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
+interface(`roundup_recv_labeledipsec',`
+	gen_require(`
+		type roundup_t;
+	')
+	allow $1 roundup_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/roundup.te serefpolicy-2.4.6.patchbox2/policy/modules/services/roundup.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/roundup.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/roundup.te	2006-12-14 11:40:21.000000000 -0600
@@ -27,6 +27,7 @@ allow roundup_t self:process signal_perm
 allow roundup_t self:unix_stream_socket create_stream_socket_perms;
 allow roundup_t self:tcp_socket create_stream_socket_perms;
 allow roundup_t self:udp_socket create_socket_perms;
+allow roundup_t self:association { sendto recvfrom };
 
 allow roundup_t roundup_var_run_t:file create_file_perms;
 allow roundup_t roundup_var_run_t:dir rw_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/rpc.if serefpolicy-2.4.6.patchbox2/policy/modules/services/rpc.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/rpc.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/rpc.if	2006-12-14 11:40:21.000000000 -0600
@@ -56,6 +56,7 @@ template(`rpc_domain_template', `
 	allow $1_t self:netlink_route_socket r_netlink_socket_perms;
 	allow $1_t self:tcp_socket create_stream_socket_perms;
 	allow $1_t self:udp_socket create_socket_perms;
+	allow $1_t self:association { sendto recvfrom };
 
 	allow $1_t var_lib_nfs_t:dir create_dir_perms;
 	allow $1_t var_lib_nfs_t:file create_file_perms;
@@ -361,3 +362,57 @@ interface(`rpc_read_nfs_state_data',`
 	allow $1 var_lib_nfs_t:dir search_dir_perms;
 	allow $1 var_lib_nfs_t:file read_file_perms;
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
+interface(`rpc_recv_labeledipsec_gssd',`
+	gen_require(`
+		type gssd_t;
+	')
+	allow $1 gssd_t:association recvfrom;
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
+interface(`rpc_recv_labeledipsec_rpcd',`
+	gen_require(`
+		type rpcd_t;
+	')
+	allow $1 rpcd_t:association recvfrom;
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
+interface(`rpc_recv_labeledipsec_nfsd',`
+	gen_require(`
+		type nsfd_t;
+	')
+	allow $1 nfsd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/rshd.if serefpolicy-2.4.6.patchbox2/policy/modules/services/rshd.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/rshd.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/rshd.if	2006-12-14 11:40:21.000000000 -0600
@@ -24,3 +24,21 @@ interface(`rshd_domtrans',`
 	allow rshd_t $1:fifo_file rw_file_perms;
 	allow rshd_t $1:process sigchld;
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
+interface(`rshd_recv_labeledipsec',`
+	gen_require(`
+		type rshd_t;
+	')
+	allow $1 rshd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/rshd.te serefpolicy-2.4.6.patchbox2/policy/modules/services/rshd.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/rshd.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/rshd.te	2006-12-14 11:40:21.000000000 -0600
@@ -20,6 +20,7 @@ allow rshd_t self:capability { setuid se
 allow rshd_t self:process { signal_perms fork setsched setpgid setexec };
 allow rshd_t self:fifo_file rw_file_perms;
 allow rshd_t self:tcp_socket create_stream_socket_perms;
+allow rshd_t self:association { sendto recvfrom };
 
 kernel_read_kernel_sysctls(rshd_t)
 
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/rsync.if serefpolicy-2.4.6.patchbox2/policy/modules/services/rsync.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/rsync.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/rsync.if	2006-12-14 11:40:21.000000000 -0600
@@ -103,3 +103,21 @@ interface(`rsync_exec',`
 
 	can_exec($1,rsync_exec_t)
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
+interface(`rsync_recv_labeledipsec',`
+	gen_require(`
+		type rsync_t;
+	')
+	allow $1 rsync_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/rsync.te serefpolicy-2.4.6.patchbox2/policy/modules/services/rsync.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/rsync.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/rsync.te	2006-12-14 11:40:21.000000000 -0600
@@ -31,6 +31,7 @@ allow rsync_t self:process signal_perms;
 allow rsync_t self:fifo_file rw_file_perms;
 allow rsync_t self:tcp_socket create_stream_socket_perms;
 allow rsync_t self:udp_socket connected_socket_perms;
+allow rsync_t self:association { sendto recvfrom };
 
 # for identd
 # cjp: this should probably only be inetd_child_t rules?
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/samba.if serefpolicy-2.4.6.patchbox2/policy/modules/services/samba.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/samba.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/samba.if	2006-12-14 11:40:21.000000000 -0600
@@ -397,3 +397,111 @@ interface(`samba_stream_connect_winbind'
 	allow $1 winbind_var_run_t:sock_file { getattr read write };
 	allow $1 winbind_t:unix_stream_socket connectto;
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
+interface(`samba_recv_labeledipsec_net',`
+	gen_require(`
+		type samba_net_t;
+	')
+	allow $1 samba_net_t:association recvfrom;
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
+interface(`samba_recv_labeledipsec_smbd',`
+	gen_require(`
+		type smbd_t;
+	')
+	allow $1 smbd_t:association recvfrom;
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
+interface(`samba_recv_labeledipsec_nmbd',`
+	gen_require(`
+		type nmbd_t;
+	')
+	allow $1 nmbd_t:association recvfrom;
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
+interface(`samba_recv_labeledipsec_smb',`
+	gen_require(`
+		type smbmount_t;
+	')
+	allow $1 smbmount_t:association recvfrom;
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
+interface(`samba_recv_labeledipsec_swat',`
+	gen_require(`
+		type swat_t;
+	')
+	allow $1 swat_t:association recvfrom;
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
+interface(`samba_recv_labeledipsec_win',`
+	gen_require(`
+		type winbind_t;
+	')
+	allow $1 winbind_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/samba.te serefpolicy-2.4.6.patchbox2/policy/modules/services/samba.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/samba.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/samba.te	2006-12-14 11:40:21.000000000 -0600
@@ -95,6 +95,7 @@ allow samba_net_t self:unix_dgram_socket
 allow samba_net_t self:unix_stream_socket create_stream_socket_perms;
 allow samba_net_t self:udp_socket create_socket_perms;
 allow samba_net_t self:tcp_socket create_socket_perms;
+allow samba_net_t self:association { sendto recvfrom };
 
 allow samba_net_t samba_etc_t:file r_file_perms;
 
@@ -176,6 +177,7 @@ allow smbd_t self:udp_socket create_sock
 allow smbd_t self:unix_dgram_socket { create_socket_perms sendto };
 allow smbd_t self:unix_stream_socket { create_stream_socket_perms connectto };
 allow smbd_t self:netlink_route_socket r_netlink_socket_perms;
+allow smbd_t self:association { sendto recvfrom };
 
 allow smbd_t samba_etc_t:dir rw_dir_perms;
 allow smbd_t samba_etc_t:file { rw_file_perms setattr };
@@ -340,6 +342,7 @@ allow nmbd_t self:tcp_socket create_stre
 allow nmbd_t self:udp_socket create_socket_perms;
 allow nmbd_t self:unix_dgram_socket { create_socket_perms sendto };
 allow nmbd_t self:unix_stream_socket { create_stream_socket_perms connectto };
+allow nmbd_t self:association { sendto recvfrom };
 
 allow nmbd_t nmbd_var_run_t:file create_file_perms;
 allow nmbd_t nmbd_var_run_t:dir rw_dir_perms;
@@ -434,6 +437,7 @@ allow smbmount_t self:tcp_socket create_
 allow smbmount_t self:udp_socket connect;
 allow smbmount_t self:unix_dgram_socket create_socket_perms;
 allow smbmount_t self:unix_stream_socket create_socket_perms;
+allow smbmount_t self:association { sendto recvfrom };
 
 allow smbmount_t samba_etc_t:dir r_dir_perms;
 allow smbmount_t samba_etc_t:file r_file_perms;
@@ -526,6 +530,7 @@ allow swat_t self:netlink_audit_socket c
 allow swat_t self:tcp_socket create_stream_socket_perms;
 allow swat_t self:udp_socket create_socket_perms;
 allow swat_t self:netlink_route_socket r_netlink_socket_perms;
+allow swat_t self:association { sendto recvfrom };
 corenet_tcp_connect_ipp_port(swat_t)
 
 allow swat_t nmbd_exec_t:file { execute read };
@@ -624,6 +629,7 @@ allow winbind_t self:unix_stream_socket 
 allow winbind_t self:netlink_route_socket r_netlink_socket_perms;
 allow winbind_t self:tcp_socket create_stream_socket_perms;
 allow winbind_t self:udp_socket create_socket_perms;
+allow winbind_t self:association { sendto recvfrom };
 
 allow winbind_t samba_etc_t:dir r_dir_perms;
 allow winbind_t samba_etc_t:lnk_file { getattr read };
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/sasl.if serefpolicy-2.4.6.patchbox2/policy/modules/services/sasl.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/sasl.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/sasl.if	2006-12-14 11:40:21.000000000 -0600
@@ -20,3 +20,21 @@ interface(`sasl_connect',`
 	allow $1 saslauthd_var_run_t:sock_file { read write };
 	allow $1 saslauthd_t:unix_stream_socket connectto;
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
+interface(`sasl_recv_labeledipsec',`
+	gen_require(`
+		type saslauthd_t;
+	')
+	allow $1 saslauthd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/sasl.te serefpolicy-2.4.6.patchbox2/policy/modules/services/sasl.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/sasl.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/sasl.te	2006-12-14 11:40:21.000000000 -0600
@@ -25,6 +25,7 @@ allow saslauthd_t self:fifo_file { read 
 allow saslauthd_t self:unix_dgram_socket create_socket_perms;
 allow saslauthd_t self:unix_stream_socket create_stream_socket_perms;
 allow saslauthd_t self:tcp_socket create_socket_perms;
+allow saslauthd_t self:association { sendto recvfrom };
 
 allow saslauthd_t saslauthd_var_run_t:file create_file_perms;
 allow saslauthd_t saslauthd_var_run_t:sock_file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/sendmail.if serefpolicy-2.4.6.patchbox2/policy/modules/services/sendmail.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/sendmail.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/sendmail.if	2006-12-14 11:40:21.000000000 -0600
@@ -111,3 +111,21 @@ interface(`sendmail_create_log',`
 
 	logging_log_filetrans($1,sendmail_log_t,file)
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
+interface(`sendmail_recv_labeledipsec',`
+	gen_require(`
+		type sendmail_t;
+	')
+	allow $1 sendmail_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/sendmail.te serefpolicy-2.4.6.patchbox2/policy/modules/services/sendmail.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/sendmail.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/sendmail.te	2006-12-14 11:40:21.000000000 -0600
@@ -33,6 +33,7 @@ allow sendmail_t self:unix_dgram_socket 
 allow sendmail_t self:tcp_socket create_stream_socket_perms;
 allow sendmail_t self:udp_socket create_socket_perms;
 allow sendmail_t self:netlink_route_socket r_netlink_socket_perms;
+allow sendmail_t self:association { sendto recvfrom };
 
 allow sendmail_t sendmail_log_t:file create_file_perms;
 allow sendmail_t sendmail_log_t:dir { rw_dir_perms setattr };
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/setroubleshoot.if serefpolicy-2.4.6.patchbox2/policy/modules/services/setroubleshoot.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/setroubleshoot.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/setroubleshoot.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>SELinux troubleshooting service</summary>
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
+interface(`setroubleshoot_recv_labeledipsec',`
+	gen_require(`
+		type setroubleshootd_t;
+	')
+	allow $1 setroubleshootd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/setroubleshoot.te serefpolicy-2.4.6.patchbox2/policy/modules/services/setroubleshoot.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/setroubleshoot.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/setroubleshoot.te	2006-12-14 11:40:21.000000000 -0600
@@ -34,6 +34,7 @@ allow setroubleshootd_t self:tcp_socket 
 allow setroubleshootd_t self:unix_stream_socket { create_stream_socket_perms connectto };
 allow setroubleshootd_t self:unix_dgram_socket create_socket_perms;
 allow setroubleshootd_t self:netlink_route_socket r_netlink_socket_perms;
+allow setroubleshootd_t self:association { sendto recvfrom };
 
 # database files
 allow setroubleshootd_t setroubleshoot_var_lib_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/smartmon.if serefpolicy-2.4.6.patchbox2/policy/modules/services/smartmon.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/smartmon.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/smartmon.if	2006-12-14 11:40:21.000000000 -0600
@@ -17,3 +17,21 @@ interface(`smartmon_read_tmp_files',`
 
 	allow $1 fsdaemon_tmp_t:file { getattr ioctl read };
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
+interface(`smartmon_recv_labeledipsec',`
+	gen_require(`
+		type fsdaemon_t;
+	')
+	allow $1 fsdaemon_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/smartmon.te serefpolicy-2.4.6.patchbox2/policy/modules/services/smartmon.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/smartmon.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/smartmon.te	2006-12-14 11:40:21.000000000 -0600
@@ -28,6 +28,7 @@ allow fsdaemon_t self:fifo_file rw_file_
 allow fsdaemon_t self:unix_dgram_socket create_socket_perms;
 allow fsdaemon_t self:unix_stream_socket create_stream_socket_perms;
 allow fsdaemon_t self:udp_socket create_socket_perms;
+allow fsdaemon_t self:association { sendto recvfrom };
 
 allow fsdaemon_t fsdaemon_tmp_t:dir create_dir_perms;
 allow fsdaemon_t fsdaemon_tmp_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/snmp.if serefpolicy-2.4.6.patchbox2/policy/modules/services/snmp.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/snmp.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/snmp.if	2006-12-14 11:40:21.000000000 -0600
@@ -65,3 +65,21 @@ interface(`snmp_dontaudit_read_snmp_var_
 	dontaudit $1 snmpd_var_lib_t:file r_file_perms;
 	dontaudit $1 snmpd_var_lib_t:lnk_file { getattr read };
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
+interface(`snmp_recv_labeledipsec',`
+	gen_require(`
+		type snmpd_t;
+	')
+	allow $1 snmpd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/snmp.te serefpolicy-2.4.6.patchbox2/policy/modules/services/snmp.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/snmp.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/snmp.te	2006-12-14 11:40:21.000000000 -0600
@@ -32,6 +32,7 @@ allow snmpd_t self:unix_dgram_socket cre
 allow snmpd_t self:unix_stream_socket create_stream_socket_perms;
 allow snmpd_t self:tcp_socket create_stream_socket_perms;
 allow snmpd_t self:udp_socket connected_stream_socket_perms;
+allow snmpd_t self:association { sendto recvfrom };
 
 allow snmpd_t snmpd_etc_t:file { getattr read };
 
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/snort.if serefpolicy-2.4.6.patchbox2/policy/modules/services/snort.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/snort.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/snort.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Snort network intrusion detection system</summary>
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
+interface(`snort_recv_labeledipsec',`
+	gen_require(`
+		type snort_t;
+	')
+	allow $1 snort_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/snort.te serefpolicy-2.4.6.patchbox2/policy/modules/services/snort.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/snort.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/snort.te	2006-12-14 11:40:21.000000000 -0600
@@ -34,6 +34,7 @@ allow snort_t self:netlink_route_socket 
 allow snort_t self:tcp_socket create_stream_socket_perms;
 allow snort_t self:udp_socket create_socket_perms;
 allow snort_t self:packet_socket create_socket_perms;
+allow snort_t self:association { sendto recvfrom };
 
 allow snort_t snort_etc_t:dir r_dir_perms;
 allow snort_t snort_etc_t:file r_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/soundserver.if serefpolicy-2.4.6.patchbox2/policy/modules/services/soundserver.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/soundserver.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/soundserver.if	2006-12-14 11:40:21.000000000 -0600
@@ -13,3 +13,21 @@
 interface(`soundserver_tcp_connect',`
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
+interface(`soundserver_recv_labeledipsec',`
+	gen_require(`
+		type soundd_t;
+	')
+	allow $1 soundd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/soundserver.te serefpolicy-2.4.6.patchbox2/policy/modules/services/soundserver.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/soundserver.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/soundserver.te	2006-12-14 11:40:21.000000000 -0600
@@ -35,6 +35,7 @@ dontaudit soundd_t self:capability sys_t
 allow soundd_t self:process { setpgid signal_perms };
 allow soundd_t self:tcp_socket create_stream_socket_perms;
 allow soundd_t self:udp_socket create_socket_perms;
+allow soundd_t self:association { sendto recvfrom };
 # for yiff
 allow soundd_t self:shm create_shm_perms;
 
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/spamassassin.if serefpolicy-2.4.6.patchbox2/policy/modules/services/spamassassin.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/spamassassin.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/spamassassin.if	2006-12-14 11:40:21.000000000 -0600
@@ -79,6 +79,7 @@ template(`spamassassin_per_role_template
 	allow $1_spamc_t self:unix_stream_socket connectto;
 	allow $1_spamc_t self:tcp_socket create_stream_socket_perms;
 	allow $1_spamc_t self:udp_socket create_socket_perms;
+	allow $1_spamc_t self:association { sendto recvfrom };
 
 	allow $1_spamc_t $1_spamc_tmp_t:dir create_dir_perms;
 	allow $1_spamc_t $1_spamc_tmp_t:file create_file_perms;
@@ -276,6 +277,7 @@ template(`spamassassin_per_role_template
 	tunable_policy(`spamassassin_can_network',`
 		allow $1_spamassassin_t self:tcp_socket create_stream_socket_perms;
 		allow $1_spamassassin_t self:udp_socket create_socket_perms;
+		allow $1_spamassassin_t self:association { sendto recvfrom };
 
 		corenet_non_ipsec_sendrecv($1_spamassassin_t)
 		corenet_tcp_sendrecv_generic_if($1_spamassassin_t)
@@ -506,3 +508,40 @@ interface(`spamassassin_dontaudit_getatt
 
 	dontaudit $1 spamd_tmp_t:sock_file getattr;
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
+interface(`spamassassin_recv_labeledipsec_spamd',`
+	gen_require(`
+		type spamd_t;
+	')
+	allow $1 spamd_t:association recvfrom;
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
+interface(`spamassassin_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_spamassassin_t;
+	')
+	allow $2 $1_spamassassin_t:association recvfrom;
+	allow $2 $1_spamc_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/spamassassin.te serefpolicy-2.4.6.patchbox2/policy/modules/services/spamassassin.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/spamassassin.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/spamassassin.te	2006-12-14 11:40:21.000000000 -0600
@@ -52,6 +52,7 @@ allow spamd_t self:unix_stream_socket co
 allow spamd_t self:tcp_socket create_stream_socket_perms;
 allow spamd_t self:udp_socket create_socket_perms;
 allow spamd_t self:netlink_route_socket r_netlink_socket_perms;
+allow spamd_t self:association { sendto recvfrom };
 
 allow spamd_t spamd_spool_t:file create_file_perms;
 allow spamd_t spamd_spool_t:dir create_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/squid.if serefpolicy-2.4.6.patchbox2/policy/modules/services/squid.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/squid.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/squid.if	2006-12-14 11:40:21.000000000 -0600
@@ -120,3 +120,21 @@ interface(`squid_manage_logs',`
 interface(`squid_use',`
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
+interface(`squid_recv_labeledipsec',`
+	gen_require(`
+		type squid_t;
+	')
+	allow $1 squid_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/squid.te serefpolicy-2.4.6.patchbox2/policy/modules/services/squid.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/squid.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/squid.te	2006-12-14 11:40:21.000000000 -0600
@@ -44,6 +44,7 @@ allow squid_t self:unix_dgram_socket sen
 allow squid_t self:unix_stream_socket connectto;
 allow squid_t self:tcp_socket create_stream_socket_perms;
 allow squid_t self:udp_socket create_socket_perms;
+allow squid_t self:association { sendto recvfrom };
 
 # Grant permissions to create, access, and delete cache files.
 allow squid_t squid_cache_t:dir create_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ssh.if serefpolicy-2.4.6.patchbox2/policy/modules/services/ssh.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ssh.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ssh.if	2006-12-14 11:40:21.000000000 -0600
@@ -734,3 +734,39 @@ interface(`ssh_dontaudit_read_server_key
 
 	dontaudit $1 sshd_key_t:file { getattr read };
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
+interface(`ssh_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_ssh_t;
+	')
+	allow $2 $1_ssh_t:association recvfrom;
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
+interface(`ssh_recv_labeledipsec_server',`
+	gen_require(`
+		type $1_t;
+	')
+	allow $1 sshd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/stunnel.if serefpolicy-2.4.6.patchbox2/policy/modules/services/stunnel.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/stunnel.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/stunnel.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>SSL Tunneling Proxy</summary>
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
+interface(`stunnel_recv_labeledipsec',`
+	gen_require(`
+		type stunnel_t;
+	')
+	allow $1 stunnel_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/stunnel.te serefpolicy-2.4.6.patchbox2/policy/modules/services/stunnel.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/stunnel.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/stunnel.te	2006-12-14 11:40:21.000000000 -0600
@@ -39,6 +39,7 @@ allow stunnel_t self:fifo_file rw_file_p
 allow stunnel_t self:tcp_socket create_stream_socket_perms;
 allow stunnel_t self:udp_socket create_socket_perms;
 allow stunnel_t self:netlink_route_socket r_netlink_socket_perms;
+allow stunnel_t self:association { sendto recvfrom };
 
 allow stunnel_t stunnel_etc_t:dir { getattr read search };
 allow stunnel_t stunnel_etc_t:file { read getattr };
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/tcpd.if serefpolicy-2.4.6.patchbox2/policy/modules/services/tcpd.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/tcpd.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/tcpd.if	2006-12-14 11:40:21.000000000 -0600
@@ -22,3 +22,21 @@ interface(`tcpd_domtrans',`
 	allow tcpd_t $1:fifo_file rw_file_perms;
 	allow tcpd_t $1:process sigchld;
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
+interface(`tcpd_recv_labeledipsec',`
+	gen_require(`
+		type tcpd_t;
+	')
+	allow $1 tcpd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/tcpd.te serefpolicy-2.4.6.patchbox2/policy/modules/services/tcpd.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/tcpd.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/tcpd.te	2006-12-14 11:40:21.000000000 -0600
@@ -18,6 +18,7 @@ files_tmp_file(tcpd_tmp_t)
 # Local policy
 #
 allow tcpd_t self:tcp_socket create_stream_socket_perms;
+allow tcpd_t self:association { sendto recvfrom };
 
 allow tcpd_t tcpd_tmp_t:dir create_dir_perms;
 allow tcpd_t tcpd_tmp_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/telnet.if serefpolicy-2.4.6.patchbox2/policy/modules/services/telnet.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/telnet.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/telnet.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Telnet daemon</summary>
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
+interface(`telnet_recv_labeledipsec',`
+	gen_require(`
+		type telnetd_t;
+	')
+	allow $1 telnetd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/telnet.te serefpolicy-2.4.6.patchbox2/policy/modules/services/telnet.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/telnet.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/telnet.te	2006-12-14 11:40:21.000000000 -0600
@@ -34,6 +34,7 @@ allow telnetd_t self:udp_socket create_s
 allow telnetd_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
 allow telnetd_t self:netlink_route_socket r_netlink_socket_perms;
 allow telnetd_t self:capability { setuid setgid };
+allow telnetd_t self:association { sendto recvfrom };
 
 allow telnetd_t telnetd_devpts_t:chr_file { rw_file_perms setattr };
 term_create_pty(telnetd_t,telnetd_devpts_t)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/tftp.if serefpolicy-2.4.6.patchbox2/policy/modules/services/tftp.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/tftp.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/tftp.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Trivial file transfer protocol daemon</summary>
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
+interface(`tftp_recv_labeledipsec',`
+	gen_require(`
+		type tftpd_t;
+	')
+	allow $1 tftpd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/tftp.te serefpolicy-2.4.6.patchbox2/policy/modules/services/tftp.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/tftp.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/tftp.te	2006-12-14 11:40:21.000000000 -0600
@@ -27,6 +27,7 @@ allow tftpd_t self:udp_socket create_soc
 allow tftpd_t self:unix_dgram_socket create_socket_perms;
 allow tftpd_t self:unix_stream_socket create_stream_socket_perms;
 dontaudit tftpd_t self:capability sys_tty_config;
+allow tftpd_t self:association { sendto recvfrom };
 
 allow tftpd_t tftpdir_t:dir { getattr read search };
 allow tftpd_t tftpdir_t:file { read getattr };
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/timidity.if serefpolicy-2.4.6.patchbox2/policy/modules/services/timidity.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/timidity.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/timidity.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>MIDI to WAV converter and player configured as a service</summary>
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
+interface(`timidity_recv_labeledipsec',`
+	gen_require(`
+		type timidity_t;
+	')
+	allow $1 timidity_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/timidity.te serefpolicy-2.4.6.patchbox2/policy/modules/services/timidity.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/timidity.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/timidity.te	2006-12-14 11:40:21.000000000 -0600
@@ -27,6 +27,7 @@ allow timidity_t self:shm create_shm_per
 allow timidity_t self:unix_stream_socket create_stream_socket_perms;
 allow timidity_t self:tcp_socket create_stream_socket_perms;
 allow timidity_t self:udp_socket create_socket_perms;
+allow timidity_t self:association { sendto recvfrom };
 
 allow timidity_t timidity_tmpfs_t:dir create_dir_perms;
 allow timidity_t timidity_tmpfs_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/tor.if serefpolicy-2.4.6.patchbox2/policy/modules/services/tor.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/tor.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/tor.if	2006-12-14 11:40:21.000000000 -0600
@@ -22,3 +22,21 @@ interface(`tor_domtrans',`
 	allow tor_t $1:fifo_file rw_file_perms;
 	allow tor_t $1:process sigchld;
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
+interface(`tor_recv_labeledipsec',`
+	gen_require(`
+		type tor_t;
+	')
+	allow $1 tor_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/tor.te serefpolicy-2.4.6.patchbox2/policy/modules/services/tor.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/tor.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/tor.te	2006-12-14 11:40:21.000000000 -0600
@@ -35,6 +35,7 @@ allow tor_t self:fifo_file { read write 
 allow tor_t self:unix_stream_socket create_stream_socket_perms;
 allow tor_t self:netlink_route_socket r_netlink_socket_perms;
 allow tor_t self:tcp_socket create_stream_socket_perms;
+allow tor_t self:association { sendto recvfrom };
 
 # configuration files
 allow tor_t tor_etc_t:dir r_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/transproxy.if serefpolicy-2.4.6.patchbox2/policy/modules/services/transproxy.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/transproxy.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/transproxy.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>HTTP transperant proxy</summary>
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
+interface(`transproxy_recv_labeledipsec',`
+	gen_require(`
+		type transproxy_t;
+	')
+	allow $1 transproxy_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/transproxy.te serefpolicy-2.4.6.patchbox2/policy/modules/services/transproxy.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/transproxy.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/transproxy.te	2006-12-14 11:40:21.000000000 -0600
@@ -22,6 +22,7 @@ allow transproxy_t self:capability { set
 dontaudit transproxy_t self:capability sys_tty_config;
 allow transproxy_t self:process signal_perms;
 allow transproxy_t self:tcp_socket create_stream_socket_perms;
+allow transproxy_t self:association { sendto recvfrom };
 
 allow transproxy_t transproxy_var_run_t:file create_file_perms;
 allow transproxy_t transproxy_var_run_t:dir rw_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ucspitcp.if serefpolicy-2.4.6.patchbox2/policy/modules/services/ucspitcp.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ucspitcp.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ucspitcp.if	2006-12-14 11:40:21.000000000 -0600
@@ -38,3 +38,39 @@ interface(`ucspitcp_service_domain', `
 	allow $1 ucspitcp_t:tcp_socket rw_stream_socket_perms;
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
+interface(`ucspitcp_recv_labeledipsec',`
+	gen_require(`
+		type ucspitcp_t, rblsmtpd_t;
+	')
+	allow $1 ucspitcp_t:association recvfrom;
+	allow $1 rblsmtpd_t:association recvfrom;
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
+interface(`ucspitcp_recv_labeledipsec_rblsmtpd',`
+	gen_require(`
+		type rblsmtpd_t;
+	')
+	allow $1 rblsmtpd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/ucspitcp.te serefpolicy-2.4.6.patchbox2/policy/modules/services/ucspitcp.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/ucspitcp.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/ucspitcp.te	2006-12-14 11:40:21.000000000 -0600
@@ -56,6 +56,7 @@ allow ucspitcp_t self:capability { setgi
 allow ucspitcp_t self:fifo_file { read write };
 allow ucspitcp_t self:tcp_socket create_stream_socket_perms;
 allow ucspitcp_t self:udp_socket create_socket_perms;
+allow ucspitcp_t self:association { sendto recvfrom };
 
 corecmd_search_bin(ucspitcp_t)
 corecmd_search_sbin(ucspitcp_t)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/uucp.if serefpolicy-2.4.6.patchbox2/policy/modules/services/uucp.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/uucp.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/uucp.if	2006-12-14 11:40:21.000000000 -0600
@@ -66,3 +66,39 @@ interface(`uucp_append_log',`
 	allow $1 uucpd_log_t:file { append getattr }
 ;
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
+interface(`uucp_recv_labeledipsec_uucpd',`
+	gen_require(`
+		type uucpd_t;
+	')
+	allow $1 uucpd_t:association recvfrom;
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
+interface(`uucp_recv_labeledipsec_uux',`
+	gen_require(`
+		type uux_t;
+	')
+	allow $1 uux_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/uucp.te serefpolicy-2.4.6.patchbox2/policy/modules/services/uucp.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/uucp.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/uucp.te	2006-12-14 11:40:21.000000000 -0600
@@ -44,6 +44,7 @@ allow uucpd_t self:fifo_file rw_file_per
 allow uucpd_t self:tcp_socket connected_stream_socket_perms;
 allow uucpd_t self:udp_socket create_socket_perms;
 allow uucpd_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
+allow uucpd_t self:association { sendto recvfrom };
 
 allow uucpd_t uucpd_log_t:file create_file_perms;
 allow uucpd_t uucpd_log_t:dir { rw_dir_perms setattr };
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/uwimap.if serefpolicy-2.4.6.patchbox2/policy/modules/services/uwimap.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/uwimap.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/uwimap.if	2006-12-14 11:40:21.000000000 -0600
@@ -23,3 +23,21 @@ interface(`uwimap_domtrans',`
 	allow imapd_t $1:fifo_file rw_file_perms;
 	allow imapd_t $1:process sigchld;
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
+interface(`uwimap_recv_labeledipsec',`
+	gen_require(`
+		type impad_t;
+	')
+	allow $1 imapd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/uwimap.te serefpolicy-2.4.6.patchbox2/policy/modules/services/uwimap.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/uwimap.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/uwimap.te	2006-12-14 11:40:21.000000000 -0600
@@ -27,6 +27,7 @@ dontaudit imapd_t self:capability sys_tt
 allow imapd_t self:process signal_perms;
 allow imapd_t self:fifo_file rw_file_perms;
 allow imapd_t self:tcp_socket create_stream_socket_perms;
+allow imapd_t self:association { sendto recvfrom };
 
 allow imapd_t imapd_tmp_t:dir create_dir_perms;
 allow imapd_t imapd_tmp_t:file create_file_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/watchdog.if serefpolicy-2.4.6.patchbox2/policy/modules/services/watchdog.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/watchdog.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/watchdog.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>Software watchdog</summary>
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
+interface(`watchdog_recv_labeledipsec',`
+	gen_require(`
+		type watchdog_t;
+	')
+	allow $1 watchdog_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/watchdog.te serefpolicy-2.4.6.patchbox2/policy/modules/services/watchdog.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/watchdog.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/watchdog.te	2006-12-14 11:40:21.000000000 -0600
@@ -28,6 +28,7 @@ allow watchdog_t self:fifo_file rw_file_
 allow watchdog_t self:unix_stream_socket create_socket_perms;
 allow watchdog_t self:tcp_socket create_stream_socket_perms;
 allow watchdog_t self:udp_socket create_socket_perms;
+allow wachdog_t self:association { sendto recvfrom };
 
 allow watchdog_t watchdog_log_t:file create_file_perms;
 logging_log_filetrans(watchdog_t,watchdog_log_t,file)
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/xprint.if serefpolicy-2.4.6.patchbox2/policy/modules/services/xprint.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/xprint.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/xprint.if	2006-12-14 11:40:21.000000000 -0600
@@ -1 +1,19 @@
 ## <summary>X print server</summary>
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
+interface(`xprint_recv_labeledipsec',`
+	gen_require(`
+		type mrtg_t;
+	')
+	allow $1 xprint_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/xprint.te serefpolicy-2.4.6.patchbox2/policy/modules/services/xprint.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/xprint.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/xprint.te	2006-12-14 11:40:21.000000000 -0600
@@ -23,6 +23,7 @@ allow xprint_t self:process signal_perms
 allow xprint_t self:fifo_file rw_file_perms;
 allow xprint_t self:tcp_socket create_stream_socket_perms;
 allow xprint_t self:udp_socket create_socket_perms;
+allow xprint_t self:association { sendto recvfrom };
 
 allow xprint_t xprint_var_run_t:file create_file_perms;
 allow xprint_t xprint_var_run_t:dir rw_dir_perms;
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/xserver.if serefpolicy-2.4.6.patchbox2/policy/modules/services/xserver.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/xserver.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/xserver.if	2006-12-14 11:40:21.000000000 -0600
@@ -60,6 +60,7 @@ template(`xserver_common_domain_template
 	allow $1_xserver_t self:netlink_route_socket r_netlink_socket_perms;
 	allow $1_xserver_t self:tcp_socket create_stream_socket_perms;
 	allow $1_xserver_t self:udp_socket create_socket_perms;
+	allow $1_xserver_t self:association { sendto recvfrom };
 
 	allow $1_xserver_t $1_xserver_tmp_t:dir manage_dir_perms;
 	allow $1_xserver_t $1_xserver_tmp_t:file manage_file_perms;
@@ -1200,3 +1201,38 @@ interface(`xserver_dontaudit_rw_xdm_pipe
 	dontaudit $1 xdm_t:fifo_file { getattr read write }; 
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
+interface(`xserver_recv_labeledipsec_xdm',`
+	gen_require(`
+		type xdm_t;
+	')
+	allow $1 xdm_t:association recvfrom;
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
+interface(`xserver_recv_labeledipsec_role',`
+	gen_require(`
+		type $1_xserver_t;
+	')
+	allow $2 $1_xserver_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/xserver.te serefpolicy-2.4.6.patchbox2/policy/modules/services/xserver.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/xserver.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/xserver.te	2006-12-14 11:40:21.000000000 -0600
@@ -94,6 +94,7 @@ allow xdm_t self:udp_socket create_socke
 allow xdm_t self:socket create_socket_perms;
 allow xdm_t self:appletalk_socket create_socket_perms;
 allow xdm_t self:key { search link write };
+allow xdm_t self:association { sendto recvfrom };
 
 # Supress permission check on .ICE-unix
 dontaudit xdm_t ice_tmp_t:dir { getattr setattr };
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/zebra.if serefpolicy-2.4.6.patchbox2/policy/modules/services/zebra.if
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/zebra.if	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/zebra.if	2006-12-14 11:40:21.000000000 -0600
@@ -21,3 +21,21 @@ interface(`zebra_read_config',`
 	allow $1 zebra_conf_t:dir r_dir_perms;
 	allow $1 zebra_conf_t:lnk_file r_file_perms;
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
+interface(`zebra_recv_labeledipsec',`
+	gen_require(`
+		type zebra_t;
+	')
+	allow $1 zebra_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patchbox1/policy/modules/services/zebra.te serefpolicy-2.4.6.patchbox2/policy/modules/services/zebra.te
--- serefpolicy-2.4.6.patchbox1/policy/modules/services/zebra.te	2006-12-14 11:43:25.000000000 -0600
+++ serefpolicy-2.4.6.patchbox2/policy/modules/services/zebra.te	2006-12-14 11:40:21.000000000 -0600
@@ -37,6 +37,7 @@ allow zebra_t self:netlink_route_socket 
 allow zebra_t self:tcp_socket { connect connected_stream_socket_perms };
 allow zebra_t self:udp_socket create_socket_perms;
 allow zebra_t self:rawip_socket create_socket_perms;
+allow zebra_t self:association { sendto recvfrom };
 
 allow zebra_t zebra_conf_t:dir r_dir_perms;
 allow zebra_t zebra_conf_t:file r_file_perms;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
