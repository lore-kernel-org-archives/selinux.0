Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uATL65hA022525
 for <selinux@tycho.nsa.gov>; Tue, 29 Nov 2016 16:06:05 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol: Fix neverallow checking to also check the other
 types when self is included in a target type set.
Date: Tue, 29 Nov 2016 16:05:48 -0500
Message-Id: <1480453548-21901-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When neverallow checking was refactored in commit 9e6840e, self
was not handled correctly. The assumption was made that self only
appeared by itself as a target type, when it may appear in a list of
types. Because of this, if self appears in a target type set of a
neverallow, the other types in the type set are not checked.

Example:

allow TYPE1 TYPE2:CLASS1 { PERM1 };
neverallow TYPE1 {TYPE2 self}:CLASS1 { PERM1 };

The old assertion checking would not find a violation in the rules
above because the target type TYPE2 would be ignored.

This fix will cause all of the types in a target list that includes
self to be checked.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/assertion.c | 53 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index a4be880..27c39e7 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -218,7 +218,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	avrule_t *avrule = a->avrule;
 	class_perm_node_t *cp;
 	uint32_t perms;
-	ebitmap_t src_matches, tgt_matches, matches;
+	ebitmap_t src_matches, tgt_matches, self_matches, matches;
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
 
@@ -230,6 +230,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 
 	ebitmap_init(&src_matches);
 	ebitmap_init(&tgt_matches);
+	ebitmap_init(&self_matches);
 	ebitmap_init(&matches);
 
 	rc = ebitmap_and(&src_matches, &avrule->stypes.types,
@@ -240,17 +241,23 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	if (ebitmap_length(&src_matches) == 0)
 		goto exit;
 
+	rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
+	if (rc)
+		goto oom;
+
 	if (avrule->flags == RULE_SELF) {
 		rc = ebitmap_and(&matches, &p->attr_type_map[k->source_type - 1], &p->attr_type_map[k->target_type - 1]);
 		if (rc)
 			goto oom;
-		rc = ebitmap_and(&tgt_matches, &avrule->stypes.types, &matches);
-		if (rc)
-			goto oom;
-	} else {
-		rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
+		rc = ebitmap_and(&self_matches, &avrule->stypes.types, &matches);
 		if (rc)
 			goto oom;
+
+		if (ebitmap_length(&self_matches) > 0) {
+			rc = ebitmap_union(&tgt_matches, &self_matches);
+			if (rc)
+				goto oom;
+		}
 	}
 
 	if (ebitmap_length(&tgt_matches) == 0)
@@ -288,6 +295,7 @@ oom:
 exit:
 	ebitmap_destroy(&src_matches);
 	ebitmap_destroy(&tgt_matches);
+	ebitmap_destroy(&self_matches);
 	ebitmap_destroy(&matches);
 	return rc;
 }
@@ -382,7 +390,7 @@ static int check_assertion_extended_permissions_avtab(avrule_t *avrule, avtab_t
 static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab,
 						avtab_key_t *k, policydb_t *p)
 {
-	ebitmap_t src_matches, tgt_matches, matches;
+	ebitmap_t src_matches, tgt_matches, self_matches, matches;
 	unsigned int i, j;
 	ebitmap_node_t *snode, *tnode;
 	class_perm_node_t *cp;
@@ -391,7 +399,9 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 
 	ebitmap_init(&src_matches);
 	ebitmap_init(&tgt_matches);
+	ebitmap_init(&self_matches);
 	ebitmap_init(&matches);
+
 	rc = ebitmap_and(&src_matches, &avrule->stypes.types,
 			 &p->attr_type_map[k->source_type - 1]);
 	if (rc)
@@ -400,19 +410,25 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 	if (ebitmap_length(&src_matches) == 0)
 		goto exit;
 
+	rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types,
+			 &p->attr_type_map[k->target_type -1]);
+	if (rc)
+		goto oom;
+
 	if (avrule->flags == RULE_SELF) {
 		rc = ebitmap_and(&matches, &p->attr_type_map[k->source_type - 1],
 				&p->attr_type_map[k->target_type - 1]);
 		if (rc)
 			goto oom;
-		rc = ebitmap_and(&tgt_matches, &avrule->stypes.types, &matches);
-		if (rc)
-			goto oom;
-	} else {
-		rc = ebitmap_and(&tgt_matches, &avrule->ttypes.types,
-				&p->attr_type_map[k->target_type -1]);
+		rc = ebitmap_and(&self_matches, &avrule->stypes.types, &matches);
 		if (rc)
 			goto oom;
+
+		if (ebitmap_length(&self_matches) > 0) {
+			rc = ebitmap_union(&tgt_matches, &self_matches);
+			if (rc)
+				goto oom;
+		}
 	}
 
 	if (ebitmap_length(&tgt_matches) == 0)
@@ -449,7 +465,7 @@ exit:
 
 static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *args)
 {
-	int rc;
+	int rc, rc2 = 0;
 	struct avtab_match_args *a = (struct avtab_match_args *)args;
 	policydb_t *p = a->p;
 	avrule_t *avrule = a->avrule;
@@ -477,12 +493,13 @@ static int check_assertion_avtab_match(avtab_key_t *k, avtab_datum_t *d, void *a
 			ebitmap_destroy(&match);
 			goto oom;
 		}
-		rc = ebitmap_match_any(&avrule->stypes.types, &match);
+		rc2 = ebitmap_match_any(&avrule->stypes.types, &match);
 		ebitmap_destroy(&match);
-	} else {
-		rc = ebitmap_match_any(&avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
 	}
-	if (rc == 0)
+
+	/* neverallow may have tgts even if it uses SELF */
+	rc = ebitmap_match_any(&avrule->ttypes.types, &p->attr_type_map[k->target_type -1]);
+	if (rc == 0 && rc2 == 0)
 		goto exit;
 
 	if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
-- 
2.7.4
