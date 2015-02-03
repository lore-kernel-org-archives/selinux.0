From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol:  Maybe fix MacOS X build.
Date: Tue,  3 Feb 2015 13:35:02 -0500
Message-Id: <1422988502-23727-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

s6_addr32 is not portable; use s6_addr instead.

Change-Id: I21c237588d3e7200cefa3af96065f657dae4b1e7
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/cil/src/cil_binary.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index e43a7cf..f2b56e8 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -2806,8 +2806,8 @@ int cil_nodecon_to_policydb(policydb_t *pdb, struct cil_sort *nodecons)
 			new_ocon->u.node.mask = cil_nodecon->mask->ip.v4.s_addr;
 		} else if (cil_nodecon->addr->family == AF_INET6) {
 			new_ocon = cil_add_ocontext(&pdb->ocontexts[OCON_NODE6], &tail6);
-			memcpy(new_ocon->u.node6.addr, &cil_nodecon->addr->ip.v6.s6_addr32[0], 16);
-			memcpy(new_ocon->u.node6.mask, &cil_nodecon->mask->ip.v6.s6_addr32[0], 16);
+			memcpy(new_ocon->u.node6.addr, &cil_nodecon->addr->ip.v6.s6_addr[0], 16);
+			memcpy(new_ocon->u.node6.mask, &cil_nodecon->mask->ip.v6.s6_addr[0], 16);
 		} else {
 			/* should not get here */
 			rc = SEPOL_ERR;
-- 
1.9.3
