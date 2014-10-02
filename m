Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s92DBQTs030422
 for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2014 09:11:28 -0400
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 3/3] policycoreutils/hll/pp: change printing behavior of
 typeattribute/sets
Date: Thu, 2 Oct 2014 09:10:10 -0400
Message-ID: <1412255410-15537-4-git-send-email-ykhodorkovskiy@tresys.com>
In-Reply-To: <1412255410-15537-1-git-send-email-ykhodorkovskiy@tresys.com>
References: <1412255410-15537-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Avrules that have the negation, star, or complement flag set for types
need typeattributes and typeattributesets that are generated. This caused
issues when these generated statements were inserted into conditionals, since
typeattributes/sets are not allowed in conditionals.

This change always prints typeattributes and typeattributesets
immediately unless the types appear inside of an avrule in conditionals or blocks.
For this special case, we print the typeattributes after the end
of each conditional/block.

Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 policycoreutils/hll/pp/pp.c | 351 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 290 insertions(+), 61 deletions(-)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index 55cf819..3f32350 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -121,6 +121,15 @@ struct role_list_node {
 	role_datum_t *role;
 };
 
+struct attr_list_node {
+	char *attribute;
+	int is_type;
+	union {
+		struct type_set *ts;
+		struct role_set *rs;
+	} set;
+};
+
 struct list_node {
 	void *data;
 	struct list_node *next;
@@ -164,6 +173,29 @@ static void role_list_destroy(void)
 	list_destroy(&role_list);
 }
 
+static void attr_list_destroy(struct list **attr_list)
+{
+	if (attr_list == NULL || *attr_list == NULL) {
+		return;
+	}
+
+	struct list_node *curr = (*attr_list)->head;
+	struct attr_list_node *attr;
+
+	while (curr != NULL) {
+		attr = curr->data;
+		if (attr != NULL) {
+			free(attr->attribute);
+		}
+
+		free(curr->data);
+		curr->data = NULL;
+		curr = curr->next;
+	}
+
+	list_destroy(attr_list);
+}
+
 static int list_init(struct list **list)
 {
 	int rc = -1;
@@ -455,7 +487,54 @@ static int num_digits(int n)
 	return num;
 }
 
