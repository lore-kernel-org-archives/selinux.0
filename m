From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, dwalsh@redhat.com, jwcart2@tycho.ns.gov,
 brindle@quarksecurity.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: Only apply bounds checking to source types
Date: Thu, 28 Apr 2016 16:43:34 -0400
Message-Id: <1461876214-31134-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The current bounds checking of both source and target types
requires allowing any domain that has access to the child
domain to also have the same permissions to the parent, which
is undesirable.  Drop the target bounds checking.

KaiGai Kohei originally removed this checking in
commit 7d52a155e38d ("selinux: remove dead code in
type_attribute_bounds_av()") but this was reverted in
commit 2ae3ba39389b ("selinux: libsepol: remove dead code in
check_avtab_hierarchy_callback()").

However, it seems to be justified in order to allow use of typebounds
for exec-based domain transitions under NNP without loosening policy
for the parent domain.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 security/selinux/ss/services.c | 77 +++++++++++-------------------------------
 1 file changed, 19 insertions(+), 58 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 89df646..4b23a48 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -543,77 +543,38 @@ static void type_attribute_bounds_av(struct context *scontext,
 				     struct av_decision *avd)
 {
 	struct context lo_scontext;
-	struct context lo_tcontext;
 	struct av_decision lo_avd;
 	struct type_datum *source;
-	struct type_datum *target;
-	u32 masked = 0;
+	u32 masked;
 
 	source = flex_array_get_ptr(policydb.type_val_to_struct_array,
 				    scontext->type - 1);
 	BUG_ON(!source);
 
-	target = flex_array_get_ptr(policydb.type_val_to_struct_array,
-				    tcontext->type - 1);
-	BUG_ON(!target);
-
-	if (source->bounds) {
-		memset(&lo_avd, 0, sizeof(lo_avd));
+	if (!source->bounds)
+		return;
 
-		memcpy(&lo_scontext, scontext, sizeof(lo_scontext));
-		lo_scontext.type = source->bounds;
+	memset(&lo_avd, 0, sizeof(lo_avd));
 
-		context_struct_compute_av(&lo_scontext,
-					  tcontext,
-					  tclass,
-					  &lo_avd,
-					  NULL);
-		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
-			return;		/* no masked permission */
-		masked = ~lo_avd.allowed & avd->allowed;
-	}
+	memcpy(&lo_scontext, scontext, sizeof(lo_scontext));
+	lo_scontext.type = source->bounds;
 
-	if (target->bounds) {
-		memset(&lo_avd, 0, sizeof(lo_avd));
+	context_struct_compute_av(&lo_scontext,
+				  tcontext,
+				  tclass,
+				  &lo_avd,
+				  NULL);
+	if ((lo_avd.allowed & avd->allowed) == avd->allowed)
+		return;		/* no masked permission */
 
-		memcpy(&lo_tcontext, tcontext, sizeof(lo_tcontext));
-		lo_tcontext.type = target->bounds;
+	masked = ~lo_avd.allowed & avd->allowed;
 
-		context_struct_compute_av(scontext,
-					  &lo_tcontext,
-					  tclass,
-					  &lo_avd,
-					  NULL);
-		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
-			return;		/* no masked permission */
-		masked = ~lo_avd.allowed & avd->allowed;
-	}
+	/* mask violated permissions */
+	avd->allowed &= ~masked;
 
-	if (source->bounds && target->bounds) {
-		memset(&lo_avd, 0, sizeof(lo_avd));
-		/*
-		 * lo_scontext and lo_tcontext are already
-		 * set up.
-		 */
-
-		context_struct_compute_av(&lo_scontext,
-					  &lo_tcontext,
-					  tclass,
-					  &lo_avd,
-					  NULL);
-		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
-			return;		/* no masked permission */
-		masked = ~lo_avd.allowed & avd->allowed;
-	}
-
-	if (masked) {
-		/* mask violated permissions */
-		avd->allowed &= ~masked;
-
-		/* audit masked permissions */
-		security_dump_masked_av(scontext, tcontext,
-					tclass, masked, "bounds");
-	}
+	/* audit masked permissions */
+	security_dump_masked_av(scontext, tcontext,
+				tclass, masked, "bounds");
 }
 
 /*
-- 
2.5.5
