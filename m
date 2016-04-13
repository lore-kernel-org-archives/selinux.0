Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3DJHqba032165
 for <selinux@tycho.nsa.gov>; Wed, 13 Apr 2016 15:17:52 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] libsepol/cil: Cleanup neverallow checking and fail if
 bounds checking fails
Date: Wed, 13 Apr 2016 15:19:17 -0400
Message-Id: <1460575157-5846-4-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1460575157-5846-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1460575157-5846-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

For both neverallow and bounds checking keep neverallow and bounds
failures separate from program faults.

Have secilc exit with an error (and fail to build a binary policy)
when bounds checks fail.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_binary.c | 55 ++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 1f89bd1..8233dfd 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4383,10 +4383,9 @@ exit:
 	return rc;
 }
 
-static int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb, struct cil_tree_node *node)
+static int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb, struct cil_tree_node *node, int *violation)
 {
-	int rc = SEPOL_ERR;
-	int ret = CIL_FALSE;
+	int rc = SEPOL_OK;
 	struct cil_avrule *cil_rule = node->data;
 	struct cil_symtab_datum *tgt = cil_rule->tgt;
 	uint32_t kind;
@@ -4425,11 +4424,11 @@ static int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb, struct
 
 		rc = check_assertion(pdb, rule);
 		if (rc == CIL_TRUE) {
+			*violation = CIL_TRUE;
 			rc = __cil_print_neverallow_failure(db, node);
 			if (rc != SEPOL_OK) {
 				goto exit;
 			}
-			ret = CIL_TRUE;
 		}
 
 	} else {
@@ -4447,12 +4446,11 @@ static int cil_check_neverallow(const struct cil_db *db, policydb_t *pdb, struct
 			rule->xperms = item->data;
 			rc = check_assertion(pdb, rule);
 			if (rc == CIL_TRUE) {
+				*violation = CIL_TRUE;
 				rc = __cil_print_neverallow_failure(db, node);
 				if (rc != SEPOL_OK) {
 					goto exit;
 				}
-				ret = CIL_TRUE;
-				goto exit;
 			}
 		}
 	}
@@ -4469,34 +4467,23 @@ exit:
 	rule->xperms = NULL;
 	__cil_destroy_sepol_avrules(rule);
 
-	if (rc) {
-		return rc;
-	} else {
-		return ret;
-	}
+	return rc;
 }
 
-static int cil_check_neverallows(const struct cil_db *db, policydb_t *pdb, struct cil_list *neverallows)
+static int cil_check_neverallows(const struct cil_db *db, policydb_t *pdb, struct cil_list *neverallows, int *violation)
 {
 	int rc = SEPOL_OK;
-	int ret = CIL_FALSE;
 	struct cil_list_item *item;
 
 	cil_list_for_each(item, neverallows) {
-		rc = cil_check_neverallow(db, pdb, item->data);
-		if (rc < 0) {
+		rc = cil_check_neverallow(db, pdb, item->data, violation);
+		if (rc != SEPOL_OK) {
 			goto exit;
-		} else if (rc > 0) {
-			ret = CIL_TRUE;
 		}
 	}
 
 exit:
-	if (rc || ret) {
-		return SEPOL_ERR;
-	} else {
-		return SEPOL_OK;
-	}
+	return rc;
 }
 
 static struct cil_list *cil_classperms_from_sepol(policydb_t *pdb, uint16_t class, uint32_t data, struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_cil[])
@@ -4551,7 +4538,7 @@ exit:
 	return rc;
 }
 
-static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void *type_value_to_cil, struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_cil[])
+static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void *type_value_to_cil, struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_cil[], int *violation)
 {
 	int rc = SEPOL_OK;
 	int i;
@@ -4579,6 +4566,8 @@ static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void
 			struct cil_avrule target;
 			struct cil_tree_node *n1 = NULL;
 
+			*violation = CIL_TRUE;
+
                         target.is_extended = 0;
 			target.rule_kind = CIL_AVRULE_ALLOWED;
 			target.src_str = NULL;
@@ -4759,20 +4748,32 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 	__cil_set_conditional_state_and_flags(pdb);
 
 	if (db->disable_neverallow != CIL_TRUE) {
+		int violation = CIL_FALSE;
 		cil_log(CIL_INFO, "Checking Neverallows\n");
-		rc = cil_check_neverallows(db, pdb, neverallows);
+		rc = cil_check_neverallows(db, pdb, neverallows, &violation);
 		if (rc != SEPOL_OK) goto exit;
 
 		cil_log(CIL_INFO, "Checking User Bounds\n");
-		bounds_check_users(NULL, pdb);
+		rc = bounds_check_users(NULL, pdb);
+		if (rc) {
+			violation = CIL_TRUE;
+		}
 
 		cil_log(CIL_INFO, "Checking Role Bounds\n");
-		bounds_check_roles(NULL, pdb);
+		rc = bounds_check_roles(NULL, pdb);
+		if (rc) {
+			violation = CIL_TRUE;
+		}
 
 		cil_log(CIL_INFO, "Checking Type Bounds\n");
-		rc = cil_check_type_bounds(db, pdb, type_value_to_cil, class_value_to_cil, perm_value_to_cil);
+		rc = cil_check_type_bounds(db, pdb, type_value_to_cil, class_value_to_cil, perm_value_to_cil, &violation);
 		if (rc != SEPOL_OK) goto exit;
 
+		if (violation == CIL_TRUE) {
+			rc = SEPOL_ERR;
+			goto exit;
+		}
+
 	}
 
 	rc = SEPOL_OK;
-- 
2.5.5
