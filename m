Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBEJSbVt002400
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 14:28:37 -0500
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBEJT8SS011070
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 19:29:09 GMT
Message-Id: <20061214192904.819757000@hp.com>
References: <20061214192414.551708000@hp.com>
Date: Thu, 14 Dec 2006 14:24:17 -0500
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 3/4] Policy patches to add a MLS socket write-to-clearance interface
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Paul Moore <paul.moore@hp.com>

This adds a mls_socket_write_to_clearance() interface which is similar in
fashion to the mls_socket_read_to_clearance() interface.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/modules/kernel/mls.if |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+)

Index: refpolicy/policy/modules/kernel/mls.if
===================================================================
--- refpolicy.orig/policy/modules/kernel/mls.if
+++ refpolicy/policy/modules/kernel/mls.if
@@ -154,6 +154,26 @@ interface(`mls_socket_read_to_clearance'
 ########################################
 ## <summary>
 ##	Make specified domain MLS trusted
+##	for writing to sockets at any level
+##	that is dominated by the process clearance.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mls_socket_write_to_clearance',`
+	gen_require(`
+		attribute mlsnetwritetoclr;
+	')
+
+	typeattribute $1 mlsnetwritetoclr;
+')
+
+########################################
+## <summary>
+##	Make specified domain MLS trusted
 ##	for writing to sockets at any level.
 ## </summary>
 ## <param name="domain">

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
