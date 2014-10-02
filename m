Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s92DBQTq030422
 for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2014 09:11:26 -0400
From: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 1/3] policycoreutils/hll/pp: Fix role/roletype scoping
Date: Thu, 2 Oct 2014 09:10:08 -0400
Message-ID: <1412255410-15537-2-git-send-email-ykhodorkovskiy@tresys.com>
In-Reply-To: <1412255410-15537-1-git-send-email-ykhodorkovskiy@tresys.com>
References: <1412255410-15537-1-git-send-email-ykhodorkovskiy@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

- Create role declarations no matter if the declaration is in base or
  a module. Since CIL does not permit role re-declarations, this change
  will break existing policies that have the same role declared in multiple
  modules. To fix this, the policies will need to change the role to be
  defined in a single place.
- Pass around the avrule_decl stack rather than just the most recent
  decl. The full stack is needed to determine if identifiers are in
  scope
- Only create roletype statements for a role and a type in two cases:
   1) The role is declared/required and the type is declared/required in
      the same scope or an ancestor scope of the role
   2) The type is declared/required and the role is declared/required in
      an ancestor scope of the type

Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>
---
 policycoreutils/hll/pp/pp.c | 410 +++++++++++++++++++++++++-------------------
 1 file changed, 237 insertions(+), 173 deletions(-)

diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
index 1c476b7..d424f80 100644
--- a/policycoreutils/hll/pp/pp.c
+++ b/policycoreutils/hll/pp/pp.c
@@ -104,7 +104,7 @@ static void cil_println(int indent, char *fmt, ...)
 struct map_args {
 	struct policydb *pdb;
 	struct avrule_block *block;
-	struct avrule_decl *decl;
+	struct stack *decl_stack;
 	int scope;
 	int indent;
 	int sym_index;
@@ -116,6 +116,122 @@ struct stack {
 	 int size;
 };
 
+struct role_list_node {
+	char *role_name;
+	role_datum_t *role;
+};
+
+struct list_node {
+	void *data;
+	struct list_node *next;
+};
+
+struct list {
+	struct list_node *head;
+};
+
+/* A linked list of all roles stored in the pdb
+ * which is iterated to determine types associated
+ * with each role when printing role_type statements
+ */
+static struct list *role_list;
+
+static void list_destroy(struct list **list)
+{
+	struct list_node *curr = (*list)->head;
+	struct list_node *tmp;
+
+	while (curr != NULL) {
+		tmp = curr->next;
+		free(curr);
+		curr = tmp;
+	}
+
+	free(*list);
+	*list = NULL;
+}
+
+static void role_list_destroy(void)
+{
+	struct list_node *curr = role_list->head;
+
+	while (curr != NULL) {
+		free(curr->data);
+		curr->data = NULL;
+		curr = curr->next;
+	}
+
+	list_destroy(&role_list);
+}
+
+static int list_init(struct list **list)
+{
+	int rc = -1;
+	struct list *l = calloc(1, sizeof(*l));
+	if (l == NULL) {
+		goto exit;
+	}
+
+	*list = l;
+
+	return 0;
+
+exit:
+	list_destroy(&l);
+	return rc;
+}
+
+static int list_prepend(struct list *list, void *data)
+{
+	int rc = -1;
+	struct list_node *node = calloc(1, sizeof(*node));
+	if (node == NULL) {
+		goto exit;
+	}
+
+	node->data = data;
+	node->next = list->head;
+	list->head = node;
+
+	rc = 0;
+
+exit:
+	return rc;
+}
+
+static int roles_gather_map(char *key, void *data, void *args)
+{
+	struct role_list_node *role_node;
+	role_datum_t *role = data;
+	int rc = -1;
+
+	role_node = calloc(1, sizeof(*role_node));
+	if (role_node == NULL) {
+		return rc;
+	}
+
+	role_node->role_name = key;
+	role_node->role = role;
+
+	rc = list_prepend((struct list *)args, role_node);
+	return rc;
+}
+
+static int role_list_create(hashtab_t roles_tab)
+{
+	int rc = -1;
+
+	rc = list_init(&role_list);
+	if (rc != 0) {
+		goto exit;
+	}
+
+	rc = hashtab_map(roles_tab, roles_gather_map, role_list);
+
+exit:
+	return rc;
+}
+
 static int stack_destroy(struct stack **stack)
 {
 	if (stack == NULL || *stack == NULL) {
@@ -195,6 +311,44 @@ static void *stack_peek(struct stack *stack)
 	return stack->stack[stack->pos];
 }
 
+static int is_id_in_scope_with_start(struct policydb *pdb, struct stack *decl_stack, int start, uint32_t symbol_type, char *id)
+{
+	int i;
+	uint32_t j;
+	struct avrule_decl *decl;
+	struct scope_datum *scope;
+
+	scope = hashtab_search(pdb->scope[symbol_type].table, id);
+	if (scope == NULL) {
+		return 0;
+	}
+
+	for (i = start; i >= 0; i--) {
+		decl = decl_stack->stack[i];
+
+		for (j = 0; j < scope->decl_ids_len; j++) {
+			if (scope->decl_ids[j] == decl->decl_id) {
+				return 1;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int is_id_in_ancestor_scope(struct policydb *pdb, struct stack *decl_stack, char *type, uint32_t symbol_type)
+{
+	int start = decl_stack->pos - 1;
+
+	return is_id_in_scope_with_start(pdb, decl_stack, start, symbol_type, type);
+}
+
+static int is_id_in_scope(struct policydb *pdb, struct stack *decl_stack, char *type, uint32_t symbol_type)
+{
+	int start = decl_stack->pos;
+
+	return is_id_in_scope_with_start(pdb, decl_stack, start, symbol_type, type);
+}
 
 static int semantic_level_to_cil(struct policydb *pdb, int sens_offset, struct mls_semantic_level *level)
 {
@@ -539,6 +693,39 @@ static void names_destroy(char ***names, uint32_t *num_names)
 	*num_names = 0;
 }
 
+static int roletype_role_in_ancestor_to_cil(struct policydb *pdb, struct stack *decl_stack, char *type_name, int indent)
+{
+	struct list_node *curr;
+	char **tnames = NULL;
+	uint32_t num_tnames, i;
+	struct role_list_node *role_node = NULL;
+	int rc;
+
+	curr = role_list->head;
+	for (curr = role_list->head; curr != NULL; curr = curr->next) {
+		role_node = curr->data;
+		if (!is_id_in_ancestor_scope(pdb, decl_stack, role_node->role_name, SYM_ROLES)) {
+			continue;
+		}
+
+		rc = typeset_to_names(indent, pdb, &role_node->role->types, &tnames, &num_tnames);
+		if (rc != 0) {
+			goto exit;
+		}
+		for (i = 0; i < num_tnames; i++) {
+			if (!strcmp(type_name, tnames[i])) {
+				cil_println(indent, "(roletype %s %s)", role_node->role_name, type_name);
+			}
+		}
+		names_destroy(&tnames, &num_tnames);
+	}
+
+	rc = 0;
+
+exit:
+	return rc;
+}
+
 
 static int name_list_to_string(char **names, int num_names, char **string)
 {
@@ -1342,7 +1529,7 @@ exit:
 	return rc;
 }
 
-static int class_to_cil(int indent, struct policydb *pdb, struct avrule_block *UNUSED(block), struct avrule_decl *UNUSED(decl), char *key, void *datum, int scope)
+static int class_to_cil(int indent, struct policydb *pdb, struct avrule_block *UNUSED(block), struct stack *UNUSED(decl_stack), char *key, void *datum, int scope)
 {
 	int rc = -1;
 	struct class_datum *class = datum;
@@ -1472,7 +1659,7 @@ static int class_order_to_cil(int indent, struct policydb *pdb, struct ebitmap o
 	return 0;
 }
 
-static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UNUSED(block), struct avrule_decl *UNUSED(decl), char *key, void *datum, int scope)
+static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UNUSED(block), struct stack *decl_stack, char *key, void *datum, int scope)
 {
 	int rc = -1;
 	struct ebitmap_node *node;
@@ -1484,16 +1671,7 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 	switch (role->flavor) {
 	case ROLE_ROLE:
 		if (scope == SCOPE_DECL) {
-			if (pdb->policy_type == SEPOL_POLICY_MOD) {
-				// roles are defined twice, once in a module and once in base.
-				// CIL doesn't allow duplicate declarations, so only take the
-				// roles defined in the modules
-				cil_println(indent, "(role %s)", key);
-
-				// the attributes of a decl role are handled elswhere
-				rc = 0;
-				goto exit;
-			}
+			cil_println(indent, "(role %s)", key);
 		}
 
 		if (ebitmap_cardinality(&role->dominates) > 1) {
@@ -1506,7 +1684,9 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 		}
 
 		for (i = 0; i < num_types; i++) {
-			cil_println(indent, "(roletype %s %s)", key, types[i]);
+			if (is_id_in_scope(pdb, decl_stack, types[i], SYM_TYPES)) {
+				cil_println(indent, "(roletype %s %s)", key, types[i]);
+			}
 		}
 
 		if (role->bounds > 0) {
@@ -1556,7 +1736,7 @@ exit:
 	return rc;
 }
 
-static int type_to_cil(int indent, struct policydb *pdb, struct avrule_block *UNUSED(block), struct avrule_decl *UNUSED(decl), char *key, void *datum, int scope)
+static int type_to_cil(int indent, struct policydb *pdb, struct avrule_block *UNUSED(block), struct stack *decl_stack, char *key, void *datum, int scope)
 {
 	int rc = -1;
 	struct type_datum *type = datum;
@@ -1569,6 +1749,11 @@ static int type_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 				// object_r is implicit in checkmodule, but not with CIL,
 				// create it as part of base
 				cil_println(indent, "(roletype " DEFAULT_OBJECT " %s)", key);
+
+				rc = roletype_role_in_ancestor_to_cil(pdb, decl_stack, key, indent);
+				if (rc != 0) {
+					goto exit;
+				}
 			} else {
 				cil_println(indent, "(typealias %s)", key);
 				cil_println(indent, "(typealiasactual %s %s)", key, pdb->p_type_val_to_name[type->s.value - 1]);
@@ -1601,13 +1786,13 @@ static int type_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 		goto exit;
 	}
 
-	return 0;
+	rc = 0;
 
 exit:
 	return rc;
 }
 
-static int user_to_cil(int indent, struct policydb *pdb, struct avrule_block *block, struct avrule_decl *UNUSED(decl), char *key, void *datum,  int scope)
+static int user_to_cil(int indent, struct policydb *pdb, struct avrule_block *block, struct stack *UNUSED(decl_stack), char *key, void *datum,  int scope)
 {
 	struct user_datum *user = datum;
 	struct ebitmap roles = user->roles.roles;
@@ -1661,7 +1846,7 @@ static int user_to_cil(int indent, struct policydb *pdb, struct avrule_block *bl
 	return 0;
 }
 
-static int boolean_to_cil(int indent, struct policydb *UNUSED(pdb), struct avrule_block *UNUSED(block), struct avrule_decl *UNUSED(decl), char *key, void *datum,  int scope)
+static int boolean_to_cil(int indent, struct policydb *UNUSED(pdb), struct avrule_block *UNUSED(block), struct stack *UNUSED(decl_stack), char *key, void *datum,  int scope)
 {
 	struct cond_bool_datum *boolean = datum;
 	char *type;
@@ -1679,7 +1864,7 @@ static int boolean_to_cil(int indent, struct policydb *UNUSED(pdb), struct avrul
 	return 0;
 }
 
-static int sens_to_cil(int indent, struct policydb *pdb, struct avrule_block *UNUSED(block), struct avrule_decl *UNUSED(decl), char *key, void *datum, int scope)
+static int sens_to_cil(int indent, struct policydb *pdb, struct avrule_block *UNUSED(block), struct stack *UNUSED(decl_stack), char *key, void *datum, int scope)
 {
 	struct level_datum *level = datum;
 
@@ -1726,7 +1911,7 @@ static int sens_order_to_cil(int indent, struct policydb *pdb, struct ebitmap or
 	return 0;
 }
 
-static int cat_to_cil(int indent, struct policydb *pdb, struct avrule_block *UNUSED(block), struct avrule_decl *UNUSED(decl), char *key, void *datum,  int scope)
+static int cat_to_cil(int indent, struct policydb *pdb, struct avrule_block *UNUSED(block), struct stack *UNUSED(decl_stack), char *key, void *datum,  int scope)
 {
 	struct cat_datum *cat = datum;
 
@@ -1779,7 +1964,7 @@ static int typealias_to_cil(char *key, void *data, void *arg)
 	struct map_args *args = arg;
 
 	if (type->primary != 1) {
-		rc = type_to_cil(args->indent, args->pdb, args->block, args->decl, key, data, args->scope);
+		rc = type_to_cil(args->indent, args->pdb, args->block, args->decl_stack, key, data, args->scope);
 		if (rc != 0) {
 			goto exit;
 		}
@@ -2642,7 +2827,7 @@ exit:
 }
 
 
-static int (*func_to_cil[SYM_NUM])(int indent, struct policydb *pdb, struct avrule_block *block, struct avrule_decl *decl, char *key, void *datum, int scope) = {
+static int (*func_to_cil[SYM_NUM])(int indent, struct policydb *pdb, struct avrule_block *block, struct stack *decl_stack, char *key, void *datum, int scope) = {
 	NULL,	// commons, only stored in the global symtab, handled elsewhere
 	class_to_cil,
 	role_to_cil,
@@ -2653,7 +2838,7 @@ static int (*func_to_cil[SYM_NUM])(int indent, struct policydb *pdb, struct avru
 	cat_to_cil
 };
 
-static int declared_scopes_to_cil(int indent, struct policydb *pdb, struct avrule_block *block, struct avrule_decl *decl)
+static int declared_scopes_to_cil(int indent, struct policydb *pdb, struct avrule_block *block, struct stack *decl_stack)
 {
 	int rc = -1;
 	struct ebitmap map;
@@ -2663,6 +2848,7 @@ static int declared_scopes_to_cil(int indent, struct policydb *pdb, struct avrul
 	struct scope_datum *scope;
 	int sym;
 	void *datum;
+	struct avrule_decl *decl = stack_peek(decl_stack);
 
 	for (sym = 0; sym < SYM_NUM; sym++) {
 		if (func_to_cil[sym] == NULL) {
@@ -2685,7 +2871,7 @@ static int declared_scopes_to_cil(int indent, struct policydb *pdb, struct avrul
 				rc = -1;
 				goto exit;
 			}
-			rc = func_to_cil[sym](indent, pdb, block, decl, key, datum, scope->scope);
+			rc = func_to_cil[sym](indent, pdb, block, decl_stack, key, datum, scope->scope);
 			if (rc != 0) {
 				goto exit;
 			}
@@ -2718,7 +2904,7 @@ exit:
 	return rc;
 }
 
-static int required_scopes_to_cil(int indent, struct policydb *pdb, struct avrule_block *block, struct avrule_decl *decl)
+static int required_scopes_to_cil(int indent, struct policydb *pdb, struct avrule_block *block, struct stack *decl_stack)
 {
 	int rc = -1;
 	struct ebitmap map;
@@ -2727,6 +2913,7 @@ static int required_scopes_to_cil(int indent, struct policydb *pdb, struct avrul
 	char * key;
 	int sym;
 	void *datum;
+	struct avrule_decl *decl = stack_peek(decl_stack);
 
 	for (sym = 0; sym < SYM_NUM; sym++) {
 		if (func_to_cil[sym] == NULL) {
@@ -2744,7 +2931,7 @@ static int required_scopes_to_cil(int indent, struct policydb *pdb, struct avrul
 				rc = -1;
 				goto exit;
 			}
-			rc = func_to_cil[sym](indent, pdb, block, decl, key, datum, SCOPE_REQ);
+			rc = func_to_cil[sym](indent, pdb, block, decl_stack, key, datum, SCOPE_REQ);
 			if (rc != 0) {
 				goto exit;
 			}
@@ -2762,7 +2949,7 @@ static int additive_scopes_to_cil_map(char *key, void *data, void *arg)
 	int rc = -1;
 	struct map_args *args = arg;
 
-	rc = func_to_cil[args->sym_index](args->indent, args->pdb, args->block, args->decl, key, data, SCOPE_REQ);
+	rc = func_to_cil[args->sym_index](args->indent, args->pdb, args->block, args->decl_stack, key, data, SCOPE_REQ);
 	if (rc != 0) {
 		goto exit;
 	}
@@ -2773,14 +2960,15 @@ exit:
 	return rc;
 }
 
-static int additive_scopes_to_cil(int indent, struct policydb *pdb, struct avrule_block *block, struct avrule_decl *decl)
+static int additive_scopes_to_cil(int indent, struct policydb *pdb, struct avrule_block *block, struct stack *decl_stack)
 {
 	int rc = -1;
 	struct map_args args;
 	args.pdb = pdb;
 	args.block = block;
-	args.decl = decl;
+	args.decl_stack = decl_stack;
 	args.indent = indent;
+	struct avrule_decl *decl = stack_peek(decl_stack);
 
 	for (args.sym_index = 0; args.sym_index < SYM_NUM; args.sym_index++) {
 		rc = hashtab_map(decl->symtab[args.sym_index].table, additive_scopes_to_cil_map, &args);
@@ -2842,144 +3030,14 @@ exit:
 	return rc;
 }
 
-static int decl_roles_to_cil(int indent, struct policydb *pdb, struct avrule_decl *decl, struct role_datum **decl_roles, uint32_t num_decl_roles)
-{
-	int rc = -1;
-	uint32_t i, j, k;
-	char **types = NULL;
-	uint32_t num_types = 0;
-	struct role_datum *role;
-	struct scope_datum *scope;
-
-	for (i = 0; i < num_decl_roles; i++) {
-		role = decl_roles[i];
-
-		rc = typeset_to_names(indent, pdb, &role->types, &types, &num_types);
-		if (rc != 0) {
-			goto exit;
-		}
-
-		for (j = 0; j < num_types; j++) {
-			scope = hashtab_search(pdb->p_types_scope.table, types[j]);
-			if (scope == NULL) {
-				rc = -1;
-				goto exit;
-			}
-			for (k = 0; k < scope->decl_ids_len; k++) {
-				if (scope->decl_ids[k] == decl->decl_id) {
-					cil_println(indent, "(roletype %s %s)", pdb->p_role_val_to_name[role->s.value - 1], types[j]);
-				}
-			}
-		}
-
-		names_destroy(&types, &num_types);
-	}
-
-	rc = 0;
-
-exit:
-	names_destroy(&types, &num_types);
-
-	return rc;
-}
-
-struct decl_roles_args {
-	struct policydb *pdb;
-	int count;
-	struct role_datum **decl_roles;
-};
-
-static int count_decl_roles(char *key, void *UNUSED(datum), void *arg)
-{
-	struct scope_datum *scope;
-	struct decl_roles_args *args = arg;
-
-	if (!strcmp(key, DEFAULT_OBJECT)) {
-		return 0;
-	}
-
-	scope = hashtab_search(args->pdb->p_roles_scope.table, key);
-	if (scope == NULL || scope->scope != SCOPE_DECL) {
-		return 0;
-	}
-	args->count++;
-
-	return 0;
-}
-
-static int fill_decl_roles(char *key, void *datum, void *arg)
-{
-	struct scope_datum *scope;
-	struct decl_roles_args *args = arg;
-
-	if (!strcmp(key, DEFAULT_OBJECT)) {
-		return 0;
-	}
-
-	scope = hashtab_search(args->pdb->p_roles_scope.table, key);
-	if (scope == NULL || scope->scope != SCOPE_DECL) {
-		return 0;
-	}
-
-	args->decl_roles[args->count++] = datum;
-
-	return 0;
-}
-
-static int get_decl_roles(struct policydb *pdb, struct role_datum ***decl_roles, int *num_decl_roles)
-{
-	int rc = -1;
-	uint32_t num;
-	struct role_datum **roles;
-	struct decl_roles_args args;
-	args.pdb = pdb;
-
-	args.count = 0;
-	rc = hashtab_map(pdb->p_roles.table, count_decl_roles, &args);
-	if (rc != 0) {
-		goto exit;
-	}
-	num = args.count;
-
-	roles = malloc(sizeof(*roles) * num);
-	if (roles == NULL) {
-		log_err("Out of memory");
-		rc = -1;
-		goto exit;
-	}
-
-	args.count = 0;
-	args.decl_roles = roles;
-	rc = hashtab_map(pdb->p_roles.table, fill_decl_roles, &args);
-	if (rc != 0) {
-		goto exit;
-	}
-
-	*decl_roles = roles;
-	*num_decl_roles = num;
-
-	return 0;
-
-exit:
-	free(roles);
-	return rc;
-}
-
-
 static int blocks_to_cil(struct policydb *pdb)
 {
 	int rc = -1;
 	struct avrule_block *block;
 	struct avrule_decl *decl;
+	struct avrule_decl *decl_tmp;
 	int indent = 0;
 	struct stack *stack;
-	int num_decl_roles = 0;
-	struct role_datum **decl_roles = NULL;
-
-	rc = get_decl_roles(pdb, &decl_roles, &num_decl_roles);
-	if (rc != 0) {
-		goto exit;
-	}
 
 	rc = stack_init(&stack);
 	if (rc != 0) {
@@ -2997,7 +3055,12 @@ static int blocks_to_cil(struct policydb *pdb)
 		}
 
 		if (block->flags & AVRULE_OPTIONAL) {
-			while (stack->pos > 0 && !is_scope_superset(&decl->required, stack_peek(stack))) {
+			while (stack->pos > 0) {
+				decl_tmp = stack_peek(stack);
+				if (is_scope_superset(&decl->required, &decl_tmp->required)) {
+					break;
+				}
+
 				stack_pop(stack);
 				indent--;
 				cil_println(indent, ")");
@@ -3007,7 +3070,7 @@ static int blocks_to_cil(struct policydb *pdb)
 			indent++;
 		}
 
-		stack_push(stack, &decl->required);
+		stack_push(stack, decl);
 
 		if (stack->pos == 0) {
 			// type aliases and commons are only stored in the global symtab.
@@ -3016,7 +3079,7 @@ static int blocks_to_cil(struct policydb *pdb)
 			struct map_args args;
 			args.pdb = pdb;
 			args.block = block;
-			args.decl = decl;
+			args.decl_stack = stack;
 			args.indent = 0;
 			args.scope = SCOPE_DECL;
 
@@ -3031,22 +3094,17 @@ static int blocks_to_cil(struct policydb *pdb)
 			}
 		}
 
-		rc = decl_roles_to_cil(indent, pdb, decl, decl_roles, num_decl_roles);
+		rc = declared_scopes_to_cil(indent, pdb, block, stack);
 		if (rc != 0) {
 			goto exit;
 		}
 
-		rc = declared_scopes_to_cil(indent, pdb, block, decl);
+		rc = required_scopes_to_cil(indent, pdb, block, stack);
 		if (rc != 0) {
 			goto exit;
 		}
 
-		rc = required_scopes_to_cil(indent, pdb, block, decl);
-		if (rc != 0) {
-			goto exit;
-		}
-
-		rc = additive_scopes_to_cil(indent, pdb, block, decl);
+		rc = additive_scopes_to_cil(indent, pdb, block, stack);
 		if (rc != 0) {
 			goto exit;
 		}
@@ -3092,7 +3150,6 @@ static int blocks_to_cil(struct policydb *pdb)
 
 exit:
 	stack_destroy(&stack);
-	free(decl_roles);
 
 	return rc;
 }
@@ -3240,6 +3297,11 @@ static int module_package_to_cil(struct sepol_module_package *mod_pkg)
 		}
 	}
 
+	rc = role_list_create(pdb->p.p_roles.table);
+	if (rc != 0) {
+		goto exit;
+	}
+
 	rc = polcaps_to_cil(&pdb->p);
 	if (rc != 0) {
 		goto exit;
@@ -3281,9 +3343,11 @@ static int module_package_to_cil(struct sepol_module_package *mod_pkg)
 		goto exit;
 	}
 
-	return 0;
+	rc = 0;
 
 exit:
+	role_list_destroy();
+
 	return rc;
 }
 
-- 
1.9.3
