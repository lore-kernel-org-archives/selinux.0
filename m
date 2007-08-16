Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7GFu09a004117
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 11:56:00 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7GFtwCf011536
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 15:55:58 GMT
Received: from localhost.localdomain (tresys-winxppro [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l7GFtvCn028154
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 11:55:57 -0400
Received: (from mgoldman@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l7GFtvAB028153
	for selinux@tycho.nsa.gov; Thu, 16 Aug 2007 11:55:57 -0400
Message-Id: <20070816155556.975975994@tresys.com>>
References: <20070816155325.881136010@tresys.com>>
Date: Thu, 16 Aug 2007 11:53:28 -0400
From: Mark Goldman <mgoldman@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [POLICYREP] [Patch 3/5] << part 1 >> This patch does all the functional work of removing the module support code.
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Various unnecessary structs were removed.

At the end of this patch, libsepol is able to load policies, but does not
know about modules.

dispol operates as expected when using libsepol at the end of this patch.

---
 libsepol/src/policydb.c | 1512 	240 +	1272 -	0 !
 1 file changed, 240 insertions(+), 1272 deletions(-)

--- foo.orig/libsepol/src/policydb.c
+++ foo/libsepol/src/policydb.c
@@ -44,7 +44,6 @@
 #include <stdlib.h>
 
 #include <sepol/policydb/policydb.h>
-#include <sepol/policydb/expand.h>
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/avrule_block.h>
 #include <sepol/policydb/util.h>
@@ -57,82 +56,40 @@
 /* These need to be updated if SYM_NUM or OCON_NUM changes */
 static struct policydb_compat_info policydb_compat[] = {
 	{
-	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM - 3,
 	 .ocon_num = OCON_FSUSE + 1,
 	 },
 	{
-	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_BOOL,
 	 .sym_num = SYM_NUM - 2,
 	 .ocon_num = OCON_FSUSE + 1,
 	 },
 	{
-	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_IPV6,
 	 .sym_num = SYM_NUM - 2,
 	 .ocon_num = OCON_NODE6 + 1,
 	 },
 	{
-	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_NLCLASS,
 	 .sym_num = SYM_NUM - 2,
 	 .ocon_num = OCON_NODE6 + 1,
 	 },
 	{
-	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_MLS,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
 	 },
 	{
-	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_AVTAB,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
 	 },
 	{
-	 .type = POLICY_KERN,
 	 .version = POLICYDB_VERSION_RANGETRANS,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
 	 },
-	{
-	 .type = POLICY_BASE,
-	 .version = MOD_POLICYDB_VERSION_BASE,
-	 .sym_num = SYM_NUM,
-	 .ocon_num = OCON_NODE6 + 1,
-	 },
-	{
-	 .type = POLICY_BASE,
-	 .version = MOD_POLICYDB_VERSION_MLS,
-	 .sym_num = SYM_NUM,
-	 .ocon_num = OCON_NODE6 + 1,
-	 },
-	{
-	 .type = POLICY_BASE,
-	 .version = MOD_POLICYDB_VERSION_MLS_USERS,
-	 .sym_num = SYM_NUM,
-	 .ocon_num = OCON_NODE6 + 1,
-	 },
-	{
-	 .type = POLICY_MOD,
-	 .version = MOD_POLICYDB_VERSION_BASE,
-	 .sym_num = SYM_NUM,
-	 .ocon_num = 0,
-	 },
-	{
-	 .type = POLICY_MOD,
-	 .version = MOD_POLICYDB_VERSION_MLS,
-	 .sym_num = SYM_NUM,
-	 .ocon_num = 0,
-	 },
-	{
-	 .type = POLICY_MOD,
-	 .version = MOD_POLICYDB_VERSION_MLS_USERS,
-	 .sym_num = SYM_NUM,
-	 .ocon_num = 0},
 };
 
 #if 0
@@ -157,15 +114,13 @@ static unsigned int symtab_sizes[SYM_NUM
 	16,
 };
 
-struct policydb_compat_info *policydb_lookup_compat(unsigned int version,
-						    unsigned int type)
+struct policydb_compat_info *policydb_lookup_compat(unsigned int version)
 {
 	unsigned int i;
 	struct policydb_compat_info *info = NULL;
 
 	for (i = 0; i < sizeof(policydb_compat) / sizeof(*info); i++) {
-		if (policydb_compat[i].version == version &&
-		    policydb_compat[i].type == type) {
+		if (policydb_compat[i].version == version) {
 			info = &policydb_compat[i];
 			break;
 		}
@@ -173,37 +128,11 @@ struct policydb_compat_info *policydb_lo
 	return info;
 }
 
-void type_set_init(type_set_t * x)
-{
-	memset(x, 0, sizeof(type_set_t));
-	ebitmap_init(&x->types);
-	ebitmap_init(&x->negset);
-}
-
-void type_set_destroy(type_set_t * x)
-{
-	if (x != NULL) {
-		ebitmap_destroy(&x->types);
-		ebitmap_destroy(&x->negset);
-	}
-}
-
-void role_set_init(role_set_t * x)
-{
-	memset(x, 0, sizeof(role_set_t));
-	ebitmap_init(&x->roles);
-}
-
-void role_set_destroy(role_set_t * x)
-{
-	ebitmap_destroy(&x->roles);
-}
-
 void role_datum_init(role_datum_t * x)
 {
 	memset(x, 0, sizeof(role_datum_t));
 	ebitmap_init(&x->dominates);
-	type_set_init(&x->types);
+	ebitmap_init(&x->types);
 	ebitmap_init(&x->cache);
 }
 
@@ -211,7 +140,7 @@ void role_datum_destroy(role_datum_t * x
 {
 	if (x != NULL) {
 		ebitmap_destroy(&x->dominates);
-		type_set_destroy(&x->types);
+		ebitmap_destroy(&x->types);
 		ebitmap_destroy(&x->cache);
 	}
 }
@@ -232,7 +161,7 @@ void type_datum_destroy(type_datum_t * x
 void user_datum_init(user_datum_t * x)
 {
 	memset(x, 0, sizeof(user_datum_t));
-	role_set_init(&x->roles);
+	ebitmap_init(&x->roles);
 	mls_semantic_range_init(&x->range);
 	mls_semantic_level_init(&x->dfltlevel);
 	ebitmap_init(&x->cache);
@@ -243,7 +172,7 @@ void user_datum_init(user_datum_t * x)
 void user_datum_destroy(user_datum_t * x)
 {
 	if (x != NULL) {
-		role_set_destroy(&x->roles);
+		ebitmap_destroy(&x->roles);
 		mls_semantic_range_destroy(&x->range);
 		mls_semantic_level_destroy(&x->dfltlevel);
 		ebitmap_destroy(&x->cache);
@@ -275,131 +204,8 @@ void cat_datum_destroy(cat_datum_t * x _
 	return;
 }
 
-void class_perm_node_init(class_perm_node_t * x)
-{
-	memset(x, 0, sizeof(class_perm_node_t));
-}
-
-void avrule_init(avrule_t * x)
-{
-	memset(x, 0, sizeof(avrule_t));
-	type_set_init(&x->stypes);
-	type_set_init(&x->ttypes);
-}
-
-void avrule_destroy(avrule_t * x)
-{
-	class_perm_node_t *cur, *next;
-
-	if (x == NULL) {
-		return;
-	}
-	type_set_destroy(&x->stypes);
-	type_set_destroy(&x->ttypes);
-
-	next = x->perms;
-	while (next) {
-		cur = next;
-		next = cur->next;
-		free(cur);
-	}
-}
-
-void role_trans_rule_init(role_trans_rule_t * x)
-{
-	memset(x, 0, sizeof(*x));
-	role_set_init(&x->roles);
-	type_set_init(&x->types);
-}
-
-void role_trans_rule_destroy(role_trans_rule_t * x)
-{
-	if (x != NULL) {
-		role_set_destroy(&x->roles);
-		type_set_destroy(&x->types);
-	}
-}
-
-void role_trans_rule_list_destroy(role_trans_rule_t * x)
-{
-	while (x != NULL) {
-		role_trans_rule_t *next = x->next;
-		role_trans_rule_destroy(x);
-		free(x);
-		x = next;
-	}
-}
-
-void role_allow_rule_init(role_allow_rule_t * x)
-{
-	memset(x, 0, sizeof(role_allow_rule_t));
-	role_set_init(&x->roles);
-	role_set_init(&x->new_roles);
-}
-
-void role_allow_rule_destroy(role_allow_rule_t * x)
-{
-	role_set_destroy(&x->roles);
-	role_set_destroy(&x->new_roles);
-}
-
-void role_allow_rule_list_destroy(role_allow_rule_t * x)
-{
-	while (x != NULL) {
-		role_allow_rule_t *next = x->next;
-		role_allow_rule_destroy(x);
-		free(x);
-		x = next;
-	}
-}
-
-void range_trans_rule_init(range_trans_rule_t * x)
-{
-	type_set_init(&x->stypes);
-	type_set_init(&x->ttypes);
-	ebitmap_init(&x->tclasses);
-	mls_semantic_range_init(&x->trange);
-	x->next = NULL;
-}
-
-void range_trans_rule_destroy(range_trans_rule_t * x)
-{
-	type_set_destroy(&x->stypes);
-	type_set_destroy(&x->ttypes);
-	ebitmap_destroy(&x->tclasses);
-	mls_semantic_range_destroy(&x->trange);
-}
-
-void range_trans_rule_list_destroy(range_trans_rule_t * x)
-{
-	while (x != NULL) {
-		range_trans_rule_t *next = x->next;
-		range_trans_rule_destroy(x);
-		free(x);
-		x = next;
-	}
-}
-
-void avrule_list_destroy(avrule_t * x)
-{
-	avrule_t *next, *cur;
-
-	if (!x)
-		return;
-
-	next = x;
-	while (next) {
-		cur = next;
-		next = next->next;
-		avrule_destroy(cur);
-		free(cur);
-	}
-}
-
 /* 
- * Initialize the role table by implicitly adding role 'object_r'.  If
- * the policy is a module, set object_r's scope to be SCOPE_REQ,
- * otherwise set it to SCOPE_DECL.
+ * Initialize the role table by implicitly adding role 'object_r'.
  */
 static int roles_init(policydb_t * p)
 {
@@ -418,10 +224,7 @@ static int roles_init(policydb_t * p)
 		goto out_free_role;
 	}
 	strcpy(key, OBJECT_R);
-	rc = symtab_insert(p, SYM_ROLES, key, role,
-			   (p->policy_type ==
-			    POLICY_MOD ? SCOPE_REQ : SCOPE_DECL), 1,
-			   &role->s.value);
+	rc = symtab_insert(p, SYM_ROLES, key, role, 1, &role->s.value);
 	if (rc)
 		goto out_free_key;
 	if (role->s.value != OBJECT_R_VAL) {
@@ -454,18 +257,6 @@ int policydb_init(policydb_t * p)
 			goto out_free_symtab;
 	}
 
-	/* initialize the module stuff */
-	for (i = 0; i < SYM_NUM; i++) {
-		if (symtab_init(&p->scope[i], symtab_sizes[i])) {
-			goto out_free_symtab;
-		}
-	}
-	if ((p->global = avrule_block_create()) == NULL ||
-	    (p->global->branch_list = avrule_decl_create(1)) == NULL) {
-		goto out_free_symtab;
-	}
-	p->decl_val_to_struct = NULL;
-
 	rc = avtab_init(&p->te_avtab);
 	if (rc)
 		goto out_free_symtab;
@@ -486,15 +277,19 @@ int policydb_init(policydb_t * p)
       out_free_symtab:
 	for (i = 0; i < SYM_NUM; i++) {
 		hashtab_destroy(p->symtab[i].table);
-		hashtab_destroy(p->scope[i].table);
 	}
-	avrule_block_list_destroy(p->global);
 	goto out;
 }
 
+/* NOTE: Cacheing may or may not make sense when the new policyrep gets
+ * here.  These functions may just go away.  Currently this function only
+ * gets called from inside libsepol.
+ *  - mgoldman@tresys.com 2007-06-21
+ */
 int policydb_role_cache(hashtab_key_t key
-			__attribute__ ((unused)), hashtab_datum_t datum,
-			void *arg)
+			__attribute__ ((unused)), hashtab_datum_t datum
+			__attribute__ ((unused)), void *arg
+			__attribute__ ((unused)))
 {
 	policydb_t *p;
 	role_datum_t *role;
@@ -503,16 +298,23 @@ int policydb_role_cache(hashtab_key_t ke
 	p = (policydb_t *) arg;
 
 	ebitmap_destroy(&role->cache);
-	if (type_set_expand(&role->types, &role->cache, p, 1)) {
+	ebitmap_init(&role->cache);
+	if (ebitmap_cpy(&role->cache, &role->types)) {
 		return -1;
 	}
 
 	return 0;
 }
 
+/* NOTE: Cacheing may or may not make sense when the new policyrep gets
+ * here.  These functions may just go away.  Currently this function only
+ * gets called from inside libsepol.
+ *  - mgoldman@tresys.com 2007-06-21
+ */
 int policydb_user_cache(hashtab_key_t key
-			__attribute__ ((unused)), hashtab_datum_t datum,
-			void *arg)
+			__attribute__ ((unused)), hashtab_datum_t datum
+			__attribute__ ((unused)), void *arg
+			__attribute__ ((unused)))
 {
 	policydb_t *p;
 	user_datum_t *user;
@@ -521,28 +323,11 @@ int policydb_user_cache(hashtab_key_t ke
 	p = (policydb_t *) arg;
 
 	ebitmap_destroy(&user->cache);
-	if (role_set_expand(&user->roles, &user->cache, p)) {
+	ebitmap_init(&user->cache);
+	if (ebitmap_cpy(&user->cache, &user->roles)) {
 		return -1;
 	}
 
-	/* we do not expand user's MLS info in kernel policies because the
-	 * semantic representation is not present and we do not expand user's
-	 * MLS info in module policies because all of the necessary mls
-	 * information is not present */
-	if (p->policy_type != POLICY_KERN && p->policy_type != POLICY_MOD) {
-		mls_range_destroy(&user->exp_range);
-		if (mls_semantic_range_expand(&user->range,
-					      &user->exp_range, p, NULL)) {
-			return -1;
-		}
-
-		mls_level_destroy(&user->exp_dfltlevel);
-		if (mls_semantic_level_expand(&user->dfltlevel,
-					      &user->exp_dfltlevel, p, NULL)) {
-			return -1;
-		}
-	}
-
 	return 0;
 }
 
@@ -723,37 +508,6 @@ int policydb_index_bools(policydb_t * p)
 	return 0;
 }
 
-int policydb_index_decls(policydb_t * p)
-{
-	avrule_block_t *curblock;
-	avrule_decl_t *decl;
-	int num_decls = 0;
-
-	free(p->decl_val_to_struct);
-
-	for (curblock = p->global; curblock != NULL; curblock = curblock->next) {
-		for (decl = curblock->branch_list; decl != NULL;
-		     decl = decl->next) {
-			num_decls++;
-		}
-	}
-
-	p->decl_val_to_struct =
-	    calloc(num_decls, sizeof(*(p->decl_val_to_struct)));
-	if (!p->decl_val_to_struct) {
-		return -1;
-	}
-
-	for (curblock = p->global; curblock != NULL; curblock = curblock->next) {
-		for (decl = curblock->branch_list; decl != NULL;
-		     decl = decl->next) {
-			p->decl_val_to_struct[decl->decl_id - 1] = decl;
-		}
-	}
-
-	return 0;
-}
-
 /*
  * Define the other val_to_name and val_to_struct arrays
  * in a policy database structure.  
@@ -986,15 +740,6 @@ void policydb_destroy(policydb_t * p)
 		free(p->user_val_to_struct);
 	if (p->type_val_to_struct)
 		free(p->type_val_to_struct);
-	free(p->decl_val_to_struct);
-
-	for (i = 0; i < SYM_NUM; i++) {
-		hashtab_map(p->scope[i].table, scope_destroy, 0);
-		hashtab_destroy(p->scope[i].table);
-	}
-	avrule_block_list_destroy(p->global);
-	free(p->name);
-	free(p->version);
 
 	avtab_destroy(&p->te_avtab);
 
@@ -1085,18 +830,6 @@ void symtabs_destroy(symtab_t * symtab)
 	}
 }
 
-int scope_destroy(hashtab_key_t key, hashtab_datum_t datum, void *p
-		  __attribute__ ((unused)))
-{
-	scope_datum_t *cur = (scope_datum_t *) datum;
-	free(key);
-	if (cur != NULL) {
-		free(cur->decl_ids);
-	}
-	free(cur);
-	return 0;
-}
-
 hashtab_destroy_func_t get_symtab_destroy_func(int sym_num)
 {
 	if (sym_num < 0 || sym_num >= SYM_NUM) {
@@ -1134,16 +867,13 @@ int policydb_load_isids(policydb_t * p, 
 }
 
 /* Declare a symbol for a certain avrule_block context.  Insert it
- * into a symbol table for a policy.  This function will handle
- * inserting the appropriate scope information in addition to
- * inserting the symbol into the hash table.
- *
+ * into a symbol table for a policy.
+ * 
  * arguments:
- *   policydb_t *pol       module policy to modify
+ *   policydb_t *pol       policy to modify
  *   uint32_t sym          the symbole table for insertion (SYM_*)
  *   hashtab_key_t key     the key for the symbol - not cloned
  *   hashtab_datum_t data  the data for the symbol - not cloned
- *   scope                 scope of this symbol, either SCOPE_REQ or SCOPE_DECL
  *   avrule_decl_id        identifier for this symbol's encapsulating declaration
  *   value (out)           assigned value to the symbol (if value is not NULL)
  *
@@ -1152,17 +882,14 @@ int policydb_load_isids(policydb_t * p, 
  *   1                     success, but symbol already existed as a requirement
  *                         (datum was not inserted and needs to be free()d)
  *   -1                    general error
- *   -2                    scope conflicted
  *   -ENOMEM               memory error
  *   error codes from hashtab_insert
  */
 int symtab_insert(policydb_t * pol, uint32_t sym,
 		  hashtab_key_t key, hashtab_datum_t datum,
-		  uint32_t scope, uint32_t avrule_decl_id, uint32_t * value)
+		  uint32_t avrule_decl_id __attribute__((unused)), uint32_t * value)
 {
 	int rc, retval = 0;
-	unsigned int i;
-	scope_datum_t *scope_datum;
 
 	/* check if the symbol is already there.  multiple
 	 * declarations of non-roles/non-users are illegal, but
@@ -1176,174 +903,16 @@ int symtab_insert(policydb_t * pol, uint
 		 * (i.e. aliases) */
 		if (value)
 			*value = ++pol->symtab[sym].nprim;
-	} else if (rc == SEPOL_EEXIST && scope == SCOPE_REQ) {
-		retval = 1;	/* symbol not added -- need to free() later */
-	} else if (rc == SEPOL_EEXIST && scope == SCOPE_DECL) {
-		if (sym == SYM_ROLES || sym == SYM_USERS) {
-			/* allow multiple declarations for these two */
-			retval = 1;
-		} else {
-			/* duplicate declarations not allowed for all else */
-			return -2;
-		}
 	} else {
 		return rc;
 	}
 
-	/* get existing scope information; if there is not one then
-	 * create it */
-	scope_datum =
-	    (scope_datum_t *) hashtab_search(pol->scope[sym].table, key);
-	if (scope_datum == NULL) {
-		hashtab_key_t key2 = strdup((char *)key);
-		if (!key2)
-			return -ENOMEM;
-		if ((scope_datum = malloc(sizeof(*scope_datum))) == NULL) {
-			free(key2);
-			return -ENOMEM;
-		}
-		scope_datum->scope = scope;
-		scope_datum->decl_ids = NULL;
-		scope_datum->decl_ids_len = 0;
-		if ((rc =
-		     hashtab_insert(pol->scope[sym].table, key2,
-				    scope_datum)) != 0) {
-			free(key2);
-			free(scope_datum);
-			return rc;
-		}
-	} else if (scope_datum->scope == SCOPE_DECL) {
-		/* disallow multiple declarations for non-roles/users */
-		if (sym != SYM_ROLES && sym != SYM_USERS) {
-			return -2;
-		}
-	} else if (scope_datum->scope == SCOPE_REQ && scope == SCOPE_DECL) {
-		/* appending to required symbol only allowed for roles/users */
-		if (sym == SYM_ROLES || sym == SYM_USERS) {
-			scope_datum->scope = SCOPE_DECL;
-		} else {
-			return -2;
-		}
-
-	} else if (scope_datum->scope != scope) {
-		/* scope does not match */
-		return -2;
-	}
-
-	/* search through the pre-existing list to avoid adding duplicates */
-	for (i = 0; i < scope_datum->decl_ids_len; i++) {
-		if (scope_datum->decl_ids[i] == avrule_decl_id) {
-			/* already there, so don't modify its scope */
-			return retval;
-		}
-	}
-
-	if (add_i_to_a(avrule_decl_id,
-		       &scope_datum->decl_ids_len,
-		       &scope_datum->decl_ids) == -1) {
-		return -ENOMEM;
-	}
-
 	return retval;
 }
 
-int type_set_or(type_set_t * dst, type_set_t * a, type_set_t * b)
-{
-	type_set_init(dst);
-
-	if (ebitmap_or(&dst->types, &a->types, &b->types)) {
-		return -1;
-	}
-	if (ebitmap_or(&dst->negset, &a->negset, &b->negset)) {
-		return -1;
-	}
-
-	dst->flags |= a->flags;
-	dst->flags |= b->flags;
-
-	return 0;
-}
-
-int type_set_cpy(type_set_t * dst, type_set_t * src)
-{
-	type_set_init(dst);
-
-	dst->flags = src->flags;
-	if (ebitmap_cpy(&dst->types, &src->types))
-		return -1;
-	if (ebitmap_cpy(&dst->negset, &src->negset))
-		return -1;
-
-	return 0;
-}
-
-int type_set_or_eq(type_set_t * dst, type_set_t * other)
-{
-	int ret;
-	type_set_t tmp;
-
-	if (type_set_or(&tmp, dst, other))
-		return -1;
-	type_set_destroy(dst);
-	ret = type_set_cpy(dst, &tmp);
-	type_set_destroy(&tmp);
-
-	return ret;
-}
-
-int role_set_get_role(role_set_t * x, uint32_t role)
-{
-	if (x->flags & ROLE_STAR)
-		return 1;
-
-	if (ebitmap_get_bit(&x->roles, role - 1)) {
-		if (x->flags & ROLE_COMP)
-			return 0;
-		else
-			return 1;
-	} else {
-		if (x->flags & ROLE_COMP)
-			return 1;
-		else
-			return 0;
-	}
-}
-
 /***********************************************************************/
 /* everything below is for policy reads */
 
-/* The following are read functions for module structures */
-
-static int role_set_read(role_set_t * r, struct policy_file *fp)
-{
-	uint32_t *buf;
-	if (ebitmap_read(&r->roles, fp))
-		return -1;
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
-		return -1;
-	r->flags = le32_to_cpu(buf[0]);
-
-	return 0;
-}
-
-static int type_set_read(type_set_t * t, struct policy_file *fp)
-{
-	uint32_t *buf;
-
-	if (ebitmap_read(&t->types, fp))
-		return -1;
-	if (ebitmap_read(&t->negset, fp))
-		return -1;
-
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
-		return -1;
-	t->flags = le32_to_cpu(buf[0]);
-
-	return 0;
-}
-
 /*
  * Read a MLS range structure from a policydb binary 
  * representation file.
@@ -1397,155 +966,43 @@ static int mls_read_range_helper(mls_ran
 }
 
 /*
- * Read a semantic MLS level structure from a policydb binary 
- * representation file.
+ * Read and validate a security context structure
+ * from a policydb binary representation file.
  */
-static int mls_read_semantic_level_helper(mls_semantic_level_t * l,
-					  struct policy_file *fp)
+static int context_read_and_validate(context_struct_t * c,
+				     policydb_t * p, struct policy_file *fp)
 {
-	uint32_t *buf, ncat;
-	unsigned int i;
-	mls_semantic_cat_t *cat;
-
-	mls_semantic_level_init(l);
+	uint32_t *buf;
 
-	buf = next_entry(fp, sizeof(uint32_t) * 2);
+	buf = next_entry(fp, sizeof(uint32_t) * 3);
 	if (!buf) {
-		ERR(fp->handle, "truncated level");
-		goto bad;
+		ERR(fp->handle, "context truncated");
+		return -1;
 	}
-	l->sens = le32_to_cpu(buf[0]);
-
-	ncat = le32_to_cpu(buf[1]);
-	for (i = 0; i < ncat; i++) {
-		cat = (mls_semantic_cat_t *) malloc(sizeof(mls_semantic_cat_t));
-		if (!cat) {
-			ERR(fp->handle, "out of memory");
-			goto bad;
-		}
-
-		mls_semantic_cat_init(cat);
-		cat->next = l->cat;
-		l->cat = cat;
-
-		buf = next_entry(fp, sizeof(uint32_t) * 2);
-		if (!buf) {
-			ERR(fp->handle, "error reading level categories");
-			goto bad;
+	c->user = le32_to_cpu(buf[0]);
+	c->role = le32_to_cpu(buf[1]);
+	c->type = le32_to_cpu(buf[2]);
+	if ((p->policyvers >= POLICYDB_VERSION_MLS)
+	    ) {
+		if (mls_read_range_helper(&c->range, fp)) {
+			ERR(fp->handle, "error reading MLS range "
+			    "of context");
+			return -1;
 		}
-		cat->low = le32_to_cpu(buf[0]);
-		cat->high = le32_to_cpu(buf[1]);
 	}
 
+	if (!policydb_context_isvalid(p, c)) {
+		ERR(fp->handle, "invalid security context");
+		context_destroy(c);
+		return -1;
+	}
 	return 0;
-
-      bad:
-	return -EINVAL;
 }
 
 /*
- * Read a semantic MLS range structure from a policydb binary 
- * representation file.
- */
-static int mls_read_semantic_range_helper(mls_semantic_range_t * r,
-					  struct policy_file *fp)
-{
-	int rc;
-
-	rc = mls_read_semantic_level_helper(&r->level[0], fp);
-	if (rc)
-		return rc;
-
-	rc = mls_read_semantic_level_helper(&r->level[1], fp);
-
-	return rc;
-}
-
-static int mls_level_to_semantic(mls_level_t * l, mls_semantic_level_t * sl)
-{
-	unsigned int i;
-	ebitmap_node_t *cnode;
-	mls_semantic_cat_t *open_cat = NULL;
-
-	mls_semantic_level_init(sl);
-	sl->sens = l->sens;
-	ebitmap_for_each_bit(&l->cat, cnode, i) {
-		if (ebitmap_node_get_bit(cnode, i)) {
-			if (open_cat)
-				continue;
-			open_cat = (mls_semantic_cat_t *)
-			    malloc(sizeof(mls_semantic_cat_t));
-			if (!open_cat)
-				return -1;
-
-			mls_semantic_cat_init(open_cat);
-			open_cat->low = i + 1;
-			open_cat->next = sl->cat;
-			sl->cat = open_cat;
-		} else {
-			if (!open_cat)
-				continue;
-			open_cat->high = i;
-			open_cat = NULL;
-		}
-	}
-	if (open_cat)
-		open_cat->high = i;
-
-	return 0;
-}
-
-static int mls_range_to_semantic(mls_range_t * r, mls_semantic_range_t * sr)
-{
-	if (mls_level_to_semantic(&r->level[0], &sr->level[0]))
-		return -1;
-
-	if (mls_level_to_semantic(&r->level[1], &sr->level[1]))
-		return -1;
-
-	return 0;
-}
-
-/*
- * Read and validate a security context structure
- * from a policydb binary representation file.
- */
-static int context_read_and_validate(context_struct_t * c,
-				     policydb_t * p, struct policy_file *fp)
-{
-	uint32_t *buf;
-
-	buf = next_entry(fp, sizeof(uint32_t) * 3);
-	if (!buf) {
-		ERR(fp->handle, "context truncated");
-		return -1;
-	}
-	c->user = le32_to_cpu(buf[0]);
-	c->role = le32_to_cpu(buf[1]);
-	c->type = le32_to_cpu(buf[2]);
-	if ((p->policy_type == POLICY_KERN
-	     && p->policyvers >= POLICYDB_VERSION_MLS)
-	    || (p->policy_type == POLICY_BASE
-		&& p->policyvers >= MOD_POLICYDB_VERSION_MLS)) {
-		if (mls_read_range_helper(&c->range, fp)) {
-			ERR(fp->handle, "error reading MLS range "
-			    "of context");
-			return -1;
-		}
-	}
-
-	if (!policydb_context_isvalid(p, c)) {
-		ERR(fp->handle, "invalid security context");
-		context_destroy(c);
-		return -1;
-	}
-	return 0;
-}
-
-/*
- * The following *_read functions are used to
- * read the symbol data from a policy database
- * binary representation file.
+ * The following *_read functions are used to
+ * read the symbol data from a policy database
+ * binary representation file.
  */
 
 static int perm_read(policydb_t * p
@@ -1635,7 +1092,8 @@ static int common_read(policydb_t * p, h
 	return -1;
 }
 
-static int read_cons_helper(policydb_t * p, constraint_node_t ** nodep,
+static int read_cons_helper(policydb_t * p __attribute__ ((unused)),
+			    constraint_node_t ** nodep,
 			    unsigned int ncons,
 			    int allowxtarget, struct policy_file *fp)
 {
@@ -1709,9 +1167,6 @@ static int read_cons_helper(policydb_t *
 				depth++;
 				if (ebitmap_read(&e->names, fp))
 					return -1;
-				if (p->policy_type != POLICY_KERN &&
-				    type_set_read(e->type_names, fp))
-					return -1;
 				break;
 			default:
 				return -1;
@@ -1787,10 +1242,8 @@ static int class_read(policydb_t * p, ha
 	if (read_cons_helper(p, &cladatum->constraints, ncons, 0, fp))
 		goto bad;
 
-	if ((p->policy_type == POLICY_KERN
-	     && p->policyvers >= POLICYDB_VERSION_VALIDATETRANS)
-	    || (p->policy_type == POLICY_BASE
-		&& p->policyvers >= MOD_POLICYDB_VERSION_VALIDATETRANS)) {
+	if ((p->policyvers >= POLICYDB_VERSION_VALIDATETRANS)
+	    ) {
 		/* grab the validatetrans rules */
 		buf = next_entry(fp, sizeof(uint32_t));
 		if (!buf)
@@ -1842,13 +1295,8 @@ static int role_read(policydb_t * p
 	if (ebitmap_read(&role->dominates, fp))
 		goto bad;
 
-	if (p->policy_type == POLICY_KERN) {
-		if (ebitmap_read(&role->types.types, fp))
-			goto bad;
-	} else {
-		if (type_set_read(&role->types, fp))
-			goto bad;
-	}
+	if (ebitmap_read(&role->types, fp))
+		goto bad;
 
 	if (strcmp(key, OBJECT_R) == 0) {
 		if (role->s.value != OBJECT_R_VAL) {
@@ -1884,22 +1332,13 @@ static int type_read(policydb_t * p
 	if (!typdatum)
 		return -1;
 
-	if (p->policy_type == POLICY_KERN) {
-		buf = next_entry(fp, sizeof(uint32_t) * 3);
-	} else {
-		buf = next_entry(fp, sizeof(uint32_t) * 4);
-	}
+	buf = next_entry(fp, sizeof(uint32_t) * 3);
 	if (!buf)
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
 	typdatum->s.value = le32_to_cpu(buf[1]);
 	typdatum->primary = le32_to_cpu(buf[2]);
-	if (p->policy_type != POLICY_KERN) {
-		typdatum->flavor = le32_to_cpu(buf[3]);
-		if (ebitmap_read(&typdatum->types, fp))
-			goto bad;
-	}
 
 	buf = next_entry(fp, len);
 	if (!buf)
@@ -2274,46 +1713,15 @@ static int user_read(policydb_t * p, has
 	memcpy(key, buf, len);
 	key[len] = 0;
 
-	if (p->policy_type == POLICY_KERN) {
-		if (ebitmap_read(&usrdatum->roles.roles, fp))
-			goto bad;
-	} else {
-		if (role_set_read(&usrdatum->roles, fp))
-			goto bad;
-	}
+	if (ebitmap_read(&usrdatum->roles, fp))
+		goto bad;
 
-	/* users were not allowed in mls modules before version
-	 * MOD_POLICYDB_VERSION_MLS_USERS, but they could have been
-	 * required - the mls fields will be empty.  user declarations in
-	 * non-mls modules will also have empty mls fields */
-	if ((p->policy_type == POLICY_KERN
-	     && p->policyvers >= POLICYDB_VERSION_MLS)
-	    || (p->policy_type == POLICY_MOD
-		&& p->policyvers >= MOD_POLICYDB_VERSION_MLS
-		&& p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS)
-	    || (p->policy_type == POLICY_BASE
-		&& p->policyvers >= MOD_POLICYDB_VERSION_MLS
-		&& p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS)) {
+	if ((p->policyvers >= POLICYDB_VERSION_MLS)
+	    ) {
 		if (mls_read_range_helper(&usrdatum->exp_range, fp))
 			goto bad;
 		if (mls_read_level(&usrdatum->exp_dfltlevel, fp))
 			goto bad;
-		if (p->policy_type != POLICY_KERN) {
-			if (mls_range_to_semantic(&usrdatum->exp_range,
-						  &usrdatum->range))
-				goto bad;
-			if (mls_level_to_semantic(&usrdatum->exp_dfltlevel,
-						  &usrdatum->dfltlevel))
-				goto bad;
-		}
-	} else if ((p->policy_type == POLICY_MOD
-		    && p->policyvers >= MOD_POLICYDB_VERSION_MLS_USERS)
-		   || (p->policy_type == POLICY_BASE
-		       && p->policyvers >= MOD_POLICYDB_VERSION_MLS_USERS)) {
-		if (mls_read_semantic_range_helper(&usrdatum->range, fp))
-			goto bad;
-		if (mls_read_semantic_level_helper(&usrdatum->dfltlevel, fp))
-			goto bad;
 	}
 
 	if (hashtab_insert(h, key, usrdatum))
@@ -2414,80 +1822,12 @@ static int (*read_f[SYM_NUM]) (policydb_
 common_read, class_read, role_read, type_read, user_read,
 	    cond_read_bool, sens_read, cat_read,};
 
-/************** module reading functions below **************/
-
-static avrule_t *avrule_read(policydb_t * p
-			     __attribute__ ((unused)), struct policy_file *fp)
-{
-	unsigned int i;
-	uint32_t *buf, len;
-	class_perm_node_t *cur, *tail = NULL;
-	avrule_t *avrule;
-
-	avrule = (avrule_t *) malloc(sizeof(avrule_t));
-	if (!avrule)
-		return NULL;
-
-	avrule_init(avrule);
-
-	buf = next_entry(fp, sizeof(uint32_t) * 2);
-	if (!buf)
-		goto bad;
-
-	(avrule)->specified = le32_to_cpu(buf[0]);
-	(avrule)->flags = le32_to_cpu(buf[1]);
-
-	if (type_set_read(&avrule->stypes, fp))
-		goto bad;
-
-	if (type_set_read(&avrule->ttypes, fp))
-		goto bad;
-
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
-		goto bad;
-	len = le32_to_cpu(buf[0]);
-
-	for (i = 0; i < len; i++) {
-		cur = (class_perm_node_t *) malloc(sizeof(class_perm_node_t));
-		if (!cur)
-			goto bad;
-		class_perm_node_init(cur);
-
-		buf = next_entry(fp, sizeof(uint32_t) * 2);
-		if (!buf) {
-			free(cur);
-			goto bad;
-		}
-
-		cur->class = le32_to_cpu(buf[0]);
-		cur->data = le32_to_cpu(buf[1]);
-
-		if (!tail) {
-			avrule->perms = cur;
-		} else {
-			tail->next = cur;
-		}
-		tail = cur;
-	}
-
-	return avrule;
-      bad:
-	if (avrule) {
-		avrule_destroy(avrule);
-		free(avrule);
-	}
-	return NULL;
-}
-
 static int range_read(policydb_t * p, struct policy_file *fp)
 {
 	uint32_t *buf, nel;
 	range_trans_t *rt, *lrt;
-	range_trans_rule_t *rtr, *lrtr = NULL;
 	unsigned int i;
-	int new_rangetr = (p->policy_type == POLICY_KERN &&
-			   p->policyvers >= POLICYDB_VERSION_RANGETRANS);
+	int new_rangetr = (p->policyvers >= POLICYDB_VERSION_RANGETRANS);
 
 	buf = next_entry(fp, sizeof(uint32_t));
 	if (!buf)
@@ -2519,417 +1859,9 @@ static int range_read(policydb_t * p, st
 		lrt = rt;
 	}
 
-	/* if this is a kernel policy, we are done - otherwise we need to
-	 * convert these structs to range_trans_rule_ts */
-	if (p->policy_type == POLICY_KERN)
-		return 0;
-
-	/* create range_trans_rules_ts that correspond to the range_trans_ts
-	 * that were just read in from an older policy */
-	for (rt = p->range_tr; rt; rt = rt->next) {
-		rtr = malloc(sizeof(range_trans_rule_t));
-		if (!rtr) {
-			return -1;
-		}
-		range_trans_rule_init(rtr);
-
-		if (lrtr)
-			lrtr->next = rtr;
-		else
-			p->global->enabled->range_tr_rules = rtr;
-
-		if (ebitmap_set_bit(&rtr->stypes.types, rt->source_type - 1, 1))
-			return -1;
-
-		if (ebitmap_set_bit(&rtr->ttypes.types, rt->target_type - 1, 1))
-			return -1;
-
-		if (ebitmap_set_bit(&rtr->tclasses, rt->target_class - 1, 1))
-			return -1;
-
-		if (mls_range_to_semantic(&rt->target_range, &rtr->trange))
-			return -1;
-
-		lrtr = rtr;
-	}
-
-	/* now destroy the range_trans_ts */
-	lrt = NULL;
-	for (rt = p->range_tr; rt; rt = rt->next) {
-		if (lrt) {
-			ebitmap_destroy(&lrt->target_range.level[0].cat);
-			ebitmap_destroy(&lrt->target_range.level[1].cat);
-			free(lrt);
-		}
-		lrt = rt;
-	}
-	if (lrt) {
-		ebitmap_destroy(&lrt->target_range.level[0].cat);
-		ebitmap_destroy(&lrt->target_range.level[1].cat);
-		free(lrt);
-	}
-	p->range_tr = NULL;
-
-	return 0;
-}
-
-int avrule_read_list(policydb_t * p, avrule_t ** avrules,
-		     struct policy_file *fp)
-{
-	unsigned int i;
-	avrule_t *cur, *tail;
-	uint32_t *buf, len;
-
-	*avrules = tail = NULL;
-
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf) {
-		return -1;
-	}
-	len = le32_to_cpu(buf[0]);
-
-	for (i = 0; i < len; i++) {
-		cur = avrule_read(p, fp);
-		if (!cur) {
-			return -1;
-		}
-
-		if (!tail) {
-			*avrules = cur;
-		} else {
-			tail->next = cur;
-		}
-		tail = cur;
-	}
-
-	return 0;
-}
-
-static int role_trans_rule_read(role_trans_rule_t ** r, struct policy_file *fp)
-{
-	uint32_t *buf, nel;
-	unsigned int i;
-	role_trans_rule_t *tr, *ltr;
-
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
-		return -1;
-	nel = le32_to_cpu(buf[0]);
-	ltr = NULL;
-	for (i = 0; i < nel; i++) {
-		tr = malloc(sizeof(role_trans_rule_t));
-		if (!tr) {
-			return -1;
-		}
-		role_trans_rule_init(tr);
-
-		if (ltr) {
-			ltr->next = tr;
-		} else {
-			*r = tr;
-		}
-
-		if (role_set_read(&tr->roles, fp))
-			return -1;
-
-		if (type_set_read(&tr->types, fp))
-			return -1;
-
-		buf = next_entry(fp, sizeof(uint32_t));
-		if (!buf)
-			return -1;
-		tr->new_role = le32_to_cpu(buf[0]);
-		ltr = tr;
-	}
-
 	return 0;
 }
 
-static int role_allow_rule_read(role_allow_rule_t ** r, struct policy_file *fp)
-{
-	unsigned int i;
-	uint32_t *buf, nel;
-	role_allow_rule_t *ra, *lra;
-
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
-		return -1;
-	nel = le32_to_cpu(buf[0]);
-	lra = NULL;
-	for (i = 0; i < nel; i++) {
-		ra = malloc(sizeof(role_allow_rule_t));
-		if (!ra) {
-			return -1;
-		}
-		role_allow_rule_init(ra);
-
-		if (lra) {
-			lra->next = ra;
-		} else {
-			*r = ra;
-		}
-
-		if (role_set_read(&ra->roles, fp))
-			return -1;
-
-		if (role_set_read(&ra->new_roles, fp))
-			return -1;
-
-		lra = ra;
-	}
-	return 0;
-}
-
-static int range_trans_rule_read(range_trans_rule_t ** r,
-				 struct policy_file *fp)
-{
-	uint32_t *buf, nel;
-	unsigned int i;
-	range_trans_rule_t *rt, *lrt = NULL;
-
-	buf = next_entry(fp, sizeof(uint32_t));
-	if (!buf)
-		return -1;
-	nel = le32_to_cpu(buf[0]);
-	for (i = 0; i < nel; i++) {
-		rt = malloc(sizeof(range_trans_rule_t));
-		if (!rt) {
-			return -1;
-		}
-		range_trans_rule_init(rt);
-
-		if (lrt)
-			lrt->next = rt;
-		else
-			*r = rt;
-
-		if (type_set_read(&rt->stypes, fp))
-			return -1;
-
-		if (type_set_read(&rt->ttypes, fp))
-			return -1;
-
-		if (ebitmap_read(&rt->tclasses, fp))
-			return -1;
-
-		if (mls_read_semantic_range_helper(&rt->trange, fp))
-			return -1;
-
-		lrt = rt;
-	}
-
-	return 0;
-}
-
-static int scope_index_read(scope_index_t * scope_index,
-			    unsigned int num_scope_syms, struct policy_file *fp)
-{
-	unsigned int i;
-	uint32_t *buf;
-	for (i = 0; i < num_scope_syms; i++) {
-		if (ebitmap_read(scope_index->scope + i, fp) == -1) {
-			return -1;
-		}
-	}
-	if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
-		return -1;
-	}
-	scope_index->class_perms_len = le32_to_cpu(buf[0]);
-	if (scope_index->class_perms_len == 0) {
-		scope_index->class_perms_map = NULL;
-		return 0;
-	}
-	if ((scope_index->class_perms_map =
-	     calloc(scope_index->class_perms_len,
-		    sizeof(*scope_index->class_perms_map))) == NULL) {
-		return -1;
-	}
-	for (i = 0; i < scope_index->class_perms_len; i++) {
-		if (ebitmap_read(scope_index->class_perms_map + i, fp) == -1) {
-			return -1;
-		}
-	}
-	return 0;
-}
-
-static int avrule_decl_read(policydb_t * p, avrule_decl_t * decl,
-			    unsigned int num_scope_syms, struct policy_file *fp)
-{
-	uint32_t *buf, nprim, nel;
-	unsigned int i, j;
-	if ((buf = next_entry(fp, sizeof(uint32_t) * 2)) == NULL) {
-		return -1;
-	}
-	decl->decl_id = le32_to_cpu(buf[0]);
-	decl->enabled = le32_to_cpu(buf[1]);
-	if (cond_read_list(p, &decl->cond_list, fp) == -1 ||
-	    avrule_read_list(p, &decl->avrules, fp) == -1 ||
-	    role_trans_rule_read(&decl->role_tr_rules, fp) == -1 ||
-	    role_allow_rule_read(&decl->role_allow_rules, fp) == -1) {
-		return -1;
-	}
-	if (p->policyvers >= MOD_POLICYDB_VERSION_RANGETRANS &&
-	    range_trans_rule_read(&decl->range_tr_rules, fp) == -1) {
-		return -1;
-	}
-	if (scope_index_read(&decl->required, num_scope_syms, fp) == -1 ||
-	    scope_index_read(&decl->declared, num_scope_syms, fp) == -1) {
-		return -1;
-	}
-
-	for (i = 0; i < num_scope_syms; i++) {
-		if ((buf = next_entry(fp, sizeof(uint32_t) * 2)) == NULL) {
-			return -1;
-		}
-		nprim = le32_to_cpu(buf[0]);
-		nel = le32_to_cpu(buf[1]);
-		for (j = 0; j < nel; j++) {
-			if (read_f[i] (p, decl->symtab[i].table, fp)) {
-				return -1;
-			}
-		}
-		decl->symtab[i].nprim = nprim;
-	}
-	return 0;
-}
-
-static int avrule_block_read(policydb_t * p,
-			     avrule_block_t ** block,
-			     unsigned int num_scope_syms,
-			     struct policy_file *fp)
-{
-	avrule_block_t *last_block = NULL, *curblock;
-	uint32_t *buf, num_blocks, nel;
-
-	if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
-		return -1;
-	}
-	num_blocks = le32_to_cpu(buf[0]);
-	nel = num_blocks;
-	while (num_blocks > 0) {
-		avrule_decl_t *last_decl = NULL, *curdecl;
-		uint32_t num_decls;
-		if ((curblock = calloc(1, sizeof(*curblock))) == NULL) {
-			return -1;
-		}
-
-		if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
-			free(curblock);
-			return -1;
-		}
-		/* if this is the first block its non-optional, else its optional */
-		if (num_blocks != nel)
-			curblock->flags |= AVRULE_OPTIONAL;
-
-		num_decls = le32_to_cpu(buf[0]);
-		while (num_decls > 0) {
-			if ((curdecl = avrule_decl_create(0)) == NULL) {
-				avrule_block_destroy(curblock);
-				return -1;
-			}
-			if (avrule_decl_read(p, curdecl, num_scope_syms, fp) ==
-			    -1) {
-				avrule_decl_destroy(curdecl);
-				avrule_block_destroy(curblock);
-				return -1;
-			}
-			if (curdecl->enabled) {
-				if (curblock->enabled != NULL) {
-					/* probably a corrupt file */
-					avrule_decl_destroy(curdecl);
-					avrule_block_destroy(curblock);
-					return -1;
-				}
-				curblock->enabled = curdecl;
-			}
-			/* one must be careful to reconstruct the
-			 * decl chain in its correct order */
-			if (curblock->branch_list == NULL) {
-				curblock->branch_list = curdecl;
-			} else {
-				last_decl->next = curdecl;
-			}
-			last_decl = curdecl;
-			num_decls--;
-		}
-
-		if (*block == NULL) {
-			*block = curblock;
-		} else {
-			last_block->next = curblock;
-		}
-		last_block = curblock;
-
-		num_blocks--;
-	}
-
-	return 0;
-}
-
-static int scope_read(policydb_t * p, int symnum, struct policy_file *fp)
-{
-	scope_datum_t *scope = NULL;
-	uint32_t *buf;
-	char *key = NULL;
-	size_t key_len;
-	unsigned int i;
-	hashtab_t h = p->scope[symnum].table;
-
-	if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
-		goto cleanup;
-	}
-	key_len = le32_to_cpu(buf[0]);
-	if ((buf = next_entry(fp, key_len)) == NULL) {
-		goto cleanup;
-	}
-	if ((key = malloc(key_len + 1)) == NULL) {
-		goto cleanup;
-	}
-	memcpy(key, buf, key_len);
-	key[key_len] = '\0';
-
-	/* ensure that there already exists a symbol with this key */
-	if (hashtab_search(p->symtab[symnum].table, key) == NULL) {
-		goto cleanup;
-	}
-
-	if ((scope = calloc(1, sizeof(*scope))) == NULL) {
-		goto cleanup;
-	}
-	if ((buf = next_entry(fp, sizeof(uint32_t) * 2)) == NULL) {
-		goto cleanup;
-	}
-	scope->scope = le32_to_cpu(buf[0]);
-	scope->decl_ids_len = le32_to_cpu(buf[1]);
-	assert(scope->decl_ids_len > 0);
-	if ((scope->decl_ids =
-	     malloc(scope->decl_ids_len * sizeof(uint32_t))) == NULL) {
-		goto cleanup;
-	}
-	if ((buf =
-	     next_entry(fp, sizeof(uint32_t) * scope->decl_ids_len)) == NULL) {
-		goto cleanup;
-	}
-	for (i = 0; i < scope->decl_ids_len; i++) {
-		scope->decl_ids[i] = le32_to_cpu(buf[i]);
-	}
-
-	if (strcmp(key, "object_r") == 0 && h == p->p_roles_scope.table) {
-		/* object_r was already added to this table in roles_init() */
-		scope_destroy(key, scope, NULL);
-	} else {
-		if (hashtab_insert(h, key, scope)) {
-			goto cleanup;
-		}
-	}
-
-	return 0;
-
-      cleanup:
-	scope_destroy(key, scope, NULL);
-	return -1;
-}
-
 /*
  * Read the configuration data from a policy database binary
  * representation file into a policy database structure.
@@ -2942,7 +1874,7 @@ int policydb_read(policydb_t * p, struct
 	size_t len, nprim, nel;
 	char *policydb_str, *target_str = NULL;
 	struct policydb_compat_info *info;
-	unsigned int policy_type, bufindex;
+	unsigned int bufindex;
 	ebitmap_node_t *tnode;
 
 	config = 0;
@@ -2955,15 +1887,11 @@ int policydb_read(policydb_t * p, struct
 		buf[i] = le32_to_cpu(buf[i]);
 
 	if (buf[0] == POLICYDB_MAGIC) {
-		policy_type = POLICY_KERN;
 		target_str = POLICYDB_STRING;
-	} else if (buf[0] == POLICYDB_MOD_MAGIC) {
-		policy_type = POLICY_MOD;
-		target_str = POLICYDB_MOD_STRING;
 	} else {
 		ERR(fp->handle, "policydb magic number %#08x does not "
-		    "match expected magic number %#08x or %#08x",
-		    buf[0], POLICYDB_MAGIC, POLICYDB_MOD_MAGIC);
+		    "match expected magic number %#08x",
+		    buf[0], POLICYDB_MAGIC);
 		return POLICYDB_ERROR;
 	}
 
@@ -2997,11 +1925,8 @@ int policydb_read(policydb_t * p, struct
 	free(policydb_str);
 	policydb_str = NULL;
 
-	/* Read the version, config, and table sizes (and policy type if it's a module). */
-	if (policy_type == POLICY_KERN)
-		nel = 4;
-	else
-		nel = 5;
+	/* Read the version, config, and table sizes. */
+	nel = 4;
 
 	buf = next_entry(fp, sizeof(uint32_t) * nel);
 	if (!buf)
@@ -3011,44 +1936,17 @@ int policydb_read(policydb_t * p, struct
 
 	bufindex = 0;
 
-	if (policy_type == POLICY_MOD) {
-		/* We know it's a module but not whether it's a base
-		   module or regular binary policy module.  buf[0]
-		   tells us which. */
-		policy_type = buf[bufindex];
-		if (policy_type != POLICY_MOD && policy_type != POLICY_BASE) {
-			ERR(fp->handle, "unknown module type: %#08x",
-			    policy_type);
-			return POLICYDB_ERROR;
-		}
-		bufindex++;
-	}
-
 	r_policyvers = buf[bufindex];
-	if (policy_type == POLICY_KERN) {
-		if (r_policyvers < POLICYDB_VERSION_MIN ||
-		    r_policyvers > POLICYDB_VERSION_MAX) {
-			ERR(fp->handle, "policydb version %d does not match "
-			    "my version range %d-%d", buf[bufindex],
-			    POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
-			return POLICYDB_ERROR;
-		}
-	} else if (policy_type == POLICY_BASE || policy_type == POLICY_MOD) {
-		if (r_policyvers < MOD_POLICYDB_VERSION_MIN ||
-		    r_policyvers > MOD_POLICYDB_VERSION_MAX) {
-			ERR(fp->handle, "policydb module version %d does "
-			    "not match my version range %d-%d",
-			    buf[bufindex], MOD_POLICYDB_VERSION_MIN,
-			    MOD_POLICYDB_VERSION_MAX);
-			return POLICYDB_ERROR;
-		}
-	} else {
-		assert(0);
+	if (r_policyvers < POLICYDB_VERSION_MIN ||
+	    r_policyvers > POLICYDB_VERSION_MAX) {
+		ERR(fp->handle, "policydb version %d does not match "
+		    "my version range %d-%d", buf[bufindex],
+		    POLICYDB_VERSION_MIN, POLICYDB_VERSION_MAX);
+		return POLICYDB_ERROR;
 	}
 	bufindex++;
 
 	/* Set the policy type and version from the read values. */
-	p->policy_type = policy_type;
 	p->policyvers = r_policyvers;
 
 	if (buf[bufindex] & POLICYDB_CONFIG_MLS) {
@@ -3059,7 +1957,7 @@ int policydb_read(policydb_t * p, struct
 
 	bufindex++;
 
-	info = policydb_lookup_compat(r_policyvers, policy_type);
+	info = policydb_lookup_compat(r_policyvers);
 	if (!info) {
 		ERR(fp->handle, "unable to find policy compat info "
 		    "for version %d", r_policyvers);
@@ -3075,79 +1973,31 @@ int policydb_read(policydb_t * p, struct
 		goto bad;
 	}
 
-	if (p->policy_type == POLICY_MOD) {
-		/* Get the module name and version */
-		if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
-			goto bad;
-		}
-		len = le32_to_cpu(buf[0]);
-		if ((buf = next_entry(fp, len)) == NULL) {
-			goto bad;
-		}
-		if ((p->name = malloc(len + 1)) == NULL) {
-			goto bad;
-		}
-		memcpy(p->name, buf, len);
-		p->name[len] = '\0';
-		if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
-			goto bad;
-		}
-		len = le32_to_cpu(buf[0]);
-		if ((buf = next_entry(fp, len)) == NULL) {
-			goto bad;
-		}
-		if ((p->version = malloc(len + 1)) == NULL) {
-			goto bad;
-		}
-		memcpy(p->version, buf, len);
-		p->version[len] = '\0';
-	}
-
 	for (i = 0; i < info->sym_num; i++) {
 		buf = next_entry(fp, sizeof(uint32_t) * 2);
-		if (!buf)
+		if (!buf){
 			goto bad;
+		}
 		nprim = le32_to_cpu(buf[0]);
 		nel = le32_to_cpu(buf[1]);
 		for (j = 0; j < nel; j++) {
-			if (read_f[i] (p, p->symtab[i].table, fp))
+			if (read_f[i] (p, p->symtab[i].table, fp)){
+				fprintf(stderr,"i = %d\tj = %d\n", i, j);
 				goto bad;
+			}
 		}
 
 		p->symtab[i].nprim = nprim;
 	}
 
-	if (policy_type == POLICY_KERN) {
-		if (avtab_read(&p->te_avtab, fp, r_policyvers))
-			goto bad;
-		if (r_policyvers >= POLICYDB_VERSION_BOOL)
-			if (cond_read_list(p, &p->cond_list, fp))
-				goto bad;
-		if (role_trans_read(&p->role_tr, fp))
-			goto bad;
-		if (role_allow_read(&p->role_allow, fp))
-			goto bad;
-	} else {
-		/* first read the AV rule blocks, then the scope tables */
-		avrule_block_destroy(p->global);
-		p->global = NULL;
-		if (avrule_block_read(p, &p->global, info->sym_num, fp) == -1) {
+	if (avtab_read(&p->te_avtab, fp, r_policyvers))
+		goto bad;
+	if (r_policyvers >= POLICYDB_VERSION_BOOL)
+		if (cond_read_list(p, &p->cond_list, fp))
 			goto bad;
-		}
-		for (i = 0; i < info->sym_num; i++) {
-			if ((buf = next_entry(fp, sizeof(uint32_t))) == NULL) {
-				goto bad;
-			}
-			nel = le32_to_cpu(buf[0]);
-			for (j = 0; j < nel; j++) {
-				if (scope_read(p, i, fp))
-					goto bad;
-			}
-		}
-
-	}
-
-	if (policydb_index_decls(p))
+	if (role_trans_read(&p->role_tr, fp))
+		goto bad;
+	if (role_allow_read(&p->role_allow, fp))
 		goto bad;
 
 	if (policydb_index_classes(p))
@@ -3164,43 +2014,36 @@ int policydb_read(policydb_t * p, struct
 		goto bad;
 	}
 
-	if ((p->policy_type == POLICY_KERN
-	     && p->policyvers >= POLICYDB_VERSION_MLS)
-	    || (p->policy_type == POLICY_BASE
-		&& p->policyvers >= MOD_POLICYDB_VERSION_MLS
-		&& p->policyvers < MOD_POLICYDB_VERSION_RANGETRANS)) {
+	if ((p->policyvers >= POLICYDB_VERSION_MLS)
+	    ) {
 		if (range_read(p, fp)) {
 			goto bad;
 		}
 	}
 
-	if (policy_type == POLICY_KERN) {
-		p->type_attr_map = malloc(p->p_types.nprim * sizeof(ebitmap_t));
-		p->attr_type_map = malloc(p->p_types.nprim * sizeof(ebitmap_t));
-		if (!p->type_attr_map || !p->attr_type_map)
-			goto bad;
-		for (i = 0; i < p->p_types.nprim; i++) {
-			ebitmap_init(&p->type_attr_map[i]);
-			ebitmap_init(&p->attr_type_map[i]);
-		}
-		for (i = 0; i < p->p_types.nprim; i++) {
-			if (r_policyvers >= POLICYDB_VERSION_AVTAB) {
-				if (ebitmap_read(&p->type_attr_map[i], fp))
+	p->type_attr_map = malloc(p->p_types.nprim * sizeof(ebitmap_t));
+	p->attr_type_map = malloc(p->p_types.nprim * sizeof(ebitmap_t));
+	if (!p->type_attr_map || !p->attr_type_map)
+		goto bad;
+	for (i = 0; i < p->p_types.nprim; i++) {
+		ebitmap_init(&p->type_attr_map[i]);
+		ebitmap_init(&p->attr_type_map[i]);
+	}
+	for (i = 0; i < p->p_types.nprim; i++) {
+		if (r_policyvers >= POLICYDB_VERSION_AVTAB) {
+			if (ebitmap_read(&p->type_attr_map[i], fp))
+				goto bad;
+			ebitmap_for_each_bit(&p->type_attr_map[i], tnode, j) {
+				if (!ebitmap_node_get_bit(tnode, j)
+				    || i == j)
+					continue;
+				if (ebitmap_set_bit(&p->attr_type_map[j], i, 1))
 					goto bad;
-				ebitmap_for_each_bit(&p->type_attr_map[i],
-						     tnode, j) {
-					if (!ebitmap_node_get_bit(tnode, j)
-					    || i == j)
-						continue;
-					if (ebitmap_set_bit
-					    (&p->attr_type_map[j], i, 1))
-						goto bad;
-				}
 			}
-			/* add the type itself as the degenerate case */
-			if (ebitmap_set_bit(&p->type_attr_map[i], i, 1))
-				goto bad;
 		}
+		/* add the type itself as the degenerate case */
+		if (ebitmap_set_bit(&p->type_attr_map[i], i, 1))
+			goto bad;
 	}
 
 	return POLICYDB_SUCCESS;
@@ -3236,3 +2079,128 @@ int policydb_reindex_users(policydb_t * 
 
 	return 0;
 }
+
+struct expand_avtab_data {
+	avtab_t *expa;
+	policydb_t *p;
+
+};
+
+static int expand_avtab_insert(avtab_t * a, avtab_key_t * k, avtab_datum_t * d)
+{
+	avtab_ptr_t node;
+	avtab_datum_t *avd;
+	int rc;
+
+	node = avtab_search_node(a, k);
+	if (!node) {
+		rc = avtab_insert(a, k, d);
+		if (rc)
+			fprintf(stderr, "Out of memory!");
+		return rc;
+	}
+
+	if ((k->specified & AVTAB_ENABLED) !=
+	    (node->key.specified & AVTAB_ENABLED)) {
+		node = avtab_insert_nonunique(a, k, d);
+		if (!node) {
+			fprintf(stderr, "Out of memory!");
+			return -1;
+		}
+		return 0;
+	}
+
+	avd = &node->datum;
+	switch (k->specified & ~AVTAB_ENABLED) {
+	case AVTAB_ALLOWED:
+	case AVTAB_AUDITALLOW:
+		avd->data |= d->data;
+		break;
+	case AVTAB_AUDITDENY:
+		avd->data &= d->data;
+		break;
+	default:
+		fprintf(stderr, "Type conflict!");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int expand_avtab_node(avtab_key_t * k, avtab_datum_t * d, void *args)
+{
+	struct expand_avtab_data *ptr = args;
+	avtab_t *expa = ptr->expa;
+	policydb_t *p = ptr->p;
+	type_datum_t *stype = p->type_val_to_struct[k->source_type - 1];
+	type_datum_t *ttype = p->type_val_to_struct[k->target_type - 1];
+	ebitmap_t *sattr = &p->attr_type_map[k->source_type - 1];
+	ebitmap_t *tattr = &p->attr_type_map[k->target_type - 1];
+	ebitmap_node_t *snode, *tnode;
+	unsigned int i, j;
+	avtab_key_t newkey;
+	int rc;
+
+	newkey.target_class = k->target_class;
+	newkey.specified = k->specified;
+
+	if (stype && ttype) {
+		/* Both are individual types, no expansion required. */
+		return expand_avtab_insert(expa, k, d);
+	}
+
+	if (stype) {
+		/* Source is an individual type, target is an attribute. */
+		newkey.source_type = k->source_type;
+		ebitmap_for_each_bit(tattr, tnode, j) {
+			if (!ebitmap_node_get_bit(tnode, j))
+				continue;
+			newkey.target_type = j + 1;
+			rc = expand_avtab_insert(expa, &newkey, d);
+			if (rc)
+				return -1;
+		}
+		return 0;
+	}
+
+	if (ttype) {
+		/* Target is an individual type, source is an attribute. */
+		newkey.target_type = k->target_type;
+		ebitmap_for_each_bit(sattr, snode, i) {
+			if (!ebitmap_node_get_bit(snode, i))
+				continue;
+			newkey.source_type = i + 1;
+			rc = expand_avtab_insert(expa, &newkey, d);
+			if (rc)
+				return -1;
+		}
+		return 0;
+	}
+
+	/* Both source and target type are attributes. */
+	ebitmap_for_each_bit(sattr, snode, i) {
+		if (!ebitmap_node_get_bit(snode, i))
+			continue;
+		ebitmap_for_each_bit(tattr, tnode, j) {
+			if (!ebitmap_node_get_bit(tnode, j))
+				continue;
+			newkey.source_type = i + 1;
+			newkey.target_type = j + 1;
+			rc = expand_avtab_insert(expa, &newkey, d);
+			if (rc)
+				return -1;
+		}
+	}
+
+	return 0;
+}
+
+int expand_avtab(policydb_t * p, avtab_t * a, avtab_t * expa)
+{
+	struct expand_avtab_data data;
+
+	data.expa = expa;
+	data.p = p; 
+	return avtab_map(a, expand_avtab_node, &data);
+}     
+

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
