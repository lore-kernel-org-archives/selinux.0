Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBLJsOot021083
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 14:54:24 -0500
Received: from QMTA04.westchester.pa.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBLJsNF8017784
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 19:54:23 GMT
Message-Id: <20071221192242.533048995@flek.lan>
Date: Fri, 21 Dec 2007 14:22:20 -0500
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] REFPOL: Add new object classes and permissions for labeled networking
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch reserves a new object class and permissions needed by the labeled
networking changes scheduled for 2.6.25.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/flask/access_vectors   |   10 ++++++++++
 policy/flask/security_classes |    3 +++
 2 files changed, 13 insertions(+)

Index: refpolicy_svn_repo/policy/flask/access_vectors
===================================================================
--- refpolicy_svn_repo.orig/policy/flask/access_vectors
+++ refpolicy_svn_repo/policy/flask/access_vectors
@@ -201,6 +201,8 @@ class node 
 	enforce_dest
 	dccp_recv
 	dccp_send
+	recvfrom
+	sendto
 }
 
 class netif
@@ -213,6 +215,8 @@ class netif
 	rawip_send
 	dccp_recv
 	dccp_send
+	ingress
+	egress
 }
 
 class netlink_socket
@@ -726,3 +730,9 @@ inherits database
 	import
 	export
 }
+
+# network peer labels
+class peer
+{
+	recv
+}
Index: refpolicy_svn_repo/policy/flask/security_classes
===================================================================
--- refpolicy_svn_repo.orig/policy/flask/security_classes
+++ refpolicy_svn_repo/policy/flask/security_classes
@@ -106,4 +106,7 @@ class db_column			# userspace
 class db_tuple			# userspace
 class db_blob			# userspace
 
+# network peer labels
+class peer
+
 # FLASK

-- 
paul moore
linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
