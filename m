Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5HJwjvX023081
 for <selinux@tycho.nsa.gov>; Wed, 17 Jun 2015 15:58:45 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 08/10 v2] libsepol/cil: Add CIL bounds checking and reporting.
Date: Wed, 17 Jun 2015 15:58:52 -0400
Message-Id: <1434571134-31452-9-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1434571134-31452-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1434571134-31452-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Use the libsepol bounds checking to check for and report user and
role bounds violations.

For type bounds checking, use libsepol bounds checking to determine
if there is a violation for a given type. For each violation display
an error message that includes the CIL AST from the root node to the
node of the rule causing the violation.

Example error report:
Child type b_t3_c exceeds bounds of parent b_t3
  (allow b_t3_c b_tc (file (write)))
    <root>
    booleanif at line 148633 of cil.conf.bounds
    true at line 148634 of cil.conf.bounds
    allow at line 148636 of cil.conf.bounds
      (allow b_t3_c b_tc (file (read write)))

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_binary.c | 135 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index f2cd938..3fade7f 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -3903,6 +3903,130 @@ exit:
 	return rc;
 }
 
+static struct cil_list *cil_classperms_from_sepol(const struct cil_db *db, policydb_t *pdb, uint16_t class, uint32_t data, struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_cil[])
+{
+	struct cil_classperms *cp;
+	struct cil_list *cp_list;
+	class_datum_t *sepol_class = pdb->class_val_to_struct[class - 1];
+	int i;
+
+	cil_classperms_init(&cp);
+
+	cp->class = class_value_to_cil[class];
+	if (!cp->class) goto exit;
+
+	cil_list_init(&cp->perms, CIL_PERM);
+	for (i = 0; i < sepol_class->permissions.nprim; i++) {
+		struct cil_perm *perm;
+		if ((data & (1 << i)) == 0) continue;
+		perm = perm_value_to_cil[class][i+1];
+		if (!perm) goto exit;
+		cil_list_append(cp->perms, CIL_PERM, perm);
+	}
+
+	cil_list_init(&cp_list, CIL_CLASSPERMS);
+	cil_list_append(cp_list, CIL_CLASSPERMS, cp);
+
+	return cp_list;
+
+exit:
+	cil_log(CIL_ERR,"Failed to create CIL class-permissions from sepol values\n");
+	return NULL;
+}
+
+static int cil_avrule_from_sepol(const struct cil_db *db, policydb_t *pdb, avtab_ptr_t sepol_rule, struct cil_avrule *cil_rule, void *type_value_to_cil[], struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_cil[])
+{
+	int rc = SEPOL_ERR;
+	avtab_key_t *k = &sepol_rule->key;
+	avtab_datum_t *d = &sepol_rule->datum;
+	cil_rule->src = type_value_to_cil[k->source_type];
+	if (!cil_rule->src) goto exit;
+
+	cil_rule->tgt = type_value_to_cil[k->target_type];
+	if (!cil_rule->tgt) goto exit;
+
+	cil_rule->classperms = cil_classperms_from_sepol(db, pdb, k->target_class, d->data, class_value_to_cil, perm_value_to_cil);
+	if (!cil_rule->classperms) goto exit;
+
+	return SEPOL_OK;
+
+exit:
+	cil_log(CIL_ERR,"Failed to create CIL AV rule from sepol values\n");
+	return rc;
+}
+
+static int cil_check_type_bounds(const struct cil_db *db, policydb_t *pdb, void *type_value_to_cil, struct cil_class *class_value_to_cil[], struct cil_perm **perm_value_to_cil[])
+{
+	int rc = SEPOL_OK;
+	int i;
+
+	for (i = 0; i < db->num_types; i++) {
+		type_datum_t *child;
+		type_datum_t *parent;
+		avtab_ptr_t bad = NULL;
+		int numbad = 0;
+		struct cil_type *t = db->val_to_type[i];
+
+		if (!t->bounds) continue;
+
+		rc = __cil_get_sepol_type_datum(pdb, DATUM(t), &child);
+		if (rc != SEPOL_OK) goto exit;
+
+		rc = __cil_get_sepol_type_datum(pdb, DATUM(t->bounds), &parent);
+		if (rc != SEPOL_OK) goto exit;
+
+		rc = bounds_check_type(NULL, pdb, child->s.value, parent->s.value, &bad, &numbad);
+		if (rc != SEPOL_OK) goto exit;
+
+		if (bad) {
+			avtab_ptr_t cur;
+			struct cil_avrule target;
+
+			target.rule_kind = CIL_AVRULE_ALLOWED;
+			target.src_str = NULL;
+			target.tgt_str = NULL;
+
+			cil_log(CIL_ERR, "Child type %s exceeds bounds of parent %s\n",
+				t->datum.fqn, t->bounds->datum.fqn);
+			for (cur = bad; cur; cur = cur->next) {
+				struct cil_list_item *i2;
+				struct cil_list *matching;
+				struct cil_tree_node *n;
+
+				rc = cil_avrule_from_sepol(db, pdb, cur, &target, type_value_to_cil, class_value_to_cil, perm_value_to_cil);
+				if (rc != SEPOL_OK) {
+					cil_log(CIL_ERR, "Failed to convert sepol avrule to CIL\n");
+					goto exit;
+				}
+				__cil_print_rule("  ", "allow", &target);
+				cil_list_init(&matching, CIL_NODE);
+				rc = cil_find_matching_avrule_in_ast(db->ast->root, CIL_AVRULE, &target, matching, CIL_FALSE);
+				if (rc) {
+					cil_log(CIL_ERR, "Error occurred while checking type bounds\n");
+					cil_list_destroy(&matching, CIL_FALSE);
+					cil_list_destroy(&target.classperms, CIL_TRUE);
+					bounds_destroy_bad(bad);
+					goto exit;
+				}
+
+				cil_list_for_each(i2, matching) {
+					__cil_print_parents("    ", (struct cil_tree_node *)i2->data);
+				}
+				i2 = matching->tail;
+				n = i2->data;
+				__cil_print_rule("      ", "allow", n->data);
+				cil_log(CIL_ERR,"\n");
+				cil_list_destroy(&matching, CIL_FALSE);
+				cil_list_destroy(&target.classperms, CIL_TRUE);
+			}
+			bounds_destroy_bad(bad);
+		}
+	}
+
+exit:
+	return rc;
+}
+
 // assumes policydb is already allocated and initialized properly with things
 // like policy type set to kernel and version set appropriately
 int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *policydb)
@@ -4021,6 +4145,17 @@ int cil_binary_create_allocated_pdb(const struct cil_db *db, sepol_policydb_t *p
 		cil_log(CIL_INFO, "Checking Neverallows\n");
 		rc = cil_check_neverallows(db, pdb, neverallows);
 		if (rc != SEPOL_OK) goto exit;
+
+		cil_log(CIL_INFO, "Checking User Bounds\n");
+		bounds_check_users(NULL, pdb);
+
+		cil_log(CIL_INFO, "Checking Role Bounds\n");
+		bounds_check_roles(NULL, pdb);
+
+		cil_log(CIL_INFO, "Checking Type Bounds\n");
+		rc = cil_check_type_bounds(db, pdb, type_value_to_cil, class_value_to_cil, perm_value_to_cil);
+		if (rc != SEPOL_OK) goto exit;
+
 	}
 
 	rc = SEPOL_OK;
-- 
1.9.3
