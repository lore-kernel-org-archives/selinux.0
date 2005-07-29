Subject: [RFC][PATCH 2/3] Reduce number of avtab nodes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Karl MacMillan <kmacmillan@tresys.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 29 Jul 2005 13:22:11 -0400
Message-Id: <1122657731.6573.211.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch, relative to the libsepol patch to reduce avtab node size,
modifies libsepol to preserve attributes in TE
allow/dontaudit/auditallow rules when possible rather than expanding
them and to create the type->attribute reverse mapping.  It does _not_
presently include code for writing older policy versions.  Some new
inline ebitmap operations are introduced to speed up assertion checking,
which is nonetheless still quite a bit slower than previously due to the
non-expanded avtab.

---

 include/sepol/ebitmap.h  |   23 ++++++
 include/sepol/expand.h   |    4 -
 include/sepol/policydb.h |    4 -
 src/assertion.c          |   67 +++++++++++++------
 src/constraint.c         |    2 
 src/expand.c             |  159 ++++++++++++++++++++++++++++++++++++-----------
 src/policydb.c           |   22 +++++-
 src/services.c           |   43 ++++++++----
 src/write.c              |   10 ++
 9 files changed, 259 insertions(+), 75 deletions(-)

diff -X /home/sds/dontdiff -rup libsepol-avtab1/include/sepol/ebitmap.h libsepol/include/sepol/ebitmap.h
--- libsepol-avtab1/include/sepol/ebitmap.h	2005-07-13 15:26:17.000000000 -0400
+++ libsepol/include/sepol/ebitmap.h	2005-07-28 14:48:44.000000000 -0400
@@ -39,12 +39,35 @@ typedef struct ebitmap {
 
 #define ebitmap_length(e) ((e)->highbit)
 #define ebitmap_startbit(e) ((e)->node ? (e)->node->startbit : 0)
+#define ebitmap_startnode(e) ((e)->node)
 
 static inline void ebitmap_init(ebitmap_t * e)
 {
 	memset(e, 0, sizeof(*e));
 }
 
+static inline unsigned int ebitmap_nextbit(ebitmap_t *e, 
+					   ebitmap_node_t **n,
+					   unsigned int bit)
+{
+	if ((bit == ((*n)->startbit + MAPSIZE - 1)) &&
+	    (*n)->next) {
+		*n = (*n)->next;
+		return (*n)->startbit;
+	}
+
+	return (bit+1);
+}
+
+static inline int ebitmap_node_get_bit(ebitmap_t *e, 
+				       ebitmap_node_t * n, 
+				       unsigned int bit)
+{
+	if (n->map & (MAPBIT << (bit - n->startbit)))
+		return 1;
+	return 0;
+}
+
 extern int ebitmap_cmp(ebitmap_t * e1, ebitmap_t * e2);
 extern int ebitmap_or(ebitmap_t * dst, ebitmap_t * e1, ebitmap_t * e2);
 extern int ebitmap_union(ebitmap_t *dst, ebitmap_t *e1);
diff -X /home/sds/dontdiff -rup libsepol-avtab1/include/sepol/expand.h libsepol/include/sepol/expand.h
--- libsepol-avtab1/include/sepol/expand.h	2005-07-13 15:26:17.000000000 -0400
+++ libsepol/include/sepol/expand.h	2005-07-28 14:48:44.000000000 -0400
@@ -29,8 +29,8 @@
 
 extern int expand_module(policydb_t *base, policydb_t *out,
                         int verbose, char *error_buf, size_t error_buf_size);
-extern int expand_convert_type_set(policydb_t *p, uint32_t *typemap, type_set_t *set, ebitmap_t *types);
-extern int type_set_expand(type_set_t *set, ebitmap_t *t, policydb_t *p);
+extern int expand_convert_type_set(policydb_t *p, uint32_t *typemap, type_set_t *set, ebitmap_t *types, unsigned char alwaysexpand);
+extern int type_set_expand(type_set_t *set, ebitmap_t *t, policydb_t *p, unsigned char alwaysexpand);
 extern int role_set_expand(role_set_t *x, ebitmap_t *r, policydb_t *p);
 extern int expand_rule(policydb_t *source_pol,
                 avrule_t *source_rule, avtab_t *dest_avtab,
diff -X /home/sds/dontdiff -rup libsepol-avtab1/include/sepol/policydb.h libsepol/include/sepol/policydb.h
--- libsepol-avtab1/include/sepol/policydb.h	2005-07-28 14:44:43.000000000 -0400
+++ libsepol/include/sepol/policydb.h	2005-07-28 14:48:44.000000000 -0400
@@ -431,6 +431,8 @@ typedef struct policydb {
 	/* range transitions */
 	range_trans_t *range_tr;
 
+	ebitmap_t *type_attr_map;
+
 	unsigned policyvers;
 } policydb_t;
 
@@ -485,7 +487,7 @@ extern void type_datum_destroy(type_datu
 extern void user_datum_init(user_datum_t *x);
 extern void user_datum_destroy(user_datum_t *x);
 
-extern int check_assertions(policydb_t *p, avrule_t *avrules, avtab_t *avtab);
+extern int check_assertions(policydb_t *p, avrule_t *avrules);
 extern int symtab_insert(policydb_t *x, uint32_t sym,
                   hashtab_key_t key, hashtab_datum_t datum,
                   uint32_t scope, uint32_t avrule_decl_id,
diff -X /home/sds/dontdiff -rup libsepol-avtab1/src/assertion.c libsepol/src/assertion.c
--- libsepol-avtab1/src/assertion.c	2005-07-28 14:44:43.000000000 -0400
+++ libsepol/src/assertion.c	2005-07-28 14:48:44.000000000 -0400
@@ -83,35 +83,62 @@ static char *av_to_string(policydb_t *po
 /* These should probably return the error to the caller but it may get very long
    when there are lots of assertion violations, may try to fix this later */
 static int check_assertion_helper(policydb_t *p, unsigned int stype, unsigned int ttype,
-        class_perm_node_t *perm, avtab_t *avtab, unsigned long line)
+        class_perm_node_t *perm, unsigned long line)
 {
         avtab_key_t avkey;
-        avtab_datum_t *avdatump;
         class_perm_node_t *curperm;
-
-        curperm = perm;
+	avtab_ptr_t node;
+	ebitmap_t *sattr, *tattr;
+	ebitmap_node_t *snode, *tnode;
+	unsigned int i, j;
 
 	for (curperm = perm; curperm != NULL; curperm = curperm->next) { 
-                avkey.source_type = stype + 1;
-                avkey.target_type = ttype + 1;
                 avkey.target_class = curperm->class;
 		avkey.specified = AVTAB_ALLOWED;
-                avdatump = avtab_search(avtab, &avkey);
-                if (!avdatump)
-			continue;
-                if (avdatump->data & curperm->data) {
-                        fprintf(stderr, "assertion on line %lu violated by allow %s %s:%s {%s };\n",
-                                line, p->p_type_val_to_name[stype], p->p_type_val_to_name[ttype],
-                                p->p_class_val_to_name[curperm->class - 1],
-				av_to_string(p, curperm->class+1, avdatump->data & curperm->data));
-                        return -1;
-                }
+		sattr = &p->type_attr_map[stype];
+		tattr = &p->type_attr_map[ttype];
+		for (i = ebitmap_startbit(sattr), 
+			     snode = ebitmap_startnode(sattr);
+		     i < ebitmap_length(sattr); 
+		     i = ebitmap_nextbit(sattr, &snode, i)) {
+			if (!ebitmap_node_get_bit(sattr, snode, i))
+				continue;
+			for (j = ebitmap_startbit(tattr), 
+				     tnode = ebitmap_startnode(tattr); 
+			     j < ebitmap_length(tattr); 
+			     j = ebitmap_nextbit(tattr, &tnode, j)) {
+				if (!ebitmap_node_get_bit(tattr, tnode, j))
+					continue;
+				avkey.source_type = i + 1;
+				avkey.target_type = j + 1;
+				for (node = avtab_search_node(&p->te_avtab, &avkey);
+				     node != NULL;
+				     node = avtab_search_node_next(node, avkey.specified)) {
+					if (node->datum.data & curperm->data)
+						goto err;
+				}
+
+				for (node = avtab_search_node(&p->te_cond_avtab, &avkey);
+				     node != NULL;
+				     node = avtab_search_node_next(node, avkey.specified)) {
+					if (node->datum.data & curperm->data)
+						goto err;
+				}
+			}
+		}
+	}
 
-        }
         return 0;
+
+err:
+	fprintf(stderr, "assertion on line %lu violated by allow %s %s:%s {%s };\n",
+		line, p->p_type_val_to_name[stype], p->p_type_val_to_name[ttype],
+		p->p_class_val_to_name[curperm->class - 1],
+		av_to_string(p, curperm->class, node->datum.data & curperm->data));
+	return -1;
 }
 
-int check_assertions(policydb_t *p, avrule_t *avrules, avtab_t *avtab)
+int check_assertions(policydb_t *p, avrule_t *avrules)
 {
         avrule_t *a;
         unsigned int i, j;
@@ -128,13 +155,13 @@ int check_assertions(policydb_t *p, avru
                         if (!ebitmap_get_bit(&a->stypes.types, i))
                                 continue;
                         if (a->flags & RULE_SELF) {
-                                if (check_assertion_helper(p, i, i, a->perms, avtab, a->line))
+                                if (check_assertion_helper(p, i, i, a->perms, a->line))
                                         errors++;
                         }
                         for (j = ebitmap_startbit(&a->ttypes.types); j < ebitmap_length(&a->ttypes.types); j++) {
                                 if (!ebitmap_get_bit(&a->ttypes.types, j))
                                         continue;
-                                if (check_assertion_helper(p, i, j, a->perms, avtab, a->line))
+                                if (check_assertion_helper(p, i, j, a->perms, a->line))
                                     errors++;
                         }
                 }
diff -X /home/sds/dontdiff -rup libsepol-avtab1/src/constraint.c libsepol/src/constraint.c
--- libsepol-avtab1/src/constraint.c	2005-07-26 11:45:32.000000000 -0400
+++ libsepol/src/constraint.c	2005-07-28 14:48:44.000000000 -0400
@@ -54,7 +54,7 @@ int expand_constraint(constraint_expr_t 
                       uint32_t *typemap, policydb_t *pol) {
          ebitmap_t e;
          int i, j;
-         if (type_set_expand(expr->type_names, &e, pol)) {
+         if (type_set_expand(expr->type_names, &e, pol, 1)) {
                  ebitmap_destroy(&e);
                  return -1;
          }
diff -X /home/sds/dontdiff -rup libsepol-avtab1/src/expand.c libsepol/src/expand.c
--- libsepol-avtab1/src/expand.c	2005-07-28 14:44:43.000000000 -0400
+++ libsepol/src/expand.c	2005-07-28 14:48:47.000000000 -0400
@@ -92,16 +92,10 @@ static int type_copy_callback(hashtab_ke
         memset(new_type, 0, sizeof(type_datum_t));
 
         new_type->isattr = type->isattr;
+	new_type->value = ++state->out->p_types.nprim;
         if (!type->isattr) {
-                new_type->value = ++state->out->p_types.nprim;
                 new_type->primary = 1;
         }
-        else {
-                /* lookups of attributes should never occur, so
-                 * explicitly set it to a blatantly illegal value
-                 * here */
-                new_type->value = -1;
-        }
         state->typemap[type->value - 1] = new_type->value;
 
         ret = hashtab_insert(state->out->p_types.table,
@@ -116,6 +110,49 @@ static int type_copy_callback(hashtab_ke
         return 0;
 }
 
+static int attr_convert_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+	int i;
+        char *id;
+        type_datum_t *type, *new_type;
+       	expand_state_t *state;
+
+        id = (char *)key;
+        type = (type_datum_t *)datum;
+        state = (expand_state_t*)data;
+
+        if (!type->isattr)
+                return 0;
+
+        if (!is_id_enabled(id, state->base, SYM_TYPES)) {
+                /* identifier's scope is not enabled */
+                return 0;
+        }
+
+        if (state->verbose)
+                printf("converting attribute %s\n", id);
+
+	new_type = hashtab_search(state->out->p_types.table, id);
+	if (!new_type) {
+		write_error (state, "attribute %s vanished!", id);
+                return -1;
+	}
+	ebitmap_init(&new_type->types);
+
+	for (i = ebitmap_startbit(&type->types); 
+	     i < ebitmap_length(&type->types); i++) {
+		if (ebitmap_get_bit(&type->types, i)) {
+			if (ebitmap_set_bit(&new_type->types,
+					    state->typemap[i]-1, 1)) {
+				write_error (state, "out of memory", id);
+				return -1;
+			}
+		}
+	}
+
+        return 0;
+}
+
 static int perm_copy_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
 {
         int ret;
@@ -249,7 +286,7 @@ static int constraint_node_clone(constra
                                 if (expand_convert_type_set(state->base,
                                                             state->typemap,
                                                             expr->type_names,
-                                                            &new_expr->names)) {
+                                                            &new_expr->names, 1)) {
                                         goto out_of_mem;
         			}
         		}
@@ -462,7 +499,7 @@ static int role_copy_callback(hashtab_ke
                 return -1;
         }
 
-        if (expand_convert_type_set(state->base, state->typemap, &role->types, &new_role->types.types)) {
+        if (expand_convert_type_set(state->base, state->typemap, &role->types, &new_role->types.types, 1)) {
                 write_error (state, "Out of memory!");
                 return -1;
         }
@@ -749,7 +786,7 @@ static int copy_role_trans(expand_state_
                         write_error (state, "Out of memory!");
 			return -1;
                 }
-		if (expand_convert_type_set(state->base, state->typemap, &cur->types, &types)) {
+		if (expand_convert_type_set(state->base, state->typemap, &cur->types, &types, 1)) {
                         write_error (state, "Out of memory!");
 			return -1;
                 }			
@@ -1100,6 +1137,7 @@ static int convert_and_expand_rule(polic
                                    int enabled, char **error_msg) {
         int retval;
         ebitmap_t stypes, ttypes;
+	unsigned char alwaysexpand;
 
         if (source_rule->specified & AVRULE_NEVERALLOW)
                 return 1;
@@ -1107,9 +1145,13 @@ static int convert_and_expand_rule(polic
         ebitmap_init(&stypes);
         ebitmap_init(&ttypes);
 
-        if (expand_convert_type_set(source_pol, typemap, &source_rule->stypes, &stypes))
+	/* Force expansion for type rules and for self rules. */
+	alwaysexpand = ((source_rule->specified & AVRULE_TYPE) ||
+			(source_rule->flags & RULE_SELF));
+
+        if (expand_convert_type_set(source_pol, typemap, &source_rule->stypes, &stypes, alwaysexpand))
                 return -1;
-        if (expand_convert_type_set(source_pol, typemap, &source_rule->ttypes, &ttypes))
+        if (expand_convert_type_set(source_pol, typemap, &source_rule->ttypes, &ttypes, alwaysexpand))
                 return -1;
 
         retval = expand_rule_helper(dest_pol, typemap,
@@ -1356,6 +1398,26 @@ static int range_trans_clone(expand_stat
         return -1;
 }
 
+static int type_attr_map(hashtab_key_t key, hashtab_datum_t datum, void *ptr)
+{
+  	type_datum_t *type;
+	expand_state_t *state = ptr;
+	policydb_t *p = state->out;
+	int i;
+
+	type = (type_datum_t *) datum;
+	if (type->isattr) {
+		for (i = ebitmap_startbit(&type->types); 
+		     i < ebitmap_length(&type->types); i++) 
+			if (ebitmap_get_bit(&type->types, i)) {
+				if (ebitmap_set_bit(&p->type_attr_map[i],
+						    type->value - 1, 1))
+					return -1;
+			}
+	}
+	return 0;
+}
+
 static int type_attr_remove(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *p __attribute__ ((unused)))
 {
 	type_datum_t *typdatum;
@@ -1366,8 +1428,7 @@ static int type_attr_remove(hashtab_key_
 	return 0;
 }
 
-
-int expand_convert_type_set(policydb_t *p, uint32_t *typemap, type_set_t *set, ebitmap_t *types)
+int expand_convert_type_set(policydb_t *p, uint32_t *typemap, type_set_t *set, ebitmap_t *types, unsigned char alwaysexpand)
 {
         int i;
         ebitmap_t tmp;
@@ -1375,7 +1436,7 @@ int expand_convert_type_set(policydb_t *
         ebitmap_init(types);
         ebitmap_init(&tmp);
         
-        if (type_set_expand(set, &tmp, p))
+        if (type_set_expand(set, &tmp, p, alwaysexpand))
                 return -1;
                 
         for (i = ebitmap_startbit(&tmp); i < ebitmap_length(&tmp); i++) {
@@ -1409,9 +1470,9 @@ int expand_rule(policydb_t *source_pol,
         ebitmap_init(&stypes);
         ebitmap_init(&ttypes);
 
-        if (type_set_expand(&source_rule->stypes, &stypes, source_pol))
+        if (type_set_expand(&source_rule->stypes, &stypes, source_pol, 1))
                 return -1;
-        if (type_set_expand(&source_rule->ttypes, &ttypes, source_pol))
+        if (type_set_expand(&source_rule->ttypes, &ttypes, source_pol, 1))
                 return -1;
         retval = expand_rule_helper(source_pol, NULL,
                                     source_rule, dest_avtab,
@@ -1459,8 +1520,13 @@ int role_set_expand(role_set_t *x, ebitm
 
 /* Expand a type set into an ebitmap containing the types. This
  * handles the negset, attributes, and flags.
+ * Attribute expansion depends on several factors:
+ * - if alwaysexpand is 1, then they will be expanded,
+ * - if the type set has a negset or flags, then they will be expanded,
+ * - otherwise, they will not be expanded.
  */
-int type_set_expand(type_set_t *set, ebitmap_t *t, policydb_t *p)
+int type_set_expand(type_set_t *set, ebitmap_t *t, policydb_t *p,
+	             unsigned char alwaysexpand)
 {
         int i;
         ebitmap_t types, neg_types;
@@ -1468,20 +1534,26 @@ int type_set_expand(type_set_t *set, ebi
         ebitmap_init(&types);
         ebitmap_init(t);
 
-        /* First go through the types and OR all the attributes to types */
-        for (i = ebitmap_startbit(&set->types); i < ebitmap_length(&set->types); i++) {
-                if (ebitmap_get_bit(&set->types, i)) {
-                        if (p->type_val_to_struct[i]->isattr) {
-                                if (ebitmap_union(&types, &p->type_val_to_struct[i]->types)) {
-                                        return -1;
-                                }
-                        } else {
-                                if (ebitmap_set_bit(&types, i, 1)) {
-                                        return -1;
-                                }
-                        }
-                }
-        }
+	if (alwaysexpand || ebitmap_length(&set->negset) || set->flags) {
+		/* First go through the types and OR all the attributes to types */
+		for (i = ebitmap_startbit(&set->types); i < ebitmap_length(&set->types); i++) {
+			if (ebitmap_get_bit(&set->types, i)) {
+				if (p->type_val_to_struct[i]->isattr) {
+					if (ebitmap_union(&types, &p->type_val_to_struct[i]->types)) {
+						return -1;
+					}
+				} else {
+					if (ebitmap_set_bit(&types, i, 1)) {
+						return -1;
+					}
+				}
+			}
+		}
+	} else {
+		/* No expansion of attributes, just copy the set as is. */
+		if (ebitmap_cpy(&types, &set->types))
+			return -1;
+	}
 
         /* Now do the same thing for negset */
         ebitmap_init(&neg_types);
@@ -1552,9 +1624,9 @@ static int copy_neverallow (policydb_t *
 	ebitmap_init(&stypes);
 	ebitmap_init(&ttypes);
 
-        if (expand_convert_type_set(source_pol, typemap, &source_rule->stypes, &stypes))
+        if (expand_convert_type_set(source_pol, typemap, &source_rule->stypes, &stypes, 1))
                 return -1;
-        if (expand_convert_type_set(source_pol, typemap, &source_rule->ttypes, &ttypes))
+        if (expand_convert_type_set(source_pol, typemap, &source_rule->ttypes, &ttypes, 1))
                 return -1;
 
         avrule = (avrule_t*)malloc(sizeof(avrule_t));
@@ -1613,7 +1685,7 @@ static int copy_neverallow (policydb_t *
 int expand_module(policydb_t *base, policydb_t *out,
                         int verbose, char *error_buf, size_t error_buf_size)
 {
-        int retval = -1;
+        int retval = -1, i;
 	expand_state_t state;
         avrule_block_t *curblock;
 	char *error_msg = NULL;
@@ -1652,6 +1724,11 @@ int expand_module(policydb_t *base, poli
         if (hashtab_map(state.base->p_types.table, type_copy_callback, &state)) {
                 goto cleanup;
         }
+
+	/* convert attribute type sets */
+        if (hashtab_map(state.base->p_types.table, attr_convert_callback, &state)) {
+                goto cleanup;
+        }
                 
         /* copy commons */
         if (hashtab_map(state.base->p_commons.table, common_copy_callback, &state)) {
@@ -1768,6 +1845,18 @@ int expand_module(policydb_t *base, poli
                 goto cleanup;
         }
 
+	/* Build the type->attribute reverse map and remove attributes. */
+	state.out->type_attr_map = malloc(state.out->p_types.nprim*
+					  sizeof(ebitmap_t));
+	for (i = 0; i < state.out->p_types.nprim; i++) {
+		ebitmap_init(&state.out->type_attr_map[i]);
+		/* add the type itself as the degenerate case */
+		if (ebitmap_set_bit(&state.out->type_attr_map[i], i, 1))
+				goto cleanup;
+	}
+	if (hashtab_map(state.out->p_types.table, type_attr_map, 
+			&state))
+		goto cleanup;
 	hashtab_map_remove_on_error(state.out->p_types.table, 
                                     type_attr_remove, 0, 0);
 	
diff -X /home/sds/dontdiff -rup libsepol-avtab1/src/policydb.c libsepol/src/policydb.c
--- libsepol-avtab1/src/policydb.c	2005-07-28 14:44:43.000000000 -0400
+++ libsepol/src/policydb.c	2005-07-28 14:48:44.000000000 -0400
@@ -427,7 +427,7 @@ int policydb_role_cache(hashtab_key_t ke
 	role = (role_datum_t *)datum;
 	p = (policydb_t *)arg;
 
-	if (type_set_expand(&role->types, &role->cache, p)) {
+	if (type_set_expand(&role->types, &role->cache, p, 1)) {
 		return -1;
 	}
 
@@ -936,6 +936,10 @@ void policydb_destroy(policydb_t * p)
 	}
 	if (lrt) free(lrt);
 
+	for (i = 0; i < p->p_types.nprim; i++)
+		ebitmap_destroy(&p->type_attr_map[i]);
+	free(p->type_attr_map);
+
 	return;
 }
 
@@ -2576,10 +2580,24 @@ int policydb_read(policydb_t * p, struct
 
 	if (r_policyvers >= POLICYDB_VERSION_MLS) {
                 if (range_read(p, fp)) {
-                        return -1;
+			goto bad;
                 }
 	}
 
+	p->type_attr_map = malloc(p->p_types.nprim*sizeof(ebitmap_t));
+	if (!p->type_attr_map)
+		goto bad;
+	for (i = 0; i < p->p_types.nprim; i++) {
+		ebitmap_init(&p->type_attr_map[i]);
+		if (r_policyvers >= POLICYDB_VERSION_AVTAB) {
+			if (ebitmap_read(&p->type_attr_map[i], fp))
+				goto bad;
+		}
+		/* add the type itself as the degenerate case */
+		if (ebitmap_set_bit(&p->type_attr_map[i], i, 1))
+				goto bad;
+	}
+
 	return 0;
 bad:
 	policydb_destroy(p);
diff -X /home/sds/dontdiff -rup libsepol-avtab1/src/services.c libsepol/src/services.c
--- libsepol-avtab1/src/services.c	2005-07-28 14:44:43.000000000 -0400
+++ libsepol/src/services.c	2005-07-28 14:48:44.000000000 -0400
@@ -306,6 +306,8 @@ static int context_struct_compute_av(con
 	avtab_key_t avkey;
 	class_datum_t *tclass_datum;
 	avtab_ptr_t node;
+	ebitmap_t *sattr, *tattr;
+	unsigned int i, j;
 
 	if (!tclass || tclass > policydb->p_classes.nprim) {
 		DEBUG(__FUNCTION__, "unrecognized class %d\n", tclass);
@@ -327,23 +329,36 @@ static int context_struct_compute_av(con
 	 * If a specific type enforcement rule was defined for
 	 * this permission check, then use it.
 	 */
-	avkey.source_type = scontext->type;
-	avkey.target_type = tcontext->type;
 	avkey.target_class = tclass;
 	avkey.specified = AVTAB_AV;
-	for (node = avtab_search_node(&policydb->te_avtab, &avkey);
-	     node != NULL;
-	     node = avtab_search_node_next(node, avkey.specified)) {
-		if (node->key.specified == AVTAB_ALLOWED)
-			avd->allowed = node->datum.data;
-		else if (node->key.specified == AVTAB_AUDITALLOW)
-			avd->auditallow = node->datum.data;
-		else if (node->key.specified == AVTAB_AUDITDENY)
-			avd->auditdeny = node->datum.data;
-	}
+	sattr = &policydb->type_attr_map[scontext->type - 1];
+	tattr = &policydb->type_attr_map[tcontext->type - 1];
+	for (i = ebitmap_startbit(sattr); 
+	     i < ebitmap_length(sattr); i++) {
+		if (!ebitmap_get_bit(sattr, i))
+		    continue;
+		for (j = ebitmap_startbit(tattr); 
+		     j < ebitmap_length(tattr); j++) {
+			if (!ebitmap_get_bit(tattr, j))
+				continue;
+			avkey.source_type = i + 1;
+			avkey.target_type = j + 1;
+			for (node = avtab_search_node(&policydb->te_avtab, &avkey);
+			     node != NULL;
+			     node = avtab_search_node_next(node, avkey.specified)) {
+				if (node->key.specified == AVTAB_ALLOWED)
+					avd->allowed |= node->datum.data;
+				else if (node->key.specified == AVTAB_AUDITALLOW)
+					avd->auditallow |= node->datum.data;
+				else if (node->key.specified == AVTAB_AUDITDENY)
+					avd->auditdeny &= node->datum.data;
+			}
+
+			/* Check conditional av table for additional permissions */
+			cond_compute_av(&policydb->te_cond_avtab, &avkey, avd);
 
-	/* Check conditional av table for additional permissions */
-	cond_compute_av(&policydb->te_cond_avtab, &avkey, avd);
+		}
+	}
 
 	if (requested & ~avd->allowed) {
 		*reason |= SEPOL_COMPUTEAV_TE;
diff -X /home/sds/dontdiff -rup libsepol-avtab1/src/write.c libsepol/src/write.c
--- libsepol-avtab1/src/write.c	2005-07-28 14:52:08.000000000 -0400
+++ libsepol/src/write.c	2005-07-29 10:36:33.000000000 -0400
@@ -288,6 +288,10 @@ static int avtab_write(avtab_t * a, stru
 		   track merged ones and compute the final nel. */
 		avtab_reset_merged(a);
 		nel = a->nel;
+		/* XXX:  Need to expand the avtab to write out older policies. */ 
+		DEBUG(__FUNCTION__, "missing compatibility support for policy "
+			"version %d\n", policyvers);
+		return -1;
 	} else {
 		/* New avtab format.  nel is good to go. */
 		nel = cpu_to_le32(a->nel);
@@ -1495,5 +1499,11 @@ int policydb_write(policydb_t * p, struc
                         return -1;
                 }
         }
+
+	if (policyvers >= POLICYDB_VERSION_AVTAB) {
+		for (i = 0; i < p->p_types.nprim; i++)
+			ebitmap_write(&p->type_attr_map[i], fp);
+	}
+
 	return 0;
 }


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
