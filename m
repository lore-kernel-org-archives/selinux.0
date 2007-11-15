Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAFGU1JV007625
	for <selinux@tycho.nsa.gov>; Thu, 15 Nov 2007 11:30:01 -0500
Received: from g4t0014.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAFGU0ai010639
	for <selinux@tycho.nsa.gov>; Thu, 15 Nov 2007 16:30:00 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v7 08/13] SELinux: Add new peer permissions to the Flask
	definitions
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Thu, 15 Nov 2007 11:29:45 -0500
Message-ID: <20071115162945.9970.77214.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20071115162053.9970.49166.stgit@flek.americas.hpqcorp.net>
References: <20071115162053.9970.49166.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add additional Flask definitions to support the new "peer" object class.
---

 security/selinux/include/av_perm_to_string.h |    3 +++
 security/selinux/include/av_permissions.h    |    3 +++
 security/selinux/include/class_to_string.h   |    7 +++++++
 security/selinux/include/flask.h             |    1 +
 4 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
index 049bf69..1d56a6a 100644
--- a/security/selinux/include/av_perm_to_string.h
+++ b/security/selinux/include/av_perm_to_string.h
@@ -159,3 +159,6 @@
    S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NODE_BIND, "node_bind")
    S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NAME_CONNECT, "name_connect")
    S_(SECCLASS_MEMPROTECT, MEMPROTECT__MMAP_ZERO, "mmap_zero")
+   S_(SECCLASS_PEER, PEER__FLOW_IN, "flow_in")
+   S_(SECCLASS_PEER, PEER__FLOW_OUT, "flow_out")
+   S_(SECCLASS_PEER, PEER__RECV, "recv")
diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
index eda89a2..95d4674 100644
--- a/security/selinux/include/av_permissions.h
+++ b/security/selinux/include/av_permissions.h
@@ -824,3 +824,6 @@
 #define DCCP_SOCKET__NODE_BIND                    0x00400000UL
 #define DCCP_SOCKET__NAME_CONNECT                 0x00800000UL
 #define MEMPROTECT__MMAP_ZERO                     0x00000001UL
+#define PEER__FLOW_IN                             0x00000001UL
+#define PEER__FLOW_OUT                            0x00000002UL
+#define PEER__RECV                                0x00000004UL
diff --git a/security/selinux/include/class_to_string.h b/security/selinux/include/class_to_string.h
index e77de0e..b1b0d1d 100644
--- a/security/selinux/include/class_to_string.h
+++ b/security/selinux/include/class_to_string.h
@@ -64,3 +64,10 @@
     S_(NULL)
     S_("dccp_socket")
     S_("memprotect")
+    S_(NULL)
+    S_(NULL)
+    S_(NULL)
+    S_(NULL)
+    S_(NULL)
+    S_(NULL)
+    S_("peer")
diff --git a/security/selinux/include/flask.h b/security/selinux/include/flask.h
index a9c2b20..09e9dd2 100644
--- a/security/selinux/include/flask.h
+++ b/security/selinux/include/flask.h
@@ -50,6 +50,7 @@
 #define SECCLASS_KEY                                     58
 #define SECCLASS_DCCP_SOCKET                             60
 #define SECCLASS_MEMPROTECT                              61
+#define SECCLASS_PEER                                    68
 
 /*
  * Security identifier indices for initial entities


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
