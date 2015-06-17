Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5HJwjvS023081
 for <selinux@tycho.nsa.gov>; Wed, 17 Jun 2015 15:58:45 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 03/10 v2] libsepol: Refactored neverallow checking.
Date: Wed, 17 Jun 2015 15:58:47 -0400
Message-Id: <1434571134-31452-4-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1434571134-31452-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1434571134-31452-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Instead of creating an expanded avtab, generating all of the avtab
keys corresponding to a neverallow rule and searching for a match,
walk the nodes in the avtab and use the attr_type_map and ebitmap
functions to find matching rules.

Memory usage is reduced from 370M to 125M and time is reduced from
14 sec to 2 sec. (Bounds checking commented out in both cases.)

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/include/sepol/policydb/policydb.h |   2 +-
 libsepol/src/assertion.c                   | 272 ++++++++++++++++++++---------
 2 files changed, 193 insertions(+), 81 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 78b09c4..5da016b 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -649,7 +649,7 @@ extern void level_datum_init(level_datum_t * x);
 extern void level_datum_destroy(level_datum_t * x);
 extern void cat_datum_init(cat_datum_t * x);
 extern void cat_datum_destroy(cat_datum_t * x);
-
+extern int check_assertion(policydb_t *p, avrule_t *avrule);
 extern int check_assertions(sepol_handle_t * handle,
 			    policydb_t * p, avrule_t * avrules);
 
diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index c335968..67a5ec4 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -27,11 +27,16 @@
 
 #include "debug.h"
 
-static void report_failure(sepol_handle_t *handle, policydb_t *p,
-			   const avrule_t * avrule,
+struct avtab_match_args {
+	sepol_handle_t *handle;
+	policydb_t *p;
+	avrule_t *avrule;
+	unsigned long errors;
+};
+
+static void report_failure(sepol_handle_t *handle, policydb_t *p, const avrule_t *avrule,
 			   unsigned int stype, unsigned int ttype,
-			   const class_perm_node_t *curperm,
-			   const avtab_ptr_t node)
+			   const class_perm_node_t *curperm, uint32_t perms)
 {
 	if (avrule->source_filename) {
 		ERR(handle, "neverallow on line %lu of %s (or line %lu of policy.conf) violated by allow %s %s:%s {%s };",
@@ -39,69 +44,208 @@ static void report_failure(sepol_handle_t *handle, policydb_t *p,
 		    p->p_type_val_to_name[stype],
 		    p->p_type_val_to_name[ttype],
 		    p->p_class_val_to_name[curperm->tclass - 1],
-		    sepol_av_to_string(p, curperm->tclass,
-				       node->datum.data & curperm->data));
+		    sepol_av_to_string(p, curperm->tclass, perms));
 	} else if (avrule->line) {
 		ERR(handle, "neverallow on line %lu violated by allow %s %s:%s {%s };",
 		    avrule->line, p->p_type_val_to_name[stype],
 		    p->p_type_val_to_name[ttype],
 		    p->p_class_val_to_name[curperm->tclass - 1],
-		    sepol_av_to_string(p, curperm->tclass,
-				       node->datum.data & curperm->data));
+		    sepol_av_to_string(p, curperm->tclass, perms));
 	} else {
 		ERR(handle, "neverallow violated by allow %s %s:%s {%s };",
 		    p->p_type_val_to_name[stype],
 		    p->p_type_val_to_name[ttype],
 		    p->p_class_val_to_name[curperm->tclass - 1],
-		    sepol_av_to_string(p, curperm->tclass,
-				       node->datum.data & curperm->data));
+		    sepol_av_to_string(p, curperm->tclass, perms));
 	}
 }
 
