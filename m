Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sA7FmQiP031814
 for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2014 10:48:26 -0500
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 2/2] policycoreutils: pp: define type aliases in the correct
 scope
Date: Fri, 7 Nov 2014 10:47:28 -0500
Message-ID: <1415375248-29632-3-git-send-email-slawrence@tresys.com>
In-Reply-To: <1415375248-29632-1-git-send-email-slawrence@tresys.com>
References: <1415375248-29632-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Previously, type aliases were converted to CIL in the global namespace,
regardless of which scope they were actually defined in. So essentially
type aliases could never be in optionals. For the most part this worked,
however, in some small number of cases, a type alias could reference a
type defined inside an optional. If that optional was disabled, the type
would be disabled and so the type alias would fail to resolve, causing
policy to fail to build.

Unfortunately, type alises are stored in pp modules different than other
symbols (e.g. types/roles/etc) so they must be added to scopes
differently. So this patch gathers up all type aliases in a list and
keeps track of which scope each type alias is defined in. When we enter
a new scope, use that list to determine which type alias are defined
there and print the appropriate CIL statements.

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
Reviewed-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 policycoreutils/hll/pp/pp.c | 166 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 130 insertions(+), 36 deletions(-)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index 5621161..8e45c22 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -268,6 +268,87 @@ exit:
 	return rc;
 }
 
