Subject: [PATCH 4/10] misc fixes
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 23 Jun 2006 10:52:15 -0400
Message-Id: <1151074335.4011.74.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This fixes several bugs: 
type_copy_callback only copies types and attribues so they are always
primary

role allows and role trans copy should append rules to the end of the
list

per a list conversation duplicate type_trans in different scopes (eg.,
different conditionals) are now a fatal error, conflicting and duplicate
type_trans now return 0 which is the documented error code. The released
refpolicy and fc5 policy will not build due to a duplicate type_trans
rule

the attr_remove_callback now nulls the indexes to avoid the expand_avtab
trying to expand bogus entries if the index memory isn't cleared

the hierarchy checker wasn't displaying the correct type in some error
messages

the read and write code for users in modules was not consistent so the
writer wrote user mls data for modules reader wouldn't read them. This
fixes the inconsistency by reading the users correctly. Note that this
means modules built with this patch with required users will not be
readable by the current toolchain. The old toolchain would also fail if
non-mls modules had users declared or required in them due to this bug.

semodule_link was not respecting the verbose flag


diff -pruN -x .svn selinux.old/libsepol/src/expand.c optionals-in-base-take2/libsepol/src/expand.c
--- selinux.old/libsepol/src/expand.c	2006-06-22 11:18:31.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/expand.c	2006-06-22 11:28:53.000000000 -0400
@@ -88,9 +88,7 @@ static int type_copy_callback(hashtab_ke
                 ERR (state->handle, "type space overflow");
                 return -1;
 	}
