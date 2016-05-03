Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u43KQpOe002705
 for <selinux@tycho.nsa.gov>; Tue, 3 May 2016 16:26:51 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol: Change logic of bounds checking
Date: Tue,  3 May 2016 16:28:32 -0400
Message-Id: <1462307312-4220-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Change logic of bounds checking to match kernel's bound checking.

The following explanation is taken from Stephen Smalley's kernel
patch.

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

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/hierarchy.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
index b24b39e..778541a 100644
--- a/libsepol/src/hierarchy.c
+++ b/libsepol/src/hierarchy.c
@@ -301,20 +301,21 @@ static int bounds_check_rule(sepol_handle_t *handle, policydb_t *p,
 		ebitmap_for_each_bit(&p->attr_type_map[tgt - 1], tnode, i) {
 			if (!ebitmap_node_get_bit(tnode, i))
 				continue;
-			avtab_key.target_type = i + 1;
-			d = bounds_not_covered(global_avtab, cur_avtab,
-					       &avtab_key, data);
-			if (!d) continue;
 			td = p->type_val_to_struct[i];
 			if (td && td->bounds) {
 				avtab_key.target_type = td->bounds;
 				d = bounds_not_covered(global_avtab, cur_avtab,
 						       &avtab_key, data);
-				if (!d) continue;
+			} else {
+				avtab_key.target_type = i + 1;
+				d = bounds_not_covered(global_avtab, cur_avtab,
+						       &avtab_key, data);
+			}
+			if (d) {
+				(*numbad)++;
+				rc = bounds_add_bad(handle, child, i+1, class, d, bad);
+				if (rc) goto exit;
 			}
-			(*numbad)++;
-			rc = bounds_add_bad(handle, child, i+1, class, d, bad);
-			if (rc) goto exit;
 		}
 	}
 
-- 
2.5.5
