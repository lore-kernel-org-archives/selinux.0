From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: drop unused socket security classes
Date: Wed, 11 Jan 2017 16:33:54 -0500
Message-Id: <1484170434-12803-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Several of the extended socket classes introduced by
commit da69a5306ab92e07 ("selinux: support distinctions
among all network address families") are never used because
sockets can never be created with the associated address family.
Remove these unused socket security classes.  The removed classes
are bridge_socket for PF_BRIDGE, ib_socket for PF_IB, and mpls_socket
for PF_MPLS.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/hooks.c            | 6 ------
 security/selinux/include/classmap.h | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 720dbd0..a5398fe 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1353,8 +1353,6 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
 			return SECCLASS_IPX_SOCKET;
 		case PF_NETROM:
 			return SECCLASS_NETROM_SOCKET;
-		case PF_BRIDGE:
-			return SECCLASS_BRIDGE_SOCKET;
 		case PF_ATMPVC:
 			return SECCLASS_ATMPVC_SOCKET;
 		case PF_X25:
@@ -1373,10 +1371,6 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
 			return SECCLASS_PPPOX_SOCKET;
 		case PF_LLC:
 			return SECCLASS_LLC_SOCKET;
-		case PF_IB:
-			return SECCLASS_IB_SOCKET;
-		case PF_MPLS:
-			return SECCLASS_MPLS_SOCKET;
 		case PF_CAN:
 			return SECCLASS_CAN_SOCKET;
 		case PF_TIPC:
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 0dfd26d..7898ffa 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -183,8 +183,6 @@ struct security_class_mapping secclass_map[] = {
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ "netrom_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
-	{ "bridge_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
 	{ "atmpvc_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ "x25_socket",
@@ -203,10 +201,6 @@ struct security_class_mapping secclass_map[] = {
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ "llc_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
-	{ "ib_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
-	{ "mpls_socket",
-	  { COMMON_SOCK_PERMS, NULL } },
 	{ "can_socket",
 	  { COMMON_SOCK_PERMS, NULL } },
 	{ "tipc_socket",
-- 
2.7.4
