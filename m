Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3DJHqbZ032165
 for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2016 15:17:52 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] libsepol/cil: Improve type bounds check reporting
Date: Wed, 13 Apr 2016 15:19:16 -0400
Message-Id: <1460575157-5846-3-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1460575157-5846-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1460575157-5846-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

There are three improvements.

When calling cil_find_matching_avrule_in_ast(), one parameter specifies
whether to return a match of the exact same (not a duplicate) rule.
Since the target passed in is created and not actually in the tree
by making this parameter true an extra comparison can be avoided.

Currently, when printing a bounds violation trace, every match except
for the last one has only the parents of the rule printed. Only the
last rule has both its parents and the actual rule printed. Now the
parents and rule are printed for each match. This has the additional
benefit that if a match is not found (there should always be a match)
a seg fault will not occur.

To reduce the amount of error reporting, only print a trace of a
matching rule if it is different from the previous one.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_binary.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 5d7e52e..1f89bd1 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4577,6 +4577,7 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
 		if (bad) {
 			avtab_ptr_t cur;
 			struct cil_avrule target;
+			struct cil_tree_node *n1 = NULL;
 
                         target.is_extended = 0;
 			target.rule_kind = CIL_AVRULE_ALLOWED;
@@ -4588,7 +4589,6 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
 			for (cur = bad; cur; cur = cur->next) {
 				struct cil_list_item *i2;
 				struct cil_list *matching;
-				struct cil_tree_node *n;
 
 				rc = cil_avrule_from_sepol(pdb, cur, &target, type_value_to_cil, class_value_to_cil, perm_value_to_cil);
 				if (rc != SEPOL_OK) {
@@ -4597,7 +4597,7 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
 				}
 				__cil_print_rule("  ", "allow", &target);
 				cil_list_init(&matching, CIL_NODE);
-				rc = cil_find_matching_avrule_in_ast(db->ast->root, CIL_AVRULE, &target, matching, CIL_FALSE);
+				rc = cil_find_matching_avrule_in_ast(db->ast->root, CIL_AVRULE, &target, matching, CIL_TRUE);
 				if (rc) {
 					cil_log(CIL_ERR, "Error occurred while checking type bounds\n");
 					cil_list_destroy(&matching, CIL_FALSE);
@@ -4605,14 +4605,17 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
 					bounds_destroy_bad(bad);
 					goto exit;
 				}
-
 				cil_list_for_each(i2, matching) {
-					__cil_print_parents("    ", (struct cil_tree_node *)i2->data);
+					struct cil_tree_node *n2 = i2->data;
+					struct cil_avrule *r2 = n2->data;
+					if (n1 == n2) {
+						cil_log(CIL_ERR, "    <See previous>\n");
+					} else {
+						n1 = n2;
+						__cil_print_parents("    ", n2);
+						__cil_print_rule("      ", "allow", r2);
+					}
 				}
-				i2 = matching->tail;
-				n = i2->data;
-				__cil_print_rule("      ", "allow", n->data);
-				cil_log(CIL_ERR,"\n");
 				cil_list_destroy(&matching, CIL_FALSE);
 				cil_list_destroy(&target.perms.classperms, CIL_TRUE);
 			}
-- 
2.5.5
