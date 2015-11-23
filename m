From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: bigon@debian.org, paul@paul-moore.com, jeffv@google.com,
 Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: fix bug in conditional rules handling
Date: Mon, 23 Nov 2015 16:07:41 -0500
Message-Id: <1448312861-3574-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

commit fa1aa143ac4a ("selinux: extended permissions for ioctls") introduced
a bug into the handling of conditional rules, skipping the processing
entirely when the caller does not provide an extended permissions (xperms)
structure.  Access checks from userspace using /sys/fs/selinux/access
do not include such a structure since that interface does not presently
expose extended permission information.  As a result, conditional rules
were being ignored entirely on userspace access requests, producing
denials when access was allowed by conditional rules in the policy.
Fix the bug by only skipping computation of extended permissions
in this situation, not the entire conditional rules processing.

Reported-by: Laurent Bigonville <bigon@debian.org>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/ss/conditional.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 18643bf..456e1a9 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -638,7 +638,7 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
 {
 	struct avtab_node *node;
 
-	if (!ctab || !key || !avd || !xperms)
+	if (!ctab || !key || !avd)
 		return;
 
 	for (node = avtab_search_node(ctab, key); node;
@@ -657,7 +657,7 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
 		if ((u16)(AVTAB_AUDITALLOW|AVTAB_ENABLED) ==
 		    (node->key.specified & (AVTAB_AUDITALLOW|AVTAB_ENABLED)))
 			avd->auditallow |= node->datum.u.data;
-		if ((node->key.specified & AVTAB_ENABLED) &&
+		if (xperms && (node->key.specified & AVTAB_ENABLED) &&
 				(node->key.specified & AVTAB_XPERMS))
 			services_compute_xperms_drivers(xperms, node);
 	}
-- 
2.4.3