-static int set_to_cil_attr(int indent, struct policydb *pdb, int is_type, struct ebitmap *pos, struct ebitmap *neg, uint32_t flags, char ***names, uint32_t *num_names)
+static int set_to_cil_attr(struct policydb *pdb, int is_type, char ***names, uint32_t *num_names)
+{
+	static unsigned int num_attrs = 0;
+	int rc = -1;
+	int len, rlen;
+	char *attr_infix;
+	char *attr;
+
+	num_attrs++;
+
+	if (is_type) {
+		attr_infix = "_typeattr_";
+	} else {
+		attr_infix = "_roleattr_";
+	}
+
+	len = strlen(pdb->name) + strlen(attr_infix) + num_digits(num_attrs) + 1;
+	attr = malloc(len);
+	if (attr == NULL) {
+		log_err("Out of memory");
+		rc = -1;
+		goto exit;
+	}
+	rlen = snprintf(attr, len, "%s%s%i", pdb->name, attr_infix, num_attrs);
+	if (rlen < 0 || rlen >= len) {
+		log_err("Failed to generate attribute name");
+		rc = -1;
+		goto exit;
+	}
+
+	*names = malloc(sizeof(**names));
+	if (*names == NULL) {
+		log_err("Out of memory");
+		rc = -1;
+		goto exit;
+	}
+
+
+	*names[0] = attr;
+	*num_names = 1;
+
+	rc = 0;
+
+exit:
+	return rc;
+}
+
+static int cil_print_attr_strs(int indent, struct policydb *pdb, int is_type, struct ebitmap *pos, struct ebitmap *neg, uint32_t flags, char *attr)
 {
 	// CIL doesn't support anonymous positive/negative/complemented sets.  So
 	// instead we create a CIL type/roleattributeset that matches the set. If
@@ -464,46 +543,22 @@ static int set_to_cil_attr(int indent, struct policydb *pdb, int is_type, struct
 	// in the negative set. Additonally, if the set is complemented, then wrap
 	// the whole thing with a negation.
 
-	static unsigned int num_attrs = 0;
-
-	int rc = -1;
+	int rc = 0;
 	struct ebitmap_node *node;
 	unsigned int i;
-	char *attr_infix;
 	char *statement;
-	char *attr;
-	int len;
-	int rlen;
 	int has_positive = pos && (ebitmap_cardinality(pos) > 0);
 	int has_negative = neg && (ebitmap_cardinality(neg) > 0);
 	char **val_to_name;
 
-	num_attrs++;
-
 	if (is_type) {
-		attr_infix = "_typeattr_";
 		statement = "type";
 		val_to_name = pdb->p_type_val_to_name;
 	} else {
-		attr_infix = "_roleattr_";
 		statement = "role";
 		val_to_name = pdb->p_role_val_to_name;
 	}
 
-	len = strlen(pdb->name) + strlen(attr_infix) + num_digits(num_attrs) + 1;
-	attr = malloc(len);
-	if (attr == NULL) {
-		log_err("Out of memory");
-		rc = -1;
-		goto exit;
-	}
-	rlen = snprintf(attr, len, "%s%s%i", pdb->name, attr_infix, num_attrs);
-	if (rlen < 0 || rlen >= len) {
-		log_err("Failed to generate attribute name");
-		rc = -1;
-		goto exit;
-	}
-
 	cil_println(indent, "(%sattribute %s)", statement, attr);
 	cil_indent(indent);
 	cil_printf("(%sattributeset %s ", statement, attr);
@@ -554,17 +609,6 @@ static int set_to_cil_attr(int indent, struct policydb *pdb, int is_type, struct
 
 	cil_printf(")\n");
 
-	*names = malloc(sizeof(**names));
-	if (*names == NULL) {
-		log_err("Out of memory");
-		rc = -1;
-		goto exit;
-	}
-	*names[0] = attr;
-	*num_names = 1;
-
-	return 0;
-exit:
 	return rc;
 }
 
@@ -637,14 +681,58 @@ exit:
 	return rc;
 }
 
-static int typeset_to_names(int indent, struct policydb *pdb, struct type_set *ts, char ***names, uint32_t *num_names)
+static int cil_add_attr_to_list(struct list *attr_list, char *attribute, int is_type, void *set)
+{
+	struct attr_list_node *attr_list_node = NULL;
+	int rc = -1;
+
+	attr_list_node = calloc(1, sizeof(*attr_list_node));
+	if (attr_list_node == NULL) {
+		log_err("Out of memory");
+		rc = -1;
+		goto exit;
+	}
+
+	rc = list_prepend(attr_list, attr_list_node);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	attr_list_node->attribute = strdup(attribute);
+	if (attr_list_node->attribute == NULL) {
+		log_err("Out of memory");
+		rc = -1;
+		goto exit;
+	}
+
+	attr_list_node->is_type = is_type;
+	if (is_type) {
+		attr_list_node->set.ts = set;
+	} else {
+		attr_list_node->set.rs = set;
+	}
+
+	return rc;
+
+exit:
+	if (attr_list_node != NULL) {
+		free(attr_list_node->attribute);
+	}
+	free(attr_list_node);
+	return rc;
+}
+
+/* generated_attribute is only set if a new attribute was generated in set_to_cil_attr */
+static int typeset_to_names(struct policydb *pdb, struct type_set *ts, char ***names, uint32_t *num_names, char **generated_attribute)
 {
 	int rc = -1;
 	if (ebitmap_cardinality(&ts->negset) > 0 || ts->flags != 0) {
-		rc = set_to_cil_attr(indent, pdb, 1, &ts->types, &ts->negset, ts->flags, names, num_names);
+		rc = set_to_cil_attr(pdb, 1, names, num_names);
 		if (rc != 0) {
 			goto exit;
 		}
+
+		*generated_attribute = *names[0];
 	} else {
 		rc = ebitmap_to_names(pdb->p_type_val_to_name, ts->types, names, num_names);
 		if (rc != 0) {
@@ -657,14 +745,17 @@ exit:
 	return rc;
 }
 
-static int roleset_to_names(int indent, struct policydb *pdb, struct role_set *rs, char ***names, uint32_t *num_names)
+/* generated_attribute is only set if a new attribute was generated in set_to_cil_attr */
+static int roleset_to_names(struct policydb *pdb, struct role_set *rs, char ***names, uint32_t *num_names, char **generated_attribute)
 {
 	int rc = -1;
 	if (rs->flags != 0) {
-		rc = set_to_cil_attr(indent, pdb, 0, &rs->roles, NULL, rs->flags, names, num_names);
+		rc = set_to_cil_attr(pdb, 0, names, num_names);
 		if (rc != 0) {
 			goto exit;
 		}
+
+		*generated_attribute = *names[0];
 	} else {
 		rc = ebitmap_to_names(pdb->p_role_val_to_name, rs->roles, names, num_names);
 		if (rc != 0) {
@@ -677,6 +768,69 @@ exit:
 	return rc;
 }
 
+static int process_roleset(int indent, struct policydb *pdb, struct role_set *rs, struct list *attr_list, char ***type_names, uint32_t *num_type_names)
+{
+	int rc = -1;
+	char *generated_attribute = NULL;
+	*num_type_names = 0;
+
+	rc = roleset_to_names(pdb, rs, type_names, num_type_names, &generated_attribute);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	if (generated_attribute == NULL) {
+		goto exit;
+	}
+
+	if (attr_list == NULL) {
+		rc = cil_print_attr_strs(indent, pdb, 0, &rs->roles, NULL, rs->flags, generated_attribute);
+		if (rc != 0) {
+			goto exit;
+		}
+	} else {
+		rc = cil_add_attr_to_list(attr_list, generated_attribute, 0, rs);
+		if (rc != 0) {
+			goto exit;
+		}
+	}
+
+exit:
+	return rc;
+}
+
+static int process_typeset(int indent, struct policydb *pdb, struct type_set *ts, struct list *attr_list, char ***type_names, uint32_t *num_type_names)
+{
+	int rc = -1;
+	char *generated_attribute = NULL;
+	*num_type_names = 0;
+
+	rc = typeset_to_names(pdb, ts, type_names, num_type_names, &generated_attribute);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	if (generated_attribute == NULL) {
+		rc = 0;
+		goto exit;
+	}
+
+	if (attr_list == NULL) {
+		rc = cil_print_attr_strs(indent, pdb, 1, &ts->types, &ts->negset, ts->flags, generated_attribute);
+		if (rc != 0) {
+			goto exit;
+		}
+	} else {
+		rc = cil_add_attr_to_list(attr_list, generated_attribute, 1, ts);
+		if (rc != 0) {
+			goto exit;
+		}
+	}
+
+exit:
+	return rc;
+}
+
 static void names_destroy(char ***names, uint32_t *num_names)
 {
 	char **arr = *names;
@@ -700,6 +854,7 @@ static int roletype_role_in_ancestor_to_cil(struct policydb *pdb, struct stack *
 	uint32_t num_tnames, i;
 	struct role_list_node *role_node = NULL;
 	int rc;
+	struct type_set *ts;
 
 	curr = role_list->head;
 	for (curr = role_list->head; curr != NULL; curr = curr->next) {
@@ -708,7 +863,8 @@ static int roletype_role_in_ancestor_to_cil(struct policydb *pdb, struct stack *
 			continue;
 		}
 
-		rc = typeset_to_names(indent, pdb, &role_node->role->types, &tnames, &num_tnames);
+		ts = &role_node->role->types;
+		rc = process_typeset(indent, pdb, ts, NULL, &tnames, &num_tnames);
 		if (rc != 0) {
 			goto exit;
 		}
@@ -776,7 +932,7 @@ exit:
 	return rc;
 }
 
-static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *avrule_list)
+static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *avrule_list, struct list *attr_list)
 {
 	int rc = -1;
 	struct avrule *avrule;
@@ -786,15 +942,17 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
 	uint32_t num_tnames;
 	uint32_t s;
 	uint32_t t;
+	struct type_set *ts;
 
 	for (avrule = avrule_list; avrule != NULL; avrule = avrule->next) {
-
-		rc = typeset_to_names(indent, pdb, &avrule->stypes, &snames, &num_snames);
+		ts = &avrule->stypes;
+		rc = process_typeset(indent, pdb, ts, attr_list, &snames, &num_snames);
 		if (rc != 0) {
 			goto exit;
 		}
 
-		rc = typeset_to_names(indent, pdb, &avrule->ttypes, &tnames, &num_tnames);
+		ts = &avrule->ttypes;
+		rc = process_typeset(indent, pdb, ts, attr_list, &tnames, &num_tnames);
 		if (rc != 0) {
 			goto exit;
 		}
@@ -971,10 +1129,50 @@ exit:
 	return rc;
 }
 
+static int cil_print_attr_list(int indent, struct policydb *pdb, struct list *attr_list)
+{
+	struct list_node *curr;
+	struct attr_list_node *attr_list_node;
+	int rc = 0;
+	struct type_set *ts;
+	struct role_set *rs;
+	char *generated_attribute;
+
+	for (curr = attr_list->head; curr != NULL; curr = curr->next) {
+		attr_list_node = curr->data;
+		generated_attribute = attr_list_node->attribute;
+		if (generated_attribute == NULL) {
+			return -1;
+		}
+
+		if (attr_list_node->is_type) {
+			ts = attr_list_node->set.ts;
+			rc = cil_print_attr_strs(indent, pdb, 1, &ts->types, &ts->negset, ts->flags, generated_attribute);
+			if (rc != 0) {
+				return rc;
+			}
+		} else {
+			rs = attr_list_node->set.rs;
+			rc = cil_print_attr_strs(indent, pdb, 0, &rs->roles, NULL, rs->flags, generated_attribute);
+			if (rc != 0) {
+				return rc;
+			}
+		}
+	}
+
+	return rc;
+}
+
 static int cond_list_to_cil(int indent, struct policydb *pdb, struct cond_node *cond_list)
 {
 	int rc = -1;
 	struct cond_node *cond;
+	struct list *attr_list;
+
+	rc = list_init(&attr_list);
+	if (rc != 0) {
+		goto exit;
+	}
 
 	for (cond = cond_list; cond != NULL; cond = cond->next) {
 
@@ -985,7 +1183,7 @@ static int cond_list_to_cil(int indent, struct policydb *pdb, struct cond_node *
 
 		if (cond->avtrue_list != NULL) {
 			cil_println(indent + 1, "(true");
-			rc = avrule_list_to_cil(indent + 2, pdb, cond->avtrue_list);
+			rc = avrule_list_to_cil(indent + 2, pdb, cond->avtrue_list, attr_list);
 			if (rc != 0) {
 				goto exit;
 			}
@@ -994,7 +1192,7 @@ static int cond_list_to_cil(int indent, struct policydb *pdb, struct cond_node *
 
 		if (cond->avfalse_list != NULL) {
 			cil_println(indent + 1, "(false");
-			rc = avrule_list_to_cil(indent + 2, pdb, cond->avfalse_list);
+			rc = avrule_list_to_cil(indent + 2, pdb, cond->avfalse_list, attr_list);
 			if (rc != 0) {
 				goto exit;
 			}
@@ -1004,9 +1202,10 @@ static int cond_list_to_cil(int indent, struct policydb *pdb, struct cond_node *
 		cil_println(indent, ")");
 	}
 
-	return 0;
+	rc = cil_print_attr_list(indent, pdb, attr_list);
 
 exit:
+	attr_list_destroy(&attr_list);
 	return rc;
 }
 
@@ -1022,15 +1221,19 @@ static int role_trans_to_cil(int indent, struct policydb *pdb, struct role_trans
 	uint32_t role;
 	uint32_t i;
 	struct ebitmap_node *node;
+	struct type_set *ts;
+	struct role_set *rs;
 
 
 	for (rule = rules; rule != NULL; rule = rule->next) {
-		rc = roleset_to_names(indent, pdb, &rule->roles, &role_names, &num_role_names);
+		rs = &rule->roles;
+		rc = process_roleset(indent, pdb, rs, NULL, &role_names, &num_role_names);
 		if (rc != 0) {
 			goto exit;
 		}
 
-		rc = typeset_to_names(indent, pdb, &rule->types, &type_names, &num_type_names);
+		ts = &rule->types;
+		rc = process_typeset(indent, pdb, ts, NULL, &type_names, &num_type_names);
 		if (rc != 0) {
 			goto exit;
 		}
@@ -1072,14 +1275,17 @@ static int role_allows_to_cil(int indent, struct policydb *pdb, struct role_allo
 	uint32_t num_new_roles = 0;
 	uint32_t i;
 	uint32_t j;
+	struct role_set *rs;
 
 	for (rule = rules; rule != NULL; rule = rule->next) {
-		rc = roleset_to_names(indent, pdb, &rule->roles, &roles, &num_roles);
+		rs = &rule->roles;
+		rc = process_roleset(indent, pdb, rs, NULL, &roles, &num_roles);
 		if (rc != 0) {
 			goto exit;
 		}
 
-		rc = roleset_to_names(indent, pdb, &rule->new_roles, &new_roles, &num_new_roles);
+		rs = &rule->new_roles;
+		rc = process_roleset(indent, pdb, rs, NULL, &new_roles, &num_new_roles);
 		if (rc != 0) {
 			goto exit;
 		}
@@ -1115,18 +1321,21 @@ static int range_trans_to_cil(int indent, struct policydb *pdb, struct range_tra
 	uint32_t i;
 	uint32_t stype;
 	uint32_t ttype;
+	struct type_set *ts;
 
 	if (!pdb->mls) {
 		return 0;
 	}
 
 	for (rule = rules; rule != NULL; rule = rule->next) {
-		rc = typeset_to_names(indent, pdb, &rule->stypes, &stypes, &num_stypes);
+		ts = &rule->stypes;
+		rc = process_typeset(indent, pdb, ts, NULL, &stypes, &num_stypes);
 		if (rc != 0) {
 			goto exit;
 		}
 
-		rc = typeset_to_names(indent, pdb, &rule->ttypes, &ttypes, &num_ttypes);
+		ts = &rule->ttypes;
+		rc = process_typeset(indent, pdb, ts, NULL, &ttypes, &num_ttypes);
 		if (rc != 0) {
 			goto exit;
 		}
@@ -1183,16 +1392,19 @@ static int filename_trans_to_cil(int indent, struct policydb *pdb, struct filena
 	uint32_t num_ttypes = 0;
 	uint32_t stype;
 	uint32_t ttype;
+	struct type_set *ts;
 
 	struct filename_trans_rule *rule;
 
 	for (rule = rules; rule != NULL; rule = rule->next) {
-		rc = typeset_to_names(indent, pdb, &rule->stypes, &stypes, &num_stypes);
+		ts = &rule->stypes;
+		rc = process_typeset(indent, pdb, ts, NULL, &stypes, &num_stypes);
 		if (rc != 0) {
 			goto exit;
 		}
 
-		rc = typeset_to_names(indent, pdb, &rule->ttypes, &ttypes, &num_ttypes);
+		ts = &rule->ttypes;
+		rc = process_typeset(indent, pdb, ts, NULL, &ttypes, &num_ttypes);
 		if (rc != 0) {
 			goto exit;
 		}
@@ -1296,6 +1508,7 @@ static int constraint_expr_to_string(int indent, struct policydb *pdb, struct co
 	char *names;
 	char **name_list = NULL;
 	uint32_t num_names = 0;
+	struct type_set *ts;
 
 	rc = stack_init(&stack);
 	if (rc != 0) {
@@ -1355,7 +1568,8 @@ static int constraint_expr_to_string(int indent, struct policydb *pdb, struct co
 				}
 			} else {
 				if (expr->attr & CEXPR_TYPE) {
-					rc = typeset_to_names(indent, pdb, expr->type_names, &name_list, &num_names);
+					ts = expr->type_names;
+					rc = process_typeset(indent, pdb, ts, NULL, &name_list, &num_names);
 					if (rc != 0) {
 						goto exit;
 					}
@@ -1667,6 +1881,7 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 	char **types = NULL;
 	uint32_t num_types = 0;
 	struct role_datum *role = datum;
+	struct type_set *ts;
 
 	switch (role->flavor) {
 	case ROLE_ROLE:
@@ -1678,7 +1893,8 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 			log_err("Warning: role 'dominance' statment unsupported in CIL. Dropping from output.");
 		}
 
-		rc = typeset_to_names(indent, pdb, &role->types, &types, &num_types);
+		ts = &role->types;
+		rc = process_typeset(indent, pdb, ts, NULL, &types, &num_types);
 		if (rc != 0) {
 			goto exit;
 		}
@@ -1711,7 +1927,8 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 			cil_printf("))\n");
 		}
 
-		rc = typeset_to_names(indent, pdb, &role->types, &types, &num_types);
+		ts = &role->types;
+		rc = process_typeset(indent, pdb, ts, NULL, &types, &num_types);
 		if (rc != 0) {
 			goto exit;
 		}
@@ -3040,6 +3257,7 @@ static int blocks_to_cil(struct policydb *pdb)
 	struct avrule_decl *decl_tmp;
 	int indent = 0;
 	struct stack *stack;
+	struct list *attr_list;
 
 	rc = stack_init(&stack);
 	if (rc != 0) {
@@ -3047,6 +3265,11 @@ static int blocks_to_cil(struct policydb *pdb)
 	}
 
 	for (block = pdb->global; block != NULL; block = block->next) {
+		rc = list_init(&attr_list);
+		if (rc != 0) {
+			goto exit;
+		}
+
 		decl = block->branch_list;
 		if (decl == NULL) {
 			continue;
@@ -3111,7 +3334,7 @@ static int blocks_to_cil(struct policydb *pdb)
 			goto exit;
 		}
 
-		rc = avrule_list_to_cil(indent, pdb, decl->avrules);
+		rc = avrule_list_to_cil(indent, pdb, decl->avrules, attr_list);
 		if (rc != 0) {
 			goto exit;
 		}
@@ -3141,6 +3364,11 @@ static int blocks_to_cil(struct policydb *pdb)
 			goto exit;
 		}
 
+		rc = cil_print_attr_list(indent, pdb, attr_list);
+		if (rc != 0) {
+			goto exit;
+		}
+		attr_list_destroy(&attr_list);
 	}
 
 	while (indent > 0) {
@@ -3152,6 +3380,7 @@ static int blocks_to_cil(struct policydb *pdb)
 
 exit:
 	stack_destroy(&stack);
+	attr_list_destroy(&attr_list);
 
 	return rc;
 }
-- 
1.9.3
