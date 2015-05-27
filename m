From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [RFC][PATCH] selinux: Remove unused permission definitions
Date: Wed, 27 May 2015 11:03:25 -0400
Message-Id: <1432739005-1955-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Remove unused permission definitions from SELinux.
Many of these were only ever used in pre-mainline
versions of SELinux, prior to Linux 2.6.0.  Some of them
were used in the legacy network or compat_net=1 checks
that were disabled by default in Linux 2.6.18 and
fully removed in Linux 2.6.30.

Permissions never used in mainline Linux:
file swapon
filesystem transition
tcp_socket { connectto newconn acceptfrom }
node enforce_dest
unix_stream_socket { newconn acceptfrom }

Legacy network checks, removed in 2.6.30:
socket { recv_msg send_msg }
node { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send dccp_recv dccp_send }
netif { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send dccp_recv dccp_send }

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/include/classmap.h | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 1d8b924..5a4eef5 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -2,12 +2,12 @@
     "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append"
 
 #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
-    "rename", "execute", "swapon", "quotaon", "mounton", "audit_access", \
+    "rename", "execute", "quotaon", "mounton", "audit_access", \
     "open", "execmod"
 
 #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
     "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
-    "sendto", "recv_msg", "send_msg", "name_bind"
+    "sendto", "name_bind"
 
 #define COMMON_IPC_PERMS "create", "destroy", "getattr", "setattr", "read", \
 	    "write", "associate", "unix_read", "unix_write"
@@ -44,7 +44,7 @@ struct security_class_mapping secclass_map[] = {
 	    "audit_control", "setfcap", NULL } },
 	{ "filesystem",
 	  { "mount", "remount", "unmount", "getattr",
-	    "relabelfrom", "relabelto", "transition", "associate", "quotamod",
+	    "relabelfrom", "relabelto", "associate", "quotamod",
 	    "quotaget", NULL } },
 	{ "file",
 	  { COMMON_FILE_PERMS,
@@ -67,7 +67,7 @@ struct security_class_mapping secclass_map[] = {
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ "tcp_socket",
 	  { COMMON_SOCK_PERMS,
-	    "connectto", "newconn", "acceptfrom", "node_bind", "name_connect",
+	    "node_bind", "name_connect",
 	    NULL } },
 	{ "udp_socket",
 	  { COMMON_SOCK_PERMS,
@@ -76,13 +76,9 @@ struct security_class_mapping secclass_map[] = {
 	  { COMMON_SOCK_PERMS,
 	    "node_bind", NULL } },
 	{ "node",
-	  { "tcp_recv", "tcp_send", "udp_recv", "udp_send",
-	    "rawip_recv", "rawip_send", "enforce_dest",
-	    "dccp_recv", "dccp_send", "recvfrom", "sendto", NULL } },
+	  { "recvfrom", "sendto", NULL } },
 	{ "netif",
-	  {  "tcp_recv", "tcp_send", "udp_recv", "udp_send",
-	     "rawip_recv", "rawip_send", "dccp_recv", "dccp_send",
-	     "ingress", "egress", NULL } },
+	  { "ingress", "egress", NULL } },
 	{ "netlink_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ "packet_socket",
@@ -90,11 +86,9 @@ struct security_class_mapping secclass_map[] = {
 	{ "key_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ "unix_stream_socket",
-	  { COMMON_SOCK_PERMS, "connectto", "newconn", "acceptfrom", NULL
-	  } },
+	  { COMMON_SOCK_PERMS, "connectto", NULL } },
 	{ "unix_dgram_socket",
-	  { COMMON_SOCK_PERMS, NULL
-	  } },
+	  { COMMON_SOCK_PERMS, NULL } },
 	{ "sem",
 	  { COMMON_IPC_PERMS, NULL } },
 	{ "msg", { "send", "receive", NULL } },
-- 
2.1.0
