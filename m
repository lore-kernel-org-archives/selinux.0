Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5NG62Lr007841
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 12:06:02 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5NG61ZW010517
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 16:06:01 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k5NG65wa012119
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 12:06:05 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k5NG65Ag012118
	for selinux@tycho.nsa.gov; Fri, 23 Jun 2006 12:06:05 -0400
Subject: [PATCH 6/10] link algorithm
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 23 Jun 2006 10:52:21 -0400
Message-Id: <1151074341.4011.76.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is the updated link algorithm that is able to handle mutual
dependencies in optionals and modules. It turns on all optionals and
iterates through disabling unfulfilled ones until there are no changes.
It also cleans up a bit of the code and adds better error handling as
well as fixing a pile of bugs in the linking code

diff -pruN -x .svn selinux.old/libsepol/include/sepol/policydb/link.h optionals-in-base-take2/libsepol/include/sepol/policydb/link.h
--- selinux.old/libsepol/include/sepol/policydb/link.h	2006-06-10 00:11:50.000000000 -0400
+++ optionals-in-base-take2/libsepol/include/sepol/policydb/link.h	2006-06-22 13:27:37.000000000 -0400
@@ -29,6 +29,11 @@
 #include <sepol/policydb/policydb.h>
 #include <stddef.h>
 
+/* error codes */
+#define SEPOL_LINK_ERROR      1 /* general error */
+#define SEPOL_LINK_NOTSUP     2 /* feature not supported in module language */
+#define SEPOL_LINK_REQNOTMET  3 /* requirements not met */
+
 extern int link_modules(sepol_handle_t *handle,
 			policydb_t *b, policydb_t **mods, int len,
 			int verbose);
