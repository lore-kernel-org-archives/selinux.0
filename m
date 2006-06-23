Subject: [PATCH 8/10] expander fixes
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 23 Jun 2006 10:52:27 -0400
Message-Id: <1151074347.4011.79.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This fixes the expander to correctly aggregate symbols (users, roles,
attributes) from the linked copy. It also adds constraint copying that
maps the type_set correctly and several other mapping issues.


diff -pruN -x .svn selinux.old/libsepol/src/expand.c optionals-in-base-take2/libsepol/src/expand.c
--- selinux.old/libsepol/src/expand.c	2006-06-22 20:46:58.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/expand.c	2006-06-22 20:50:37.000000000 -0400
@@ -140,6 +140,7 @@ static int attr_convert_callback(hashtab
                 ERR (state->handle, "Out of memory!");
                 return -1;
         }
+	ebitmap_destroy(&tmp_union);
 
         return 0;
 }
@@ -370,6 +371,25 @@ static int class_copy_callback(hashtab_k
                 new_class->permissions.nprim += new_class->comdatum->permissions.nprim;
         }
 
+        return 0;
+}
+
+static int constraint_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+        char *id;
+        class_datum_t *class, *new_class;
+       	expand_state_t *state;
+
+        id = (char *)key;
+        class = (class_datum_t *)datum;
+        state = (expand_state_t*)data;
+	
+	new_class = hashtab_search(state->out->p_classes.table, id);
+	if (!new_class) {
+		ERR (state->handle, "class %s vanished", id);
+		return -1;
+	}
+
         /* constraints */
         if (constraint_node_clone(&new_class->constraints, class->constraints, state) == -1 ||
             constraint_node_clone(&new_class->validatetrans, class->validatetrans, state) == -1) {
@@ -438,6 +458,7 @@ static int role_copy_callback(hashtab_ke
         role_datum_t *role;
         role_datum_t *new_role;
        	expand_state_t *state;
+	ebitmap_t tmp_union_types;
 
         id = key;
         role = (role_datum_t*)datum;
@@ -454,40 +475,62 @@ static int role_copy_callback(hashtab_ke
         if (state->verbose)
                 INFO(state->handle, "copying role %s", id);
 
-        new_role = (role_datum_t *) malloc(sizeof(role_datum_t));
-        if (!new_role) {
-                ERR (state->handle, "Out of memory!");
-                return -1;
-        }
-        memset(new_role, 0, sizeof(role_datum_t));
+	new_role = (role_datum_t *) hashtab_search(state->out->p_roles.table, id);
+	if (!new_role) {
+		new_role = (role_datum_t *) malloc(sizeof(role_datum_t));
+		if (!new_role) {
+			ERR (state->handle, "Out of memory!");
+			return -1;
+		}
+		memset(new_role, 0, sizeof(role_datum_t));
 
-        new_id = strdup(id);
-        if (!new_id) {
-                ERR (state->handle, "Out of memory!");
-                return -1;
-        }
+		new_id = strdup(id);
+		if (!new_id) {
+			ERR (state->handle, "Out of memory!");
+			return -1;
+		}
 
-        new_role->value = role->value;
-        state->out->p_roles.nprim++;
-        ret = hashtab_insert(state->out->p_roles.table,
-                             (hashtab_key_t) new_id, (hashtab_datum_t) new_role);
+		new_role->value = role->value;
+		state->out->p_roles.nprim++;
+		ret = hashtab_insert(state->out->p_roles.table,
+					(hashtab_key_t) new_id, (hashtab_datum_t) new_role);
+
+		if (ret) {
+			ERR (state->handle, "hashtab overflow");
+			free(new_role);
+			free(new_id);
+			return -1;
+		}
+	}
 
-        if (ret) {
-                ERR (state->handle, "hashtab overflow");
-                free(new_role);
-                free(new_id);
+	if (!(&new_role->dominates.node)) {
+		ebitmap_init(&new_role->dominates);
+	}
+
+        if (ebitmap_union(&new_role->dominates, &role->dominates)) {
+                ERR (state->handle, "Out of memory!");
                 return -1;
         }
 
-        if (ebitmap_cpy(&new_role->dominates, &role->dominates)) {
+	ebitmap_init(&tmp_union_types);
+	
+	/* convert types in the role datum in the global symtab */
+        if (expand_convert_type_set(state->out, state->typemap, &role->types, &tmp_union_types, 1)) {
+		ebitmap_destroy(&tmp_union_types);
                 ERR (state->handle, "Out of memory!");
                 return -1;
         }
 
-        if (expand_convert_type_set(state->out, state->typemap, &role->types, &new_role->types.types, 1)) {
+	if (!(&new_role->types.types.node)) {
+		ebitmap_init(&new_role->types.types);
+	}
+	
+	if (ebitmap_union(&new_role->types.types, &tmp_union_types)) {
                 ERR (state->handle, "Out of memory!");
+		ebitmap_destroy(&tmp_union_types);
                 return -1;
         }
+	ebitmap_destroy(&tmp_union_types);
 
         return 0;
 }
@@ -507,6 +550,7 @@ static int user_copy_callback(hashtab_ke
         user_datum_t *user;
         user_datum_t *new_user;
         char *id, *new_id;
+	ebitmap_t tmp_union;
 
         id = key;
         user = (user_datum_t *)datum;
@@ -520,43 +564,62 @@ static int user_copy_callback(hashtab_ke
         if (state->verbose)
                 INFO(state->handle, "copying user %s", id);
 
-        new_user = (user_datum_t *) malloc(sizeof(user_datum_t));
-        if (!new_user) {
-                ERR (state->handle, "Out of memory!");
-                return -1;
-        }
-        memset(new_user, 0, sizeof(user_datum_t));
+	new_user = (user_datum_t *) hashtab_search(state->out->p_users.table, id);
+	if (!new_user) {
+		new_user = (user_datum_t *) malloc(sizeof(user_datum_t));
+		if (!new_user) {
+			ERR (state->handle, "Out of memory!");
+			return -1;
+		}
+		memset(new_user, 0, sizeof(user_datum_t));
 
-        new_user->value = user->value;
-        state->out->p_users.nprim++;
+		new_user->value = user->value;
+		state->out->p_users.nprim++;
 
-        new_id = strdup(id);
-        if (!new_id) {
-                ERR (state->handle, "Out of memory!");
-                return -1;
-        }
-        ret = hashtab_insert(state->out->p_users.table,
-                             (hashtab_key_t)new_id, (hashtab_datum_t)new_user);
-        if (ret) {
-                ERR (state->handle, "hashtab overflow");
-                user_datum_destroy(new_user);
-                free(new_user);
-                free(new_id);
-                return -1;
-        }
-         
-        if (role_set_expand(&user->roles, &new_user->roles.roles, state->base)) {
-                ERR (state->handle, "Out of memory!");
-        	return -1;
+		new_id = strdup(id);
+		if (!new_id) {
+			ERR (state->handle, "Out of memory!");
+			return -1;
+		}
+		ret = hashtab_insert(state->out->p_users.table,
+					(hashtab_key_t)new_id, (hashtab_datum_t)new_user);
+		if (ret) {
+			ERR (state->handle, "hashtab overflow");
+			user_datum_destroy(new_user);
+			free(new_user);
+			free(new_id);
+			return -1;
+		}
+
+		/* clone MLS stuff */
+		if (mls_level_clone(&new_user->range.level[0], &user->range.level[0]) == -1 ||
+		   mls_level_clone(&new_user->range.level[1], &user->range.level[1]) == -1 ||
+		   mls_level_clone(&new_user->dfltlevel, &user->dfltlevel) == -1) {
+			ERR (state->handle, "Out of memory!");
+			return -1;
+		}
+	}
+	
+	ebitmap_init(&tmp_union);
+
+	/* get global roles for this user */
+        if (role_set_expand(&user->roles, &tmp_union, state->base)) {
+       	        ERR (state->handle, "Out of memory!");
+		ebitmap_destroy(&tmp_union);
+       		return -1;
         }
 
-        /* clone MLS stuff */
-        if (mls_level_clone(&new_user->range.level[0], &user->range.level[0]) == -1 ||
-            mls_level_clone(&new_user->range.level[1], &user->range.level[1]) == -1 ||
-            mls_level_clone(&new_user->dfltlevel, &user->dfltlevel) == -1) {
+	if (!(&new_user->roles.roles.node)) {
+		ebitmap_init(&new_user->roles.roles);
+	}
+
+	if (ebitmap_union(&new_user->roles.roles, &tmp_union)) {
                 ERR (state->handle, "Out of memory!");
-        	return -1;
+		ebitmap_destroy(&tmp_union);
+                return -1;
         }
+	ebitmap_destroy(&tmp_union);
+		
         return 0;
 }
 
@@ -1471,6 +1534,7 @@ int expand_convert_type_set(policydb_t *
         if (type_set_expand(&tmpset, types, p, alwaysexpand))
                 return -1;
 
+	type_set_destroy(&tmpset);
 
         return 0;
 }
@@ -1724,6 +1788,8 @@ err:
 
 /* Linking should always be done before calling expand, even if
  * there is only a base since all optionals are dealt with at link time
+ * the base passed in should be indexed and avrule blocks should be 
+ * enabled.
  */
 int expand_module(sepol_handle_t *handle,
 		  policydb_t *base, policydb_t *out,
@@ -1734,10 +1800,6 @@ int expand_module(sepol_handle_t *handle
 	expand_state_t state;
         avrule_block_t *curblock;
 
-	/* activate the global branch before expansion */
-	base->global->branch_list->enabled = 1;
-	base->global->enabled = base->global->branch_list;
-
 	state.verbose = verbose;
         state.typemap = NULL;
 	state.base = base;
@@ -1749,14 +1811,6 @@ int expand_module(sepol_handle_t *handle
                 return -1;
         }
 
-	if (policydb_index_classes(state.base)) {
-                ERR (handle, "Error while indexing base classes");
-                goto cleanup;
-        }
-	if (policydb_index_others(handle, state.base, 0)) {
-                ERR (handle, "Error while indexing base symbols");
-                goto cleanup;
-        }
 	state.out->policy_type = POLICY_KERN;
 	state.out->policyvers = POLICYDB_VERSION_MAX;
 
@@ -1785,20 +1839,22 @@ int expand_module(sepol_handle_t *handle
                 goto cleanup;
         }
 
-        /* copy classes */
+        /* copy classes, note, this does not copy constraints, constraints can't be
+	 * copied until after all the blocks have been processed and attributes are complete */
         if (hashtab_map(state.base->p_classes.table, class_copy_callback, &state)) {
                 goto cleanup;
         }
-		
-	if (policydb_index_classes(out)) {
-                ERR (handle, "Error while indexing out classes");
-                goto cleanup;
-        }
 
         /* copy aliases */
         if (hashtab_map(state.base->p_types.table, alias_copy_callback, &state))
                 goto cleanup;
 
+	/* index here so that type indexes are available for role_copy_callback */
+        if (policydb_index_others(handle, out, verbose)) {
+                ERR (handle, "Error while indexing out symbols");
+                goto cleanup;
+        }
+
         /* copy roles */
         if (hashtab_map(state.base->p_roles.table, role_copy_callback, &state))
                 goto cleanup;
@@ -1826,22 +1882,40 @@ int expand_module(sepol_handle_t *handle
                 goto cleanup;
         }
 
+	/* loop through all decls and union attributes, roles, users */
         for (curblock = state.base->global; curblock != NULL; curblock = curblock->next) {
-                avrule_decl_t *decl = curblock->branch_list;
-                avrule_t *cur_avrule;
+                avrule_decl_t *decl = curblock->enabled;
 
-                /* find the first declaration that is enabled */
-                while (decl != NULL) {
-                        if (decl->enabled) {
-                                break;
-                        }
-                        decl = decl->next;
-                }
                 if (decl == NULL) {
                         /* nothing was enabled within this block */
                         continue;
                 }                
                 
+		/* convert attribute type sets */
+	        if (hashtab_map(decl->p_types.table, attr_convert_callback, &state)) {
+       	       		goto cleanup;
+      		}
+                
+		/* copy roles */
+		if (hashtab_map(decl->p_roles.table, role_copy_callback, &state))
+			goto cleanup;
+
+		/* copy users */
+		if (hashtab_map(decl->p_users.table, user_copy_callback, &state))
+			goto cleanup;
+
+	}
+
+	/* then loop through delcs to copy and expand rules */
+        for (curblock = state.base->global; curblock != NULL; curblock = curblock->next) {
+                avrule_decl_t *decl = curblock->enabled;
+                avrule_t *cur_avrule;
+
+                if (decl == NULL) {
+                        /* nothing was enabled within this block */
+                        continue;
+                }                
+
                 /* copy role allows and role trans */
                 if (copy_role_allows(&state, decl->role_allow_rules) != 0 ||
                     copy_role_trans(&state, decl->role_tr_rules) != 0) {
@@ -1870,6 +1944,10 @@ int expand_module(sepol_handle_t *handle
                         goto cleanup;
         }
 
+	/* copy constraints */
+        if (hashtab_map(state.base->p_classes.table, constraint_copy_callback, &state)) {
+                goto cleanup;
+        }
 
 	cond_optimize_lists(state.out->cond_list);
 	evaluate_conds(state.out);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
