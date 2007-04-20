Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3KIqNYd024945
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 14:52:23 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3KIqMxc006160
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 18:52:22 GMT
From: dwalsh@redhat.com
Date: Fri, 20 Apr 2007 14:52:19 -0400
Message-Id: <200704201852.l3KIqJnR027114@redsox.boston.devel.redhat.com>
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: cups sends mail, connects to smbd port and binds to ports 600-1023
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/cups.te	2007-03-26 10:39:04.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/cups.te	2007-04-11 17:07:34.000000000 -0400
@@ -151,9 +151,11 @@
 corenet_tcp_bind_reserved_port(cupsd_t)
 corenet_dontaudit_tcp_bind_all_reserved_ports(cupsd_t)
 corenet_tcp_connect_all_ports(cupsd_t)
+corenet_tcp_connect_smbd_port(cupsd_t)
 corenet_sendrecv_hplip_client_packets(cupsd_t)
 corenet_sendrecv_ipp_client_packets(cupsd_t)
 corenet_sendrecv_ipp_server_packets(cupsd_t)
+corenet_tcp_bind_all_rpc_ports(cupsd_t)
 
 dev_rw_printer(cupsd_t)
 dev_read_urand(cupsd_t)
@@ -294,6 +296,10 @@
 ')
 
 optional_policy(`
+	sendmail_domtrans(cupsd_t)
+')
+
+optional_policy(`
 	seutil_sigchld_newrole(cupsd_t)
 ')
 

From:  <dwalsh@redhat.com>
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: cups sends mail, connects to smbd port and binds to ports 600-1023


--- nsaserefpolicy/policy/modules/services/cups.te	2007-03-26 10:39:04.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/services/cups.te	2007-04-11 17:07:34.000000000 -0400
@@ -151,9 +151,11 @@
 corenet_tcp_bind_reserved_port(cupsd_t)
 corenet_dontaudit_tcp_bind_all_reserved_ports(cupsd_t)
 corenet_tcp_connect_all_ports(cupsd_t)
+corenet_tcp_connect_smbd_port(cupsd_t)
 corenet_sendrecv_hplip_client_packets(cupsd_t)
 corenet_sendrecv_ipp_client_packets(cupsd_t)
 corenet_sendrecv_ipp_server_packets(cupsd_t)
+corenet_tcp_bind_all_rpc_ports(cupsd_t)
 
 dev_rw_printer(cupsd_t)
 dev_read_urand(cupsd_t)
@@ -294,6 +296,10 @@
 ')
 
 optional_policy(`
+	sendmail_domtrans(cupsd_t)
+')
+
+optional_policy(`
 	seutil_sigchld_newrole(cupsd_t)
 ')
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