+// array of lists, where each list contains all the aliases defined in the scope at index i
+static struct list **typealias_lists;
+static uint32_t typealias_lists_len;
+
+static int typealiases_gather_map(char *key, void *data, void *arg)
+{
+	int rc = -1;
+	struct type_datum *type = data;
+	struct policydb *pdb = arg;
+	struct scope_datum *scope;
+	uint32_t i;
+	uint32_t scope_id;
+
+	if (type->primary != 1) {
+		scope = hashtab_search(pdb->scope[SYM_TYPES].table, key);
+		if (scope == NULL) {
+			return -1;
+		}
+
+		for (i = 0; i < scope->decl_ids_len; i++) {
+			scope_id = scope->decl_ids[i];
+			if (typealias_lists[scope_id] == NULL) {
+				rc = list_init(&typealias_lists[scope_id]);
+				if (rc != 0) {
+					goto exit;
+				}
+			}
+			list_prepend(typealias_lists[scope_id], key);
+		}
+	}
+
+	return 0;
+
+exit:
+	return rc;
+}
+
+static void typealias_list_destroy(void)
+{
+	uint32_t i;
+	for (i = 0; i < typealias_lists_len; i++) {
+		if (typealias_lists[i] != NULL) {
+			list_destroy(&typealias_lists[i]);
+		}
+	}
+	typealias_lists_len = 0;
+	free(typealias_lists);
+	typealias_lists = NULL;
+}
+
+static int typealias_list_create(struct policydb *pdb)
+{
+	uint32_t max_decl_id = 0;
+	struct avrule_decl *decl;
+	struct avrule_block *block;
+	uint32_t rc = -1;
+
+	for (block = pdb->global; block != NULL; block = block->next) {
+		decl = block->branch_list;
+		if (decl->decl_id > max_decl_id) {
+			max_decl_id = decl->decl_id;
+		}
+	}
+
+	typealias_lists = calloc(max_decl_id + 1, sizeof(*typealias_lists));
+	typealias_lists_len = max_decl_id + 1;
+			
+	rc = hashtab_map(pdb->p_types.table, typealiases_gather_map, pdb);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	return 0;
+
+exit:
+	typealias_list_destroy();	
+
+	return rc;
+}
+
+
 static int stack_destroy(struct stack **stack)
 {
 	if (stack == NULL || *stack == NULL) {
@@ -2005,19 +2086,14 @@ static int type_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 	switch(type->flavor) {
 	case TYPE_TYPE:
 		if (scope == SCOPE_DECL) {
-			if (type->primary == 1) {
-				cil_println(indent, "(type %s)", key);
-				// object_r is implicit in checkmodule, but not with CIL,
-				// create it as part of base
-				cil_println(indent, "(roletype " DEFAULT_OBJECT " %s)", key);
+			cil_println(indent, "(type %s)", key);
+			// object_r is implicit in checkmodule, but not with CIL,
+			// create it as part of base
+			cil_println(indent, "(roletype " DEFAULT_OBJECT " %s)", key);
 
-				rc = roletype_role_in_ancestor_to_cil(pdb, decl_stack, key, indent);
-				if (rc != 0) {
-					goto exit;
-				}
-			} else {
-				cil_println(indent, "(typealias %s)", key);
-				cil_println(indent, "(typealiasactual %s %s)", key, pdb->p_type_val_to_name[type->s.value - 1]);
+			rc = roletype_role_in_ancestor_to_cil(pdb, decl_stack, key, indent);
+			if (rc != 0) {
+				goto exit;
 			}
 		}
 
@@ -2218,25 +2294,6 @@ exit:
 	return rc;
 }
 
-static int typealias_to_cil(char *key, void *data, void *arg)
-{
-	int rc = -1;
-	struct type_datum *type = data;
-	struct map_args *args = arg;
-
-	if (type->primary != 1) {
-		rc = type_to_cil(args->indent, args->pdb, args->block, args->decl_stack, key, data, args->scope);
-		if (rc != 0) {
-			goto exit;
-		}
-	}
-
-	return 0;
-
-exit:
-	return rc;
-}
-
 static int polcaps_to_cil(struct policydb *pdb)
 {
 	int rc = -1;
@@ -3105,6 +3162,37 @@ static int (*func_to_cil[SYM_NUM])(int indent, struct policydb *pdb, struct avru
 	cat_to_cil
 };
 
+static int typealiases_to_cil(int indent, struct policydb *pdb, struct avrule_block *UNUSED(block), struct stack *decl_stack)
+{
+	struct type_datum *alias_datum;
+	char *alias_name;
+	struct list_node *curr;
+	struct avrule_decl *decl = stack_peek(decl_stack);
+	struct list *alias_list = typealias_lists[decl->decl_id];
+	int rc = -1;
+
+	if (alias_list == NULL) {
+		return 0;
+	}
+
+	for (curr = alias_list->head; curr != NULL; curr = curr->next) {
+		alias_name = curr->data;
+		alias_datum = hashtab_search(pdb->p_types.table, alias_name);
+		if (alias_datum == NULL) {
+			rc = -1;
+			goto exit;
+		}
+
+		cil_println(indent, "(typealias %s)", alias_name);
+		cil_println(indent, "(typealiasactual %s %s)", alias_name, pdb->p_type_val_to_name[alias_datum->s.value - 1]);
+	}
+
+	return 0;
+
+exit:
+	return rc;
+}
+
 static int declared_scopes_to_cil(int indent, struct policydb *pdb, struct avrule_block *block, struct stack *decl_stack)
 {
 	int rc = -1;
@@ -3376,17 +3464,17 @@ static int blocks_to_cil(struct policydb *pdb)
 			args.indent = 0;
 			args.scope = SCOPE_DECL;
 
-			rc = hashtab_map(pdb->p_types.table, typealias_to_cil, &args);
-			if (rc != 0) {
-				goto exit;
-			}
-
 			rc = hashtab_map(pdb->p_commons.table, common_to_cil, &args);
 			if (rc != 0) {
 				goto exit;
 			}
 		}
 
+		rc = typealiases_to_cil(indent, pdb, block, stack);
+		if (rc != 0) {
+			goto exit;
+		}
+
 		rc = declared_scopes_to_cil(indent, pdb, block, stack);
 		if (rc != 0) {
 			goto exit;
@@ -3615,6 +3703,11 @@ static int module_package_to_cil(struct sepol_module_package *mod_pkg)
 		goto exit;
 	}
 
+	rc = typealias_list_create(&pdb->p);
+	if (rc != 0) {
+		goto exit;
+	}
+
 	rc = polcaps_to_cil(&pdb->p);
 	if (rc != 0) {
 		goto exit;
@@ -3660,6 +3753,7 @@ static int module_package_to_cil(struct sepol_module_package *mod_pkg)
 
 exit:
 	role_list_destroy();
+	typealias_list_destroy();
 
 	return rc;
 }
-- 
1.9.3
