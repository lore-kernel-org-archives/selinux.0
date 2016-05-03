From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: paul@paul-moore.com, dwalsh@redhat.com, jwcart2@tycho.nsa.gov,
 brindle@quarksecurity.com, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v3] selinux: Only apply bounds checking to source types
Date: Tue,  3 May 2016 13:48:20 -0400
Message-Id: <1462297700-31193-1-git-send-email-sds@tycho.nsa.gov>
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
permissions to the parent of the target.  Further, this change
reworks the logic such that we only perform a single computation
for each case and there is no ambiguity as to how to resolve
a bounds violation.

Under the new logic, if the source type and target types are both
bounded, then the parent of the source type must be allowed the same
permissions to the parent of the target type.  If only the source
type is bounded, then the parent of the source type must be allowed
the same permissions to the target type.

Examples of the new logic and comparisons with the old logic:
1. If we have:
	typebounds A B;
then:
	allow B self:process <permissions>;
will satisfy the bounds constraint iff:
	allow A self:process <permissions>;
is also allowed in policy.

Under the old logic, the allow rule on B satisfies the
bounds constraint if any of the following three are allowed:
	allow A B:process <permissions>; or
	allow B A:process <permissions>; or
	allow A self:process <permissions>;
However, either of the first two ultimately require the third to satisfy
the bounds constraint under the old logic, and therefore this degenerates
to the same result (but is more efficient - we only need to perform
one compute_av call).

2. If we have:
	typebounds A B;
	typebounds A_exec B_exec;
then:
	allow B B_exec:file <permissions>;
will satisfy the bounds constraint iff:
	allow A A_exec:file <permissions>;
is also allowed in policy.

This is essentially the same as #1; it is merely included as
an example of dealing with object types related to a bounded domain
in a manner that satisfies the bounds relationship.  Note that
this approach is preferable to leaving B_exec unbounded and having:
	allow A B_exec:file <permissions>;
in policy because that would allow B's entrypoints to be used to
enter A.  Similarly for _tmp or other related types.

3. If we have:
	typebounds A B;
and an unbounded type T, then:
	allow B T:file <permissions>;
will satisfy the bounds constraint iff:
	allow A T:file <permissions>;
is allowed in policy.

The old logic would have been identical for this example.

4. If we have:
	typebounds A B;
and an unbounded domain D, then:
	allow D B:unix_stream_socket <permissions>;
is not subject to any bounds constraints under the new logic
because D is not bounded.  This is desirable so that we can
allow a domain to e.g. connectto a child domain without having
to allow it to do the same to its parent.

The old logic would have required:
	allow D A:unix_stream_socket <permissions>;
to also be allowed in policy.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
v3 fixes an ambiguity introduced by v2, which would have allowed
the bounds constraint when the target type is bounded to be resolved
in two different ways.  v3 should also yield more efficient code since
we now only have to perform a single compute_av call.

While this is a change in logic, it is "compatible" in the sense that
it only allows what would have been previously denied (example 4 above),
and I am not aware of anyone relying on the previous behavior.
selinux-testsuite still passes since it does not exercise the bounded
target type case.

 security/selinux/ss/services.c | 36 +++++++++---------------------------
 1 file changed, 9 insertions(+), 27 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 89df646..48babec 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -553,33 +553,23 @@ static void type_attribute_bounds_av(struct context *scontext,
 				    scontext->type - 1);
 	BUG_ON(!source);
 
+	if (!source->bounds)
+		return;
+
 	target = flex_array_get_ptr(policydb.type_val_to_struct_array,
 				    tcontext->type - 1);
 	BUG_ON(!target);
 
-	if (source->bounds) {
-		memset(&lo_avd, 0, sizeof(lo_avd));
-
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
 
 	if (target->bounds) {
-		memset(&lo_avd, 0, sizeof(lo_avd));
-
 		memcpy(&lo_tcontext, tcontext, sizeof(lo_tcontext));
 		lo_tcontext.type = target->bounds;
 
-		context_struct_compute_av(scontext,
+		context_struct_compute_av(&lo_scontext,
 					  &lo_tcontext,
 					  tclass,
 					  &lo_avd,
@@ -587,17 +577,9 @@ static void type_attribute_bounds_av(struct context *scontext,
 		if ((lo_avd.allowed & avd->allowed) == avd->allowed)
 			return;		/* no masked permission */
 		masked = ~lo_avd.allowed & avd->allowed;
-	}
-
-	if (source->bounds && target->bounds) {
-		memset(&lo_avd, 0, sizeof(lo_avd));
-		/*
-		 * lo_scontext and lo_tcontext are already
-		 * set up.
-		 */
-
+	} else {
 		context_struct_compute_av(&lo_scontext,
-					  &lo_tcontext,
+					  tcontext,
 					  tclass,
 					  &lo_avd,
 					  NULL);
-- 
2.5.5