-static unsigned long check_assertion_helper(sepol_handle_t * handle,
-				  policydb_t * p,
-				  avtab_t * te_avtab, avtab_t * te_cond_avtab,
-				  unsigned int stype, unsigned int ttype,
-				  const avrule_t * avrule)
+static int match_any_class_permissions(class_perm_node_t *cp, uint32_t class, uint32_t data)
 {
-	avtab_key_t avkey;
-	avtab_ptr_t node;
-	class_perm_node_t *curperm;
-	unsigned long errors = 0;
+	for (; cp; cp = cp->next) {
+		if ((cp->tclass == class) && (cp->data & data)) {
+			break;
+		}
+	}
+	if (!cp)
+		return 0;
 
-	for (curperm = avrule->perms; curperm != NULL; curperm = curperm->next) {
-		avkey.source_type = stype + 1;
-		avkey.target_type = ttype + 1;
-		avkey.target_class = curperm->tclass;
-		avkey.specified = AVTAB_ALLOWED;
-		for (node = avtab_search_node(te_avtab, &avkey);
-		     node != NULL;
-		     node = avtab_search_node_next(node, avkey.specified)) {
-			if (node->datum.data & curperm->data) {
-				report_failure(handle, p, avrule, stype, ttype, curperm, node);
-				errors++;
-			}
+	return 1;
+}
+
+
+static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void *args)
+{
+	int rc = 0;
+	struct avtab_match_args *a = (struct avtab_match_args *)args;
+	sepol_handle_t *handle = a->handle;
+	policydb_t *p = a->p;
+	avrule_t *avrule = a->avrule;
+	class_perm_node_t *cp;
+	uint32_t perms;
+	ebitmap_t src_matches, tgt_matches, matches;
+	ebitmap_node_t *snode, *tnode;
+	unsigned int i, j;
+
+	if (k->specified != AVTAB_ALLOWED)
+		return 0;
+
+	if (!match_any_class_permissions(avrule->perms, k->target_class, d->data))
+		return 0;
+
+	ebitmap_init(&src_matches);
+	ebitmap_init(&tgt_matches);
+	ebitmap_init(&matches);
+
+	rc = ebitmap_and(&src_matches, &avrule->stypes.types,
+			 &p->attr_type_map[k->source_type - 1]);
+	if (rc)
+		goto oom;
+
+	if (ebitmap_length(&src_matches) == 0)
+		goto exit;
+
+	if (avrule->flags == RULE_SELF) {
+		rc = ebitmap_and(&matches, &p->attr_type_map[k->source_type - 1], &p->attr_type_map[k->target_type - 1]);
+		if (rc)
+			goto oom;
+		rc = ebitmap_and(&tgt_matches, &avrule->stypes.types, &matches);
+		if (rc)
+			goto oom;
+	} else {
+		rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
+		if (rc)
+			goto oom;
+	}
+
+	if (ebitmap_length(&tgt_matches) == 0)
+		goto exit;
+
+	for (cp = avrule->perms; cp; cp = cp->next) {
+		perms = cp->data & d->data;
+		if ((cp->tclass != k->target_class) || !perms) {
+			continue;
 		}
-		for (node = avtab_search_node(te_cond_avtab, &avkey);
-		     node != NULL;
-		     node = avtab_search_node_next(node, avkey.specified)) {
-			if (node->datum.data & curperm->data) {
-				report_failure(handle, p, avrule, stype, ttype, curperm, node);
-				errors++;
+
+		ebitmap_for_each_bit(&src_matches, snode, i) {
+			if (!ebitmap_node_get_bit(snode, i))
+				continue;
+			ebitmap_for_each_bit(&tgt_matches, tnode, j) {
+				if (!ebitmap_node_get_bit(tnode, j))
+					continue;
+				a->errors++;
+				report_failure(handle, p, avrule, i, j, cp, perms);
 			}
 		}
 	}
 
-	return errors;
+	goto exit;
+
+oom:
+	ERR(NULL, "Out of memory - unable to check neverallows");
+	
+exit:
+	ebitmap_destroy(&src_matches);
+	ebitmap_destroy(&tgt_matches);
+	ebitmap_destroy(&matches);
+	return rc;
+}
+
+int report_assertion_failures(sepol_handle_t *handle, policydb_t *p, avrule_t *avrule)
+{
+	int rc;
+	struct avtab_match_args args;
+
+	args.handle = handle;
+	args.p = p;
+	args.avrule = avrule;
+	args.errors = 0;
+
+	rc = avtab_map(&p->te_avtab, report_assertion_avtab_matches, &args);
+	if (rc)
+		goto oom;
+
+	rc = avtab_map(&p->te_cond_avtab, report_assertion_avtab_matches, &args);
+	if (rc)
+		goto oom;
+
+	return args.errors;
+
+oom:
+	return rc;
+}
+
+static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *args)
+{
+	int rc;
+	struct avtab_match_args *a = (struct avtab_match_args *)args;
+	policydb_t *p = a->p;
+	avrule_t *avrule = a->avrule;
+
+	if (k->specified != AVTAB_ALLOWED)
+		goto exit;
+
+	if (!match_any_class_permissions(avrule->perms, k->target_class, d->data))
+		goto exit;
+
+	rc = ebitmap_match_any(&avrule->stypes.types, &p->attr_type_map[k->source_type - 1]);
+	if (rc == 0)
+		goto exit;
+
+	if (avrule->flags == RULE_SELF) {
+		/* If the neverallow uses SELF, then it is not enough that the
+		 * neverallow's source matches the src and tgt of the rule being checked.
+		 * It must match the same thing in the src and tgt, so AND the source
+		 * and target together and check for a match on the result.
+		 */
+		ebitmap_t match;
+		rc = ebitmap_and(&match, &p->attr_type_map[k->source_type - 1], &p->attr_type_map[k->target_type - 1] );
+		if (rc) {
+			ebitmap_destroy(&match);
+			goto oom;
+		}
+		rc = ebitmap_match_any(&avrule->stypes.types, &match);
+		ebitmap_destroy(&match);
+	} else {
+		rc = ebitmap_match_any(&avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
+	}
+	if (rc == 0)
+		goto exit;
+
+	return 1;
+
+exit:
+	return 0;
+
+oom:
+	ERR(NULL, "Out of memory - unable to check neverallows");
+	return rc;
+}
+
+int check_assertion(policydb_t *p, avrule_t *avrule)
+{
+	int rc;
+	struct avtab_match_args args;
+
+	args.handle = NULL;
+	args.p = p;
+	args.avrule = avrule;
+	args.errors = 0;
+
+	rc = avtab_map(&p->te_avtab, check_assertion_avtab_match, &args);
+
+	if (rc == 0) {
+		rc = avtab_map(&p->te_cond_avtab, check_assertion_avtab_match, &args);
+	}
+
+	return rc;
 }
 
 int check_assertions(sepol_handle_t * handle, policydb_t * p,
 		     avrule_t * avrules)
 {
+	int rc;
 	avrule_t *a;
-	avtab_t te_avtab, te_cond_avtab;
-	ebitmap_node_t *snode, *tnode;
-	unsigned int i, j;
 	unsigned long errors = 0;
 
 	if (!avrules) {
@@ -111,54 +255,22 @@ int check_assertions(sepol_handle_t * handle, policydb_t * p,
 		return 0;
 	}
 
-	if (avrules) {
-		if (avtab_init(&te_avtab))
-			goto oom;
-		if (avtab_init(&te_cond_avtab)) {
-			avtab_destroy(&te_avtab);
-			goto oom;
-		}
-		if (expand_avtab(p, &p->te_avtab, &te_avtab) ||
-		    expand_avtab(p, &p->te_cond_avtab, &te_cond_avtab)) {
-			avtab_destroy(&te_avtab);
-			avtab_destroy(&te_cond_avtab);
-			goto oom;
-		}
-	}
-
 	for (a = avrules; a != NULL; a = a->next) {
-		ebitmap_t *stypes = &a->stypes.types;
-		ebitmap_t *ttypes = &a->ttypes.types;
-
 		if (!(a->specified & AVRULE_NEVERALLOW))
 			continue;
-
-		ebitmap_for_each_bit(stypes, snode, i) {
-			if (!ebitmap_node_get_bit(snode, i))
-				continue;
-			if (a->flags & RULE_SELF) {
-				errors += check_assertion_helper
-				    (handle, p, &te_avtab, &te_cond_avtab, i, i,
-				     a);
-			}
-			ebitmap_for_each_bit(ttypes, tnode, j) {
-				if (!ebitmap_node_get_bit(tnode, j))
-					continue;
-				errors += check_assertion_helper
-				    (handle, p, &te_avtab, &te_cond_avtab, i, j,
-				     a);
+		rc = check_assertion(p, a);
+		if (rc) {
+			rc = report_assertion_failures(handle, p, a);
+			if (rc < 0) {
+				ERR(handle, "Error occurred while checking neverallows");
+				return -1;
 			}
+			errors += rc;
 		}
 	}
 
 	if (errors)
 		ERR(handle, "%lu neverallow failures occurred", errors);
 
-	avtab_destroy(&te_avtab);
-	avtab_destroy(&te_cond_avtab);
 	return errors ? -1 : 0;
-
-      oom:
-	ERR(handle, "Out of memory - unable to check neverallows");
-	return -1;
 }
-- 
1.9.3