diff -pruN -x .svn selinux.old/libsepol/include/sepol/policydb/policydb.h optionals-in-base-take2/libsepol/include/sepol/policydb/policydb.h
--- selinux.old/libsepol/include/sepol/policydb/policydb.h	2006-06-22 13:16:40.000000000 -0400
+++ optionals-in-base-take2/libsepol/include/sepol/policydb/policydb.h	2006-06-22 13:27:30.000000000 -0400
@@ -313,8 +313,8 @@ typedef struct scope_index {
  * can never have an ELSE branch. */
 typedef struct avrule_decl {
         uint32_t decl_id;
-        int enabled;    /* flag set during linking if this decl is enabled;
-                           parent avrule_block->enabled will point to me */
+        uint32_t enabled; /* whether this block is enabled */
+                         
         cond_list_t *cond_list;
         avrule_t *avrules;
         role_trans_rule_t *role_tr_rules;
@@ -332,6 +332,8 @@ typedef struct avrule_block {
         avrule_decl_t *branch_list;
         avrule_decl_t *enabled; /* pointer to which branch is enabled.  this is
                                    used in linking and never written to disk */
+#define AVRULE_OPTIONAL 1
+	uint32_t flags; 	/* any flags for this block, currently just optional */
         struct avrule_block *next;
 } avrule_block_t;
 
diff -pruN -x .svn selinux.old/libsepol/src/link.c optionals-in-base-take2/libsepol/src/link.c
--- selinux.old/libsepol/src/link.c	2006-06-22 13:16:40.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/link.c	2006-06-22 13:26:56.000000000 -0400
@@ -24,6 +24,7 @@
 #include <sepol/policydb/hashtab.h>
 #include <sepol/policydb/avrule_block.h>
 #include <sepol/policydb/link.h>
+#include <sepol/policydb/util.h>
 
 #include <stdlib.h>
 #include <stdarg.h>
@@ -60,53 +61,27 @@ typedef struct link_state {
         char *cur_mod_name;
         avrule_decl_t *dest_decl;
         class_datum_t *src_class, *dest_class;
+	char *dest_class_name;
+	char dest_class_req; /* flag indicating the class was not declared */
         uint32_t symbol_num;
+	/* used to report the name of the module if dependancy error occurs */
+	policydb_t **decl_to_mod;
 
         /* error reporting fields */
 	sepol_handle_t *handle;
 } link_state_t;
 
-struct missing_requirement {
+typedef struct missing_requirement {
         uint32_t symbol_type;
         uint32_t symbol_value;
         uint32_t perm_value;
-};
+} missing_requirement_t;
 
 static const char *symtab_names[SYM_NUM] = {
         "common", "class", "role", "type/attribute", "user",
         "bool", "level", "category"
 };
 
-/* FIX ME: this function is in util.c already! */
-
-/* Add an unsigned integer to a dynamically reallocated array.  *cnt
- * is a reference pointer to the number of values already within array
- * *a; it will be incremented upon successfully appending i.  If *a is
- * NULL then this function will create a new array (*cnt is reset to
- * 0).  Return 0 on success, -1 on out of memory. */
-static int add_i_to_a(uint32_t i, uint32_t *cnt, uint32_t **a)
-{
-        if(cnt == NULL || a == NULL)
-                return -1;
-
-        /* FIX ME: This is not very elegant! We use an array that we
-         * grow as new uint32_t are added to an array.  But rather
-         * than be smart about it, for now we realloc() the array each
-         * time a new uint32_t is added! */
-        if(*a != NULL)
-                *a = (uint32_t *) realloc(*a, (*cnt + 1) * sizeof(uint32_t));
-        else /* empty list */ {
-                *cnt = 0;
-                *a = (uint32_t *) malloc(sizeof(uint32_t));
-        }
-        if(*a == NULL) {
-                return -1;
-        }
-        (*a)[*cnt] = i;
-        (*cnt)++;
-        return 0;
-}
-
 /* Deallocates all elements within a module, but NOT the policydb_t
  * structure within, as well as the pointer itself. */
 static void policy_module_destroy(policy_module_t *mod)
@@ -129,32 +104,76 @@ static void policy_module_destroy(policy
 
 /***** functions that copy identifiers from a module to base *****/
 
+/* Note: there is currently no scoping for permissions, which causes some
+ * strange side-effects. The current approach is this:
+ *
+ * a) perm is required and the class _and_ perm are declared in base: only add a mapping.
+ * b) perm is required and the class and perm are _not_ declared in base: simply add the permissions
+ *    to the object class. This means that the requirements for the decl are the union of the permissions
+ *    required for all decls, but who cares.
+ * c) perm is required, the class is declared in base, but the perm is not present. Nothing we can do
+ *    here because we can't mark a single permission as required, so we bail with a requirement error
+ *    _even_ if we are in an optional.
+ *
+ * A is correct behavior, b is wrong but not too bad, c is totall wrong for optionals. Fixing this requires
+ * a format change.
+ */
 static int permission_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
-        /* build the mapping for permissions encompassing this class.
-         * unlike symbols, the permission map translates between
-         * module permission bit to target permission bit.  that bit
-         * may have originated from the class -or- it could be from
-         * the class's common parent.*/
-        char *perm_id = key;
-        perm_datum_t *perm, *new_perm;
+        char *perm_id = key, *new_id = NULL;
+        perm_datum_t *perm, *new_perm = NULL, *dest_perm;
         link_state_t *state = (link_state_t *)data;
 
         class_datum_t *src_class = state->src_class;
         class_datum_t *dest_class = state->dest_class;
         policy_module_t *mod = state->cur;
         uint32_t sclassi = src_class->value - 1;
+	int ret;
 
         perm = (perm_datum_t *) datum;
-        new_perm = hashtab_search(dest_class->permissions.table, perm_id);
-        if (new_perm == NULL && dest_class->comdatum != NULL) {
-                new_perm = hashtab_search(dest_class->comdatum->permissions.table, perm_id);
+        dest_perm = hashtab_search(dest_class->permissions.table, perm_id);
+        if (dest_perm == NULL && dest_class->comdatum != NULL) {
+                dest_perm = hashtab_search(dest_class->comdatum->permissions.table, perm_id);
         }
-        if (!new_perm) {
-                ERR(state->handle, "Module %s depends on permission %s in class %s, not satisfied", state->cur_mod_name, perm_id, mod->policy->p_class_val_to_name[dest_class->value - 1]);
-                return -1;
+	
+        if (dest_perm == NULL) {
+		/* If the object class was not declared in the base, add the perm
+		 * to the object class. */
+		if (state->dest_class_req) {
+			/* If the class was required (not declared), insert the new permission */
+			new_id = strdup(perm_id);
+			if (new_id == NULL) {
+				ERR(state->handle, "Memory error");
+				ret = -SEPOL_LINK_ERROR;
+				goto err;
+			}
+			new_perm = (perm_datum_t*)calloc(1, sizeof(perm_datum_t));
+			if (new_perm == NULL) {
+				ERR(state->handle, "Memory error");
+				ret = -SEPOL_LINK_ERROR;
+				goto err;
+			}
+			ret = hashtab_insert(dest_class->permissions.table,
+					     (hashtab_key_t)new_id, (hashtab_datum_t)new_perm);
+			if (ret) {
+				ERR(state->handle, "could not insert permission into class\n");
+				goto err;
+			}
+			new_perm->value = dest_class->permissions.nprim + 1;
+			dest_perm = new_perm;
+		} else {
+			/* this is case c from above */
+			ERR(state->handle, "Module %s depends on permission %s in class %s, not satisfied",
+			    state->cur_mod_name, perm_id, state->dest_class_name);
+			return -SEPOL_LINK_REQNOTMET;
+		}
         }
 
+        /* build the mapping for permissions encompassing this class.
+         * unlike symbols, the permission map translates between
+         * module permission bit to target permission bit.  that bit
+         * may have originated from the class -or- it could be from
+         * the class's common parent.*/
         if (perm->value > mod->perm_map_len[sclassi]) {
                 uint32_t *newmap = calloc(perm->value, sizeof(*newmap));
                 if (newmap == NULL) {
@@ -166,33 +185,97 @@ static int permission_copy_callback(hash
                 mod->perm_map[sclassi] = newmap;
                 mod->perm_map_len[sclassi] = perm->value;
         }
-        mod->perm_map[sclassi][perm->value - 1] = new_perm->value;
+        mod->perm_map[sclassi][perm->value - 1] = dest_perm->value;
         
         return 0;
+err:
+	free(new_id);
+	free(new_perm);
+	return ret;
 }
 
 static int class_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
-        char *id = key;
-        class_datum_t *cladatum, *new_class;
+        char *id = key, *new_id = NULL;
+        class_datum_t *cladatum, *new_class = NULL;
 	link_state_t *state = (link_state_t *)data;
+	scope_datum_t *scope = NULL;
+	int ret;
 
         cladatum = (class_datum_t *) datum;
+	state->dest_class_req = 0;
+
         new_class = hashtab_search(state->base->p_classes.table, id);
-        if (!new_class) {
-                ERR(state->handle, "%s: Modules may not yet declare new classes.", state->cur_mod_name);
-                return -1;
-        }
+	/* If there is not an object class already in the base symtab that means
+	 * that either a) a module is trying to declare a new object class (which
+	 * the compiler should prevent) or b) an object class was required that is
+	 * not in the base.
+	 */
+	if (new_class == NULL) {
+		scope = hashtab_search(state->cur->policy->p_classes_scope.table, id);
+		if (scope == NULL) {
+			ret = -SEPOL_LINK_ERROR;
+			goto err;
+		}
+		if (scope->scope == SCOPE_DECL) {
+			/* disallow declarations in modules */
+			ERR(state->handle, "%s: Modules may not yet declare new classes.", state->cur_mod_name);
+			ret = -SEPOL_LINK_NOTSUP;
+			goto err;
+		} else {
+			/* It would be nice to error early here because the requirement is
+			 * not met, but we cannot because the decl might be optional (in which
+			 * case we should record the requirement so that it is just turned
+			 * off). Note: this will break horribly if modules can declare object
+			 * classes because the class numbers will be all wrong (i.e., they
+			 * might be assigned in the order they were required rather than the
+			 * current scheme which ensures correct numbering by ordering the 
+			 * declarations properly). This can't be fixed until some infrastructure
+			 * for querying the object class numbers is in place. */
+			state->dest_class_req = 1;
+			new_class = (class_datum_t*)calloc(1, sizeof(class_datum_t));
+			if (new_class == NULL) {
+				ERR(state->handle, "Memory error\n");
+				ret = -SEPOL_LINK_ERROR;
+				goto err;
+			}
+			if (symtab_init(&new_class->permissions, PERM_SYMTAB_SIZE)) {
+				ret = -SEPOL_LINK_ERROR;
+				goto err;
+			}
+			new_id = strdup(id);
+			if (new_id == NULL) {
+				ERR(state->handle, "Memory error\n");
+				ret = -SEPOL_LINK_ERROR;
+				goto err;
+			}
+			ret = hashtab_insert(state->base->p_classes.table,
+					     (hashtab_key_t)new_id, (hashtab_datum_t)new_class);
+			if (ret) {
+				ERR(state->handle, "could not insert new class into symtab");
+				goto err;
+			}
+			new_class->value = ++(state->base->p_classes.nprim);
+		}
+	}
+
         state->cur->map[SYM_CLASSES][cladatum->value - 1] = new_class->value;
 
         /* copy permissions */
         state->src_class = cladatum;
         state->dest_class = new_class;
-        if (hashtab_map(cladatum->permissions.table, permission_copy_callback, state) != 0) {
-                return -1;
+	state->dest_class_name = (char*)key;
+
+        ret = hashtab_map(cladatum->permissions.table, permission_copy_callback, state);
+	if (ret != 0) {
+                return ret;
         }
         
         return 0;
+err:
+	free(new_class);
+	free(new_id);
+	return ret;
 }
 
 static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
@@ -348,14 +431,22 @@ static int user_copy_callback(hashtab_ke
         char *id = key, *new_id = NULL;
         user_datum_t *user, *base_user, *new_user = NULL;
 	link_state_t *state = (link_state_t *)data;
+	scope_datum_t *scope;
 
+        user = (user_datum_t*)datum;
 	if (state->base->mls) {
-		ERR(state->handle, "Users cannot be declared in MLS modules");
-		return -1;
+		scope = hashtab_search(state->cur->policy->p_users_scope.table, id);
+		if (!scope) {
+			ERR(state->handle, "No scope information for user %s in module %s\n",id, state->cur_mod_name);
+			return -1;
+		}
+		if (scope->scope == SCOPE_DECL) {
+			ERR(state->handle, "Users cannot be declared in MLS modules");
+			return -1;
+		}
+		/* required users fall through */
 	}
 
-        user = (user_datum_t*)datum;
-
         base_user = hashtab_search(state->base->p_users.table, id);
         if (base_user == NULL) {
                 if (state->verbose)
@@ -761,77 +852,6 @@ static int (*fix_callback_f[SYM_NUM]) (h
         NULL
 };
 
-static int role_merge_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
-{
-        char *id = key;
-        role_datum_t *role, *dest_role = NULL;
-	link_state_t *state = (link_state_t *)data;
-
-        role = (role_datum_t *)datum;
-        
-        dest_role = hashtab_search(state->base->p_roles.table, id);
-        assert(dest_role != NULL);
-
-        if (ebitmap_union(&dest_role->dominates, &role->dominates) ||
-            type_set_or_eq(&dest_role->types, &role->types)) {
-                ERR(state->handle, "Out of memory!");
-                return -1;
-        }
-        return 0;
-}
-
-static int type_merge_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
-{
-        char *id = key;
-        type_datum_t *type, *new_type = NULL;
-	link_state_t *state = (link_state_t *)data;
-
-        type = (type_datum_t *)datum;
-
-        /* only fix attributes */
-        if (!type->primary || !type->isattr) {
-                return 0;
-        }
-
-        new_type = hashtab_search(state->base->p_types.table, id);
-        assert(new_type != NULL && new_type->isattr);
-
-        if (ebitmap_union(&new_type->types, &type->types)) {
-                ERR(state->handle, "Out of memory!");
-                return -1;
-        }
-        return 0;
-}
-
-static int user_merge_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
-{
-        char *id = key;
-        user_datum_t *user, *new_user = NULL;
-	link_state_t *state = (link_state_t *)data;
-
-        user = (user_datum_t *)datum;
-        
-        new_user = hashtab_search(state->base->p_users.table, id);
-        assert(new_user != NULL);
-        if (ebitmap_union(&new_user->roles.roles, &user->roles.roles)) {
-                ERR(state->handle, "Out of memory!");
-                return -1;
-        }
-        new_user->roles.flags |= user->roles.flags;
-        return 0;
-}
-
-static int (*merge_callback_f[SYM_NUM]) (hashtab_key_t key, hashtab_datum_t datum, void *datap) = {
-        NULL,
-        NULL,
-        role_merge_callback,
-        type_merge_callback,
-        user_merge_callback,
-        NULL,
-        NULL,
-        NULL
-};
-
 /*********** functions that copy AV rules ***********/
 
 static int copy_avrule_list(avrule_t *list, avrule_t **dst,
@@ -1019,6 +1039,7 @@ static int copy_cond_list(cond_node_t *l
                         cur_expr->bool = module->map[SYM_BOOLS][cur_expr->bool - 1];
                 }
                 new_node->nbools = cur->nbools;
+		/* FIXME should COND_MAX_BOOLS be used here? */
                 for (i = 0; i < min(cur->nbools, COND_MAX_BOOLS); i++) {
                         uint32_t remapped_id = module->map[SYM_BOOLS][cur->bool_ids[i] - 1];
                         assert(remapped_id != 0);
@@ -1051,14 +1072,17 @@ static int copy_cond_list(cond_node_t *l
 
 /*********** functions that copy avrule_decls from module to base ***********/
 
-static int copy_identifiers(link_state_t *state,
-                            symtab_t *src_symtab, avrule_decl_t *dest_decl) {
-        int i;
+static int copy_identifiers(link_state_t *state,symtab_t *src_symtab, 
+				avrule_decl_t *dest_decl) {
+        int i, ret;
+
         state->dest_decl = dest_decl;
         for (i = 0; i < SYM_NUM; i++) {
-                if (copy_callback_f[i] != NULL &&
-                    hashtab_map(src_symtab[i].table, copy_callback_f[i], state)) {
-                        return -1;
+                if (copy_callback_f[i] != NULL) {
+			ret = hashtab_map(src_symtab[i].table, copy_callback_f[i], state);
+			if (ret) {
+				return ret;
+			}
                 }
         }
 
@@ -1076,45 +1100,6 @@ static int copy_identifiers(link_state_t
         return 0;
 }
 
-static int copy_module_identifiers(link_state_t *state, policy_module_t *module) {
-        avrule_block_t *new_avrule = avrule_block_create();
-        avrule_decl_t *new_decl;
-        policydb_t *pol = module->policy;
-
-        if (new_avrule == NULL) {
-                ERR(state->handle, "Out of memory!");
-                goto cleanup;
-        }
-        new_decl = avrule_decl_create(state->next_decl_id);
-        if (new_decl == NULL) {
-                ERR(state->handle, "Out of memory!");
-                goto cleanup;
-        }
-        new_avrule->branch_list = new_decl;
-        module->base_global = new_avrule;
-        state->decl_id_to_decl[state->next_decl_id] = new_decl;
-        module->avdecl_map[pol->global->branch_list->decl_id] = new_decl->decl_id;
-
-        /* for now assume that this global scope is enabled.  in
-         * verify_module_requirements() this assumption will be
-         * checked */
-        new_avrule->enabled = new_decl;
-        new_decl->enabled = 1;
-
-        if (copy_identifiers(state, pol->symtab, new_decl) == -1) {
-                goto cleanup;
-        }
-
-        state->last_avrule_block->next = new_avrule;
-        state->last_avrule_block = new_avrule;
-        state->next_decl_id++;
-
-        return 0;
- cleanup:
-        avrule_block_list_destroy(new_avrule);
-        return -1;
-}
-
 static int copy_scope_index(scope_index_t *src, scope_index_t *dest,
                             policy_module_t *module, link_state_t *state) {
         unsigned int i, j;
@@ -1171,7 +1156,9 @@ static int copy_scope_index(scope_index_
 
 static int copy_avrule_decl(link_state_t *state, policy_module_t *module,
                             avrule_decl_t *src_decl, avrule_decl_t *dest_decl) {
-        /* first copy all of the RBAC and TE rules */
+	int ret;
+
+        /* copy all of the RBAC and TE rules */
         if (copy_avrule_list(src_decl->avrules, &dest_decl->avrules, module, state) == -1 ||
             copy_role_trans_list(src_decl->role_tr_rules, &dest_decl->role_tr_rules, module, state) == -1 ||
             copy_role_allow_list(src_decl->role_allow_rules, &dest_decl->role_allow_rules, module, state) == -1 ||
@@ -1179,6 +1166,12 @@ static int copy_avrule_decl(link_state_t
                 return -1;
         }
         
+        /* finally copy any identifiers local to this declaration */
+        ret = copy_identifiers(state, src_decl->symtab, dest_decl);
+	if (ret < 0) {
+                return ret;
+        }
+
         /* then copy required and declared scope indices here */
         if (copy_scope_index(&src_decl->required, &dest_decl->required,
                              module, state) == -1 ||
@@ -1187,26 +1180,29 @@ static int copy_avrule_decl(link_state_t
                 return -1;
         }
 
-        /* finally copy any identifiers local to this declaration */
-        if (copy_identifiers(state, src_decl->symtab, dest_decl) == -1) {
-                return -1;
-        }
         return 0;
 }
 
 static int copy_avrule_block(link_state_t *state, policy_module_t *module,
-                             avrule_block_t *block) {
+                             avrule_block_t *block)
+{
         avrule_block_t *new_block = avrule_block_create();
         avrule_decl_t *decl, *last_decl = NULL;
+	int ret;
+
         if (new_block == NULL) {
                 ERR(state->handle, "Out of memory!");
+		ret = -1;
                 goto cleanup;
         }
+	
+	new_block->flags = block->flags;
 
         for (decl = block->branch_list; decl != NULL; decl = decl->next) {
                 avrule_decl_t *new_decl = avrule_decl_create(state->next_decl_id);
                 if (new_decl == NULL) {
                         ERR(state->handle, "Out of memory!");
+			ret = -1;
                         goto cleanup;
                 }
                 if (last_decl == NULL) {
@@ -1220,7 +1216,8 @@ static int copy_avrule_block(link_state_
 		state->decl_to_mod[state->next_decl_id] = module->policy;
                 module->avdecl_map[decl->decl_id] = new_decl->decl_id;
 
-                if (copy_avrule_decl(state, module, decl, new_decl) == -1) {
+                ret = copy_avrule_decl(state, module, decl, new_decl);
+		if (ret) {
                         goto cleanup;
                 }
 
@@ -1232,7 +1229,7 @@ static int copy_avrule_block(link_state_
 
  cleanup:
         avrule_block_list_destroy(new_block);
-        return -1;
+        return ret;
 }
 
 static int scope_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
@@ -1325,28 +1322,24 @@ static int scope_copy_callback(hashtab_k
 /* Copy a module over to a base, remapping all values within.  After
  * all identifiers and rules are done, copy the scoping information.
  * This is when it checks for duplicate declarations. */
-static int copy_module(link_state_t *state, policy_module_t *module) {
-        int i;
+static int copy_module(link_state_t *state, policy_module_t *module)
+{
+        int i, ret;
         avrule_block_t *cur;
         state->cur = module;
         state->cur_mod_name = module->policy->name;
 
-        /* first copy the identifiers used by this module */
-        if (copy_module_identifiers(state, module) == -1) {
-                return -1;
+	/* first copy all of the identifiers */
+        ret = copy_identifiers(state, module->policy->symtab, NULL);
+	if (ret) {
+                return ret;
         }
-        /* next copy the avrule blocks for the module's global scope */
-        if (copy_avrule_decl(state, module,
-                             module->policy->global->branch_list,
-                             module->base_global->branch_list) == -1) {
-                return -1;
-        }
-        assert(module->policy->global->branch_list->next == NULL);
 
-        /* next copy all of the optional avrule blocks */
-        for (cur = module->policy->global->next; cur != NULL; cur = cur->next) {
-                if (copy_avrule_block(state, module, cur) == -1) {
-                        return -1;
+        /* next copy all of the avrule blocks */
+        for (cur = module->policy->global; cur != NULL; cur = cur->next) {
+                ret = copy_avrule_block(state, module, cur);
+		if  (ret) {
+                        return ret;
                 }
         }
 
@@ -1406,11 +1399,6 @@ static int is_decl_requires_met(link_sta
         policydb_t *pol = state->base;
 	ebitmap_node_t *node;
         
-        if (decl->enabled) {
-                /* this declaration was already checked */
-                return 1;
-        }
-        
         /* check that all symbols have been satisfied */
         for (i = 0; i < SYM_NUM; i++) {
                 if (i == SYM_CLASSES) {
@@ -1441,16 +1429,25 @@ static int is_decl_requires_met(link_sta
 
                 bitmap = decl->required.class_perms_map + i;
 		ebitmap_for_each_bit(bitmap, node, j) {
-
                         struct find_perm_arg fparg;
-
                         class_datum_t *cladatum;
                         uint32_t perm_value = j + 1;
+			scope_datum_t *scope;
+
                         if (!ebitmap_node_get_bit(node, j)) {
                                 continue;
                         }
                         id = pol->p_class_val_to_name[i];
                         cladatum = pol->class_val_to_struct[i];
+			
+			scope = hashtab_search(state->base->p_classes_scope.table, id);
+			if (scope == NULL) {
+				ERR(state->handle, "Could not find scope information for class %s",
+				    id);
+				return -1;
+			}
+			if (scope->scope == SCOPE_REQ)
+				return 0;
 		
 			fparg.valuep = perm_value;
 			fparg.key = NULL;
@@ -1476,75 +1473,22 @@ static int is_decl_requires_met(link_sta
         return 1;
 }
 
-/* Check each of the avrules blocks within a chain, enabling as many
- * as possible.  If multiple decls within a chain can be enabled, give
- * preference to the earlier one.  The result is an algorithm akin to
- * iterative-deepening search.
- *
- * N.b.: This algorithm is position dependent and is not guaranteed to
- * find the optimal enabled declarations, for resolving dependencies
- * is at least an NP-complete problem.  This solution works /only/
- * because it exploits two limitations of the module language.  First,
- * else branches may not have make any declarations of their own.
- * Second, the grammar does not currently support else-if branches.
- *
- * Proof: The problem is similar to a boolean satisfiability problem,
- * for nothing less than an exhaustive search is guaranteed to derive
- * the optimal enabling arrangement.
- */
-static void enable_avrules(link_state_t *state, policydb_t *pol) {
-        int more_to_go;
-        int max_depth = 1;
-        int changed;
-        do {
-                more_to_go = 0;
-                changed = 0;
-                avrule_block_t *block;
-                for (block = pol->global;
-                     block != NULL;
-                     block = block->next) {
-                        avrule_decl_t *decl = block->branch_list;
-                        int depth_count = max_depth;
-                        if (block->enabled != NULL) {
-                                continue;
-                        }
-                        while (depth_count-- > 0 && decl != NULL) {
-                                if (is_decl_requires_met(state, decl, NULL)) {
-                                        decl->enabled = 1;
-                                        block->enabled = decl;
-                                        changed = 1;
-                                        break;
-                                }
-                                decl = decl->next;
-                        }
-                        if (decl != NULL) {
-                                more_to_go = 1;
-                        }
-                }
-                if (!changed) {
-                        /* increase search depth if nothing changed on
-                           this pass */
-                        max_depth++;
-                }
-        } while (more_to_go);
-}
-
-static int verify_module_requirements(link_state_t *state,
-                                      policy_module_t **modules,
-                                      int len) {
-        int i;
-        struct missing_requirement req;
-        policydb_t *p = state->base;
+static int debug_requirements(link_state_t *state, policydb_t *p)
+{
+	int ret;
+	avrule_block_t *cur;
+	missing_requirement_t req;
 
-        if (state->verbose) {
-                INFO(state->handle, "Verifying module global requirements.");
-        }
-        
-        for (i = 0; i < len; i++) {
-                avrule_decl_t *module_global = modules[i]->base_global->branch_list;
-                char *mod_name = modules[i]->policy->name;
-                module_global->enabled = 0;
-                if (!is_decl_requires_met(state, module_global, &req)) {
+	for (cur = p->global; cur != NULL; cur = cur->next) {
+		if (cur->enabled != NULL)
+			continue;
+
+		ret = is_decl_requires_met(state, cur->branch_list, &req);
+		if (ret < 0) {
+			return ret;
+		} else if (ret == 0) {
+			char *mod_name = state->decl_to_mod[cur->branch_list->decl_id]->name?
+				 state->decl_to_mod[cur->branch_list->decl_id]->name : "BASE";
                         if (req.symbol_type == SYM_CLASSES) {
 	
                                 struct find_perm_arg fparg;
@@ -1555,214 +1499,158 @@ static int verify_module_requirements(li
                                 fparg.valuep = req.perm_value;
                                 fparg.key = NULL;
                                 hashtab_map(cladatum->permissions.table, find_perm, &fparg);
-
-                                ERR(state->handle,
-                                            "Module %s's global requirements were not met: class %s, permission %s",
-                                            mod_name,
-                                            p->p_class_val_to_name[req.symbol_value - 1],
-                                            fparg.key);
-                                return -1;
+				
+				if (cur->flags & AVRULE_OPTIONAL) {
+					ERR(state->handle,
+					    "%s[%d]'s optional requirements were not met: class %s, permission %s",
+					    mod_name, cur->branch_list->decl_id,
+					    p->p_class_val_to_name[req.symbol_value - 1],
+					    fparg.key);
+				} else {
+					ERR(state->handle,
+					    "%s[%d]'s global requirements were not met: class %s, permission %s",
+					    mod_name, cur->branch_list->decl_id,
+					    p->p_class_val_to_name[req.symbol_value - 1],
+					    fparg.key);
+				}
                         }
                         else {
-                                ERR(state->handle,
-                                            "Module %s's global requirements were not met: %s %s",
-                                            mod_name, 
-                                            symtab_names[req.symbol_type],
-                                            p->sym_val_to_name[req.symbol_type][req.symbol_value - 1]);
-                                return -1;
+				if (cur->flags & AVRULE_OPTIONAL) {
+					ERR(state->handle,
+                                            "%s[%d]'s optional requirements were not met: %s %s",
+					    mod_name, cur->branch_list->decl_id,
+					    symtab_names[req.symbol_type],
+					    p->sym_val_to_name[req.symbol_type][req.symbol_value - 1]);
+				} else {
+					ERR(state->handle,
+                                            "%s[%d]'s global requirements were not met: %s %s",
+					    mod_name, cur->branch_list->decl_id,
+					    symtab_names[req.symbol_type],
+					    p->sym_val_to_name[req.symbol_type][req.symbol_value - 1]);
+				}
                         }
                 }
-                module_global->enabled = 1;
-        }
-        return 0;
+	}
+	return 0;
 }
 
-/*********** merging and stripping functions ***********/
+static void print_missing_requirements(link_state_t *state, avrule_block_t *cur, missing_requirement_t *req)
+{
+        policydb_t *p = state->base;
+	char *mod_name = state->decl_to_mod[cur->branch_list->decl_id]->name?
+		state->decl_to_mod[cur->branch_list->decl_id]->name : "BASE";
+	if (req->symbol_type == SYM_CLASSES) {
+	
+		struct find_perm_arg fparg;
 
-/* for each enabled block, merge its identifiers and avrules into the base */
-static int merge_avrules(link_state_t *state, avrule_block_t *block) {
-        avrule_decl_t *dest_decl = block->branch_list;
-        cond_node_t *src_cond, *dest_cond;
-        avrule_t *last_avrule = dest_decl->avrules, *tmp;
-        role_trans_rule_t *last_rt = dest_decl->role_tr_rules;
-        role_allow_rule_t *last_ra = dest_decl->role_allow_rules;
+		class_datum_t *cladatum;
+		cladatum = p->class_val_to_struct[req->symbol_value - 1];
 
-        while (last_avrule != NULL && last_avrule->next != NULL) {
-                last_avrule = last_avrule->next;
-        }
-        while (last_rt != NULL && last_rt->next != NULL) {
-                last_rt = last_rt->next;
-        }
-        while (last_ra != NULL && last_ra->next != NULL) {
-                last_ra = last_ra->next;
+		fparg.valuep = req->perm_value;
+		fparg.key = NULL;
+		hashtab_map(cladatum->permissions.table, find_perm, &fparg);
+
+		ERR(state->handle,
+		    "%s's global requirements were not met: class %s, permission %s",
+		    mod_name,
+		    p->p_class_val_to_name[req->symbol_value - 1],
+		    fparg.key);
+	} else {
+		ERR(state->handle,
+		    "%s's global requirements were not met: %s %s",
+		    mod_name, 
+		    symtab_names[req->symbol_type],
+		    p->sym_val_to_name[req->symbol_type][req->symbol_value - 1]);
+	}
+}
+
+/* Enable all of the avrule_decl blocks for the policy. This simple
+ * algorithm is the following:
+ *
+ * 1) Enable all of the non-else avrule_decls for all blocks.
+ * 2) Iterate through the non-else decls looking for decls whose requirements
+ *    are not met.
+ *    2a) If the decl is non-optional, return immediately with an error.
+ *    2b) If the decl is optional, disable the block and mark changed = 1
+ * 3) If changed == 1 goto 2.
+ * 4) Iterate through all blocks looking for those that have no enabled
+ *    decl. If the block has an else decl, enable.
+ *
+ * This will correctly handle all dependencies, including mutual and
+ * cicular. The only downside is that it is slow.
+ */
+static int enable_avrules(link_state_t *state, policydb_t *pol) {
+        int changed = 1;
+	avrule_block_t *block;
+	avrule_decl_t *decl;
+	missing_requirement_t req;
+	int ret = 0, rc;
+	
+        if (state->verbose) {
+                INFO(state->handle, "Determining which avrules to enable.");
         }
-        
-        block = block->next; /* start with the first non-base block */
-        while (block != NULL) {
-                avrule_decl_t *decl = block->enabled;
-                unsigned int i, j;
 
-                block = block->next;
-                if (decl == NULL) {
-                        continue;
-                }
+	/* 1) enable all of the non-else blocks */
+	for (block = pol->global; block != NULL; block = block->next) {
+		block->enabled = block->branch_list;
+		block->enabled->enabled = 1;
+		for (decl = block->branch_list->next; decl != NULL; decl = decl->next)
+			decl->enabled = 0;
+	}
 
-                /* merge additive statements */
-                for (i = 0; i < SYM_NUM; i++) {
-                        if (merge_callback_f[i] != NULL &&
-                            hashtab_map(decl->symtab[i].table, merge_callback_f[i], state)) {
-                                return -1;
-                        }
-                }
-                
-                /* merge cond_list, avrules, role_tr rules, and
-                 * role_allow rules */
-                src_cond = decl->cond_list;
-                while (src_cond != NULL) {
-                        dest_cond = get_decl_cond_list(state->base, dest_decl, src_cond);
-                        if (dest_cond == NULL) {
-                                ERR(state->handle, "Out of memory!");
-                                return -1;
-                        }
-                        if (dest_cond->avtrue_list == NULL) {
-                                dest_cond->avtrue_list = src_cond->avtrue_list;
-                        }
-                        else {
-                                tmp = dest_cond->avtrue_list;
-                                while (tmp->next != NULL) {
-                                        tmp = tmp->next;
-                                }
-                                tmp->next = src_cond->avtrue_list; 
-                        }
-                        src_cond->avtrue_list = NULL;
-                        if (dest_cond->avfalse_list == NULL) {
-                                dest_cond->avfalse_list = src_cond->avfalse_list;
-                        }
-                        else {
-                                tmp = dest_cond->avfalse_list;
-                                while (tmp->next != NULL) {
-                                        tmp = tmp->next;
-                                }
-                                tmp->next = src_cond->avfalse_list; 
-                        }
-                        src_cond->avfalse_list = NULL;
-                        src_cond = src_cond->next;
-                }
-                
-                if (decl->avrules != NULL) {
-                        if (last_avrule == NULL) {
-                                dest_decl->avrules = decl->avrules;
-                        }
-                        else {
-                                last_avrule->next = decl->avrules;
-                        }
-                        last_avrule = decl->avrules;
-                        while (last_avrule->next != NULL) {
-                                last_avrule = last_avrule->next;
-                        }
-                        decl->avrules = NULL;
-                }
-                if (decl->role_tr_rules != NULL) {
-                        if (last_rt == NULL) {
-                                dest_decl->role_tr_rules = decl->role_tr_rules;
-                        }
-                        else {
-                                last_rt->next = decl->role_tr_rules;
-                        }
-                        last_rt = decl->role_tr_rules;
-                        while (last_rt->next != NULL) {
-                                last_rt = last_rt->next;
-                        }
-                        decl->role_tr_rules = NULL;
-                }
-                if (decl->role_allow_rules != NULL) {
-                        if (last_ra == NULL) {
-                                dest_decl->role_allow_rules = decl->role_allow_rules;
-                        }
-                        else {
-                                last_ra->next = decl->role_allow_rules;
-                        }
-                        last_ra = decl->role_allow_rules;
-                        while (last_ra->next != NULL) {
-                                last_ra = last_ra->next;
-                        }
-                        decl->role_allow_rules = NULL;
-                }
-                /* checks for conflicting type transitions / role
-                 * transitions will occur during expansion */
-                
-                /* finally merge declarations table */
-                for (i = 0; i < SYM_NUM; i++) {
-                        ebitmap_t *srcmap = decl->declared.scope + i;
-                        ebitmap_t *destmap = dest_decl->declared.scope + i;
-			ebitmap_node_t *node;
-                        if (copy_callback_f[i] == NULL) {
+	/* 2) Iterate */
+	while (changed) {
+                changed = 0;
+                for (block = pol->global; block != NULL; block = block->next) {
+                        if (block->enabled == NULL) {
                                 continue;
                         }
-			ebitmap_for_each_bit(srcmap, node, j) {
-                                if (ebitmap_node_get_bit(node, j) &&
-                                    ebitmap_set_bit(destmap, j, 1) != 0) {
-                                        ERR(state->handle, "Out of memory!");
-                                        return -1;
-                                }
-                        }
+                        decl = block->branch_list;
+			if (state->verbose) {
+				char *mod_name = state->decl_to_mod[decl->decl_id]->name?
+					state->decl_to_mod[decl->decl_id]->name : "BASE";
+				INFO(state->handle, "check module %s decl %d\n", mod_name, decl->decl_id);
+			}
+			rc = is_decl_requires_met(state, decl, &req);
+			if (rc < 0) {
+				ret = -SEPOL_LINK_ERROR;
+				goto out;
+			} else if (rc == 0) {
+				decl->enabled = 0;
+				block->enabled = NULL;
+				changed = 1;
+				if (!(block->flags & AVRULE_OPTIONAL)) {
+					print_missing_requirements(state, block, &req);
+					ret = -SEPOL_LINK_REQNOTMET;
+					goto out;
+				}
+			}
                 }
-        }
-        return 0;
-}
+	}
 
-static int check_symbol_used(hashtab_key_t k, hashtab_datum_t d, void *args) {
-        scope_datum_t *scope = (scope_datum_t *) d;
-        link_state_t *state = (link_state_t *) args;
-        int sym_num = state->symbol_num, retval;
-
-        /* if the scope is declared and at least one of its decls is
-         * enabled then don't remove this symbol */
-        if (scope->scope == SCOPE_DECL) {
-                unsigned int i;
-                for (i = 0; i < scope->decl_ids_len; i++) {
-                        avrule_decl_t *decl = state->decl_id_to_decl[scope->decl_ids[i]];
-                        if (decl->enabled) {
-                                /* overwrite this scope_datum's
-                                 * declaration table to only point to
-                                 * the root block */
-                                free(scope->decl_ids);
-                                scope->decl_ids = NULL;
-                                if (add_i_to_a(state->dest_decl->decl_id,
-                                               &scope->decl_ids_len,
-                                               &scope->decl_ids) == -1) {
-                                        ERR(state->handle, "Out of memory!");
-                                }
-                                return 0;
-                        }
-                }
-        }
+	/* 4) else handling
+	 *
+	 * Iterate through all of the blocks skipping the first (which is the
+	 * global block, is required to be present, and cannot have an else).
+	 * If the block is disabled and has an else decl, enable that.
+	 *
+	 * This code assumes that the second block in the branch list is the else
+	 * block. This is currently supported by the compiler.
+	 */
+	for (block = pol->global->next; block != NULL; block = block->next) {
+		if (block->enabled == NULL) {
+			if (block->branch_list->next != NULL) {
+				block->enabled = block->branch_list->next;
+				block->branch_list->next->enabled = 1;
+			}
+		}
+	}
 
-        /* prune this symbol from the global symbol table */
-        retval = hashtab_remove(state->base->symtab[sym_num].table, k,
-                                get_symtab_destroy_func(sym_num),
-                                state->base);
-        assert(retval == 0);
-        /* hashtab_map_remove_on_error() will handle removing the
-         * scope_datum_t */
-        return -1;
-}
+out:
+	if (state->verbose)
+		debug_requirements(state, pol);
 
-/* Note that as a side effect of this removal, there will be 'holes'
- * within the scope and symbol tables.  Thus, if there exists a symbol
- * table with an nprim field of 50, there is not necessarily at least
- * 50 items actually within it. */
-static int strip_symbols(link_state_t *state) {
-        int i;
-        state->dest_decl = state->base->global->branch_list;
-        for (i = 0; i < SYM_NUM; i++) {
-                state->symbol_num = i;
-                hashtab_map_remove_on_error(state->base->scope[i].table,
-                                            check_symbol_used,
-                                            (hashtab_destroy_func_t) scope_destroy,
-                                            state);
-        }
-        return 0;
+	return ret;
 }
 

@@ -1892,51 +1780,15 @@ static int prepare_base(link_state_t *st
  * similar to an actual compiler: it requires a set of order dependent
  * steps.  The base and every module must have been indexed prior to
  * calling this function.
- * 
- * The general linking algorithm is:
- *
- *   1. Iterate through each module's avrule block.  Copy every avrule
- *      decl within to the base; during the copy remap every 'value'
- *      reference from the module to base.  During this copy enable the
- *      'global' block for each module.  (symbol remap phase)
- *   2. Enable the first avrule_decl in base module's 'global' block.
- *      (By definition any requires in the base module are ignored.)
- *   3. Iterate through each of base's avrule blocks.  If it has not
- *      been decided which decl has been enabled, check the requirements
- *      for the first decl.  If it is met, enable the decl.  (flow
- *      analysis phase)
- *   4. For each avrule block not enabled yet, try the first and second
- *      decl.  Keep increasing the search so that eventually each block's
- *      chain is search, to find the first decl to enable.  (This is a
- *      type of iterative deepening search, for you AI folks out there.)
- *   5. From step 1, it was recorded where within base's avrule_block
- *      chain were each of the global block that was auto-enabled.  Go
- *      through those and actually verify that their requirements have
- *      been met.  This step is deliberately done after all processing to
- *      to enable as many avrule blocks as possible.
- *   6. Now that the linker has enabled the appropriate modules and
- *      optionals, merge their symbol tables into base.  Do the same
- *      with avrule rule declarations.  (static link phase)
- *   7. Then search through the base policy and prune symbols that are
- *      were used only by disabled optionals.  (strip phase)
- *
- * Returns 0 on success, -1 on memory error, or -2 if could not copy a
- * block, or -3 if a module requirement was not met.
- *
- * To enable error reporting, pass a non-NULL allocated error buffer
- * and its size.  This function will fill in the buffer with a
- * detailed error description, ala errno.  Upon success the error
- * buffer will be untouched.
  */
 int link_modules(sepol_handle_t *handle,
 		 policydb_t *b, policydb_t **mods, int len,
                  int verbose)
 {
-        int i, retval = -1;
+        int i, ret, retval = -1;
         policy_module_t **modules = NULL;
 	link_state_t state;
         uint32_t num_mod_decls = 0;
-        uint32_t base_was_enabled;
 
         memset(&state, 0, sizeof(state));
         state.base = b;
@@ -1983,66 +1835,44 @@ int link_modules(sepol_handle_t *handle,
                 goto cleanup;
         }
 
-        /* copy and remap the module's data over to base */
-        for (i = 0; i < len; i++) {
-                state.cur = modules[i];
-                if (copy_module(&state, modules[i]) == -1) {
-                        retval = -2;
+	/* copy all types, declared and required */
+	for (i = 0; i < len; i++) {
+		state.cur = modules[i];
+		state.cur_mod_name = modules[i]->policy->name;
+		ret = hashtab_map(modules[i]->policy->p_types.table, type_copy_callback, &state);
+		if (ret) {
+			retval = ret;
+			goto cleanup;
+		}
+	}
+	
+	/* then copy everything else, including aliases, and fixup attributes */
+	for (i = 0; i < len; i++) {
+		state.cur = modules[i];
+		state.cur_mod_name = modules[i]->policy->name;
+		ret = copy_identifiers(&state, modules[i]->policy->symtab, NULL);
+		if (ret) {
+			retval = ret;
                         goto cleanup;
                 }
         }
-        
-        /* re-index base, for symbols were added to symbol tables  */
-        if (policydb_index_classes(state.base)) {
-                ERR(state.handle, "Error while indexing classes");
-                goto cleanup;
-        }
+
         if (policydb_index_others(state.handle, state.base, 0)) {
                 ERR(state.handle, "Error while indexing others");
                 goto cleanup;
         }
 
-        /* at this point the base policy includes all of the modules
-         * data; one could destroy the module policies for they are no
-         * longer needed other than for error reporting purposes */
-
-        if (state.verbose) {
-                INFO(state.handle, "Determining which avrules to enable.");
-        }
-        /* enable the global branch, then the appropriate optional branches */
-        base_was_enabled = b->global->branch_list->enabled;
-        b->global->enabled = b->global->branch_list;
-        b->global->branch_list->enabled = 1;
-        enable_avrules(&state, state.base);
-
-        /* check that each module's global requirements have been met */
-        if (verify_module_requirements(&state, modules, len) == -1) {
-                retval = -3;
-                goto cleanup;
-        }
-
-        /* merge enabled blocks into base's global block */
-        if (merge_avrules(&state, state.base->global) == -1) {
-                retval = -1;
-                goto cleanup;
-        }
-
-        /* strip away parts of the policy that are no longer needed */
-        if (strip_symbols(&state) == -1) {
-                retval = -1;
-                goto cleanup;
-        }
-        avrule_block_list_destroy(state.base->global->next);
-        state.base->global->next = NULL;
-
-        /* reset the global branch enabled flag now that the policy
-           has been reconstructed */
-        b->global->branch_list->enabled = base_was_enabled;
-        if (!base_was_enabled) {
-                b->global->enabled = NULL;
+        /* copy and remap the module's data over to base */
+        for (i = 0; i < len; i++) {
+                state.cur = modules[i];
+                ret = copy_module(&state, modules[i]);
+		if (ret) {
+			retval = ret;
+                        goto cleanup;
+                }
         }
         
-        /* re-index base one final time, for some symbols were removed */
+        /* re-index base, for symbols were added to symbol tables  */
         if (policydb_index_classes(state.base)) {
                 ERR(state.handle, "Error while indexing classes");
                 goto cleanup;
@@ -2052,12 +1882,17 @@ int link_modules(sepol_handle_t *handle,
                 goto cleanup;
         }
 
+        if (enable_avrules(&state, state.base)) {
+		retval = -SEPOL_LINK_REQNOTMET;
+		goto cleanup;
+	}
+
         retval = 0;
  cleanup:
         for (i = 0; modules != NULL && i < len; i++) {
                 policy_module_destroy(modules[i]);
         }
         free(modules);
-        free(state.decl_id_to_decl);
+	free(state.decl_to_mod);
         return retval;
 }
diff -pruN -x .svn selinux.old/libsepol/src/policydb.c optionals-in-base-take2/libsepol/src/policydb.c
--- selinux.old/libsepol/src/policydb.c	2006-06-22 13:16:40.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/policydb.c	2006-06-22 13:28:40.000000000 -0400
@@ -2469,13 +2469,13 @@ static int avrule_block_read(policydb_t 
                              struct policy_file *fp)
 {
         avrule_block_t *last_block = NULL, *curblock;
-        uint32_t *buf, num_blocks;
+        uint32_t *buf, num_blocks, nel;
 
         if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
                 return -1;
         }
         num_blocks = le32_to_cpu(buf[0]);
-
+	nel = num_blocks;
         while (num_blocks > 0) {
                 avrule_decl_t *last_decl = NULL, *curdecl;
                 uint32_t num_decls;
@@ -2487,6 +2487,10 @@ static int avrule_block_read(policydb_t 
 			free(curblock);
                         return -1;
                 }
+		/* if this is the first block its non-optional, else its optional */
+		if (num_blocks != nel)
+			curblock->flags |= AVRULE_OPTIONAL;
+
                 num_decls = le32_to_cpu(buf[0]);
                 while (num_decls > 0) {
                         if ((curdecl = avrule_decl_create(0)) == NULL) {
@@ -2519,8 +2523,6 @@ static int avrule_block_read(policydb_t 
                         num_decls--;
                 }
                
-                /* one must be careful to reconstruct the block chain
-                 * in its correct order */
                 if (*block == NULL) {
                         *block = curblock;
                 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
