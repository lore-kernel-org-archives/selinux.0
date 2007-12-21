Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBLHRmHp004529
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 12:27:48 -0500
Received: from QMTA03.westchester.pa.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBLHRiF8015340
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 17:27:44 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v9 12/18] SELinux: Add a new peer class and permissions to
	the Flask definitions
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Cc: vyekkirala@TrustedCS.com, chanson@TrustedCS.com
Date: Fri, 21 Dec 2007 12:09:59 -0500
Message-ID: <20071221170959.12522.46443.stgit@flek.lan>
In-Reply-To: <20071221165109.12522.29726.stgit@flek.lan>
References: <20071221165109.12522.29726.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add additional Flask definitions to support the new "peer" object class and
additional permissions to the netif and node object classes.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 security/selinux/include/av_perm_to_string.h |    5 +++++
 security/selinux/include/av_permissions.h    |    5 +++++
 security/selinux/include/class_to_string.h   |    7 +++++++
 security/selinux/include/flask.h             |    1 +
 4 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
index 049bf69..caa0634 100644
--- a/security/selinux/include/av_perm_to_string.h
+++ b/security/selinux/include/av_perm_to_string.h
@@ -37,6 +37,8 @@
    S_(SECCLASS_NODE, NODE__ENFORCE_DEST, "enforce_dest")
    S_(SECCLASS_NODE, NODE__DCCP_RECV, "dccp_recv")
    S_(SECCLASS_NODE, NODE__DCCP_SEND, "dccp_send")
+   S_(SECCLASS_NODE, NODE__RECVFROM, "recvfrom")
+   S_(SECCLASS_NODE, NODE__SENDTO, "sendto")
    S_(SECCLASS_NETIF, NETIF__TCP_RECV, "tcp_recv")
    S_(SECCLASS_NETIF, NETIF__TCP_SEND, "tcp_send")
    S_(SECCLASS_NETIF, NETIF__UDP_RECV, "udp_recv")
@@ -45,6 +47,8 @@
    S_(SECCLASS_NETIF, NETIF__RAWIP_SEND, "rawip_send")
    S_(SECCLASS_NETIF, NETIF__DCCP_RECV, "dccp_recv")
    S_(SECCLASS_NETIF, NETIF__DCCP_SEND, "dccp_send")
+   S_(SECCLASS_NETIF, NETIF__INGRESS, "ingress")
+   S_(SECCLASS_NETIF, NETIF__EGRESS, "egress")
    S_(SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__CONNECTTO, "connectto")
    S_(SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__NEWCONN, "newconn")
    S_(SECCLASS_UNIX_STREAM_SOCKET, UNIX_STREAM_SOCKET__ACCEPTFROM, "acceptfrom")
@@ -159,3 +163,4 @@
    S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NODE_BIND, "node_bind")
    S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NAME_CONNECT, "name_connect")
    S_(SECCLASS_MEMPROTECT, MEMPROTECT__MMAP_ZERO, "mmap_zero")
+   S_(SECCLASS_PEER, PEER__RECV, "recv")
diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
index eda89a2..c2b5bb2 100644
--- a/security/selinux/include/av_permissions.h
+++ b/security/selinux/include/av_permissions.h
@@ -292,6 +292,8 @@
 #define NODE__ENFORCE_DEST                        0x00000040UL
 #define NODE__DCCP_RECV                           0x00000080UL
 #define NODE__DCCP_SEND                           0x00000100UL
+#define NODE__RECVFROM                            0x00000200UL
+#define NODE__SENDTO                              0x00000400UL
 #define NETIF__TCP_RECV                           0x00000001UL
 #define NETIF__TCP_SEND                           0x00000002UL
 #define NETIF__UDP_RECV                           0x00000004UL
@@ -300,6 +302,8 @@
 #define NETIF__RAWIP_SEND                         0x00000020UL
 #define NETIF__DCCP_RECV                          0x00000040UL
 #define NETIF__DCCP_SEND                          0x00000080UL
+#define NETIF__INGRESS                            0x00000100UL
+#define NETIF__EGRESS                             0x00000200UL
 #define NETLINK_SOCKET__IOCTL                     0x00000001UL
 #define NETLINK_SOCKET__READ                      0x00000002UL
 #define NETLINK_SOCKET__WRITE                     0x00000004UL
@@ -824,3 +828,4 @@
 #define DCCP_SOCKET__NODE_BIND                    0x00400000UL
 #define DCCP_SOCKET__NAME_CONNECT                 0x00800000UL
 #define MEMPROTECT__MMAP_ZERO                     0x00000001UL
+#define PEER__RECV                                0x00000001UL
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
