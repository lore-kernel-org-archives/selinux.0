Subject: [PATCH 7/10] fix link callbacks
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 23 Jun 2006 10:52:24 -0400
Message-Id: <1151074344.4011.77.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This fixes the linker callbacks so that symbols aren't added to local
decl symtabs when not necessary and fixes several other bugs in the callbacks.

diff -pruN -x .svn selinux.old/libsepol/src/link.c optionals-in-base-take2/libsepol/src/link.c
--- selinux.old/libsepol/src/link.c	2006-06-22 13:30:12.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/link.c	2006-06-22 13:32:18.000000000 -0400
@@ -314,21 +314,23 @@ static int role_copy_callback(hashtab_ke
                 base_role = new_role;
         }
 
-        new_id = NULL;
-        if ((new_role = malloc(sizeof(*new_role))) == NULL) {
-                goto cleanup;
-        }
-        role_datum_init(new_role);
-        new_role->value = base_role->value;
-        if ((new_id = strdup(id)) == NULL) {
-                goto cleanup;
-        }
-        if (hashtab_insert(state->dest_decl->p_roles.table, new_id, new_role)) {
-                goto cleanup;
-        }
-        state->dest_decl->p_roles.nprim++;
+	if (state->dest_decl) {
+		new_id = NULL;
+		if ((new_role = malloc(sizeof(*new_role))) == NULL) {
+			goto cleanup;
+		}
+		role_datum_init(new_role);
+		new_role->value = base_role->value;
+		if ((new_id = strdup(id)) == NULL) {
+			goto cleanup;
+		}
+		if (hashtab_insert(state->dest_decl->p_roles.table, new_id, new_role)) {
+			goto cleanup;
+		}
+		state->dest_decl->p_roles.nprim++;
+	}
         
-        state->cur->map[SYM_ROLES][role->value - 1] = new_role->value;
+        state->cur->map[SYM_ROLES][role->value - 1] = base_role->value;
         return 0;
         
  cleanup:
@@ -399,22 +401,24 @@ static int type_copy_callback(hashtab_ke
                 base_type = new_type;
         }
 
-        new_id = NULL;
-        if ((new_type = calloc(1, sizeof(*new_type))) == NULL) {
-                goto cleanup;
-        }
-        new_type->primary = type->primary;
-        new_type->isattr = type->isattr;
-        new_type->value = base_type->value;
-        if ((new_id = strdup(id)) == NULL) {
-                goto cleanup;
-        }
-        if (hashtab_insert(state->dest_decl->p_types.table, new_id, new_type)) {
-                goto cleanup;
-        }
-        state->dest_decl->p_types.nprim++;
+	if (state->dest_decl) {
+		new_id = NULL;
+		if ((new_type = calloc(1, sizeof(*new_type))) == NULL) {
+			goto cleanup;
+		}
+		new_type->primary = type->primary;
+		new_type->isattr = type->isattr;
+		new_type->value = base_type->value;
+		if ((new_id = strdup(id)) == NULL) {
+			goto cleanup;
+		}
+		if (hashtab_insert(state->dest_decl->p_types.table, new_id, new_type)) {
+			goto cleanup;
+		}
+		state->dest_decl->p_types.nprim++;
+	}
         
-        state->cur->map[SYM_TYPES][type->value - 1] = new_type->value;
+        state->cur->map[SYM_TYPES][type->value - 1] = base_type->value;
         return 0;
         
  cleanup:
@@ -475,21 +479,23 @@ static int user_copy_callback(hashtab_ke
                 base_user = new_user;
         }
 
-        new_id = NULL;
-        if ((new_user = malloc(sizeof(*new_user))) == NULL) {
-                goto cleanup;
-        }
-        user_datum_init(new_user);
-        new_user->value = base_user->value;
-        if ((new_id = strdup(id)) == NULL) {
-                goto cleanup;
-        }
-        if (hashtab_insert(state->dest_decl->p_users.table, new_id, new_user)) {
-                goto cleanup;
-        }
-        state->dest_decl->p_users.nprim++;
+	if (state->dest_decl) {
+		new_id = NULL;
+		if ((new_user = malloc(sizeof(*new_user))) == NULL) {
+			goto cleanup;
+		}
+		user_datum_init(new_user);
+		new_user->value = base_user->value;
+		if ((new_id = strdup(id)) == NULL) {
+			goto cleanup;
+		}
+		if (hashtab_insert(state->dest_decl->p_users.table, new_id, new_user)) {
+			goto cleanup;
+		}
+		state->dest_decl->p_users.nprim++;
+	}
         
-        state->cur->map[SYM_USERS][user->value - 1] = new_user->value;
+        state->cur->map[SYM_USERS][user->value - 1] = base_user->value;
         return 0;
         
  cleanup:
@@ -534,21 +540,7 @@ static int bool_copy_callback(hashtab_ke
                 
         }
 
-        new_id = NULL;
-        if ((new_bool = malloc(sizeof(*new_bool))) == NULL) {
-                goto cleanup;
-        }
-        new_bool->state = base_bool->state;
-        new_bool->value = base_bool->value;
-        if ((new_id = strdup(id)) == NULL) {
-                goto cleanup;
-        }
-        if (hashtab_insert(state->dest_decl->p_bools.table, new_id, new_bool)) {
-                goto cleanup;
-        }
-        state->dest_decl->p_bools.nprim++;
-
-        state->cur->map[SYM_BOOLS][booldatum->value - 1] = new_bool->value;
+        state->cur->map[SYM_BOOLS][booldatum->value - 1] = base_bool->value;
         return 0;
         
  cleanup:
@@ -733,10 +725,15 @@ static int role_fix_callback(hashtab_key
         ebitmap_t e_tmp;
         policy_module_t *mod = state->cur;
 	ebitmap_node_t *rnode;
+	hashtab_t role_tab;
 
         role = (role_datum_t *)datum;
+	if (state->dest_decl == NULL)
+		role_tab = state->base->p_roles.table;
+	else
+		role_tab = state->dest_decl->p_roles.table;
         
-        dest_role = hashtab_search(state->dest_decl->p_roles.table, id);
+        dest_role = hashtab_search(role_tab, id);
         assert(dest_role != NULL);
 
         if (state->verbose) {
@@ -777,15 +774,21 @@ static int type_fix_callback(hashtab_key
         ebitmap_t e_tmp;
         policy_module_t *mod = state->cur;
 	ebitmap_node_t *tnode;
+	symtab_t *typetab;
 
         type = (type_datum_t *)datum;
 
+	if (state->dest_decl == NULL)
+		typetab = &state->base->p_types;
+	else 
+		typetab = &state->dest_decl->p_types;
+        
         /* only fix attributes */
         if (!type->primary || !type->isattr) {
                 return 0;
         }
 
-        new_type = hashtab_search(state->dest_decl->p_types.table, id);
+        new_type = hashtab_search(typetab->table, id);
         assert(new_type != NULL && new_type->isattr);
 
         if (state->verbose) {
@@ -823,6 +826,9 @@ static int user_fix_callback(hashtab_key
 
         user = (user_datum_t *)datum;
         
+	if (state->dest_decl == NULL)
+		return 0;
+        
         new_user = hashtab_search(state->dest_decl->p_users.table, id);
         assert(new_user != NULL);
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
