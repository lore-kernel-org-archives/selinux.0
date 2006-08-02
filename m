Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k77FDgZF001576
	for <selinux@tycho.nsa.gov>; Mon, 7 Aug 2006 11:13:42 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k77FDXCS012296
	for <selinux@tycho.nsa.gov>; Mon, 7 Aug 2006 15:13:33 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k77FDURq019475
	for <selinux@tycho.nsa.gov>; Mon, 7 Aug 2006 11:13:30 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7/Submit) id k77FDUO0019474
	for selinux@tycho.nsa.gov; Mon, 7 Aug 2006 11:13:30 -0400
Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k72I3NKR004402
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 14:03:23 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k72I3Ca2000921
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 18:03:12 GMT
From: kmacmillan@mentalrootkit.com
To: selinux@tycho.nsa.gov
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: [PATCH 1/2] Introduce symtab_datum_t.
Reply-To: kmacmillan@mentalrootkit.com
Date: Wed, 02 Aug 2006 14:03:06 -0400
Message-Id: <11545417914109-git-send-email-kmacmillan@mentalrootkit.com>
In-Reply-To: <11545417871050-git-send-email-kmacmillan@mentalrootkit.com>
References: <11545417871050-git-send-email-kmacmillan@mentalrootkit.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Karl MacMillan <kmacmillan@mentalrootkit.com>

This patch adds a new structure - symtab_datum_t - and converts all of
the datum types to place this struct as their first member. This unifies
the storage of data common to all symtab datums and allows free casting
between specific datum types (e.g., role_datum_t) and symtab_datum_t.
This patch is large, but almost all of the changes are trivial.

Karl
---
 checkpolicy/checkpolicy.c                  |    8 +-
 checkpolicy/module_compiler.c              |   34 +++++----
 checkpolicy/policy_parse.y                 |  102 ++++++++++++++--------------
 checkpolicy/test/dismod.c                  |   10 +--
 libsepol/include/sepol/policydb/policydb.h |   16 ++--
 libsepol/include/sepol/policydb/symtab.h   |   11 +++
 libsepol/src/booleans.c                    |    2 -
 libsepol/src/conditional.c                 |    8 +-
 libsepol/src/context.c                     |    6 +-
 libsepol/src/expand.c                      |   34 +++++----
 libsepol/src/genusers.c                    |    2 -
 libsepol/src/hierarchy.c                   |   18 ++---
 libsepol/src/link.c                        |   54 +++++++--------
 libsepol/src/mls.c                         |   10 +--
 libsepol/src/policydb.c                    |   54 +++++++--------
 libsepol/src/services.c                    |   12 ++-
 libsepol/src/users.c                       |   12 ++-
 libsepol/src/util.c                        |    2 -
 libsepol/src/write.c                       |   16 ++--
 19 files changed, 211 insertions(+), 200 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index fb88fa3..8d766cf 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -141,7 +141,7 @@ static int find_perm(hashtab_key_t key, 
 
 	perdatum = (perm_datum_t *) datum;
 
-	if (v->val == perdatum->value) {
+	if (v->val == perdatum->s.value) {
 		v->name = key;
 		return 1;
 	}
@@ -636,7 +636,7 @@ #endif
 					printf("\nNo such class\n");
 					break;
 				}
-				tclass = cladatum->value;
+				tclass = cladatum->s.value;
 			}
 
 			if (!cladatum->comdatum && !cladatum->permissions.nprim) {
@@ -750,7 +750,7 @@ #endif
 					printf("\nNo such class\n");
 					break;
 				}
-				tclass = cladatum->value;
+				tclass = cladatum->s.value;
 			}
 
 			if (ch == '3')
@@ -945,7 +945,7 @@ #endif
 					printf("\nNo such class\n");
 					break;
 				}
-				tclass = cladatum->value;
+				tclass = cladatum->s.value;
 			}
 			sepol_genfs_sid(fstype, path, tclass, &ssid);
 			printf("sid %d\n", ssid);
diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index cb0d2c7..ec5fc89 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -183,7 +183,7 @@ role_datum_t *declare_role(void)
 	    declare_symbol(SYM_ROLES, id, (hashtab_datum_t *) role, &value,
 			   &value);
 	if (retval == 0) {
-		role->value = value;
+		role->s.value = value;
 		if ((dest_id = strdup(id)) == NULL) {
 			yyerror("Out of memory!");
 			return NULL;
@@ -214,7 +214,7 @@ role_datum_t *declare_role(void)
 				return NULL;
 			}
 			role_datum_init(dest_role);
-			dest_role->value = value;
+			dest_role->s.value = value;
 			if (hashtab_insert(roles_tab, dest_id, dest_role)) {
 				yyerror("Out of memory!");
 				free(dest_id);
@@ -243,7 +243,7 @@ role_datum_t *declare_role(void)
 		}
 	case 0:{
 			if (ebitmap_set_bit
-			    (&dest_role->dominates, role->value - 1, 1)) {
+			    (&dest_role->dominates, role->s.value - 1, 1)) {
 				yyerror("out of memory");
 				return NULL;
 			}
@@ -290,7 +290,7 @@ type_datum_t *declare_type(unsigned char
 	retval = declare_symbol(SYM_TYPES, id, typdatum, &value, &value);
 	if (retval == 0 || retval == 1) {
 		if (typdatum->primary) {
-			typdatum->value = value;
+			typdatum->s.value = value;
 		}
 	} else {
 		/* error occurred (can't have duplicate type declarations) */
@@ -344,7 +344,7 @@ user_datum_t *declare_user(void)
 			   &value);
 
 	if (retval == 0) {
-		user->value = value;
+		user->s.value = value;
 		if ((dest_id = strdup(id)) == NULL) {
 			yyerror("Out of memory!");
 			return NULL;
@@ -375,7 +375,7 @@ user_datum_t *declare_user(void)
 				return NULL;
 			}
 			user_datum_init(dest_user);
-			dest_user->value = value;
+			dest_user->s.value = value;
 			if (hashtab_insert(users_tab, dest_id, dest_user)) {
 				yyerror("Out of memory!");
 				free(dest_id);
@@ -441,7 +441,7 @@ type_datum_t *get_local_type(char *id, u
 			return NULL;
 		}
 		type_datum_init(dest_typdatum);
-		dest_typdatum->value = value;
+		dest_typdatum->s.value = value;
 		dest_typdatum->flavor = isattr ? TYPE_ATTRIB : TYPE_TYPE;
 		dest_typdatum->primary = 1;
 		if (hashtab_insert(types_tab, id, dest_typdatum)) {
@@ -624,8 +624,8 @@ int require_class(int pass)
 		goto cleanup;
 	}
 	ret =
-	    require_symbol(SYM_CLASSES, class_id, datum, &datum->value,
-			   &datum->value);
+	    require_symbol(SYM_CLASSES, class_id, datum, &datum->s.value,
+			   &datum->s.value);
 	switch (ret) {
 	case -3:{
 			yyerror("Out of memory!");
@@ -705,10 +705,10 @@ int require_class(int pass)
 				free(perm);
 				goto cleanup;
 			}
-			perm->value = datum->permissions.nprim + 1;
+			perm->s.value = datum->permissions.nprim + 1;
 		}
 
-		if (add_perm_to_class(perm->value, datum->value) == -1) {
+		if (add_perm_to_class(perm->s.value, datum->s.value) == -1) {
 			yyerror("Out of memory!");
 			goto cleanup;
 		}
@@ -743,7 +743,7 @@ int require_role(int pass)
 	role_datum_init(role);
 	retval =
 	    require_symbol(SYM_ROLES, id, (hashtab_datum_t *) role,
-			   &role->value, &role->value);
+			   &role->s.value, &role->s.value);
 	if (retval != 0) {
 		free(id);
 		role_datum_destroy(role);
@@ -765,7 +765,7 @@ int require_role(int pass)
 	case 0:{
 			/* all roles dominate themselves */
 			if (ebitmap_set_bit
-			    (&role->dominates, role->value - 1, 1)) {
+			    (&role->dominates, role->s.value - 1, 1)) {
 				yyerror("Out of memory");
 				return -1;
 			}
@@ -803,7 +803,7 @@ static int require_type_or_attribute(int
 	type->flavor = isattr ? TYPE_ATTRIB : TYPE_TYPE;
 	retval =
 	    require_symbol(SYM_TYPES, id, (hashtab_datum_t *) type,
-			   &type->value, &type->value);
+			   &type->s.value, &type->s.value);
 	if (retval != 0) {
 		free(id);
 		free(type);
@@ -864,7 +864,7 @@ int require_user(int pass)
 	user_datum_init(user);
 	retval =
 	    require_symbol(SYM_USERS, id, (hashtab_datum_t *) user,
-			   &user->value, &user->value);
+			   &user->s.value, &user->s.value);
 	if (retval != 0) {
 		free(id);
 		user_datum_destroy(user);
@@ -914,7 +914,7 @@ int require_bool(int pass)
 	}
 	retval =
 	    require_symbol(SYM_BOOLS, id, (hashtab_datum_t *) booldatum,
-			   &booldatum->value, &booldatum->value);
+			   &booldatum->s.value, &booldatum->s.value);
 	if (retval != 0) {
 		cond_destroy_bool(id, booldatum, NULL);
 	}
@@ -1026,7 +1026,7 @@ int is_perm_in_scope(hashtab_key_t perm_
 	if (perdatum == NULL) {
 		return 1;
 	}
-	return is_perm_in_stack(perdatum->value, cladatum->value, stack_top);
+	return is_perm_in_stack(perdatum->s.value, cladatum->s.value, stack_top);
 }
 
 cond_list_t *get_current_cond_list(cond_list_t * cond)
diff --git a/checkpolicy/policy_parse.y b/checkpolicy/policy_parse.y
index c262534..f514c1c 100644
--- a/checkpolicy/policy_parse.y
+++ b/checkpolicy/policy_parse.y
@@ -983,7 +983,7 @@ static int define_class(void)
 			assert(0);	/* should never get here */
 		}
 	}
-	datum->value = value;
+	datum->s.value = value;
 	return 0;
 
       bad:
@@ -1088,7 +1088,7 @@ static int define_common_perms(void)
 		yyerror("hash table overflow");
 		goto bad;
 	}
-	comdatum->value = policydbp->p_commons.nprim + 1;
+	comdatum->s.value = policydbp->p_commons.nprim + 1;
 	if (symtab_init(&comdatum->permissions, PERM_SYMTAB_SIZE)) {
 		yyerror("out of memory");
 		goto bad;
@@ -1101,9 +1101,9 @@ static int define_common_perms(void)
 			goto bad_perm;
 		}
 		memset(perdatum, 0, sizeof(perm_datum_t));
-		perdatum->value = comdatum->permissions.nprim + 1;
+		perdatum->s.value = comdatum->permissions.nprim + 1;
 
-		if (perdatum->value > (sizeof(sepol_access_vector_t) * 8)) {
+		if (perdatum->s.value > (sizeof(sepol_access_vector_t) * 8)) {
 			yyerror
 			    ("too many permissions to fit in an access vector");
 			goto bad_perm;
@@ -1212,9 +1212,9 @@ static int define_av_perms(int inherits)
 			goto bad;
 		}
 		memset(perdatum, 0, sizeof(perm_datum_t));
-		perdatum->value = ++cladatum->permissions.nprim;
+		perdatum->s.value = ++cladatum->permissions.nprim;
 
-		if (perdatum->value > (sizeof(sepol_access_vector_t) * 8)) {
+		if (perdatum->s.value > (sizeof(sepol_access_vector_t) * 8)) {
 			yyerror
 			    ("too many permissions to fit in an access vector");
 			goto bad;
@@ -1250,7 +1250,7 @@ static int define_av_perms(int inherits)
 			yyerror("hash table overflow");
 			goto bad;
 		}
-		if (add_perm_to_class(perdatum->value, cladatum->value)) {
+		if (add_perm_to_class(perdatum->s.value, cladatum->s.value)) {
 			yyerror("out of memory");
 			goto bad;
 		}
@@ -1503,7 +1503,7 @@ static int define_category(void)
 			assert(0);	/* should never get here */
 		}
 	}
-	datum->value = value;
+	datum->s.value = value;
 
 	while ((id = queue_remove(id_queue))) {
 		if (id_has_dot(id)) {
@@ -1517,11 +1517,11 @@ static int define_category(void)
 		}
 		memset(aliasdatum, 0, sizeof(cat_datum_t));
 		aliasdatum->isalias = TRUE;
-		aliasdatum->value = datum->value;
+		aliasdatum->s.value = datum->s.value;
 
 		ret =
 		    declare_symbol(SYM_CATS, id, aliasdatum, NULL,
-				   &datum->value);
+				   &datum->s.value);
 		switch (ret) {
 		case -3:{
 				yyerror("Out of memory!");
@@ -1649,7 +1649,7 @@ static int define_level(void)
 				free(id);
 				return -1;
 			}
-			range_start = cdatum->value - 1;
+			range_start = cdatum->s.value - 1;
 			cdatum =
 			    (cat_datum_t *) hashtab_search(policydbp->p_cats.
 							   table,
@@ -1662,7 +1662,7 @@ static int define_level(void)
 				free(id);
 				return -1;
 			}
-			range_end = cdatum->value - 1;
+			range_end = cdatum->s.value - 1;
 
 			if (range_end < range_start) {
 				sprintf(errormsg, "category range is invalid");
@@ -1675,7 +1675,7 @@ static int define_level(void)
 			    (cat_datum_t *) hashtab_search(policydbp->p_cats.
 							   table,
 							   (hashtab_key_t) id);
-			range_start = range_end = cdatum->value - 1;
+			range_start = range_end = cdatum->s.value - 1;
 		}
 
 		for (i = range_start; i <= range_end; i++) {
@@ -1730,10 +1730,10 @@ static int add_aliases_to_type(type_datu
 			return -1;
 		}
 		memset(aliasdatum, 0, sizeof(type_datum_t));
-		aliasdatum->value = type->value;
+		aliasdatum->s.value = type->s.value;
 
 		ret = declare_symbol(SYM_TYPES, id, aliasdatum,
-				     NULL, &aliasdatum->value);
+				     NULL, &aliasdatum->s.value);
 		switch (ret) {
 		case -3:{
 				yyerror("Out of memory!");
@@ -1851,12 +1851,12 @@ static int define_typeattribute(void)
 			return -1;
 		}
 
-		if ((attr = get_local_type(id, attr->value, 1)) == NULL) {
+		if ((attr = get_local_type(id, attr->s.value, 1)) == NULL) {
 			yyerror("Out of memory!");
 			return -1;
 		}
 
-		if (ebitmap_set_bit(&attr->types, (t->value - 1), TRUE)) {
+		if (ebitmap_set_bit(&attr->types, (t->s.value - 1), TRUE)) {
 			yyerror("out of memory");
 			return -1;
 		}
@@ -1914,12 +1914,12 @@ static int define_type(int alias)
 			return -1;
 		}
 
-		if ((attr = get_local_type(id, attr->value, 1)) == NULL) {
+		if ((attr = get_local_type(id, attr->s.value, 1)) == NULL) {
 			yyerror("Out of memory!");
 			return -1;
 		}
 
-		if (ebitmap_set_bit(&attr->types, datum->value - 1, TRUE)) {
+		if (ebitmap_set_bit(&attr->types, datum->s.value - 1, TRUE)) {
 			yyerror("Out of memory");
 			return -1;
 		}
@@ -1984,10 +1984,10 @@ static int set_types(type_set_t * set, c
 	}
 
 	if (*add == 0) {
-		if (ebitmap_set_bit(&set->negset, t->value - 1, TRUE))
+		if (ebitmap_set_bit(&set->negset, t->s.value - 1, TRUE))
 			goto oom;
 	} else {
-		if (ebitmap_set_bit(&set->types, t->value - 1, TRUE))
+		if (ebitmap_set_bit(&set->types, t->s.value - 1, TRUE))
 			goto oom;
 	}
 	free(id);
@@ -2042,7 +2042,7 @@ static int define_compute_type_helper(in
 			yyerror(errormsg);
 			goto bad;
 		}
-		if (ebitmap_set_bit(&tclasses, cladatum->value - 1, TRUE)) {
+		if (ebitmap_set_bit(&tclasses, cladatum->s.value - 1, TRUE)) {
 			yyerror("Out of memory");
 			goto bad;
 		}
@@ -2076,7 +2076,7 @@ static int define_compute_type_helper(in
 			}
 			class_perm_node_init(perm);
 			perm->class = i + 1;
-			perm->data = datum->value;
+			perm->data = datum->s.value;
 			perm->next = avrule->perms;
 			avrule->perms = perm;
 		}
@@ -2191,7 +2191,7 @@ static int define_bool(void)
 			assert(0);	/* should never get here */
 		}
 	}
-	datum->value = value;
+	datum->s.value = value;
 
 	bool_value = (char *)queue_remove(id_queue);
 	if (!bool_value) {
@@ -2284,7 +2284,7 @@ static int define_te_avtab_helper(int wh
 			ret = -1;
 			goto out;
 		}
-		if (ebitmap_set_bit(&tclasses, cladatum->value - 1, TRUE)) {
+		if (ebitmap_set_bit(&tclasses, cladatum->s.value - 1, TRUE)) {
 			yyerror("Out of memory");
 			ret = -1;
 			goto out;
@@ -2361,7 +2361,7 @@ static int define_te_avtab_helper(int wh
 				}
 				continue;
 			} else {
-				cur_perms->data |= 1U << (perdatum->value - 1);
+				cur_perms->data |= 1U << (perdatum->s.value - 1);
 			}
 		      next:
 			cur_perms = cur_perms->next;
@@ -2459,7 +2459,7 @@ static role_datum_t *merge_roles_dom(rol
 		return NULL;
 	}
 	memset(new, 0, sizeof(role_datum_t));
-	new->value = 0;		/* temporary role */
+	new->s.value = 0;		/* temporary role */
 	if (ebitmap_or(&new->dominates, &r1->dominates, &r2->dominates)) {
 		yyerror("out of memory");
 		return NULL;
@@ -2468,13 +2468,13 @@ static role_datum_t *merge_roles_dom(rol
 		yyerror("out of memory");
 		return NULL;
 	}
-	if (!r1->value) {
+	if (!r1->s.value) {
 		/* free intermediate result */
 		type_set_destroy(&r1->types);
 		ebitmap_destroy(&r1->dominates);
 		free(r1);
 	}
-	if (!r2->value) {
+	if (!r2->s.value) {
 		/* free intermediate result */
 		yyerror("right hand role is temporary?");
 		type_set_destroy(&r2->types);
@@ -2494,11 +2494,11 @@ static int dominate_role_recheck(hashtab
 	int i;
 
 	/* Don't bother to process against self role */
-	if (rdatum->value == rdp->value)
+	if (rdatum->s.value == rdp->s.value)
 		return 0;
 
 	/* If a dominating role found */
-	if (ebitmap_get_bit(&(rdatum->dominates), rdp->value - 1)) {
+	if (ebitmap_get_bit(&(rdatum->dominates), rdp->s.value - 1)) {
 		ebitmap_t types;
 		ebitmap_init(&types);
 		if (type_set_expand(&rdp->types, &types, policydbp, 1)) {
@@ -2560,8 +2560,8 @@ static role_datum_t *define_role_dom(rol
 		memset(role, 0, sizeof(role_datum_t));
 		ret =
 		    declare_symbol(SYM_ROLES, (hashtab_key_t) role_id,
-				   (hashtab_datum_t) role, &role->value,
-				   &role->value);
+				   (hashtab_datum_t) role, &role->s.value,
+				   &role->s.value);
 		switch (ret) {
 		case -3:{
 				yyerror("Out of memory!");
@@ -2584,7 +2584,7 @@ static role_datum_t *define_role_dom(rol
 				assert(0);	/* should never get here */
 			}
 		}
-		if (ebitmap_set_bit(&role->dominates, role->value - 1, TRUE)) {
+		if (ebitmap_set_bit(&role->dominates, role->s.value - 1, TRUE)) {
 			yyerror("Out of memory!");
 			goto cleanup;
 		}
@@ -2608,7 +2608,7 @@ static role_datum_t *define_role_dom(rol
 					goto oom;
 		}
 		ebitmap_destroy(&types);
-		if (!r->value) {
+		if (!r->s.value) {
 			/* free intermediate result */
 			type_set_destroy(&r->types);
 			ebitmap_destroy(&r->dominates);
@@ -2640,7 +2640,7 @@ static int role_val_to_name_helper(hasht
 
 	roldatum = (role_datum_t *) datum;
 
-	if (v->val == roldatum->value) {
+	if (v->val == roldatum->s.value) {
 		v->name = key;
 		return 1;
 	}
@@ -2687,7 +2687,7 @@ static int set_roles(role_set_t * set, c
 		return -1;
 	}
 
-	if (ebitmap_set_bit(&set->roles, r->value - 1, TRUE)) {
+	if (ebitmap_set_bit(&set->roles, r->s.value - 1, TRUE)) {
 		yyerror("out of memory");
 		free(id);
 		return -1;
@@ -2786,7 +2786,7 @@ static int define_role_trans(void)
 			memset(tr, 0, sizeof(struct role_trans));
 			tr->role = i + 1;
 			tr->type = j + 1;
-			tr->new_role = role->value;
+			tr->new_role = role->s.value;
 			tr->next = policydbp->role_tr;
 			policydbp->role_tr = tr;
 		}
@@ -2800,7 +2800,7 @@ static int define_role_trans(void)
 	memset(rule, 0, sizeof(struct role_trans_rule));
 	rule->roles = roles;
 	rule->types = types;
-	rule->new_role = role->value;
+	rule->new_role = role->s.value;
 
 	append_role_trans(rule);
 
@@ -2966,7 +2966,7 @@ static int define_constraint(constraint_
 			free(id);
 			return -1;
 		}
-		if (ebitmap_set_bit(&classmap, cladatum->value - 1, TRUE)) {
+		if (ebitmap_set_bit(&classmap, cladatum->s.value - 1, TRUE)) {
 			yyerror("out of memory");
 			ebitmap_destroy(&classmap);
 			free(id);
@@ -3030,7 +3030,7 @@ static int define_constraint(constraint_
 					}
 				}
 				node->permissions |=
-				    (1 << (perdatum->value - 1));
+				    (1 << (perdatum->s.value - 1));
 			}
 		}
 		free(id);
@@ -3109,7 +3109,7 @@ static int define_validatetrans(constrai
 			free(id);
 			return -1;
 		}
-		if (ebitmap_set_bit(&classmap, (cladatum->value - 1), TRUE)) {
+		if (ebitmap_set_bit(&classmap, (cladatum->s.value - 1), TRUE)) {
 			yyerror("out of memory");
 			ebitmap_destroy(&classmap);
 			free(id);
@@ -3241,7 +3241,7 @@ define_cexpr(uint32_t expr_type, uintptr
 					constraint_expr_destroy(expr);
 					return 0;
 				}
-				val = user->value;
+				val = user->s.value;
 			} else if (expr->attr & CEXPR_ROLE) {
 				if (!is_id_in_scope(SYM_ROLES, id)) {
 					yyerror2("role %s is not within scope",
@@ -3262,7 +3262,7 @@ define_cexpr(uint32_t expr_type, uintptr
 					constraint_expr_destroy(expr);
 					return 0;
 				}
-				val = role->value;
+				val = role->s.value;
 			} else if (expr->attr & CEXPR_TYPE) {
 				if (set_types(expr->type_names, id, &add, 0)) {
 					constraint_expr_destroy(expr);
@@ -3495,7 +3495,7 @@ static cond_expr_t *define_cond_expr(uin
 			free(id);
 			return NULL;
 		}
-		expr->bool = bool_var->value;
+		expr->bool = bool_var->s.value;
 		free(id);
 		return expr;
 	default:
@@ -3568,7 +3568,7 @@ parse_categories(char *id, level_datum_t
 			yyerror(errormsg);
 			return -1;
 		}
-		range_start = cdatum->value - 1;
+		range_start = cdatum->s.value - 1;
 		cdatum = (cat_datum_t *) hashtab_search(policydbp->p_cats.table,
 							(hashtab_key_t) id_end);
 		if (!cdatum) {
@@ -3576,7 +3576,7 @@ parse_categories(char *id, level_datum_t
 			yyerror(errormsg);
 			return -1;
 		}
-		range_end = cdatum->value - 1;
+		range_end = cdatum->s.value - 1;
 
 		if (range_end < range_start) {
 			sprintf(errormsg, "category range is invalid");
@@ -3591,7 +3591,7 @@ parse_categories(char *id, level_datum_t
 			yyerror(errormsg);
 			return -1;
 		}
-		range_start = range_end = cdatum->value - 1;
+		range_start = range_end = cdatum->s.value - 1;
 	}
 
 	for (i = range_start; i <= range_end; i++) {
@@ -3803,7 +3803,7 @@ static int parse_security_context(contex
 		free(id);
 		goto bad;
 	}
-	c->user = usrdatum->value;
+	c->user = usrdatum->s.value;
 
 	/* no need to keep the user name */
 	free(id);
@@ -3827,7 +3827,7 @@ static int parse_security_context(contex
 		free(id);
 		return -1;
 	}
-	c->role = role->value;
+	c->role = role->s.value;
 
 	/* no need to keep the role name */
 	free(id);
@@ -3852,7 +3852,7 @@ static int parse_security_context(contex
 		free(id);
 		return -1;
 	}
-	c->type = typdatum->value;
+	c->type = typdatum->s.value;
 
 	/* no need to keep the type name */
 	free(id);
diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index 98ddd31..e4ed7c3 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -295,13 +295,13 @@ int display_type_callback(hashtab_key_t 
 	fp = (FILE *) data;
 
 	if (type->primary) {
-		display_id(&policydb, fp, SYM_TYPES, type->value - 1, "");
-		fprintf(fp, " [%d]: ", type->value);
+		display_id(&policydb, fp, SYM_TYPES, type->s.value - 1, "");
+		fprintf(fp, " [%d]: ", type->s.value);
 	} else {
 		/* as that aliases have no value of their own and that
 		 * they can never be required by a module, use this
 		 * alternative way of displaying a name */
-		fprintf(fp, " %s [%d]: ", (char *)key, type->value);
+		fprintf(fp, " %s [%d]: ", (char *)key, type->s.value);
 	}
 	if (type->flavor == TYPE_ATTRIB) {
 		fprintf(fp, "attribute for types");
@@ -320,7 +320,7 @@ int display_type_callback(hashtab_key_t 
 		fprintf(fp, "type");
 	} else {
 		fprintf(fp, "alias for type");
-		display_id(&policydb, fp, SYM_TYPES, type->value - 1, "");
+		display_id(&policydb, fp, SYM_TYPES, type->s.value - 1, "");
 	}
 	fprintf(fp, "\n");
 
@@ -482,7 +482,7 @@ int role_display_callback(hashtab_key_t 
 	fp = (FILE *) data;
 
 	fprintf(fp, "role:");
-	display_id(&policydb, fp, SYM_ROLES, role->value - 1, "");
+	display_id(&policydb, fp, SYM_ROLES, role->s.value - 1, "");
 	fprintf(fp, " types: ");
 	display_type_set(&role->types, 0, &policydb, fp);
 	fprintf(fp, "\n");
diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 77688bd..45736a0 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -90,18 +90,18 @@ #define ROLE_COMP 2
 
 /* Permission attributes */
 typedef struct perm_datum {
-	uint32_t value;		/* permission bit + 1 */
+	symtab_datum_t s;
 } perm_datum_t;
 
 /* Attributes of a common prefix for access vectors */
 typedef struct common_datum {
-	uint32_t value;		/* internal common value */
+	symtab_datum_t s;
 	symtab_t permissions;	/* common permissions */
 } common_datum_t;
 
 /* Class attributes */
 typedef struct class_datum {
-	uint32_t value;		/* class value */
+	symtab_datum_t s;
 	char *comkey;		/* common name */
 	common_datum_t *comdatum;	/* common datum */
 	symtab_t permissions;	/* class-specific permission symbol table */
@@ -111,7 +111,7 @@ typedef struct class_datum {
 
 /* Role attributes */
 typedef struct role_datum {
-	uint32_t value;		/* internal role value */
+	symtab_datum_t s;
 	ebitmap_t dominates;	/* set of roles dominated by this role */
 	type_set_t types;	/* set of authorized types for role */
 	ebitmap_t cache;	/* This is an expanded set used for context validation during parsing */
@@ -132,7 +132,7 @@ typedef struct role_allow {
 
 /* Type attributes */
 typedef struct type_datum {
-	uint32_t value;		/* internal type value */
+	symtab_datum_t s;
 	uint32_t primary;	/* primary name? can be set to primary value if below is TYPE_ */
 #define TYPE_TYPE 0		/* regular type or alias in kernel policies */
 #define TYPE_ATTRIB 1		/* attribute */
@@ -143,7 +143,7 @@ #define TYPE_ALIAS 2		/* alias in modula
 
 /* User attributes */
 typedef struct user_datum {
-	uint32_t value;		/* internal user value */
+	symtab_datum_t s;
 	role_set_t roles;	/* set of authorized roles for user */
 	mls_range_t range;	/* MLS range (min. - max.) for user */
 	mls_level_t dfltlevel;	/* default login MLS level for user */
@@ -159,7 +159,7 @@ typedef struct level_datum {
 
 /* Category attributes */
 typedef struct cat_datum {
-	uint32_t value;		/* internal category bit + 1 */
+	symtab_datum_t s;
 	unsigned char isalias;	/* is this category an alias for another? */
 } cat_datum_t;
 
@@ -172,7 +172,7 @@ typedef struct range_trans {
 
 /* Boolean data type */
 typedef struct cond_bool_datum {
-	uint32_t value;		/* internal type value */
+	symtab_datum_t s;
 	int state;
 } cond_bool_datum_t;
 
diff --git a/libsepol/include/sepol/policydb/symtab.h b/libsepol/include/sepol/policydb/symtab.h
index 678f709..c8ad664 100644
--- a/libsepol/include/sepol/policydb/symtab.h
+++ b/libsepol/include/sepol/policydb/symtab.h
@@ -15,6 +15,17 @@ #define _SEPOL_POLICYDB_SYMTAB_H_
 
 #include <sepol/policydb/hashtab.h>
 
+/* The symtab_datum struct stores the common information for
+ * all symtab datums. It should the first element in every
+ * struct that will be used in a symtab to allow the specific
+ * datum types to be freely cast to this type.
+ *
+ * The values start at 1 - 0 is never a valid value.
+ */
+typedef struct symtab_datum {
+	uint32_t value;
+} symtab_datum_t;
+
 typedef struct {
 	hashtab_t table;	/* hash table (keyed on a string) */
 	uint32_t nprim;		/* number of primary names in table */
diff --git a/libsepol/src/booleans.c b/libsepol/src/booleans.c
index 3f3570a..7f37c8b 100644
--- a/libsepol/src/booleans.c
+++ b/libsepol/src/booleans.c
@@ -160,7 +160,7 @@ int sepol_bool_query(sepol_handle_t * ha
 	}
 
 	if (bool_to_record(handle, policydb,
-			   booldatum->value - 1, response) < 0)
+			   booldatum->s.value - 1, response) < 0)
 		goto err;
 
 	free(name);
diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
index dd3c226..f7ec015 100644
--- a/libsepol/src/conditional.c
+++ b/libsepol/src/conditional.c
@@ -539,11 +539,11 @@ int cond_index_bool(hashtab_key_t key, h
 	booldatum = datum;
 	p = datap;
 
-	if (!booldatum->value || booldatum->value > p->p_bools.nprim)
+	if (!booldatum->s.value || booldatum->s.value > p->p_bools.nprim)
 		return -EINVAL;
 
-	p->p_bool_val_to_name[booldatum->value - 1] = key;
-	p->bool_val_to_struct[booldatum->value - 1] = booldatum;
+	p->p_bool_val_to_name[booldatum->s.value - 1] = key;
+	p->bool_val_to_struct[booldatum->s.value - 1] = booldatum;
 
 	return 0;
 }
@@ -572,7 +572,7 @@ int cond_read_bool(policydb_t * p
 	if (!buf)
 		goto err;
 
-	booldatum->value = le32_to_cpu(buf[0]);
+	booldatum->s.value = le32_to_cpu(buf[0]);
 	booldatum->state = le32_to_cpu(buf[1]);
 
 	if (!bool_isvalid(booldatum))
diff --git a/libsepol/src/context.c b/libsepol/src/context.c
index dfb89bb..0d5ffd0 100644
--- a/libsepol/src/context.c
+++ b/libsepol/src/context.c
@@ -171,7 +171,7 @@ int context_from_record(sepol_handle_t *
 		ERR(handle, "user %s is not defined", user);
 		goto err_destroy;
 	}
-	scontext->user = usrdatum->value;
+	scontext->user = usrdatum->s.value;
 
 	/* Role */
 	roldatum = (role_datum_t *) hashtab_search(policydb->p_roles.table,
@@ -180,7 +180,7 @@ int context_from_record(sepol_handle_t *
 		ERR(handle, "role %s is not defined", role);
 		goto err_destroy;
 	}
-	scontext->role = roldatum->value;
+	scontext->role = roldatum->s.value;
 
 	/* Type */
 	typdatum = (type_datum_t *) hashtab_search(policydb->p_types.table,
@@ -189,7 +189,7 @@ int context_from_record(sepol_handle_t *
 		ERR(handle, "type %s is not defined", type);
 		goto err_destroy;
 	}
-	scontext->type = typdatum->value;
+	scontext->type = typdatum->s.value;
 
 	/* MLS */
 	if (mls && !policydb->mls) {
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 72f57fe..aafd8d6 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -83,15 +83,15 @@ static int type_copy_callback(hashtab_ke
 	memset(new_type, 0, sizeof(type_datum_t));
 
 	new_type->flavor = type->flavor;
-	new_type->value = ++state->out->p_types.nprim;
-	if (new_type->value > UINT16_MAX) {
+	new_type->s.value = ++state->out->p_types.nprim;
+	if (new_type->s.value > UINT16_MAX) {
 		free(new_id);
 		free(new_type);
 		ERR(state->handle, "type space overflow");
 		return -1;
 	}
 	new_type->primary = 1;
-	state->typemap[type->value - 1] = new_type->value;
+	state->typemap[type->s.value - 1] = new_type->s.value;
 
 	ret = hashtab_insert(state->out->p_types.table,
 			     (hashtab_key_t) new_id,
@@ -173,7 +173,7 @@ static int perm_copy_callback(hashtab_ke
 		return -1;
 	}
 
-	new_perm->value = perm->value;
+	new_perm->s.value = perm->s.value;
 	s->nprim++;
 
 	ret = hashtab_insert(s->table, new_id, (hashtab_datum_t *) new_perm);
@@ -220,7 +220,7 @@ static int common_copy_callback(hashtab_
 		return -1;
 	}
 
-	new_common->value = common->value;
+	new_common->s.value = common->s.value;
 	state->out->p_commons.nprim++;
 
 	ret =
@@ -347,7 +347,7 @@ static int class_copy_callback(hashtab_k
 		return -1;
 	}
 
-	new_class->value = class->value;
+	new_class->s.value = class->s.value;
 	state->out->p_classes.nprim++;
 
 	new_id = strdup(id);
@@ -465,9 +465,9 @@ static int alias_copy_callback(hashtab_k
 	}
 	memset(new_alias, 0, sizeof(type_datum_t));
 	if (alias->flavor == TYPE_TYPE)
-		new_alias->value = state->typemap[alias->value - 1];
+		new_alias->s.value = state->typemap[alias->s.value - 1];
 	else if (alias->flavor == TYPE_ALIAS)
-		new_alias->value = state->typemap[alias->primary - 1];
+		new_alias->s.value = state->typemap[alias->primary - 1];
 	else
 		assert(0);	/* unreachable */
 
@@ -482,7 +482,7 @@ static int alias_copy_callback(hashtab_k
 		return -1;
 	}
 
-	state->typemap[alias->value - 1] = new_alias->value;
+	state->typemap[alias->s.value - 1] = new_alias->s.value;
 	return 0;
 }
 
@@ -527,7 +527,7 @@ static int role_copy_callback(hashtab_ke
 			return -1;
 		}
 
-		new_role->value = role->value;
+		new_role->s.value = role->s.value;
 		state->out->p_roles.nprim++;
 		ret = hashtab_insert(state->out->p_roles.table,
 				     (hashtab_key_t) new_id,
@@ -615,7 +615,7 @@ static int user_copy_callback(hashtab_ke
 		}
 		memset(new_user, 0, sizeof(user_datum_t));
 
-		new_user->value = user->value;
+		new_user->s.value = user->s.value;
 		state->out->p_users.nprim++;
 
 		new_id = strdup(id);
@@ -702,7 +702,7 @@ static int bool_copy_callback(hashtab_ke
 		return -1;
 	}
 
-	new_bool->value = bool->value;
+	new_bool->s.value = bool->s.value;
 	state->out->p_bools.nprim++;
 
 	ret = hashtab_insert(state->out->p_bools.table,
@@ -787,7 +787,7 @@ static int cats_copy_callback(hashtab_ke
 		goto out_of_mem;
 	}
 
-	new_cat->value = cat->value;
+	new_cat->s.value = cat->s.value;
 	new_cat->isalias = cat->isalias;
 	state->out->p_cats.nprim++;
 	if (hashtab_insert(state->out->p_cats.table,
@@ -1541,7 +1541,7 @@ static int type_attr_map(hashtab_key_t k
 
 	type = (type_datum_t *) datum;
 	if (type->flavor == TYPE_ATTRIB) {
-		if (ebitmap_cpy(&p->attr_type_map[type->value - 1],
+		if (ebitmap_cpy(&p->attr_type_map[type->s.value - 1],
 				&type->types)) {
 			ERR(state->handle, "Out of memory!");
 			return -1;
@@ -1550,7 +1550,7 @@ static int type_attr_map(hashtab_key_t k
 			if (!ebitmap_node_get_bit(tnode, i))
 				continue;
 			if (ebitmap_set_bit(&p->type_attr_map[i],
-					    type->value - 1, 1)) {
+					    type->s.value - 1, 1)) {
 				ERR(state->handle, "Out of memory!");
 				return -1;
 			}
@@ -1577,8 +1577,8 @@ static int type_attr_remove(hashtab_key_
 	typdatum = (type_datum_t *) datum;
 	p = (policydb_t *) args;
 	if (typdatum->flavor == TYPE_ATTRIB) {
-		p->type_val_to_struct[typdatum->value - 1] = NULL;
-		p->p_type_val_to_name[typdatum->value - 1] = NULL;
+		p->type_val_to_struct[typdatum->s.value - 1] = NULL;
+		p->p_type_val_to_name[typdatum->s.value - 1] = NULL;
 		return 1;
 	}
 	return 0;
diff --git a/libsepol/src/genusers.c b/libsepol/src/genusers.c
index 98fe53b..27355a7 100644
--- a/libsepol/src/genusers.c
+++ b/libsepol/src/genusers.c
@@ -87,7 +87,7 @@ static int load_users(struct policydb *p
 				return -1;
 			}
 			memset(usrdatum, 0, sizeof(user_datum_t));
-			usrdatum->value = ++policydb->p_users.nprim;
+			usrdatum->s.value = ++policydb->p_users.nprim;
 			ebitmap_init(&usrdatum->roles.roles);
 			if (hashtab_insert(policydb->p_users.table,
 					   id, (hashtab_datum_t) usrdatum)) {
diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
index 43a2d53..4633ff7 100644
--- a/libsepol/src/hierarchy.c
+++ b/libsepol/src/hierarchy.c
@@ -105,12 +105,12 @@ static int check_type_hierarchy_callback
 	if (!t2) {
 		/* If the parent does not exist this type is an orphan, not legal */
 		ERR(a->handle, "type %s does not exist, %s is an orphan",
-		    parent, a->p->p_type_val_to_name[t->value - 1]);
+		    parent, a->p->p_type_val_to_name[t->s.value - 1]);
 		a->numerr++;
 	} else if (t2->flavor == TYPE_ATTRIB) {
 		/* The parent is an attribute but the child isn't, not legal */
 		ERR(a->handle, "type %s is a child of an attribute",
-		    a->p->p_type_val_to_name[t->value - 1]);
+		    a->p->p_type_val_to_name[t->s.value - 1]);
 		a->numerr++;
 	}
 	free(parent);
@@ -152,7 +152,7 @@ static int check_avtab_hierarchy_callbac
 		}
 		free(parent);
 
-		key.source_type = t->value;
+		key.source_type = t->s.value;
 		key.target_type = k->target_type;
 		key.target_class = k->target_class;
 		key.specified = AVTAB_ALLOWED;
@@ -192,7 +192,7 @@ static int check_avtab_hierarchy_callbac
 		free(parent);
 
 		key.source_type = k->source_type;
-		key.target_type = t2->value;
+		key.target_type = t2->s.value;
 		key.target_class = k->target_class;
 		key.specified = AVTAB_ALLOWED;
 
@@ -217,8 +217,8 @@ static int check_avtab_hierarchy_callbac
 	}
 
 	if (t && t2) {
-		key.source_type = t->value;
-		key.target_type = t2->value;
+		key.source_type = t->s.value;
+		key.target_type = t2->s.value;
 		key.target_class = k->target_class;
 		key.specified = AVTAB_ALLOWED;
 
@@ -327,7 +327,7 @@ static int check_role_hierarchy_callback
 	a = (hierarchy_args_t *) args;
 	r = (role_datum_t *) d;
 
-	if (find_parent(a->p->p_role_val_to_name[r->value - 1], &parent))
+	if (find_parent(a->p->p_role_val_to_name[r->s.value - 1], &parent))
 		return -1;
 
 	if (!parent) {
@@ -339,7 +339,7 @@ static int check_role_hierarchy_callback
 	if (!rp) {
 		/* Orphan role */
 		ERR(a->handle, "role %s doesn't exist, %s is an orphan",
-		    parent, a->p->p_role_val_to_name[r->value - 1]);
+		    parent, a->p->p_role_val_to_name[r->s.value - 1]);
 		free(parent);
 		a->numerr++;
 		return 0;
@@ -354,7 +354,7 @@ static int check_role_hierarchy_callback
 	if (!ebitmap_cmp(&eb, &rp->types.types)) {
 		/* This is a violation of the hiearchal constraint, return error condition */
 		ERR(a->handle, "Role hierarchy violation, %s exceeds %s",
-		    a->p->p_role_val_to_name[r->value - 1], parent);
+		    a->p->p_role_val_to_name[r->s.value - 1], parent);
 		a->numerr++;
 	}
 
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index b94044a..4e74b14 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -129,7 +129,7 @@ static int permission_copy_callback(hash
 	class_datum_t *src_class = state->src_class;
 	class_datum_t *dest_class = state->dest_class;
 	policy_module_t *mod = state->cur;
-	uint32_t sclassi = src_class->value - 1;
+	uint32_t sclassi = src_class->s.value - 1;
 	int ret;
 
 	perm = (perm_datum_t *) datum;
@@ -166,7 +166,7 @@ static int permission_copy_callback(hash
 				    "could not insert permission into class\n");
 				goto err;
 			}
-			new_perm->value = dest_class->permissions.nprim + 1;
+			new_perm->s.value = dest_class->permissions.nprim + 1;
 			dest_perm = new_perm;
 		} else {
 			/* this is case c from above */
@@ -183,8 +183,8 @@ static int permission_copy_callback(hash
 	 * module permission bit to target permission bit.  that bit
 	 * may have originated from the class -or- it could be from
 	 * the class's common parent.*/
-	if (perm->value > mod->perm_map_len[sclassi]) {
-		uint32_t *newmap = calloc(perm->value, sizeof(*newmap));
+	if (perm->s.value > mod->perm_map_len[sclassi]) {
+		uint32_t *newmap = calloc(perm->s.value, sizeof(*newmap));
 		if (newmap == NULL) {
 			ERR(state->handle, "Out of memory!");
 			return -1;
@@ -193,9 +193,9 @@ static int permission_copy_callback(hash
 		       mod->perm_map_len[sclassi] * sizeof(*newmap));
 		free(mod->perm_map[sclassi]);
 		mod->perm_map[sclassi] = newmap;
-		mod->perm_map_len[sclassi] = perm->value;
+		mod->perm_map_len[sclassi] = perm->s.value;
 	}
-	mod->perm_map[sclassi][perm->value - 1] = dest_perm->value;
+	mod->perm_map[sclassi][perm->s.value - 1] = dest_perm->s.value;
 
 	return 0;
       err:
@@ -274,11 +274,11 @@ static int class_copy_callback(hashtab_k
 				    "could not insert new class into symtab");
 				goto err;
 			}
-			new_class->value = ++(state->base->p_classes.nprim);
+			new_class->s.value = ++(state->base->p_classes.nprim);
 		}
 	}
 
-	state->cur->map[SYM_CLASSES][cladatum->value - 1] = new_class->value;
+	state->cur->map[SYM_CLASSES][cladatum->s.value - 1] = new_class->s.value;
 
 	/* copy permissions */
 	state->src_class = cladatum;
@@ -326,7 +326,7 @@ static int role_copy_callback(hashtab_ke
 
 		/* new_role's dominates and types field will be copied
 		 * during role_fix_callback() */
-		new_role->value = state->base->p_roles.nprim + 1;
+		new_role->s.value = state->base->p_roles.nprim + 1;
 
 		ret = hashtab_insert(state->base->p_roles.table,
 				     (hashtab_key_t) new_id,
@@ -344,7 +344,7 @@ static int role_copy_callback(hashtab_ke
 			goto cleanup;
 		}
 		role_datum_init(new_role);
-		new_role->value = base_role->value;
+		new_role->s.value = base_role->s.value;
 		if ((new_id = strdup(id)) == NULL) {
 			goto cleanup;
 		}
@@ -355,7 +355,7 @@ static int role_copy_callback(hashtab_ke
 		state->dest_decl->p_roles.nprim++;
 	}
 
-	state->cur->map[SYM_ROLES][role->value - 1] = base_role->value;
+	state->cur->map[SYM_ROLES][role->s.value - 1] = base_role->s.value;
 	return 0;
 
       cleanup:
@@ -420,7 +420,7 @@ static int type_copy_callback(hashtab_ke
 		/* for attributes, the writing of new_type->types is
 		   done in type_fix_callback() */
 
-		new_type->value = state->base->p_types.nprim + 1;
+		new_type->s.value = state->base->p_types.nprim + 1;
 
 		ret = hashtab_insert(state->base->p_types.table,
 				     (hashtab_key_t) new_id,
@@ -439,7 +439,7 @@ static int type_copy_callback(hashtab_ke
 		}
 		new_type->primary = type->primary;
 		new_type->flavor = type->flavor;
-		new_type->value = base_type->value;
+		new_type->s.value = base_type->s.value;
 		if ((new_id = strdup(id)) == NULL) {
 			goto cleanup;
 		}
@@ -450,7 +450,7 @@ static int type_copy_callback(hashtab_ke
 		state->dest_decl->p_types.nprim++;
 	}
 
-	state->cur->map[SYM_TYPES][type->value - 1] = base_type->value;
+	state->cur->map[SYM_TYPES][type->s.value - 1] = base_type->s.value;
 	return 0;
 
       cleanup:
@@ -505,7 +505,7 @@ static int user_copy_callback(hashtab_ke
 		   fix_user_callback().  the MLS fields are currently
 		   unimplemented */
 
-		new_user->value = state->base->p_users.nprim + 1;
+		new_user->s.value = state->base->p_users.nprim + 1;
 
 		ret = hashtab_insert(state->base->p_users.table,
 				     (hashtab_key_t) new_id,
@@ -523,7 +523,7 @@ static int user_copy_callback(hashtab_ke
 			goto cleanup;
 		}
 		user_datum_init(new_user);
-		new_user->value = base_user->value;
+		new_user->s.value = base_user->s.value;
 		if ((new_id = strdup(id)) == NULL) {
 			goto cleanup;
 		}
@@ -534,7 +534,7 @@ static int user_copy_callback(hashtab_ke
 		state->dest_decl->p_users.nprim++;
 	}
 
-	state->cur->map[SYM_USERS][user->value - 1] = base_user->value;
+	state->cur->map[SYM_USERS][user->s.value - 1] = base_user->s.value;
 	return 0;
 
       cleanup:
@@ -569,7 +569,7 @@ static int bool_copy_callback(hashtab_ke
 			goto cleanup;
 		}
 		new_bool->state = booldatum->state;
-		new_bool->value = state->base->p_bools.nprim + 1;
+		new_bool->s.value = state->base->p_bools.nprim + 1;
 
 		ret = hashtab_insert(state->base->p_bools.table,
 				     (hashtab_key_t) new_id,
@@ -582,7 +582,7 @@ static int bool_copy_callback(hashtab_ke
 
 	}
 
-	state->cur->map[SYM_BOOLS][booldatum->value - 1] = base_bool->value;
+	state->cur->map[SYM_BOOLS][booldatum->s.value - 1] = base_bool->s.value;
 	return 0;
 
       cleanup:
@@ -626,7 +626,7 @@ static int alias_copy_callback(hashtab_k
 	if (type->flavor == TYPE_ALIAS)
 		primval = type->primary;
 	else
-		primval = type->value;
+		primval = type->s.value;
 
 	target_id = mod->policy->p_type_val_to_name[primval - 1];
 	target_type = hashtab_search(state->base->p_types.table, target_id);
@@ -646,9 +646,9 @@ static int alias_copy_callback(hashtab_k
 			goto cleanup;
 		}
 		/* the linked copy always has TYPE_ALIAS style aliases */
-		new_type->primary = target_type->value;
+		new_type->primary = target_type->s.value;
 		new_type->flavor = TYPE_ALIAS;
-		new_type->value = state->base->p_types.nprim + 1;
+		new_type->s.value = state->base->p_types.nprim + 1;
 		if ((new_id = strdup(id)) == NULL) {
 			goto cleanup;
 		}
@@ -665,10 +665,10 @@ static int alias_copy_callback(hashtab_k
 
 		if (base_type->flavor == TYPE_ALIAS) {
 			/* error checking */
-			assert(base_type->primary == target_type->value);
+			assert(base_type->primary == target_type->s.value);
 			assert(base_type->primary ==
 			       mod->map[SYM_TYPES][primval - 1]);
-			assert(mod->map[SYM_TYPES][type->value - 1] ==
+			assert(mod->map[SYM_TYPES][type->s.value - 1] ==
 			       base_type->primary);
 			return 0;
 		}
@@ -680,12 +680,12 @@ static int alias_copy_callback(hashtab_k
 		}
 
 		base_type->flavor = TYPE_ALIAS;
-		base_type->primary = target_type->value;
+		base_type->primary = target_type->s.value;
 
 	}
 	/* the aliases map points from its value to its primary so when this module 
 	 * references this type the value it gets back from the map is the primary */
-	mod->map[SYM_TYPES][type->value - 1] = base_type->primary;
+	mod->map[SYM_TYPES][type->s.value - 1] = base_type->primary;
 
 	return 0;
 
@@ -1497,7 +1497,7 @@ static int find_perm(hashtab_key_t key, 
 	struct find_perm_arg *arg = varg;
 
 	perm_datum_t *perdatum = (perm_datum_t *) datum;
-	if (arg->valuep == perdatum->value) {
+	if (arg->valuep == perdatum->s.value) {
 		arg->key = key;
 		return 1;
 	}
diff --git a/libsepol/src/mls.c b/libsepol/src/mls.c
index 509057a..2ab28a7 100644
--- a/libsepol/src/mls.c
+++ b/libsepol/src/mls.c
@@ -388,7 +388,7 @@ int mls_context_to_sid(const policydb_t 
 
 				if (ebitmap_set_bit
 				    (&context->range.level[l].cat,
-				     catdatum->value - 1, 1))
+				     catdatum->s.value - 1, 1))
 					goto err;
 
 				/* If range, set all categories in range */
@@ -403,11 +403,11 @@ int mls_context_to_sid(const policydb_t 
 					if (!rngdatum)
 						goto err;
 
-					if (catdatum->value >= rngdatum->value)
+					if (catdatum->s.value >= rngdatum->s.value)
 						goto err;
 
-					for (i = catdatum->value;
-					     i < rngdatum->value; i++) {
+					for (i = catdatum->s.value;
+					     i < rngdatum->s.value; i++) {
 						if (ebitmap_set_bit
 						    (&context->range.level[l].
 						     cat, i, 1))
@@ -589,7 +589,7 @@ int mls_convert_context(policydb_t * old
 				if (!catdatum)
 					return -EINVAL;
 				rc = ebitmap_set_bit(&bitmap,
-						     catdatum->value - 1, 1);
+						     catdatum->s.value - 1, 1);
 				if (rc)
 					return rc;
 			}
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index aa79293..1c5d56c 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -348,10 +348,10 @@ static int roles_init(policydb_t * p)
 	rc = symtab_insert(p, SYM_ROLES, key, role,
 			   (p->policy_type ==
 			    POLICY_MOD ? SCOPE_REQ : SCOPE_DECL), 1,
-			   &role->value);
+			   &role->s.value);
 	if (rc)
 		goto out_free_key;
-	if (role->value != OBJECT_R_VAL) {
+	if (role->s.value != OBJECT_R_VAL) {
 		rc = -EINVAL;
 		goto out_free_role;
 	}
@@ -472,9 +472,9 @@ static int common_index(hashtab_key_t ke
 
 	comdatum = (common_datum_t *) datum;
 	p = (policydb_t *) datap;
-	if (!comdatum->value || comdatum->value > p->p_commons.nprim)
+	if (!comdatum->s.value || comdatum->s.value > p->p_commons.nprim)
 		return -EINVAL;
-	p->p_common_val_to_name[comdatum->value - 1] = (char *)key;
+	p->p_common_val_to_name[comdatum->s.value - 1] = (char *)key;
 
 	return 0;
 }
@@ -486,10 +486,10 @@ static int class_index(hashtab_key_t key
 
 	cladatum = (class_datum_t *) datum;
 	p = (policydb_t *) datap;
-	if (!cladatum->value || cladatum->value > p->p_classes.nprim)
+	if (!cladatum->s.value || cladatum->s.value > p->p_classes.nprim)
 		return -EINVAL;
-	p->p_class_val_to_name[cladatum->value - 1] = (char *)key;
-	p->class_val_to_struct[cladatum->value - 1] = cladatum;
+	p->p_class_val_to_name[cladatum->s.value - 1] = (char *)key;
+	p->class_val_to_struct[cladatum->s.value - 1] = cladatum;
 
 	return 0;
 }
@@ -501,10 +501,10 @@ static int role_index(hashtab_key_t key,
 
 	role = (role_datum_t *) datum;
 	p = (policydb_t *) datap;
-	if (!role->value || role->value > p->p_roles.nprim)
+	if (!role->s.value || role->s.value > p->p_roles.nprim)
 		return -EINVAL;
-	p->p_role_val_to_name[role->value - 1] = (char *)key;
-	p->role_val_to_struct[role->value - 1] = role;
+	p->p_role_val_to_name[role->s.value - 1] = (char *)key;
+	p->role_val_to_struct[role->s.value - 1] = role;
 
 	return 0;
 }
@@ -518,10 +518,10 @@ static int type_index(hashtab_key_t key,
 	p = (policydb_t *) datap;
 
 	if (typdatum->primary) {
-		if (!typdatum->value || typdatum->value > p->p_types.nprim)
+		if (!typdatum->s.value || typdatum->s.value > p->p_types.nprim)
 			return -EINVAL;
-		p->p_type_val_to_name[typdatum->value - 1] = (char *)key;
-		p->type_val_to_struct[typdatum->value - 1] = typdatum;
+		p->p_type_val_to_name[typdatum->s.value - 1] = (char *)key;
+		p->type_val_to_struct[typdatum->s.value - 1] = typdatum;
 	}
 
 	return 0;
@@ -535,11 +535,11 @@ static int user_index(hashtab_key_t key,
 	usrdatum = (user_datum_t *) datum;
 	p = (policydb_t *) datap;
 
-	if (!usrdatum->value || usrdatum->value > p->p_users.nprim)
+	if (!usrdatum->s.value || usrdatum->s.value > p->p_users.nprim)
 		return -EINVAL;
 
-	p->p_user_val_to_name[usrdatum->value - 1] = (char *)key;
-	p->user_val_to_struct[usrdatum->value - 1] = usrdatum;
+	p->p_user_val_to_name[usrdatum->s.value - 1] = (char *)key;
+	p->user_val_to_struct[usrdatum->s.value - 1] = usrdatum;
 
 	return 0;
 }
@@ -571,9 +571,9 @@ static int cat_index(hashtab_key_t key, 
 	p = (policydb_t *) datap;
 
 	if (!catdatum->isalias) {
-		if (!catdatum->value || catdatum->value > p->p_cats.nprim)
+		if (!catdatum->s.value || catdatum->s.value > p->p_cats.nprim)
 			return -EINVAL;
-		p->p_cat_val_to_name[catdatum->value - 1] = (char *)key;
+		p->p_cat_val_to_name[catdatum->s.value - 1] = (char *)key;
 	}
 
 	return 0;
@@ -1363,7 +1363,7 @@ static int perm_read(policydb_t * p
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
-	perdatum->value = le32_to_cpu(buf[1]);
+	perdatum->s.value = le32_to_cpu(buf[1]);
 
 	buf = next_entry(fp, len);
 	if (!buf)
@@ -1401,7 +1401,7 @@ static int common_read(policydb_t * p, h
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
-	comdatum->value = le32_to_cpu(buf[1]);
+	comdatum->s.value = le32_to_cpu(buf[1]);
 
 	if (symtab_init(&comdatum->permissions, PERM_SYMTAB_SIZE))
 		goto bad;
@@ -1541,7 +1541,7 @@ static int class_read(policydb_t * p, ha
 
 	len = le32_to_cpu(buf[0]);
 	len2 = le32_to_cpu(buf[1]);
-	cladatum->value = le32_to_cpu(buf[2]);
+	cladatum->s.value = le32_to_cpu(buf[2]);
 
 	if (symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE))
 		goto bad;
@@ -1625,7 +1625,7 @@ static int role_read(policydb_t * p
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
-	role->value = le32_to_cpu(buf[1]);
+	role->s.value = le32_to_cpu(buf[1]);
 
 	buf = next_entry(fp, len);
 	if (!buf)
@@ -1648,9 +1648,9 @@ static int role_read(policydb_t * p
 	}
 
 	if (strcmp(key, OBJECT_R) == 0) {
-		if (role->value != OBJECT_R_VAL) {
+		if (role->s.value != OBJECT_R_VAL) {
 			ERR(fp->handle, "role %s has wrong value %d",
-			    OBJECT_R, role->value);
+			    OBJECT_R, role->s.value);
 			role_destroy(key, role, NULL);
 			return -1;
 		}
@@ -1690,7 +1690,7 @@ static int type_read(policydb_t * p
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
-	typdatum->value = le32_to_cpu(buf[1]);
+	typdatum->s.value = le32_to_cpu(buf[1]);
 	typdatum->primary = le32_to_cpu(buf[2]);
 	if (p->policy_type != POLICY_KERN) {
 		typdatum->flavor = le32_to_cpu(buf[3]);
@@ -2060,7 +2060,7 @@ static int user_read(policydb_t * p, has
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
-	usrdatum->value = le32_to_cpu(buf[1]);
+	usrdatum->s.value = le32_to_cpu(buf[1]);
 
 	buf = next_entry(fp, len);
 	if (!buf)
@@ -2162,7 +2162,7 @@ static int cat_read(policydb_t * p
 		goto bad;
 
 	len = le32_to_cpu(buf[0]);
-	catdatum->value = le32_to_cpu(buf[1]);
+	catdatum->s.value = le32_to_cpu(buf[1]);
 	catdatum->isalias = le32_to_cpu(buf[2]);
 
 	buf = next_entry(fp, len);
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index 3f3f719..5c5fe98 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -768,7 +768,7 @@ static int validate_perm(hashtab_key_t k
 		ERR(NULL, "permission %s disappeared", key);
 		return -1;
 	}
-	if (perdatum->value != perdatum2->value) {
+	if (perdatum->s.value != perdatum2->s.value) {
 		ERR(NULL, "the value of permissions %s changed", key);
 		return -1;
 	}
@@ -794,7 +794,7 @@ static int validate_class(hashtab_key_t 
 		ERR(NULL, "class %s disappeared", key);
 		return -1;
 	}
-	if (cladatum->value != cladatum2->value) {
+	if (cladatum->s.value != cladatum2->s.value) {
 		ERR(NULL, "the value of class %s changed", key);
 		return -1;
 	}
@@ -885,7 +885,7 @@ static int convert_context(sepol_securit
 	if (!usrdatum) {
 		goto bad;
 	}
-	c->user = usrdatum->value;
+	c->user = usrdatum->s.value;
 
 	/* Convert the role. */
 	role = (role_datum_t *) hashtab_search(args->newp->p_roles.table,
@@ -894,7 +894,7 @@ static int convert_context(sepol_securit
 	if (!role) {
 		goto bad;
 	}
-	c->role = role->value;
+	c->role = role->s.value;
 
 	/* Convert the type. */
 	typdatum = (type_datum_t *)
@@ -903,7 +903,7 @@ static int convert_context(sepol_securit
 	if (!typdatum) {
 		goto bad;
 	}
-	c->type = typdatum->value;
+	c->type = typdatum->s.value;
 
 	rc = mls_convert_context(args->oldp, args->newp, c);
 	if (rc)
@@ -1256,7 +1256,7 @@ int hidden sepol_get_user_sids(sepol_sec
 		rc = -EINVAL;
 		goto out;
 	}
-	usercon.user = user->value;
+	usercon.user = user->s.value;
 
 	mysids = malloc(maxnel * sizeof(sepol_security_id_t));
 	if (!mysids) {
diff --git a/libsepol/src/users.c b/libsepol/src/users.c
index 5a4cf72..539d7fc 100644
--- a/libsepol/src/users.c
+++ b/libsepol/src/users.c
@@ -140,10 +140,10 @@ int sepol_user_modify(sepol_handle_t * h
 	/* If it does, we will modify it */
 	if (usrdatum) {
 
-		int value_cp = usrdatum->value;
+		int value_cp = usrdatum->s.value;
 		user_datum_destroy(usrdatum);
 		user_datum_init(usrdatum);
-		usrdatum->value = value_cp;
+		usrdatum->s.value = value_cp;
 
 		/* Otherwise, create a new one */
 	} else {
@@ -249,14 +249,14 @@ int sepol_user_modify(sepol_handle_t * h
 			goto omem;
 
 		/* Store user */
-		usrdatum->value = ++policydb->p_users.nprim;
+		usrdatum->s.value = ++policydb->p_users.nprim;
 		if (hashtab_insert(policydb->p_users.table, name,
 				   (hashtab_datum_t) usrdatum) < 0)
 			goto omem;
 
 		/* Set up reverse entry */
-		policydb->p_user_val_to_name[usrdatum->value - 1] = name;
-		policydb->user_val_to_struct[usrdatum->value - 1] = usrdatum;
+		policydb->p_user_val_to_name[usrdatum->s.value - 1] = name;
+		policydb->user_val_to_struct[usrdatum->s.value - 1] = usrdatum;
 		name = NULL;
 
 		/* Expand roles */
@@ -332,7 +332,7 @@ int sepol_user_query(sepol_handle_t * ha
 		return STATUS_SUCCESS;
 	}
 
-	if (user_to_record(handle, policydb, usrdatum->value - 1, response) < 0)
+	if (user_to_record(handle, policydb, usrdatum->s.value - 1, response) < 0)
 		goto err;
 
 	return STATUS_SUCCESS;
diff --git a/libsepol/src/util.c b/libsepol/src/util.c
index e389a2e..a824e61 100644
--- a/libsepol/src/util.c
+++ b/libsepol/src/util.c
@@ -66,7 +66,7 @@ static int perm_name(hashtab_key_t key, 
 
 	perdatum = (perm_datum_t *) datum;
 
-	if (v->val == perdatum->value) {
+	if (v->val == perdatum->s.value) {
 		v->name = key;
 		return 1;
 	}
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 8134fb7..991e10a 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -398,7 +398,7 @@ static int cat_write(hashtab_key_t key, 
 	len = strlen(key);
 	items = 0;
 	buf[items++] = cpu_to_le32(len);
-	buf[items++] = cpu_to_le32(catdatum->value);
+	buf[items++] = cpu_to_le32(catdatum->s.value);
 	buf[items++] = cpu_to_le32(catdatum->isalias);
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 	if (items != items2)
@@ -505,7 +505,7 @@ static int cond_write_bool(hashtab_key_t
 
 	len = strlen(key);
 	items = 0;
-	buf[items++] = cpu_to_le32(booldatum->value);
+	buf[items++] = cpu_to_le32(booldatum->s.value);
 	buf[items++] = cpu_to_le32(booldatum->state);
 	buf[items++] = cpu_to_le32(len);
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
@@ -691,7 +691,7 @@ static int perm_write(hashtab_key_t key,
 	len = strlen(key);
 	items = 0;
 	buf[items++] = cpu_to_le32(len);
-	buf[items++] = cpu_to_le32(perdatum->value);
+	buf[items++] = cpu_to_le32(perdatum->s.value);
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 	if (items != items2)
 		return -1;
@@ -716,7 +716,7 @@ static int common_write(hashtab_key_t ke
 	len = strlen(key);
 	items = 0;
 	buf[items++] = cpu_to_le32(len);
-	buf[items++] = cpu_to_le32(comdatum->value);
+	buf[items++] = cpu_to_le32(comdatum->s.value);
 	buf[items++] = cpu_to_le32(comdatum->permissions.nprim);
 	buf[items++] = cpu_to_le32(comdatum->permissions.table->nel);
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
@@ -808,7 +808,7 @@ static int class_write(hashtab_key_t key
 	items = 0;
 	buf[items++] = cpu_to_le32(len);
 	buf[items++] = cpu_to_le32(len2);
-	buf[items++] = cpu_to_le32(cladatum->value);
+	buf[items++] = cpu_to_le32(cladatum->s.value);
 	buf[items++] = cpu_to_le32(cladatum->permissions.nprim);
 	if (cladatum->permissions.table)
 		buf[items++] = cpu_to_le32(cladatum->permissions.table->nel);
@@ -868,7 +868,7 @@ static int role_write(hashtab_key_t key,
 	len = strlen(key);
 	items = 0;
 	buf[items++] = cpu_to_le32(len);
-	buf[items++] = cpu_to_le32(role->value);
+	buf[items++] = cpu_to_le32(role->s.value);
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 	if (items != items2)
 		return -1;
@@ -904,7 +904,7 @@ static int type_write(hashtab_key_t key,
 	len = strlen(key);
 	items = 0;
 	buf[items++] = cpu_to_le32(len);
-	buf[items++] = cpu_to_le32(typdatum->value);
+	buf[items++] = cpu_to_le32(typdatum->s.value);
 	buf[items++] = cpu_to_le32(typdatum->primary);
 	if (p->policy_type != POLICY_KERN) {
 		buf[items++] = cpu_to_le32(typdatum->flavor);
@@ -939,7 +939,7 @@ static int user_write(hashtab_key_t key,
 	len = strlen(key);
 	items = 0;
 	buf[items++] = cpu_to_le32(len);
-	buf[items++] = cpu_to_le32(usrdatum->value);
+	buf[items++] = cpu_to_le32(usrdatum->s.value);
 	items2 = put_entry(buf, sizeof(uint32_t), items, fp);
 	if (items != items2)
 		return -1;
-- 
1.4.1

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
