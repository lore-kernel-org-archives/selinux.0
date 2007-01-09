Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l09NlWav028375
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 18:47:32 -0500
Received: from e3.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l09NmKUL009514
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 23:48:20 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id l09NmKEQ009336
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 18:48:20 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id l09NmKjT248640
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 18:48:20 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l09NmKlJ012483
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 18:48:20 -0500
Received: from austin.ibm.com (netmail1.austin.ibm.com [9.41.248.175])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l09NmJOE012452
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 18:48:19 -0500
Received: from faith.austin.ibm.com (faith.austin.ibm.com [9.53.40.35])
	by austin.ibm.com (8.12.10/8.12.10) with ESMTP id l09NmJnP039894
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 17:48:19 -0600
Received: from faith.austin.ibm.com (localhost.localdomain [127.0.0.1])
	by faith.austin.ibm.com (8.13.4/8.12.8) with ESMTP id l09NXnTb027217
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 17:33:49 -0600
Received: (from jml@localhost)
	by faith.austin.ibm.com (8.13.4/8.13.4/Submit) id l09NXnuC027216
	for selinux@tycho.nsa.gov; Tue, 9 Jan 2007 17:33:49 -0600
Date: Tue, 9 Jan 2007 17:33:49 -0600
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200701092333.l09NXnuC027216@faith.austin.ibm.com>
To: selinux@tycho.nsa.gov
Subject: PATCH[2.2/3]: labeled ipsec policy
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Patch2 was too big to be received on this mailing list,
so I split it into two, 2.1 and 2.2.
My apologies for not readily realizing the patch had not
been received.

Regards,
Joy


diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/nessus.if serefpolicy-2.4.6.patch2/policy/modules/services/nessus.if
--- serefpolicy-2.4.6.patch/policy/modules/services/nessus.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/nessus.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/networkmanager.if serefpolicy-2.4.6.patch2/policy/modules/services/networkmanager.if
--- serefpolicy-2.4.6.patch/policy/modules/services/networkmanager.if	2007-01-04 15:33:11.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/networkmanager.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/nis.if serefpolicy-2.4.6.patch2/policy/modules/services/nis.if
--- serefpolicy-2.4.6.patch/policy/modules/services/nis.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/nis.if	2007-01-05 10:47:48.000000000 -0600
@@ -255,3 +255,75 @@ interface(`nis_domtrans_ypxfr',`
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/nscd.if serefpolicy-2.4.6.patch2/policy/modules/services/nscd.if
--- serefpolicy-2.4.6.patch/policy/modules/services/nscd.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/nscd.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/nsd.if serefpolicy-2.4.6.patch2/policy/modules/services/nsd.if
--- serefpolicy-2.4.6.patch/policy/modules/services/nsd.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/nsd.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/ntp.if serefpolicy-2.4.6.patch2/policy/modules/services/ntp.if
--- serefpolicy-2.4.6.patch/policy/modules/services/ntp.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/ntp.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/nx.if serefpolicy-2.4.6.patch2/policy/modules/services/nx.if
--- serefpolicy-2.4.6.patch/policy/modules/services/nx.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/nx.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/oav.if serefpolicy-2.4.6.patch2/policy/modules/services/oav.if
--- serefpolicy-2.4.6.patch/policy/modules/services/oav.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/oav.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/openvpn.if serefpolicy-2.4.6.patch2/policy/modules/services/openvpn.if
--- serefpolicy-2.4.6.patch/policy/modules/services/openvpn.if	2007-01-04 15:33:11.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/openvpn.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/pcscd.if serefpolicy-2.4.6.patch2/policy/modules/services/pcscd.if
--- serefpolicy-2.4.6.patch/policy/modules/services/pcscd.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/pcscd.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/pegasus.if serefpolicy-2.4.6.patch2/policy/modules/services/pegasus.if
--- serefpolicy-2.4.6.patch/policy/modules/services/pegasus.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/pegasus.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/perdition.if serefpolicy-2.4.6.patch2/policy/modules/services/perdition.if
--- serefpolicy-2.4.6.patch/policy/modules/services/perdition.if	2007-01-04 15:33:11.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/perdition.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/portmap.if serefpolicy-2.4.6.patch2/policy/modules/services/portmap.if
--- serefpolicy-2.4.6.patch/policy/modules/services/portmap.if	2007-01-04 15:33:11.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/portmap.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/portslave.if serefpolicy-2.4.6.patch2/policy/modules/services/portslave.if
--- serefpolicy-2.4.6.patch/policy/modules/services/portslave.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/portslave.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/postfix.if serefpolicy-2.4.6.patch2/policy/modules/services/postfix.if
--- serefpolicy-2.4.6.patch/policy/modules/services/postfix.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/postfix.if	2007-01-05 10:47:48.000000000 -0600
@@ -485,3 +485,256 @@ interface(`postfix_domtrans_user_mail_ha
 
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/postgresql.if serefpolicy-2.4.6.patch2/policy/modules/services/postgresql.if
--- serefpolicy-2.4.6.patch/policy/modules/services/postgresql.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/postgresql.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/postgrey.if serefpolicy-2.4.6.patch2/policy/modules/services/postgrey.if
--- serefpolicy-2.4.6.patch/policy/modules/services/postgrey.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/postgrey.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/ppp.if serefpolicy-2.4.6.patch2/policy/modules/services/ppp.if
--- serefpolicy-2.4.6.patch/policy/modules/services/ppp.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/ppp.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/privoxy.if serefpolicy-2.4.6.patch2/policy/modules/services/privoxy.if
--- serefpolicy-2.4.6.patch/policy/modules/services/privoxy.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/privoxy.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/procmail.if serefpolicy-2.4.6.patch2/policy/modules/services/procmail.if
--- serefpolicy-2.4.6.patch/policy/modules/services/procmail.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/procmail.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/pyzor.if serefpolicy-2.4.6.patch2/policy/modules/services/pyzor.if
--- serefpolicy-2.4.6.patch/policy/modules/services/pyzor.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/pyzor.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/qmail.if serefpolicy-2.4.6.patch2/policy/modules/services/qmail.if
--- serefpolicy-2.4.6.patch/policy/modules/services/qmail.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/qmail.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/radius.if serefpolicy-2.4.6.patch2/policy/modules/services/radius.if
--- serefpolicy-2.4.6.patch/policy/modules/services/radius.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/radius.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/radvd.if serefpolicy-2.4.6.patch2/policy/modules/services/radvd.if
--- serefpolicy-2.4.6.patch/policy/modules/services/radvd.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/radvd.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/razor.if serefpolicy-2.4.6.patch2/policy/modules/services/razor.if
--- serefpolicy-2.4.6.patch/policy/modules/services/razor.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/razor.if	2007-01-05 10:47:48.000000000 -0600
@@ -215,3 +215,39 @@ interface(`razor_domtrans',`
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/rdisc.if serefpolicy-2.4.6.patch2/policy/modules/services/rdisc.if
--- serefpolicy-2.4.6.patch/policy/modules/services/rdisc.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/rdisc.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/ricci.if serefpolicy-2.4.6.patch2/policy/modules/services/ricci.if
--- serefpolicy-2.4.6.patch/policy/modules/services/ricci.if	2007-01-04 15:33:11.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/ricci.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/rlogin.if serefpolicy-2.4.6.patch2/policy/modules/services/rlogin.if
--- serefpolicy-2.4.6.patch/policy/modules/services/rlogin.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/rlogin.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/roundup.if serefpolicy-2.4.6.patch2/policy/modules/services/roundup.if
--- serefpolicy-2.4.6.patch/policy/modules/services/roundup.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/roundup.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/rpc.if serefpolicy-2.4.6.patch2/policy/modules/services/rpc.if
--- serefpolicy-2.4.6.patch/policy/modules/services/rpc.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/rpc.if	2007-01-05 10:47:48.000000000 -0600
@@ -362,3 +362,57 @@ interface(`rpc_read_nfs_state_data',`
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/rshd.if serefpolicy-2.4.6.patch2/policy/modules/services/rshd.if
--- serefpolicy-2.4.6.patch/policy/modules/services/rshd.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/rshd.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/rsync.if serefpolicy-2.4.6.patch2/policy/modules/services/rsync.if
--- serefpolicy-2.4.6.patch/policy/modules/services/rsync.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/rsync.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/samba.if serefpolicy-2.4.6.patch2/policy/modules/services/samba.if
--- serefpolicy-2.4.6.patch/policy/modules/services/samba.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/samba.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/sasl.if serefpolicy-2.4.6.patch2/policy/modules/services/sasl.if
--- serefpolicy-2.4.6.patch/policy/modules/services/sasl.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/sasl.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/sendmail.if serefpolicy-2.4.6.patch2/policy/modules/services/sendmail.if
--- serefpolicy-2.4.6.patch/policy/modules/services/sendmail.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/sendmail.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/setroubleshoot.if serefpolicy-2.4.6.patch2/policy/modules/services/setroubleshoot.if
--- serefpolicy-2.4.6.patch/policy/modules/services/setroubleshoot.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/setroubleshoot.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/smartmon.if serefpolicy-2.4.6.patch2/policy/modules/services/smartmon.if
--- serefpolicy-2.4.6.patch/policy/modules/services/smartmon.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/smartmon.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/snmp.if serefpolicy-2.4.6.patch2/policy/modules/services/snmp.if
--- serefpolicy-2.4.6.patch/policy/modules/services/snmp.if	2007-01-04 15:33:11.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/snmp.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/snort.if serefpolicy-2.4.6.patch2/policy/modules/services/snort.if
--- serefpolicy-2.4.6.patch/policy/modules/services/snort.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/snort.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/soundserver.if serefpolicy-2.4.6.patch2/policy/modules/services/soundserver.if
--- serefpolicy-2.4.6.patch/policy/modules/services/soundserver.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/soundserver.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/spamassassin.if serefpolicy-2.4.6.patch2/policy/modules/services/spamassassin.if
--- serefpolicy-2.4.6.patch/policy/modules/services/spamassassin.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/spamassassin.if	2007-01-05 10:47:48.000000000 -0600
@@ -508,3 +508,40 @@ interface(`spamassassin_dontaudit_getatt
 
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/squid.if serefpolicy-2.4.6.patch2/policy/modules/services/squid.if
--- serefpolicy-2.4.6.patch/policy/modules/services/squid.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/squid.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/ssh.if serefpolicy-2.4.6.patch2/policy/modules/services/ssh.if
--- serefpolicy-2.4.6.patch/policy/modules/services/ssh.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/ssh.if	2007-01-08 17:24:52.000000000 -0600
@@ -50,6 +50,7 @@ template(`ssh_basic_client_template',`
 	type $1_ssh_t;
 	domain_type($1_ssh_t)
 	domain_entry_file($1_ssh_t,ssh_exec_t)
+	corenet_type($1_ssh_t)
 	role $3 types $1_ssh_t;
 
 	type $1_home_ssh_t;
@@ -460,6 +461,7 @@ template(`ssh_per_role_template',`
 template(`ssh_server_template', `
 	type $1_t, ssh_server;
 	auth_login_pgm_domain($1_t)
+	corenet_type($1_t)
 
 	type $1_devpts_t;
 	term_login_pty($1_devpts_t)
@@ -734,3 +736,39 @@ interface(`ssh_dontaudit_read_server_key
 
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/stunnel.if serefpolicy-2.4.6.patch2/policy/modules/services/stunnel.if
--- serefpolicy-2.4.6.patch/policy/modules/services/stunnel.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/stunnel.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/tcpd.if serefpolicy-2.4.6.patch2/policy/modules/services/tcpd.if
--- serefpolicy-2.4.6.patch/policy/modules/services/tcpd.if	2007-01-04 15:33:10.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/tcpd.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/telnet.if serefpolicy-2.4.6.patch2/policy/modules/services/telnet.if
--- serefpolicy-2.4.6.patch/policy/modules/services/telnet.if	2007-01-04 15:33:07.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/telnet.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/tftp.if serefpolicy-2.4.6.patch2/policy/modules/services/tftp.if
--- serefpolicy-2.4.6.patch/policy/modules/services/tftp.if	2007-01-04 15:33:11.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/tftp.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/timidity.if serefpolicy-2.4.6.patch2/policy/modules/services/timidity.if
--- serefpolicy-2.4.6.patch/policy/modules/services/timidity.if	2007-01-04 15:33:11.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/timidity.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/tor.if serefpolicy-2.4.6.patch2/policy/modules/services/tor.if
--- serefpolicy-2.4.6.patch/policy/modules/services/tor.if	2007-01-04 15:33:11.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/tor.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/transproxy.if serefpolicy-2.4.6.patch2/policy/modules/services/transproxy.if
--- serefpolicy-2.4.6.patch/policy/modules/services/transproxy.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/transproxy.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/ucspitcp.if serefpolicy-2.4.6.patch2/policy/modules/services/ucspitcp.if
--- serefpolicy-2.4.6.patch/policy/modules/services/ucspitcp.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/ucspitcp.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/uucp.if serefpolicy-2.4.6.patch2/policy/modules/services/uucp.if
--- serefpolicy-2.4.6.patch/policy/modules/services/uucp.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/uucp.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/uwimap.if serefpolicy-2.4.6.patch2/policy/modules/services/uwimap.if
--- serefpolicy-2.4.6.patch/policy/modules/services/uwimap.if	2007-01-04 15:33:11.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/uwimap.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/watchdog.if serefpolicy-2.4.6.patch2/policy/modules/services/watchdog.if
--- serefpolicy-2.4.6.patch/policy/modules/services/watchdog.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/watchdog.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/xprint.if serefpolicy-2.4.6.patch2/policy/modules/services/xprint.if
--- serefpolicy-2.4.6.patch/policy/modules/services/xprint.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/xprint.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/xserver.if serefpolicy-2.4.6.patch2/policy/modules/services/xserver.if
--- serefpolicy-2.4.6.patch/policy/modules/services/xserver.if	2007-01-04 15:33:09.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/xserver.if	2007-01-05 10:47:48.000000000 -0600
@@ -1201,3 +1201,38 @@ interface(`xserver_dontaudit_rw_xdm_pipe
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/services/zebra.if serefpolicy-2.4.6.patch2/policy/modules/services/zebra.if
--- serefpolicy-2.4.6.patch/policy/modules/services/zebra.if	2007-01-04 15:33:08.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/services/zebra.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/system/hotplug.if serefpolicy-2.4.6.patch2/policy/modules/system/hotplug.if
--- serefpolicy-2.4.6.patch/policy/modules/system/hotplug.if	2007-01-04 15:33:12.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/system/hotplug.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/system/init.if serefpolicy-2.4.6.patch2/policy/modules/system/init.if
--- serefpolicy-2.4.6.patch/policy/modules/system/init.if	2007-01-04 15:33:12.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/system/init.if	2007-01-05 10:47:48.000000000 -0600
@@ -1314,3 +1314,21 @@ interface(`init_manage_utmp',`
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/system/iscsi.if serefpolicy-2.4.6.patch2/policy/modules/system/iscsi.if
--- serefpolicy-2.4.6.patch/policy/modules/system/iscsi.if	2007-01-04 15:33:12.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/system/iscsi.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/system/logging.if serefpolicy-2.4.6.patch2/policy/modules/system/logging.if
--- serefpolicy-2.4.6.patch/policy/modules/system/logging.if	2007-01-04 15:33:12.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/system/logging.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/system/lvm.if serefpolicy-2.4.6.patch2/policy/modules/system/lvm.if
--- serefpolicy-2.4.6.patch/policy/modules/system/lvm.if	2007-01-04 15:33:12.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/system/lvm.if	2007-01-05 10:47:48.000000000 -0600
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
+		type clvmd_t;
+	')
+	allow $1 clvmd_t:association recvfrom;
+')
diff -urpN serefpolicy-2.4.6.patch/policy/modules/system/sysnetwork.if serefpolicy-2.4.6.patch2/policy/modules/system/sysnetwork.if
--- serefpolicy-2.4.6.patch/policy/modules/system/sysnetwork.if	2007-01-04 15:33:12.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/system/sysnetwork.if	2007-01-05 10:47:48.000000000 -0600
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
diff -urpN serefpolicy-2.4.6.patch/policy/modules/system/xen.if serefpolicy-2.4.6.patch2/policy/modules/system/xen.if
--- serefpolicy-2.4.6.patch/policy/modules/system/xen.if	2007-01-04 15:33:12.000000000 -0600
+++ serefpolicy-2.4.6.patch2/policy/modules/system/xen.if	2007-01-05 10:47:48.000000000 -0600
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

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
