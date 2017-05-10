From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] checkpolicy,libsepol: drop unnecessary usage of s6_addr32
Date: Wed, 10 May 2017 10:24:36 -0400
Message-Id: <20170510142436.30161-1-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

s6_addr32 is not portable; use s6_addr instead.
This obviates the need for #ifdef __APPLE__ conditionals in these cases.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 checkpolicy/policy_define.c | 6 ------
 libsepol/src/node_record.c  | 8 --------
 2 files changed, 14 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 63e3c53..8fab214 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -5260,14 +5260,8 @@ int define_ipv6_node_context(void)
 	}
 
 	memset(newc, 0, sizeof(ocontext_t));
-
-#ifdef __APPLE__
 	memcpy(&newc->u.node6.addr[0], &addr.s6_addr[0], 16);
 	memcpy(&newc->u.node6.mask[0], &mask.s6_addr[0], 16);
-#else
-	memcpy(&newc->u.node6.addr[0], &addr.s6_addr32[0], 16);
-	memcpy(&newc->u.node6.mask[0], &mask.s6_addr32[0], 16);
-#endif
 
 	if (parse_security_context(&newc->context[0])) {
 		free(newc);
diff --git a/libsepol/src/node_record.c b/libsepol/src/node_record.c
index 21043b6..6189c31 100644
--- a/libsepol/src/node_record.c
+++ b/libsepol/src/node_record.c
@@ -70,11 +70,7 @@ static int node_parse_addr(sepol_handle_t * handle,
 				return STATUS_ERR;
 			}
 
-#ifdef __APPLE__
 			memcpy(addr_bytes, in_addr.s6_addr, 16);
-#else
-			memcpy(addr_bytes, in_addr.s6_addr32, 16);
-#endif
 			break;
 		}
 	default:
@@ -162,11 +158,7 @@ static int node_expand_addr(sepol_handle_t * handle,
 		{
 			struct in6_addr addr;
 			memset(&addr, 0, sizeof(struct in6_addr));
-#ifdef __APPLE__
 			memcpy(&addr.s6_addr[0], addr_bytes, 16);
-#else
-			memcpy(&addr.s6_addr32[0], addr_bytes, 16);
-#endif
 			if (inet_ntop(AF_INET6, &addr, addr_str,
 				      INET6_ADDRSTRLEN) == NULL) {
 
-- 
2.9.3
