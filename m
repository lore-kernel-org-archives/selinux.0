Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4QIUegA006732
	for <selinux@tycho.nsa.gov>; Thu, 26 May 2005 14:30:40 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4QIPGmU007731
	for <selinux@tycho.nsa.gov>; Thu, 26 May 2005 18:25:16 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id j4QIQSsa024363
	for <selinux@tycho.nsa.gov>; Thu, 26 May 2005 14:26:28 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.1/8.13.1/Submit) id j4QIQSVD024362
	for selinux@tycho.nsa.gov; Thu, 26 May 2005 14:26:28 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4QHXAgA006183
	for <selinux@tycho.nsa.gov>; Thu, 26 May 2005 13:33:10 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4QHRgmU002760
	for <selinux@tycho.nsa.gov>; Thu, 26 May 2005 17:27:47 GMT
Subject: [Patch 2/3] Loadable policy module infrastructure
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux <selinux@tycho.nsa.gov>
Cc: selinux-dev@tresys.com
Content-Type: text/plain
Date: Thu, 26 May 2005 13:27:04 -0400
Message-Id: <1117128424.3482.20.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

diff -burNd a1/libsepol/src/expand.c b/libsepol/src/expand.c
--- a1/libsepol/src/expand.c	1969-12-31 19:00:00.000000000 -0500
+++ b/libsepol/src/expand.c	2005-05-25 13:11:19.526055000 -0400
@@ -0,0 +1,1746 @@
+/* Authors: Karl MacMillan <kmacmillan@tresys.com>
+ *          Jason Tang <jtang@tresys.com>
+ *	    Joshua Brindle <jbrindle@tresys.com>
+ *
+ * Copyright (C) 2004-5 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+
+#include <sepol/context.h>
+#include <sepol/policydb.h>
+#include <sepol/conditional.h>
+#include <sepol/hashtab.h>
+#include <sepol/expand.h>
+
+#include <stdlib.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+#include <assert.h>
+
+typedef struct expand_state {
+	int verbose;
+	uint32_t *typemap;
+	policydb_t *base;
+	policydb_t *out;
+        char *error_buf;
+        size_t error_buf_size;
+} expand_state_t;
+
+/* Write an error message to the current error buffer, up to the
+ * buffer's specified size. */
+static void write_error (expand_state_t *state, char *fmt, ...) {
+        va_list ap;
+        if (state->error_buf == NULL) {
+                return;
+        }
+        va_start (ap, fmt);
+        (void) vsnprintf (state->error_buf, state->error_buf_size, fmt, ap);
+        va_end (ap);
+}
+
+static int type_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+        int ret;
+        char *id, *new_id;
+        type_datum_t *type, *new_type;
+       	expand_state_t *state;
+
+        id = (char *)key;
+        type = (type_datum_t *)datum;
+        state = (expand_state_t*)data;
+
+        if (!type->primary) {
+                /* aliases are handled later */
+                return 0;
+        }
+
+        if (state->verbose)
+                printf("copying type or attribute %s\n", id);
+
+        new_id = strdup(id);
+        if (new_id == NULL) {
+                write_error (state, "Out of memory!");
+                return -1;
+        }
+
+        new_type = (type_datum_t *) malloc(sizeof(type_datum_t));
+        if (!new_type) {
+                write_error (state, "Out of memory!\n");
+                free (new_id);
+                return -ENOMEM;
+        }
+        memset(new_type, 0, sizeof(type_datum_t));
+
+        new_type->isattr = type->isattr;
+        if (!type->isattr) {
+                new_type->value = ++state->out->p_types.nprim;
+                /* FIX ME: temp fix here */
+                new_type->value = type->order;
+                new_type->primary = 1;
+        }
+        else {
+                /* lookups of attributes should never occur, so
+                 * explicitly set it to a blatantly illegal value
+                 * here */
+                new_type->value = -1;
+        }
+        state->typemap[type->value - 1] = new_type->value;
+
+        ret = hashtab_insert(state->out->p_types.table,
+                             (hashtab_key_t)new_id, (hashtab_datum_t)new_type);
+        if (ret) {
+                free (new_id);
+                free (new_type);
+                write_error (state, "hashtab overflow");
+                return -1;
+        }
+
+        return 0;
+}
+
+static int perm_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+        int ret;
+        char *id, *new_id;
+        symtab_t *s;
+        perm_datum_t *perm, *new_perm;
+
+        id = key;
+        perm = (perm_datum_t*)datum;
+        s = (symtab_t*)data;
+
+        new_perm = (perm_datum_t*)malloc(sizeof(perm_datum_t));
+        if (!new_perm) {
+                return -1;
+        }
+        memset(new_perm, 0, sizeof(perm_datum_t));
+
+        new_id = strdup(id);
+        if (!new_id) {
+                free (new_perm);
+                return -1;
+        }
+
+        new_perm->value = perm->value;
+        s->nprim++;
+
+        ret = hashtab_insert(s->table, new_id, (hashtab_datum_t*)new_perm);
+        if (ret) {
+                free (new_id);
+                free (new_perm);
+                return -1;
+        }
+
+        return 0;
+}
+
+static int common_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+        int ret;
+        char *id, *new_id;
+        common_datum_t *common, *new_common;
+       	expand_state_t *state;
+
+        id = (char *)key;
+        common = (common_datum_t *)datum;
+        state = (expand_state_t*)data;
+
+        if (state->verbose)
+                printf("copying common %s\n", id);
+
+        new_common = (common_datum_t*)malloc(sizeof(common_datum_t));
+        if (!new_common) {
+                write_error (state, "Out of memory!");
+                return -1;
+        }
+        memset(new_common, 0, sizeof(common_datum_t));
+        if (symtab_init(&new_common->permissions, PERM_SYMTAB_SIZE)) {
+                write_error (state, "Out of memory!");
+                free (new_common);
+                return -1;
+        }
+
+        new_id = strdup(id);
+        if (!new_id) {
+                write_error (state, "Out of memory!");
+                free (new_common);
+                return -1;
+        }
+
+        new_common->value = common->value;
+	state->out->p_commons.nprim++;
+
+        ret = hashtab_insert(state->out->p_commons.table, new_id, (hashtab_datum_t*)new_common);
+        if (ret) {
+                write_error (state, "hashtab overflow");
+                free (new_common);
+                free (new_id);
+                return -1;
+        }
+
+        if (hashtab_map(common->permissions.table, perm_copy_callback, &new_common->permissions)) {
+                write_error (state, "Out of memory!");
+                return -1;
+        }
+
+        return 0;
+}
+
+static int constraint_node_clone(constraint_node_t **dst, constraint_node_t *src, expand_state_t *state)
+{
+        constraint_node_t *new_con, *last_new_con = NULL;
+        *dst = NULL;
+        while (src != NULL) {
+                constraint_expr_t *expr, *new_expr, *expr_l = NULL;
+        	new_con = (constraint_node_t*)malloc(sizeof(constraint_node_t));
+        	if (!new_con) {
+                        goto out_of_mem;
+        	}
+        	memset(new_con, 0, sizeof(constraint_node_t));
+        	new_con->permissions = src->permissions;
+        	for (expr = src->expr; expr; expr = expr->next) {
+        		new_expr = (constraint_expr_t*)malloc(sizeof(constraint_expr_t));
+        		if (!new_expr) {
+                                goto out_of_mem;
+        		}
+        		memset(new_expr, 0, sizeof(constraint_expr_t));
+        		ebitmap_init(&new_expr->names);
+        		
+        		new_expr->expr_type = expr->expr_type;
+        		new_expr->attr = expr->attr;
+        		new_expr->op = expr->op;
+                        /* If the constraint expression indicates a
+                           type name, remap the corresponding 'names'
+                           bitmap from old to new by way of the
+                           typemap.  Note that if a name is actually
+                           an attribute, one needs to remap the
+                           /components/ of that attribute as well. */
+        		if (new_expr->expr_type == CEXPR_NAMES) {
+                                int i, j;
+        			for (i = ebitmap_startbit(&expr->names); i < ebitmap_length(&expr->names); i++) {
+        				if (!ebitmap_get_bit(&expr->names, i))
+        					continue;
+        				if (new_expr->attr & CEXPR_TYPE) {
+        					if (state->base->type_val_to_struct[i]->isattr) {
+        						ebitmap_t *attr = &state->base->type_val_to_struct[i]->types;
+        						for (j = ebitmap_startbit(attr); j < ebitmap_length(attr); j++) {
+        							if (!ebitmap_get_bit(attr, j))
+        								continue;
+        							if (ebitmap_set_bit(&new_expr->names, state->typemap[j] - 1, 1))
+        								goto out_of_mem;
+        						}
+        					} else {
+        						if (ebitmap_set_bit(&new_expr->names, state->typemap[i] - 1, 1)) {
+                                                                goto out_of_mem;
+                                                        }
+        					}
+        				} else {
+        					if (ebitmap_set_bit(&new_expr->names, i, 1)) {
+                                                        goto out_of_mem;
+                                                }
+        				}
+        			}
+        		}
+        		if (expr_l) {
+        			expr_l->next = new_expr;
+        		} else {
+        			new_con->expr = new_expr;
+        		}
+        		expr_l = new_expr;
+        	}
+                if (last_new_con == NULL) {
+                        *dst = new_con;
+                }
+                else {
+        		last_new_con->next = new_con;
+        	}
+        	last_new_con = new_con;
+                src = src->next;
+        }
+
+        return 0;
+ out_of_mem:
+        write_error(state, "Out of memory!");
+        return -1;
+}
+
+static int class_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+        int ret;
+        char *id, *new_id;
+        class_datum_t *class, *new_class;
+       	expand_state_t *state;
+
+        id = (char *)key;
+        class = (class_datum_t *)datum;
+        state = (expand_state_t*)data;
+
+        if (state->verbose)
+                printf("copying class %s\n", id);
+
+        new_class = (class_datum_t*)malloc(sizeof(class_datum_t));
+        if (!new_class) {
+                write_error (state, "Out of memory!");
+                return -1;
+        }
+        memset(new_class, 0, sizeof(class_datum_t));
+        if (symtab_init(&new_class->permissions, PERM_SYMTAB_SIZE)) {
+                write_error (state, "Out of memory!");
+                free (new_class);
+                return -1;
+        }
+
+        new_class->value = class->value;
+	state->out->p_classes.nprim++;
+
+        new_id = strdup(id);
+        if (!new_id) {
+                write_error (state, "Out of memory!");
+                free (new_class);
+                return -1;
+        }
+
+        ret = hashtab_insert(state->out->p_classes.table, new_id, (hashtab_datum_t*)new_class);
+        if (ret) {
+                write_error (state, "hashtab overflow");
+                free (new_class);
+                free (new_id);
+                return -1;
+        }
+
+        if (hashtab_map(class->permissions.table, perm_copy_callback, &new_class->permissions)) {
+                write_error (state, "hashtab overflow");
+                return -1;
+        }
+
+        if (class->comkey) {
+                new_class->comkey = strdup(class->comkey);
+                if (!new_class->comkey)
+                {
+                        write_error (state, "Out of memory!");
+                        return -1;
+                }
+
+                new_class->comdatum = hashtab_search(state->out->p_commons.table, new_class->comkey);
+                if (!new_class->comdatum)
+                {
+                        write_error (state, "could not find common datum %s\n", new_class->comkey);
+                        return -1;
+                }
+                new_class->permissions.nprim += new_class->comdatum->permissions.nprim;
+        }
+
+        /* constraints */
+        if (constraint_node_clone(&new_class->constraints, class->constraints, state) == -1 ||
+            constraint_node_clone(&new_class->validatetrans, class->validatetrans, state) == -1) {
+                return -1;
+        }
+        return 0;
+}
+
+/* The aliases have to be copied after the types and attributes to be certain that
+ * the out symbol table will have the type that the alias refers. Otherwise, we
+ * won't be able to find the type value for the alias. We can't depend on the
+ * declaration ordering because of the hash table.
+ */
+static int alias_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+        int ret;
+        char *id, *new_id;
+        type_datum_t *alias, *new_alias;
+       	expand_state_t *state;
+
+        id = (char *)key;
+        alias = (type_datum_t *)datum;
+        state = (expand_state_t*)data;
+
+        /* ignore types and attributes */
+        if (alias->primary || alias->isattr) {
+                return 0;
+        }
+
+        if (state->verbose)
+                printf("copying alias %s\n", id);
+
+        new_id = strdup(id);
+        if (!new_id) {
+                write_error (state, "Out of memory!");
+                return -1;
+        }
+
+        new_alias = (type_datum_t *) malloc(sizeof(type_datum_t));
+        if (!new_alias) {
+                write_error (state, "Out of memory!");
+                return -ENOMEM;
+        }
+        memset(new_alias, 0, sizeof(type_datum_t));
+        new_alias->value = state->typemap[alias->value - 1];
+
+        ret = hashtab_insert(state->out->p_types.table,
+                             (hashtab_key_t)new_id, (hashtab_datum_t) new_alias);
+
+        if (ret) {
+                write_error (state, "hashtab overflow");
+                free(new_alias);
+                free(new_id);
+                return -1;
+        }
+
+        state->typemap[alias->value - 1] = new_alias->value;
+        return 0;
+}
+
+static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+        int ret;
+        char *id, *new_id;
+        role_datum_t *role;
+        role_datum_t *new_role;
+       	expand_state_t *state;
+
+        id = key;
+        role = (role_datum_t*)datum;
+        state = (expand_state_t*)data;
+
+        if (strcmp(id, OBJECT_R) == 0)
+                return 0;
+
+        if (state->verbose)
+                printf("copying role %s\n", id);
+
+        new_role = (role_datum_t *) malloc(sizeof(role_datum_t));
+        if (!new_role) {
+                write_error (state, "Out of memory!");
+                return -1;
+        }
+        memset(new_role, 0, sizeof(role_datum_t));
+
+        new_id = strdup(id);
+        if (!new_id) {
+                write_error (state, "Out of memory!");
+                return -1;
+        }
+        new_role->value = role->value;
+        state->out->p_roles.nprim++;
+        ret = hashtab_insert(state->out->p_roles.table,
+                             (hashtab_key_t) new_id, (hashtab_datum_t) new_role);
+
+        if (ret) {
+                write_error (state, "hashtab overflow");
+                free(new_role);
+                free(new_id);
+                return -1;
+        }
+
+        if (ebitmap_cpy(&new_role->dominates, &role->dominates)) {
+                write_error (state, "Out of memory!");
+                return -1;
+        }
+
+        if (expand_convert_type_set(state->base, state->typemap, &role->types, &new_role->types.types)) {
+                write_error (state, "Out of memory!");
+                return -1;
+        }
+
+        return 0;
+}
+
+static int mls_level_clone(mls_level_t *dst, mls_level_t *src) {
+        dst->sens = src->sens;
+        if (ebitmap_cpy(&dst->cat, &src->cat)) {
+                return -1;
+        }
+        return 0;
+}
+
+static int user_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+        int ret;
+       	expand_state_t *state;
+        user_datum_t *user;
+        user_datum_t *new_user;
+        char *id, *new_id;
+
+        id = key;
+        user = (user_datum_t *)datum;
+        state = (expand_state_t*)data;
+
+        if (state->verbose)
+                printf("copying user %s\n", id);
+
+        new_user = (user_datum_t *) malloc(sizeof(user_datum_t));
+        if (!new_user) {
+                write_error (state, "Out of memory!");
+                return -1;
+        }
+        memset(new_user, 0, sizeof(user_datum_t));
+
+        new_user->value = user->value;
+        state->out->p_users.nprim++;
+
+        new_id = strdup(id);
+        if (!new_id) {
+                write_error (state, "Out of memory!");
+                return -1;
+        }
+        ret = hashtab_insert(state->out->p_users.table,
+                             (hashtab_key_t)new_id, (hashtab_datum_t)new_user);
+        if (ret) {
+                write_error (state, "hashtab overflow");
+                user_datum_destroy(NULL, new_user, NULL);
+                free(new_user);
+                free(new_id);
+                return -1;
+        }
+         
+        if (role_set_expand(&user->roles, &new_user->roles.roles, state->base)) {
+                write_error (state, "Out of memory!");
+        	return -1;
+        }
+
+        /* clone MLS stuff */
+        if (mls_level_clone(&new_user->range.level[0], &user->range.level[0]) == -1 ||
+            mls_level_clone(&new_user->range.level[1], &user->range.level[1]) == -1 ||
+            mls_level_clone(&new_user->dfltlevel, &user->dfltlevel) == -1) {
+                write_error (state, "Out of memory!");
+        	return -1;
+        }
+        new_user->defined = user->defined;
+        return 0;
+}
+
+
+static int bool_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+        int ret;
+       	expand_state_t *state;
+        cond_bool_datum_t *bool, *new_bool;
+        char *id, *new_id;
+
+        id = key;
+        bool = (cond_bool_datum_t *)datum;
+        state = (expand_state_t*)data;
+
+        if (state->verbose)
+                printf("copying boolean %s\n", id);
+
+        new_bool = (cond_bool_datum_t*)malloc(sizeof(cond_bool_datum_t));
+        if (!new_bool) {
+                write_error (state, "Out of memory!");
+                return -1;
+        }
+
+        new_id = strdup(id);
+        if (!new_id) {
+                write_error (state, "Out of memory!");
+                free (new_bool);
+                return -1;
+        }
+
+        new_bool->value = bool->value;
+        state->out->p_bools.nprim++;
+
+        ret = hashtab_insert(state->out->p_bools.table,
+                             (hashtab_key_t)new_id, (hashtab_datum_t)new_bool);
+        if (ret) {
+                write_error (state, "hashtab overflow");
+                free(new_bool);
+                free(new_id);
+                return -1;
+        }
+
+        new_bool->state = bool->state;
+
+        return 0;
+}
+
+static int sens_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+       	expand_state_t *state = (expand_state_t*)data;
+        level_datum_t *level = (level_datum_t *)datum, *new_level = NULL;
+        char *id = (char *) key, *new_id = NULL;
+
+        if (state->verbose)
+                printf("copying senitivity level %s\n", id);
+
+        if ((new_level = (level_datum_t*)calloc(1, sizeof(*new_level))) == NULL ||
+            (new_level->level = (mls_level_t *)calloc(1, sizeof(mls_level_t))) == NULL ||
+            (new_id = strdup(id)) == NULL) {
+                goto out_of_mem;
+        }
+
+        if (mls_level_clone(new_level->level, level->level)) {
+                goto out_of_mem;
+        }
+        new_level->isalias = level->isalias;
+        state->out->p_levels.nprim++;
+
+        if (hashtab_insert(state->out->p_levels.table,
+                           (hashtab_key_t)new_id, (hashtab_datum_t)new_level)) {
+                goto out_of_mem;
+        }
+        return 0;
+        
+ out_of_mem:
+        write_error(state, "Out of memory!");
+        if (new_level != NULL) {
+                ebitmap_destroy(&new_level->level->cat);
+                free(new_level->level);
+        }
+        free(new_level);
+        free(new_id);
+        return -1;
+}
+
+static int cats_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+       	expand_state_t *state = (expand_state_t*)data;
+        cat_datum_t *cat = (cat_datum_t *)datum, *new_cat = NULL;
+        char *id = (char *)key, *new_id = NULL;
+
+        if (state->verbose)
+                printf("copying category attribute %s\n", id);
+
+        if ((new_cat = (cat_datum_t*)calloc(1, sizeof(*new_cat))) == NULL ||
+            (new_id = strdup(id)) == NULL) {
+                goto out_of_mem;
+        }
+
+        new_cat->value = cat->value;
+        new_cat->isalias = cat->isalias;
+        state->out->p_cats.nprim++;
+        if (hashtab_insert(state->out->p_cats.table,
+                           (hashtab_key_t)new_id, (hashtab_datum_t)new_cat)) {
+                goto out_of_mem;
+        }
+
+        return 0;
+        
+ out_of_mem:
+        write_error(state, "Out of memory!");
+        free(new_cat);
+        free(new_id);
+        return -1;
+}
+
+
+static int copy_role_allows(expand_state_t *state)
+{
+	int i, j;
+	role_allow_t *cur_allow, *n, *l;
+	role_allow_rule_t *cur;
+	ebitmap_t roles, new_roles;
+	
+	l = NULL;
+	cur = state->base->role_allow_rules;
+	while (cur) {
+		ebitmap_init(&roles);
+		ebitmap_init(&new_roles);
+		
+		if (role_set_expand(&cur->roles, &roles, state->out)) {
+                        write_error (state, "Out of memory!");
+			return -1;
+                }
+		if (role_set_expand(&cur->new_roles, &new_roles, state->out)) {
+                        write_error (state, "Out of memory!");
+			return -1;
+                }			
+		for (i = ebitmap_startbit(&roles); i < ebitmap_length(&roles); i++) {
+			if (!ebitmap_get_bit(&roles, i))
+				continue;
+			for (j = ebitmap_startbit(&new_roles); j < ebitmap_length(&new_roles); j++) {
+				if (!ebitmap_get_bit(&new_roles, j))
+					continue;
+				/* check for duplicates */
+				cur_allow = state->out->role_allow;
+				while (cur_allow) {
+					if ((cur_allow->role == i + 1) &&
+					    (cur_allow->new_role == j + 1))
+					    	break;
+					cur_allow = cur_allow->next;
+				}
+				if (cur_allow)
+					continue;
+				n = (role_allow_t*)malloc(sizeof(role_allow_t));
+				if (!n) {
+                                        write_error (state, "Out of memory!");
+					return -1;	
+				}
+				memset(n, 0, sizeof(role_allow_t));
+				n->role = i + 1;
+				n->new_role = j + 1;
+				if (l) {
+					l->next = n;	
+				} else {
+					state->out->role_allow = n;	
+				}
+				l = n;
+			}
+		}
+		
+		ebitmap_destroy(&roles);
+		ebitmap_destroy(&new_roles);
+		
+		cur = cur->next;
+	}
+	
+	return 0;
+}
+
+static int copy_role_trans(expand_state_t *state)
+{
+	int i, j;
+	role_trans_t *n, *l, *cur_trans;
+	role_trans_rule_t *cur;
+	ebitmap_t roles, types;
+	
+	l = NULL;
+	cur = state->base->role_tr_rules;
+	while (cur) {
+		ebitmap_init(&roles);
+		ebitmap_init(&types);
+		
+		if (role_set_expand(&cur->roles, &roles, state->out)) {
+                        write_error (state, "Out of memory!");
+			return -1;
+                }
+		if (expand_convert_type_set(state->base, state->typemap, &cur->types, &types)) {
+                        write_error (state, "Out of memory!");
+			return -1;
+                }			
+		for (i = ebitmap_startbit(&roles); i < ebitmap_length(&roles); i++) {
+			if (!ebitmap_get_bit(&roles, i))
+				continue;
+			for (j = ebitmap_startbit(&types); j < ebitmap_length(&types); j++) {
+				if (!ebitmap_get_bit(&types, j))
+					continue;
+					
+				cur_trans = state->out->role_tr;
+				while (cur_trans) {
+					if ((cur_trans->role == i + 1) &&
+					    (cur_trans->type == j + 1)) {
+					 	if (cur_trans->new_role == cur->new_role) {
+					 		break;
+					 	} else {
+					 		write_error (state, "Conflicting role trans rule %s %s : %s",
+					 			state->out->p_role_val_to_name[i],
+					 			state->out->p_type_val_to_name[j],
+					 			state->out->p_role_val_to_name[cur->new_role - 1]);
+					 		return -1;
+					 	}	   	
+					}
+					cur_trans = cur_trans->next;
+				}
+				if (cur_trans)
+					continue;
+		
+				n = (role_trans_t*)malloc(sizeof(role_trans_t));
+				if (!n) {
+                                        write_error (state, "Out of memory!");
+					return -1;	
+				}
+				memset(n, 0, sizeof(role_trans_t));
+				n->role = i + 1;
+				n->type = j + 1;
+				n->new_role = cur->new_role;
+				if (l) {
+					l->next = n;	
+				} else {
+					state->out->role_tr = n;	
+				}
+				l = n;
+			}
+		}
+		
+		ebitmap_destroy(&roles);
+		ebitmap_destroy(&types);
+		
+		cur = cur->next;
+	}
+	return 0;	
+}
+
+/* Search for an AV tab node within a hash table with the given key.
+ * If the node does not exist, create it and return it; otherwise
+ * return the pre-existing one.
+ *
+ * When looking for the existing node, use 'lookup_specified' as part
+ * of the lookup key.  If doesn't exist, then create it, but instead
+ * set the node's specified field to 'real_specified'.
+*/
+static avtab_ptr_t find_avtab_node(avtab_t *avtab, avtab_key_t *key,
+                                   uint32_t lookup_specified, uint32_t real_specified,
+                                   cond_av_list_t **cond)
+{               
+        avtab_ptr_t node;
+        avtab_datum_t avdatum;
+        cond_av_list_t *nl;
+
+        node = avtab_search_node(avtab, key, lookup_specified);
+
+        /* If this is for conditional policies, keep searching in case
+           the node is part of my conditional avtab. */
+        if (cond) {     
+                while (node) {
+                        if (node->parse_context == cond)
+                                break;
+                        node = avtab_search_node_next(node, lookup_specified);
+                }
+        }
+
+        if (!node) {
+                memset(&avdatum, 0, sizeof avdatum);
+                avdatum.specified = real_specified;
+                /* this is used to get the node - insertion is actually unique */
+                node = avtab_insert_nonunique(avtab, key, &avdatum);
+                if (!node) {
+                        fprintf(stderr, "hash table overflow");
+                        return NULL;
+                }
+                if (cond) {
+                        node->parse_context = cond;
+                        nl = (cond_av_list_t*)malloc(sizeof(cond_av_list_t));
+                        if (!nl) {
+                                fprintf(stderr, "Memory error\n");
+                                return NULL;
+                        }
+                        memset(nl, 0, sizeof(cond_av_list_t));
+                        nl->node = node;
+                        nl->next = *cond;
+                        *cond = nl;
+                }
+        }
+
+        return node;
+}
+
+static int expand_terule_helper(policydb_t *p, uint32_t *typemap, uint32_t specified,
+                                cond_av_list_t **cond, cond_av_list_t **other,
+                                uint32_t stype, uint32_t ttype, class_perm_node_t *perms,
+                                avtab_t *avtab, int enabled, char **error_msg)
+{
+        avtab_key_t avkey;
+        avtab_datum_t *avdatump;
+        avtab_ptr_t node;
+        class_perm_node_t *cur;
+        int conflict;
+        uint32_t oldtype = 0, spec = 0;
+
+        if (specified & AVRULE_TRANSITION) {
+                spec = AVTAB_TRANSITION;
+        } else if (specified & AVRULE_MEMBER) {
+                spec = AVTAB_MEMBER;
+        } else if (specified & AVRULE_CHANGE) {
+                spec = AVTAB_CHANGE;
+        } else {
+                assert(0); /* unreachable */
+        }
+
+        cur = perms;
+        while (cur) {
+                uint32_t remapped_data = typemap ? typemap[cur->data - 1] : cur->data;
+                avkey.source_type = stype + 1;
+                avkey.target_type = ttype + 1;
+                avkey.target_class = cur->class;
+
+                conflict = 0;
+                /* check to see if the expanded TE already exists --
+                 * either in the global scope or in another
+                 * conditional AV tab */
+                node = avtab_search_node(&p->te_avtab, &avkey, spec);
+                if (node) {
+                        conflict = 1;
+                } else {
+                        node = avtab_search_node(&p->te_cond_avtab, &avkey, spec);
+                        if (node && node->parse_context != other) {
+                                conflict = 2;
+                        }
+                }
+
+                if (conflict) {
+                        avdatump = &node->datum;
+                        if (specified & AVRULE_TRANSITION) {
+                                oldtype = avtab_transition(avdatump);
+                        } else if (specified & AVRULE_MEMBER) {
+                                oldtype = avtab_member(avdatump);
+                        } else if (specified & AVRULE_CHANGE) {
+                                oldtype = avtab_change(avdatump);
+                        }
+                        /* ignore duplicates */
+                        
+                        if (oldtype == remapped_data)
+                                return 1;
+                        if (error_msg) {
+                                *error_msg = (char*)malloc(4096);
+                                if (!*error_msg) {
+                                        fprintf(stderr, "Memory error\n");
+                                        return -1;
+                                }
+                                snprintf(*error_msg, 4096, "conflicting TE rule for (%s, %s:%s):  default was %s, new is %s\n",
+                                        p->p_type_val_to_name[avkey.source_type - 1],
+                                        p->p_type_val_to_name[avkey.target_type - 1],
+                                        p->p_class_val_to_name[avkey.target_class - 1],
+                                        p->p_type_val_to_name[oldtype - 1],
+                                        p->p_type_val_to_name[remapped_data]);
+				/* This should probably return a
+				   failure but the current compiler
+				   doesn't do this so we won't but we
+				   will print the error which would
+				   normally get passed back to the
+				   caller */
+				fprintf(stderr, "%s\n",*error_msg);
+                        }
+			/* to maintain the behavior of the upstream
+			   compiler, if the rule is in a conditional
+			   and is conflicting with the unconditional
+			   rule then we bail */
+			if (cond && conflict == 1)
+	                        return 0;
+                }
+
+                /* the upstream compiler does not collapse multiple AV
+                   rules into a single one for those given within
+                   conditionals */
+                node = find_avtab_node(avtab, &avkey,
+                                       (cond == NULL ? AVTAB_TYPE : spec),
+                                       spec, cond);
+                if (!node)
+                        return -1;
+                avdatump = &node->datum;
+                if (enabled) {
+                        avdatump->specified |= AVTAB_ENABLED;
+                }
+                else {
+                        avdatump->specified &= ~AVTAB_ENABLED;
+                }
+
+                if (specified & AVRULE_TRANSITION) {
+                        avtab_transition(avdatump) = remapped_data;
+                } else if (specified & AVRULE_MEMBER) {
+                        avtab_member(avdatump) = remapped_data;
+                } else if (specified & AVRULE_CHANGE) {
+                        avtab_change(avdatump) = remapped_data;
+                } else {
+                        assert(0);   /* should never occur */
+                }
+
+                cur = cur->next;
+        }
+
+        return 1;
+}
+
+static int expand_avrule_helper(uint32_t specified,
+                                cond_av_list_t **cond,
+                                uint32_t stype, uint32_t ttype, class_perm_node_t *perms,
+                                avtab_t *avtab, int enabled)
+{
+        avtab_key_t avkey;
+        avtab_datum_t *avdatump;
+        avtab_ptr_t node;
+        class_perm_node_t *cur;
+        uint32_t spec = 0;
+
+        if (specified & AVRULE_ALLOWED) {
+                spec = AVTAB_ALLOWED;
+        } else if (specified & AVRULE_AUDITALLOW) {
+                spec = AVTAB_AUDITALLOW;
+        } else if (specified & AVRULE_AUDITDENY) {
+                spec = AVTAB_AUDITDENY;
+        } else if (specified & AVRULE_DONTAUDIT) {
+                spec = AVTAB_AUDITDENY;
+        } else {
+                assert(0); /* unreachable */
+        }
+
+        cur = perms;
+        while (cur) {
+                avkey.source_type = stype + 1;
+                avkey.target_type = ttype + 1;
+                avkey.target_class = cur->class;
+
+                /* the upstream compiler does not collapse multiple AV
+                   rules into a single one for those given within
+                   conditionals */
+                node = find_avtab_node(avtab, &avkey,
+                                       (cond == NULL ? AVTAB_AV : spec),
+                                       spec, cond);
+                if (!node)
+                        return -1;
+                avdatump = &node->datum;
+                avdatump->specified |= spec;
+                if (enabled) {
+                        avdatump->specified |= AVTAB_ENABLED;
+                }
+                else {
+                        avdatump->specified &= ~AVTAB_ENABLED;
+                }
+
+                if (specified & AVRULE_ALLOWED) {
+                        avtab_allowed(avdatump) |= cur->data;
+                } else if (specified & AVRULE_AUDITALLOW) {
+                        avtab_auditallow(avdatump) |= cur->data;
+                } else if (specified & AVRULE_AUDITDENY) {
+                        /* Since a '0' in an auditdeny mask represents
+                         * a permission we do NOT want to audit
+                         * (dontaudit), we use the '&' operand to
+                         * ensure that all '0's in the mask are
+                         * retained (much unlike the allow and
+                         * auditallow cases).
+                         */
+                        avtab_auditdeny(avdatump) &= cur->data;
+                } else if (specified & AVRULE_DONTAUDIT) {
+                        if (avtab_auditdeny(avdatump))
+                                avtab_auditdeny(avdatump) &= ~cur->data;
+                        else
+                                avtab_auditdeny(avdatump) = ~cur->data;
+                } else {
+                        assert(0);   /* should never occur */
+                }
+
+                cur = cur->next;
+        }        
+	return 1;
+}               
+
+static int expand_rule_helper(policydb_t *p, uint32_t *typemap,
+                              avrule_t *source_rule, avtab_t *dest_avtab,
+                              cond_av_list_t **cond, cond_av_list_t **other,
+                              int enabled, char **error_msg,
+                              ebitmap_t *stypes, ebitmap_t *ttypes)
+{
+        int i, j, retval;
+        for (i = ebitmap_startbit(stypes); i < ebitmap_length(stypes); i++) {
+                if (!ebitmap_get_bit(stypes, i))
+                        continue;
+                if (source_rule->flags & RULE_SELF) {
+                        if (source_rule->specified & AVRULE_AV) {
+                                if ((retval =
+                                     expand_avrule_helper(source_rule->specified,
+                                                          cond,
+                                                          i, i, source_rule->perms,
+                                                          dest_avtab, enabled)) != 1) {
+                                        return retval;
+                                }
+                        } else {
+                                if ((retval =
+                                     expand_terule_helper(p,
+                                                          typemap, source_rule->specified,
+                                                          cond, other,
+                                                          i, i, source_rule->perms,
+                                                          dest_avtab, enabled, error_msg)) != 1) {
+                                        return retval;
+                                }
+                        }
+                }
+                for (j = ebitmap_startbit(ttypes); j < ebitmap_length(ttypes); j++) {
+                        if (!ebitmap_get_bit(ttypes, j))
+                                continue;
+                        if (source_rule->specified & AVRULE_AV) {
+                                if ((retval =
+                                     expand_avrule_helper(source_rule->specified,
+                                                          cond,
+                                                          i, j, source_rule->perms,
+                                                          dest_avtab, enabled)) != 1) {
+                                        return retval;
+                                }
+                        } else {
+                                if ((retval =
+                                     expand_terule_helper(p,
+                                                          typemap, source_rule->specified,
+                                                          cond, other,
+                                                          i, j, source_rule->perms,
+                                                          dest_avtab, enabled, error_msg)) != 1) {
+                                        return retval;
+                                }
+                        }
+                }
+        }
+
+        return 1;
+}
+
+/* Expand a rule into a given avtab - checking for conflicting type
+ * rules in the destination policy.  Return 1 on success, 0 if the
+ * rule conflicts with something (and hence was not added), or -1 on
+ * error. */
+static int convert_and_expand_rule(policydb_t *source_pol, policydb_t *dest_pol,
+                                   uint32_t *typemap, avrule_t *source_rule, avtab_t *dest_avtab,
+                                   cond_av_list_t **cond, cond_av_list_t **other,
+                                   int enabled, char **error_msg) {
+        int retval;
+        ebitmap_t stypes, ttypes;
+
+        if (source_rule->specified & AVRULE_NEVERALLOW)
+                return 1;
+
+        ebitmap_init(&stypes);
+        ebitmap_init(&ttypes);
+
+        if (expand_convert_type_set(source_pol, typemap, &source_rule->stypes, &stypes))
+                return -1;
+        if (expand_convert_type_set(source_pol, typemap, &source_rule->ttypes, &ttypes))
+                return -1;
+
+        retval = expand_rule_helper(dest_pol, typemap,
+                                    source_rule, dest_avtab,
+                                    cond, other,
+                                    enabled, error_msg,
+                                    &stypes, &ttypes);
+        ebitmap_destroy(&stypes);
+        ebitmap_destroy(&ttypes);
+        return retval;
+}
+
+
+static int cond_avrule_list_copy(policydb_t *source_pol, policydb_t *dest_pol,
+                                 avrule_t *source_rules, avtab_t *dest_avtab,
+                                 cond_av_list_t **list, cond_av_list_t **other,
+                                 uint32_t *typemap, int enabled,
+                                 expand_state_t *state)
+{
+	char *error_msg;
+	avrule_t *cur;
+	
+	cur = source_rules;
+        error_msg = NULL;
+	while (cur) {
+		if (convert_and_expand_rule(source_pol, dest_pol,
+                                            typemap, cur, dest_avtab,
+                                            list, other,
+                                            enabled, &error_msg) != 1) {
+			if (error_msg) {
+                                write_error (state, "%s", error_msg);
+				free(error_msg);
+			}
+			return -1;
+		}
+		cur = cur->next;
+	}
+	
+	return 0;
+}
+
+/* copy the nodes in *reverse* order -- the result is that the last
+ * given conditional appears first in the policy, so as to match the
+ * behavior of the upstream compiler */
+static int cond_node_copy(cond_node_t *cn, expand_state_t *state)
+{
+	cond_node_t *new_cond;
+
+        if (cn == NULL) {
+                return 0;
+        }
+        if (cond_node_copy(cn->next, state)) {
+                return -1;
+        }
+	if (cond_normalize_expr(state->base, cn)) {
+                write_error (state, "Error while normalizing conditional");
+		return -1;
+        }
+
+	new_cond = cond_node_search(state->out, state->out->cond_list, cn);
+	if (!new_cond) {
+                write_error (state, "Out of memory!");
+		return -1;
+        }
+
+	if (cond_avrule_list_copy(state->base, state->out,
+                                  cn->avtrue_list, &state->out->te_cond_avtab,
+                                  &new_cond->true_list, &new_cond->false_list,
+                                  state->typemap, new_cond->cur_state, state))
+		return -1;
+	if (cond_avrule_list_copy(state->base, state->out,
+                                  cn->avfalse_list, &state->out->te_cond_avtab,
+                                  &new_cond->false_list, &new_cond->true_list, 
+                                  state->typemap, !new_cond->cur_state, state))
+		return -1;
+
+	return 0;
+}
+
+static int context_copy(context_struct_t *dst, context_struct_t *src, expand_state_t *state)
+{
+	dst->user = src->user;
+	dst->role = src->role;
+	dst->type = state->typemap[src->type - 1];
+        return mls_context_cpy(dst, src);
+}
+
+static int ocontext_copy(expand_state_t *state)
+{
+	int i, j;
+	ocontext_t *c, *n, *l;
+	
+	for (i = 0; i < OCON_NUM; i++) {	
+		l = NULL;
+		for (c = state->base->ocontexts[i]; c; c = c->next) {
+			n = malloc(sizeof(ocontext_t));
+			if (!n) {
+                                write_error (state, "Out of memory!");
+				return -1;	
+			}
+			memset(n, 0, sizeof(ocontext_t));
+			if (l) {
+				l->next = n;
+			} else {
+				state->out->ocontexts[i] = n;
+			}
+			l = n;
+                        if (context_copy(&n->context[0], &c->context[0], state)) {
+                                write_error (state, "Out of memory!");
+                                return -1;
+                        }
+			switch (i) {
+			case OCON_ISID:
+				n->sid[0] = c->sid[0];
+                                break;
+			case OCON_FS:     /* FALLTHROUGH */
+			case OCON_NETIF:
+				n->u.name = strdup(c->u.name);
+				if (!n->u.name) {
+                                        write_error (state, "Out of memory!");
+					return -1;	
+				}
+					if (context_copy(&n->context[1], &c->context[1], state)) {
+						write_error (state, "Out of memory!");
+						return -1;
+					}
+					break;
+				case OCON_PORT:
+					n->u.port.protocol = c->u.port.protocol;
+					n->u.port.low_port = c->u.port.low_port;
+					n->u.port.high_port = c->u.port.high_port;
+					break;
+				case OCON_NODE:
+					n->u.node.addr = c->u.node.addr;
+					n->u.node.mask = c->u.node.mask;
+					break;
+				case OCON_FSUSE:
+					n->v.behavior = c->v.behavior;
+					n->u.name = strdup(c->u.name);
+					if (!n->u.name) {
+						write_error (state, "Out of memory!");
+						return -1;	
+					}
+					break;
+				case OCON_NODE6:
+					for (j = 0; j < 4; j++)
+						n->u.node6.addr[j] = c->u.node6.addr[j];
+					for (j = 0; j < 4; j++)
+						n->u.node6.mask[j] = c->u.node6.mask[j];
+					break;
+				default:
+					/* shouldn't get here */
+					assert(0);
+				}
+			}
+		}
+		return 0;
+	}
+
+static int genfs_copy(expand_state_t *state)
+{
+	ocontext_t *c, *newc, *l;
+	genfs_t *genfs, *newgenfs, *end;
+
+	end = NULL;
+	for (genfs = state->base->genfs; genfs; genfs = genfs->next) {
+		newgenfs = malloc(sizeof(genfs_t));
+		if (!newgenfs) {
+                        write_error (state, "Out of memory!");
+			return -1;
+		}
+		memset(newgenfs, 0, sizeof(genfs_t));
+		newgenfs->fstype = strdup(genfs->fstype);
+		if (!newgenfs->fstype) {
+                        write_error (state, "Out of memory!");
+			return -1;			
+		}
+
+		l = NULL;
+		for (c = genfs->head; c; c = c->next) {
+			newc = malloc(sizeof(ocontext_t));
+			if (!newc) {
+                                write_error (state, "Out of memory!");
+				return -1;
+			}
+			memset(newc, 0, sizeof(ocontext_t));
+			newc->u.name = strdup(c->u.name);
+			if (!newc->u.name) {
+                                write_error (state, "Out of memory!");
+				return -1;
+			}
+			newc->v.sclass = c->v.sclass;
+			context_copy(&newc->context[0], &c->context[0], state);
+			if (l)
+				l->next = newc;
+			else
+				newgenfs->head = newc;
+			l = newc;
+		}
+		if (!end) {
+			state->out->genfs = newgenfs;
+		} else {
+			end->next = newgenfs;
+		}
+		end = newgenfs;
+	}
+	return 0;	
+}
+
+
+static int range_trans_clone(expand_state_t *state)
+{
+        range_trans_t *range = state->base->range_tr, *last_new_range = NULL;
+        state->out->range_tr = NULL;
+
+        if (state->verbose)
+                printf("copying range transitions\n");
+
+        while (range != NULL) {
+                range_trans_t *new_range;
+                if ((new_range = malloc(sizeof(*new_range))) == NULL) {
+                        goto out_of_mem;
+                }
+                new_range->dom = range->dom;
+                new_range->type = range->type;
+                if (mls_level_clone(&new_range->range.level[0], &range->range.level[0]) == -1 ||
+                    mls_level_clone(&new_range->range.level[1], &range->range.level[1])) {
+                        goto out_of_mem;
+                }
+                new_range->next = NULL;
+                if (last_new_range == NULL) {
+                        state->out->range_tr = last_new_range = new_range;
+                }
+                else {
+                        last_new_range->next = new_range;
+                        last_new_range = new_range;
+                }
+                range = range->next;
+        }
+        return 0;
+
+ out_of_mem:
+        write_error(state, "Out of memory!");
+        return -1;
+}
+
+static int type_attr_remove(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *p __attribute__ ((unused)))
+{
+	type_datum_t *typdatum;
+
+	typdatum = (type_datum_t *) datum;
+	if (typdatum->isattr)
+		return 1;
+	return 0;
+}
+
+
+int expand_convert_type_set(policydb_t *p, uint32_t *typemap, type_set_t *set, ebitmap_t *types)
+{
+        int i;
+        ebitmap_t tmp;
+        
+        ebitmap_init(types);
+        ebitmap_init(&tmp);
+        
+        if (type_set_expand(set, &tmp, p))
+                return -1;
+                
+        for (i = ebitmap_startbit(&tmp); i < ebitmap_length(&tmp); i++) {
+                if (!ebitmap_get_bit(&tmp, i))
+                        continue;
+                if (ebitmap_set_bit(types, typemap[i] - 1, 1))
+                        return -1;
+        }
+
+        ebitmap_destroy(&tmp);
+
+        return 0;
+}
+
+
+
+/* Expand a rule into a given avtab - checking for conflicting type
+ * rules.  Return 1 on success, 0 if the rule conflicts with something
+ * (and hence was not added), or -1 on error. */
+int expand_rule(policydb_t *source_pol,
+                avrule_t *source_rule, avtab_t *dest_avtab,
+                cond_av_list_t **cond, cond_av_list_t **other,
+                int enabled, char **error_msg)
+{
+        int retval;
+        ebitmap_t stypes, ttypes;
+                
+        if (source_rule->specified & AVRULE_NEVERALLOW)
+                return 1;
+        
+        ebitmap_init(&stypes);
+        ebitmap_init(&ttypes);
+
+        if (type_set_expand(&source_rule->stypes, &stypes, source_pol))
+                return -1;
+        if (type_set_expand(&source_rule->ttypes, &ttypes, source_pol))
+                return -1;
+        retval = expand_rule_helper(source_pol, NULL,
+                                    source_rule, dest_avtab,
+                                    cond, other, enabled, error_msg,
+                                    &stypes, &ttypes);
+        ebitmap_destroy(&stypes);
+        ebitmap_destroy(&ttypes);
+        return retval;
+}
+
+int role_set_expand(role_set_t *x, ebitmap_t *r, policydb_t *p)
+{
+        int i;
+
+        ebitmap_init(r);
+
+        if (x->flags & ROLE_STAR) {
+                for (i = 0; i < p->p_roles.nprim++; i++)
+                        if (ebitmap_set_bit(r, i, 1))
+                                return -1;
+                return 0;
+        }
+
+        for (i = ebitmap_startbit(&x->roles); i < ebitmap_length(&x->roles); i++) {
+                if (ebitmap_get_bit(&x->roles, i)) {
+                        if(ebitmap_set_bit (r, i, 1))
+                                return -1;
+                }
+        }
+
+        /* if role is to be complimented, invert the entire bitmap here */
+        if (x->flags & ROLE_COMP) {
+                for (i = 0; i < ebitmap_length(r); i++) {
+                        if (ebitmap_get_bit(r, i)) {
+                                if (ebitmap_set_bit(r, i, 0))
+                                        return -1;
+                        } else {
+                                if (ebitmap_set_bit(r, i, 1))
+                                        return -1;
+                        }
+                }
+        }
+        return 0;
+}
+
+/* Expand a type set into an ebitmap containing the types. This
+ * handles the negset, attributes, and flags.
+ */
+int type_set_expand(type_set_t *set, ebitmap_t *t, policydb_t *p)
+{
+        int i;
+        ebitmap_t types, neg_types;
+
+        ebitmap_init(&types);
+        ebitmap_init(t);
+
+        /* First go through the types and OR all the attributes to types */
+        for (i = ebitmap_startbit(&set->types); i < ebitmap_length(&set->types); i++) {
+                if (ebitmap_get_bit(&set->types, i)) {
+                        if (p->type_val_to_struct[i]->isattr) {
+                                if (ebitmap_or_eq(&types, &p->type_val_to_struct[i]->types)) {
+                                        return -1;
+                                }
+                        } else {
+                                if (ebitmap_set_bit(&types, i, 1)) {
+                                        return -1;
+                                }
+                        }
+                }
+        }
+
+        /* Now do the same thing for negset */
+        ebitmap_init(&neg_types);
+        for (i = ebitmap_startbit(&set->negset); i < ebitmap_length(&set->negset); i++) {
+                if (ebitmap_get_bit(&set->negset, i)) {
+                        if (p->type_val_to_struct[i]->isattr) {
+                                if (ebitmap_or_eq(&neg_types, &p->type_val_to_struct[i]->types)) {
+                                        return -1;
+                                }
+                        } else {
+                                if (ebitmap_set_bit(&neg_types, i, 1)) {
+                                        return -1;
+                                }
+                        }
+                }
+        }
+
+        if (set->flags & TYPE_STAR) {
+                /* set all types not in neg_types */
+                for (i = 0; i < p->p_types.nprim; i++) {
+                        if (ebitmap_get_bit(&neg_types, i))
+                                continue;
+                        if (p->type_val_to_struct[i]->isattr)
+                                continue;
+                        if (ebitmap_set_bit(t, i, 1))
+                                return -1;
+                }
+                goto out;
+        }
+
+        for (i = 0; i < p->p_types.nprim; i++) {
+                if (ebitmap_get_bit(&types, i) && (!ebitmap_get_bit(&neg_types, i)))
+                        if (ebitmap_set_bit(t, i, 1))
+                                return -1;
+        }
+
+        if (set->flags & TYPE_COMP) {
+                for(i = 0; i < p->p_types.nprim; i++) {
+                        if (p->type_val_to_struct[i]->isattr) {
+                                assert(!ebitmap_get_bit(t, i));
+                                continue;
+                        }
+                        if (ebitmap_get_bit(t, i)) {
+                                if (ebitmap_set_bit(t, i, 0))
+                                        return -1;
+                        } else {
+                                if (ebitmap_set_bit(t, i, 1))
+                                        return -1;
+                        }
+                }
+        }
+
+out:
+
+        ebitmap_destroy(&types);
+        ebitmap_destroy(&neg_types);
+
+	return 0;
+}
+
+static int copy_neverallow (policydb_t *source_pol, policydb_t *dest_pol,
+                            uint32_t *typemap, avrule_t *source_rule)
+{
+	ebitmap_t stypes, ttypes;
+	avrule_t *avrule;
+	class_perm_node_t *cur_perm, *new_perm, *tail_perm;
+
+	ebitmap_init(&stypes);
+	ebitmap_init(&ttypes);
+
+        if (expand_convert_type_set(source_pol, typemap, &source_rule->stypes, &stypes))
+                return -1;
+        if (expand_convert_type_set(source_pol, typemap, &source_rule->ttypes, &ttypes))
+                return -1;
+
+        avrule = (avrule_t*)malloc(sizeof(avrule_t));
+        if (!avrule) 
+		return -1;
+        
+	avrule_init(avrule);
+        avrule->specified = AVRULE_NEVERALLOW;
+        avrule->line = source_rule->line;
+        avrule->flags = source_rule->flags;
+
+	if (ebitmap_cpy(&avrule->stypes.types, &stypes))
+		return -1;
+
+	if (ebitmap_cpy(&avrule->ttypes.types, &ttypes))
+		return -1;
+
+	cur_perm = source_rule->perms;
+	tail_perm = NULL;
+	while (cur_perm) {
+		new_perm = (class_perm_node_t*)malloc(sizeof(class_perm_node_t));
+		if (!new_perm)
+			return -1;
+		class_perm_node_init(new_perm);
+		new_perm->class = cur_perm->class;
+		assert(new_perm->class);
+
+		/* once we have modules with permissions we'll need to map the permissions (and classes) */
+		new_perm->data = cur_perm->data;
+
+		if (!avrule->perms)
+			avrule->perms = new_perm;
+
+		if (tail_perm)
+			tail_perm->next = new_perm;
+		tail_perm = new_perm;
+		cur_perm = cur_perm->next;
+	}
+
+	/* just prepend the avrule, it'll never be written to disk */
+	if (!dest_pol->avrules) 
+		dest_pol->avrules = avrule;
+	else {
+		avrule->next = dest_pol->avrules;
+		dest_pol->avrules = avrule;
+	}
+
+	ebitmap_destroy(&stypes);
+	ebitmap_destroy(&ttypes);
+
+	return 0;
+}
+
+
+int expand_module(policydb_t *base, policydb_t *out,
+                        int verbose, char *error_buf, size_t error_buf_size)
+{
+        int retval = -1;
+	expand_state_t state;
+	avrule_t *cur;
+	char *error_msg = NULL;
+
+	state.verbose = verbose;
+        state.typemap = NULL;
+	state.base = base;
+	state.out = out;
+        state.error_buf = error_buf;
+        state.error_buf_size = error_buf_size;
+        if (error_buf != NULL && error_buf_size > 0) {
+                *error_buf = '\0';
+        }
+        
+	if (policydb_index_classes(state.base)) {
+                write_error (&state, "Error while indexing base classes");
+                goto cleanup;
+        }
+	if (policydb_index_others(state.base, 0)) {
+                write_error (&state, "Error while indexing base symbols");
+                goto cleanup;
+        }
+	if (policydb_init(state.out, POLICY_KERN)) {
+                write_error (&state, "Out of memory!");
+                goto cleanup;
+        }
+		
+	if ((state.typemap = (uint32_t*)calloc(state.base->p_types.nprim, sizeof(uint32_t))) == NULL) {
+                write_error (&state, "Out of memory!");
+                goto cleanup;
+	}
+
+	/* order is important - types must be first */
+
+        /* copy types */
+        if (hashtab_map(state.base->p_types.table, type_copy_callback, &state)) {
+                goto cleanup;
+        }
+                
+        /* copy commons */
+        if (hashtab_map(state.base->p_commons.table, common_copy_callback, &state)) {
+                goto cleanup;
+        }
+
+        /* copy classes */
+        if (hashtab_map(state.base->p_classes.table, class_copy_callback, &state)) {
+                goto cleanup;
+        }
+		
+	if (policydb_index_classes(out)) {
+                write_error (&state, "Error while indexing out classes");
+                goto cleanup;
+        }
+        /* copy aliases */
+        if (hashtab_map(state.base->p_types.table, alias_copy_callback, &state))
+                goto cleanup;
+
+        /* copy roles */
+        if (hashtab_map(state.base->p_roles.table, role_copy_callback, &state))
+                goto cleanup;
+
+        /* copy users */
+        if (hashtab_map(state.base->p_users.table, user_copy_callback, &state))
+                goto cleanup;
+
+        /* copy bools */
+        if (hashtab_map(state.base->p_bools.table, bool_copy_callback, &state))
+                goto cleanup;
+
+        /* now copy MLS's sensitivity level and categories */
+        if (hashtab_map(state.base->p_levels.table, sens_copy_callback, &state) ||
+            hashtab_map(state.base->p_cats.table, cats_copy_callback, &state)) {
+                goto cleanup;
+        }
+
+	if (policydb_index_classes(out)) {
+                write_error (&state, "Error while indexing out classes");
+                goto cleanup;
+        }
+        if (policydb_index_others(out, 0)) {
+                write_error (&state, "Error while indexing symbols");
+                goto cleanup;
+        }
+
+	/* role allows */
+	if (copy_role_allows(&state))
+                goto cleanup;
+
+	/* role trans */
+	if (copy_role_trans(&state))
+		goto cleanup;
+
+	/* copy rules */
+	cur = state.base->avrules;
+	while (cur) {
+		if (cur->specified & AVRULE_NEVERALLOW) {
+			/* We'll just copy this over directly so we can check the assertions later */
+			if (copy_neverallow(state.base, out, state.typemap, cur))
+				write_error (&state, "Error while copying neverallows.");
+		} else {																								
+			if (convert_and_expand_rule(state.base, out, 
+       	                                     state.typemap, cur, &out->te_avtab,
+       	                                     NULL, NULL,
+       	                                     0, &error_msg) != 1) {
+				if (error_msg == NULL) {
+       	                         write_error (&state, "Error while expanding rule.");
+       	                 }
+       	                 else {
+       	                         write_error (&state, "%s", error_msg);
+					free(error_msg);	
+				}
+				goto cleanup;
+			}
+		}
+		cur = cur->next;
+	}
+	
+	/* copy conditional rules */
+        if (cond_node_copy(state.base->cond_list, &state))
+                goto cleanup;
+
+	cond_optimize_lists(state.out->cond_list);
+	evaluate_conds(state.out);
+	
+	/* copy ocontexts */
+	if (ocontext_copy(&state))
+		goto cleanup;
+	
+	/* copy genfs */
+	if (genfs_copy(&state))
+		goto cleanup;
+
+        if (range_trans_clone(&state) == -1) {
+                goto cleanup;
+        }
+
+	hashtab_map_remove_on_error(state.out->p_types.table, 
+			    type_attr_remove, 0, 0);
+	
+        retval = 0;
+
+ cleanup:
+        
+        free (state.typemap);
+        return retval;
+}

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
