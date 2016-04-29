From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, dwalsh@redhat.com, jwcart2@tycho.nsa.gov,
 brindle@quarksecurity.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v2] selinux: Only apply bounds checking to source types
Date: Fri, 29 Apr 2016 12:29:57 -0400
Message-Id: <1461947397-4478-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The current bounds checking of both source and target types
requires allowing any domain that has access to the child
domain to also have the same permissions to the parent, which
is undesirable.  Drop the target bounds checking.

KaiGai Kohei originally removed all use of target bounds in
commit 7d52a155e38d ("selinux: remove dead code in
type_attribute_bounds_av()") but this was reverted in
commit 2ae3ba39389b ("selinux: libsepol: remove dead code in
check_avtab_hierarchy_callback()") because it would have
required explicitly allowing the parent any permissions
to the child that the child is allowed to itself.

This change in contrast retains the logic for the case where both
source and target types are bounded, thereby allowing access
if the parent of the source is allowed the corresponding
permissions to the parent of the target.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v2 retains the logic for the case where both source and target
types are bounded as described above, and amends the patch
description to explain the difference from KaiGai's earlier attempt.

 security/selinux/ss/services.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 89df646..ca42265 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -573,28 +573,14 @@ static void type_attribute_bounds_av(struct context *scontext,
 		masked = ~lo_avd.allowed & avd->allowed;
 	}
 
-	if (target->bounds) {
-		memset(&lo_avd, 0, sizeof(lo_avd));
-
-		memcpy(&lo_tcontext, tcontext, sizeof(lo_tcontext));
-		lo_tcontext.type = target->bounds;
-
-		context_struct_compute_av(scontext,
-					  &lo_tcontext,
-					  tclass,
-					  &lo_avd,
-					  NULL);
-		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
-			return;		/* no masked permission */
-		masked = ~lo_avd.allowed & avd->allowed;
-	}
-
 	if (source->bounds && target->bounds) {
 		memset(&lo_avd, 0, sizeof(lo_avd));
+
 		/*
-		 * lo_scontext and lo_tcontext are already
-		 * set up.
+		 * lo_scontext is already set up above.
 		 */
+		memcpy(&lo_tcontext, tcontext, sizeof(lo_tcontext));
+		lo_tcontext.type = target->bounds;
 
 		context_struct_compute_av(&lo_scontext,
 					  &lo_tcontext,
-- 
2.5.5