-        if (!type->isattr) {
-                new_type->primary = 1;
-        }
+	new_type->primary = 1;
         state->typemap[type->value - 1] = new_type->value;
 
         ret = hashtab_insert(state->out->p_types.table,
@@ -700,7 +698,9 @@ static int copy_role_allows(expand_state
 	ebitmap_t roles, new_roles;
 	ebitmap_node_t *snode, *tnode;
 	
-	l = NULL;
+	/* start at the end of the list */
+	for (l = state->out->role_allow; l && l->next; l = l->next);
+
 	cur = rules;
 	while (cur) {
 		ebitmap_init(&roles);
@@ -764,7 +764,9 @@ static int copy_role_trans(expand_state_
 	ebitmap_t roles, types;
 	ebitmap_node_t *rnode, *tnode;
 	
-	l = NULL;
+	/* start at the end of the list */
+	for (l = state->out->role_tr; l && l->next; l = l->next);
+
 	cur = rules;
 	while (cur) {
 		ebitmap_init(&roles);
@@ -933,17 +935,26 @@ static int expand_terule_helper(sepol_ha
                         } else if (specified & AVRULE_CHANGE) {
                                 oldtype = avdatump->data;
                         }
-                        /* ignore duplicates */
                         
-                        if (oldtype == remapped_data)
-                                return 1;
+                        if (oldtype == remapped_data) {
+                        	/* if the duplicate is inside the same scope (eg., unconditional 
+				 * or in same conditional then ignore it */
+				if ((conflict == 1 && cond == NULL) || node->parse_context == cond)
+					return 1;
+				ERR(handle, "duplicate TE rule for %s %s:%s %s",
+						p->p_type_val_to_name[avkey.source_type - 1],
+						p->p_type_val_to_name[avkey.target_type - 1],
+						p->p_class_val_to_name[avkey.target_class - 1],
+						p->p_type_val_to_name[oldtype - 1]);
+				return 0;
+			}
 			ERR(handle, "conflicting TE rule for (%s, %s:%s):  old was %s, new is %s",
 			    p->p_type_val_to_name[avkey.source_type - 1],
 			    p->p_type_val_to_name[avkey.target_type - 1],
 			    p->p_class_val_to_name[avkey.target_class - 1],
 			    p->p_type_val_to_name[oldtype - 1],
 			    p->p_type_val_to_name[remapped_data - 1]);
-			return -1;
+			return 0;
                 }
 
                 node = find_avtab_node(handle, avtab, &avkey, cond);
@@ -1408,13 +1419,18 @@ static void type_destroy(hashtab_key_t k
 	free(datum);
 }
 
-static int type_attr_remove(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *p __attribute__ ((unused)))
+static int type_attr_remove(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *args )
 {
 	type_datum_t *typdatum;
+	policydb_t *p;
 
 	typdatum = (type_datum_t *) datum;
-	if (typdatum->isattr)
+	p = (policydb_t *)args;
+	if (!typdatum->primary) {
+		p->type_val_to_struct[typdatum->value - 1] = NULL;
+		p->p_type_val_to_name[typdatum->value - 1] = NULL;
 		return 1;
+	}
 	return 0;
 }
 
@@ -1805,7 +1821,7 @@ int expand_module(sepol_handle_t *handle
                 ERR (handle, "Error while indexing out classes");
                 goto cleanup;
         }
-        if (policydb_index_others(handle, out, 0)) {
+        if (policydb_index_others(handle, out, verbose)) {
                 ERR (handle, "Error while indexing out symbols");
                 goto cleanup;
         }
@@ -1892,8 +1908,7 @@ int expand_module(sepol_handle_t *handle
 			&state))
 		goto cleanup;
 	hashtab_map_remove_on_error(state.out->p_types.table, 
-				    type_attr_remove, type_destroy, 0);
-
+				    type_attr_remove, type_destroy, state.out);
 	if (check) {
 		if (hierarchy_check_constraints(handle, state.out))
 			goto cleanup;
diff -pruN -x .svn selinux.old/libsepol/src/hierarchy.c optionals-in-base-take2/libsepol/src/hierarchy.c
--- selinux.old/libsepol/src/hierarchy.c	2006-06-22 11:26:10.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/hierarchy.c	2006-06-22 11:21:01.000000000 -0400
@@ -74,22 +74,24 @@ static int find_parent(char *type, char 
 /* This function verifies that the type passed in either has a parent or is in the 
  * root of the namespace, 0 on success, 1 on orphan and -1 on error
  */
-static int check_type_hierarchy_callback(hashtab_key_t k __attribute__ ((unused)), hashtab_datum_t d, void *args)
+static int check_type_hierarchy_callback(hashtab_key_t k, hashtab_datum_t d, void *args)
 {
 	char *parent;
 	hierarchy_args_t *a;
 	type_datum_t *t, *t2;
+	char *key;
 	int rc;
 
 	a = (hierarchy_args_t *)args;
 	t = (type_datum_t *)d;
+	key = (char *)k;
 
 	if (t->isattr) {
 		/* It's an attribute, we don't care */
 		return 0;
 	}
         
-	if (find_parent(a->p->p_type_val_to_name[t->value - 1], &parent))
+	if (find_parent(key, &parent))
 		return -1;
 
 	if (!parent) {
@@ -144,7 +146,7 @@ static int check_avtab_hierarchy_callbac
 		if (!t) {
 			/* If the parent does not exist this type is an orphan, not legal */
 			ERR(a->handle, "type %s doesn't exist, %s is an orphan",
-				parent,a->p->p_type_val_to_name[k->target_type - 1]);
+				parent,a->p->p_type_val_to_name[k->source_type - 1]);
 			free(parent);
 			return 1;
 		}
diff -pruN -x .svn selinux.old/libsepol/src/policydb.c optionals-in-base-take2/libsepol/src/policydb.c
--- selinux.old/libsepol/src/policydb.c	2006-06-22 11:26:10.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/policydb.c	2006-06-22 11:19:23.000000000 -0400
@@ -1112,7 +1112,9 @@ int symtab_insert(policydb_t *pol, uint3
         }
         else if (scope_datum->scope == SCOPE_REQ && scope == SCOPE_DECL) {
                 /* appending to required symbol only allowed for roles/users */
-                if (sym != SYM_ROLES && sym != SYM_USERS) {
+                if (sym == SYM_ROLES || sym == SYM_USERS) {
+			scope_datum->scope = SCOPE_DECL;
+		} else {
                         return -2;
                 }
                 
@@ -2051,7 +2053,10 @@ static int user_read(policydb_t * p, has
 			goto bad;
 	}
 
+	/* users aren't allowed in mls modules but they can be required, the mls fields will be empty,
+	 * user declarations in non-mls modules will also have empty mls fields */
 	if ((p->policy_type == POLICY_KERN && p->policyvers >= POLICYDB_VERSION_MLS) ||
+	    (p->policy_type == POLICY_MOD && p->policyvers >= MOD_POLICYDB_VERSION_MLS) ||
 	    (p->policy_type == POLICY_BASE && p->policyvers >= MOD_POLICYDB_VERSION_MLS)) {
 		if (mls_read_range_helper(&usrdatum->range, fp))
 			goto bad;
diff -pruN -x .svn selinux.old/libsepol/src/write.c optionals-in-base-take2/libsepol/src/write.c
--- selinux.old/libsepol/src/write.c	2006-06-22 11:26:10.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/write.c	2006-06-22 11:19:39.000000000 -0400
@@ -1362,7 +1362,7 @@ static int scope_write(hashtab_key_t key
         size_t key_len = strlen(key);
         unsigned int items = 2 + scope->decl_ids_len, i;
 
-        if (items >= sizeof(buf)) {
+        if (items >= (sizeof(static_buf) / 4)) {
                 /* too many things required, so dynamically create a
                  * buffer.  this would have been easier with C99's
                  * dynamic arrays... */
diff -pruN -x .svn selinux.old/policycoreutils/semodule_link/semodule_link.c optionals-in-base-take2/policycoreutils/semodule_link/semodule_link.c
--- selinux.old/policycoreutils/semodule_link/semodule_link.c	2006-06-22 11:26:10.000000000 -0400
+++ optionals-in-base-take2/policycoreutils/semodule_link/semodule_link.c	2006-06-22 11:19:56.000000000 -0400
@@ -27,7 +27,7 @@ extern int optind;
 
 static void usage(char *program_name)
 {
-        printf("usage: %s [-V] [-o outfile] basemodpkg modpkg1 [modpkg2]...\n", program_name);
+        printf("usage: %s [-Vv] [-o outfile] basemodpkg modpkg1 [modpkg2]...\n", program_name);
         exit(1);
 }
 
@@ -81,7 +81,7 @@ int main(int argc, char **argv)
 
 	progname = argv[0];
 	
-	while ((ch = getopt(argc, argv, "o:V")) != EOF) {
+	while ((ch = getopt(argc, argv, "o:Vv")) != EOF) {
                 switch (ch) {
                 case 'V':
                         show_version = 1;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
