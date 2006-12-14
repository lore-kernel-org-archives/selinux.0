Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBEJTpCL002476
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 14:29:51 -0500
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBEJUMSS011327
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 19:30:23 GMT
Message-Id: <20061214192905.606250000@hp.com>
References: <20061214192414.551708000@hp.com>
Date: Thu, 14 Dec 2006 14:24:18 -0500
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com
Subject: [PATCH 4/4] Policy patches to add MLS read/write-to-clearance access to inetd_t
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Paul Moore <paul.moore@hp.com>

There is a strong desire in the MLS/LSPP space to use xinetd and labeled
networking to start child daemons with the MLS label of the incoming
connection.  This patch give the inetd_t domain the ability to read and write
to sockets with MLS labels up to and including it's clearance MLS label.

Signed-of-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/services/inetd.te |    3 +++
 1 files changed, 3 insertions(+)

Index: refpolicy/policy/modules/services/inetd.te
===================================================================
--- refpolicy.orig/policy/modules/services/inetd.te
+++ refpolicy/policy/modules/services/inetd.te
@@ -71,6 +71,9 @@ corenet_sendrecv_all_client_packets(inet
 ifdef(`enable_mls',`
 	corenet_tcp_recv_netlabel(inetd_t)
 	corenet_udp_recv_netlabel(inetd_t)
+
+	mls_socket_read_to_clearance(inetd_t)
+	mls_socket_write_to_clearance(inetd_t)
 ')
 
 # listen on service ports:

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
