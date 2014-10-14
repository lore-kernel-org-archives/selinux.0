From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol:  Report all neverallow violations.
Date: Tue, 14 Oct 2014 13:51:25 -0400
Message-Id: <1413309085-19729-1-git-send-email-sds@tycho.nsa.gov>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Switch libsepol check_assertions() from only reporting the first violation
to reporting them all.

Change-Id: I45b3502ff96b1d093574e1fecff93a582f8d00bd
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/src/assertion.c | 99 +++++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 47 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index ebc011b..5e4c4e8 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -27,38 +27,12 @@
 
 #include "debug.h"
 
-static int check_assertion_helper(sepol_handle_t * handle,
-				  policydb_t * p,
-				  avtab_t * te_avtab, avtab_t * te_cond_avtab,
-				  unsigned int stype, unsigned int ttype,
-				  avrule_t * avrule)
+static void report_failure(sepol_handle_t *handle, policydb_t *p,
+			   const avrule_t * avrule,
+			   unsigned int stype, unsigned int ttype,
+			   const class_perm_node_t *curperm,
+			   const avtab_ptr_t node)
 {
-	avtab_key_t avkey;
-	avtab_ptr_t node;
-	class_perm_node_t *curperm;
-
-	for (curperm = avrule->perms; curperm != NULL; curperm = curperm->next) {
-		avkey.source_type = stype + 1;
-		avkey.target_type = ttype + 1;
-		avkey.target_class = curperm->class;
-		avkey.specified = AVTAB_ALLOWED;
-		for (node = avtab_search_node(te_avtab, &avkey);
-		     node != NULL;
-		     node = avtab_search_node_next(node, avkey.specified)) {
-			if (node->datum.data & curperm->data)
-				goto err;
-		}
-		for (node = avtab_search_node(te_cond_avtab, &avkey);
-		     node != NULL;
-		     node = avtab_search_node_next(node, avkey.specified)) {
-			if (node->datum.data & curperm->data)
-				goto err;
-		}
-	}
-
-	return 0;
-
-      err:
 	if (avrule->source_filename) {
 		ERR(handle, "neverallow on line %lu of %s (or line %lu of policy.conf) violated by allow %s %s:%s {%s };",
 		    avrule->source_line, avrule->source_filename, avrule->line,
@@ -76,13 +50,49 @@ static int check_assertion_helper(sepol_handle_t * handle,
 				       node->datum.data & curperm->data));
 	} else {
 		ERR(handle, "neverallow violated by allow %s %s:%s {%s };",
-		    p->p_type_val_to_name[stype], 
+		    p->p_type_val_to_name[stype],
 		    p->p_type_val_to_name[ttype],
 		    p->p_class_val_to_name[curperm->class - 1],
 		    sepol_av_to_string(p, curperm->class,
 				       node->datum.data & curperm->data));
 	}
-	return -1;
+}
+
+static unsigned long check_assertion_helper(sepol_handle_t * handle,
+				  policydb_t * p,
+				  avtab_t * te_avtab, avtab_t * te_cond_avtab,
+				  unsigned int stype, unsigned int ttype,
+				  const avrule_t * avrule)
+{
+	avtab_key_t avkey;
+	avtab_ptr_t node;
+	class_perm_node_t *curperm;
+	unsigned long errors = 0;
+
+	for (curperm = avrule->perms; curperm != NULL; curperm = curperm->next) {
+		avkey.source_type = stype + 1;
+		avkey.target_type = ttype + 1;
+		avkey.target_class = curperm->class;
+		avkey.specified = AVTAB_ALLOWED;
+		for (node = avtab_search_node(te_avtab, &avkey);
+		     node != NULL;
+		     node = avtab_search_node_next(node, avkey.specified)) {
+			if (node->datum.data & curperm->data) {
+				report_failure(handle, p, avrule, stype, ttype, curperm, node);
+				errors++;
+			}
+		}
+		for (node = avtab_search_node(te_cond_avtab, &avkey);
+		     node != NULL;
+		     node = avtab_search_node_next(node, avkey.specified)) {
+			if (node->datum.data & curperm->data) {
+				report_failure(handle, p, avrule, stype, ttype, curperm, node);
+				errors++;
+			}
+		}
+	}
+
+	return errors;
 }
 
 int check_assertions(sepol_handle_t * handle, policydb_t * p,
@@ -92,7 +102,7 @@ int check_assertions(sepol_handle_t * handle, policydb_t * p,
 	avtab_t te_avtab, te_cond_avtab;
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
-	int rc;
+	unsigned long errors = 0;
 
 	if (!avrules) {
 		/* Since assertions are stored in avrules, if it is NULL
@@ -127,31 +137,26 @@ int check_assertions(sepol_handle_t * handle, policydb_t * p,
 			if (!ebitmap_node_get_bit(snode, i))
 				continue;
 			if (a->flags & RULE_SELF) {
-				if (check_assertion_helper
+				errors += check_assertion_helper
 				    (handle, p, &te_avtab, &te_cond_avtab, i, i,
-				     a)) {
-					rc = -1;
-					goto out;
-				}
+				     a);
 			}
 			ebitmap_for_each_bit(ttypes, tnode, j) {
 				if (!ebitmap_node_get_bit(tnode, j))
 					continue;
-				if (check_assertion_helper
+				errors += check_assertion_helper
 				    (handle, p, &te_avtab, &te_cond_avtab, i, j,
-				     a)) {
-					rc = -1;
-					goto out;
-				}
+				     a);
 			}
 		}
 	}
 
-	rc = 0;
-out:
+	if (errors)
+		ERR(handle, "%lu neverallow failures occurred", errors);
+
 	avtab_destroy(&te_avtab);
 	avtab_destroy(&te_cond_avtab);
-	return rc;
+	return errors ? -1 : 0;
 
       oom:
 	ERR(handle, "Out of memory - unable to check neverallows");
-- 
1.8.3.1
