Subject: [RFC 3/3] expander support for hooks
From: Josh Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Content-Type: text/plain
Date: Tue, 01 Aug 2006 07:52:08 -0400
Message-Id: <1154433128.23513.10.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

These are the expander changes, some hooks aren't implemented yet so it
is marked with an XXX comment where I think the enforcement needs to
go. 

diff -pruN -xhooks.c trunk-old/checkpolicy/checkmodule.c trunk/checkpolicy/checkmodule.c
--- trunk-old/checkpolicy/checkmodule.c	2006-08-01 07:27:29.000000000 -0400
+++ trunk/checkpolicy/checkmodule.c	2006-08-01 07:15:52.000000000 -0400
@@ -236,7 +236,7 @@ int main(int argc, char **argv)
 			fprintf(stderr, "%s:  link modules failed\n", argv[0]);
 			exit(1);
 		}
-		if (expand_module(NULL, &modpolicydb, &kernpolicydb, 0, 1)) {
+		if (expand_module(NULL, &modpolicydb, &kernpolicydb, 0, 1, EXPAND_NORMAL)) {
 			fprintf(stderr, "%s:  expand module failed\n", argv[0]);
 			exit(1);
 		}
diff -pruN -xhooks.c trunk-old/checkpolicy/checkpolicy.c trunk/checkpolicy/checkpolicy.c
--- trunk-old/checkpolicy/checkpolicy.c	2006-08-01 07:27:29.000000000 -0400
+++ trunk/checkpolicy/checkpolicy.c	2006-08-01 07:16:01.000000000 -0400
@@ -535,7 +535,7 @@ int main(int argc, char **argv)
 			exit(1);
 		}
 
-		if (expand_module(NULL, &parse_policy, &policydb, 0, 1)) {
+		if (expand_module(NULL, &parse_policy, &policydb, 0, 1, EXPAND_NORMAL)) {
 			fprintf(stderr, "Error while expanding policy\n");
 			exit(1);
 		}
diff -pruN -xhooks.c trunk-old/libsepol/include/sepol/policydb/expand.h trunk/libsepol/include/sepol/policydb/expand.h
--- trunk-old/libsepol/include/sepol/policydb/expand.h	2006-08-01 07:27:29.000000000 -0400
+++ trunk/libsepol/include/sepol/policydb/expand.h	2006-08-01 07:16:26.000000000 -0400
@@ -29,9 +29,13 @@
 #include <sepol/handle.h>
 #include <sepol/policydb/conditional.h>
 
+#define EXPAND_NORMAL 0
+#define EXPAND_CHECK 1
+#define EXPAND_ALL 2
+
 extern int expand_module(sepol_handle_t * handle,
 			 policydb_t * base, policydb_t * out,
-			 int verbose, int check);
+			 int verbose, int check, int expand_type);
 extern int convert_type_ebitmap(ebitmap_t * src, ebitmap_t * dst,
 				uint32_t * typemap);
 extern int expand_convert_type_set(policydb_t * p, uint32_t * typemap,
diff -pruN -xhooks.c trunk-old/libsepol/include/sepol/policydb/policydb.h trunk/libsepol/include/sepol/policydb/policydb.h
--- trunk-old/libsepol/include/sepol/policydb/policydb.h	2006-08-01 07:27:29.000000000 -0400
+++ trunk/libsepol/include/sepol/policydb/policydb.h	2006-08-01 07:17:00.000000000 -0400
@@ -115,6 +115,8 @@ typedef struct role_datum {
 	ebitmap_t dominates;	/* set of roles dominated by this role */
 	type_set_t types;	/* set of authorized types for role */
 	ebitmap_t cache;	/* This is an expanded set used for context validation during parsing */
+	type_set_t all_types;	/* used during policy access control check */
+	ebitmap_t all_doms;	/* used during policy access control check */
 } role_datum_t;
 
 typedef struct role_trans {
@@ -139,6 +141,7 @@ typedef struct type_datum {
 #define TYPE_ALIAS 2		/* alias in modular policy */
 	uint32_t flavor;
 	ebitmap_t types;	/* types with this attribute */
+	ebitmap_t all_types;	/* used during policy access control check */
 } type_datum_t;
 
 /* User attributes */
@@ -148,6 +151,7 @@ typedef struct user_datum {
 	mls_range_t range;	/* MLS range (min. - max.) for user */
 	mls_level_t dfltlevel;	/* default login MLS level for user */
 	ebitmap_t cache;	/* This is an expanded set used for context validation during parsing */
+	role_set_t all_roles;	/* used during policy access control check */
 } user_datum_t;
 
 /* Sensitivity attributes */
@@ -374,6 +378,12 @@ typedef struct policydb {
 	/* Whether this policydb is mls, should always be set */
 	int mls;
 
+	/* Whether this is an invalid policy, currently set when EXPAND_ALL
+	 * is passed to the expander to prevent this policy from being written
+	 * to disk. 
+	 */
+	int invalid;
+
 	/* symbol tables */
 	symtab_t symtab[SYM_NUM];
 #define p_commons symtab[SYM_COMMONS]
diff -pruN -xhooks.c trunk-old/libsepol/src/expand.c trunk/libsepol/src/expand.c
--- trunk-old/libsepol/src/expand.c	2006-08-01 07:27:29.000000000 -0400
+++ trunk/libsepol/src/expand.c	2006-08-01 07:22:40.000000000 -0400
@@ -26,13 +26,17 @@
 #include <sepol/policydb/expand.h>
 #include <sepol/policydb/hierarchy.h>
 #include <sepol/policydb/avrule_block.h>
+#include <sepol/hooks.h>
 
 #include <stdlib.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <string.h>
 #include <assert.h>
+#include <alloca.h>
 
+#include "hooks_internal.h"
+#include "sym_destroy.h"
 #include "debug.h"
 
 typedef struct expand_state {
@@ -41,6 +45,11 @@ typedef struct expand_state {
 	policydb_t *base;
 	policydb_t *out;
 	sepol_handle_t *handle;
+	int expand_type;	/* use EXPAND_* defines from expand.h */
+	int block_disabled;	/* used for policy access control */
+	int copy_disabled;	/* used for policy access control */
+
+	int sym_type;		/* used only when removing disabled symbols */
 } expand_state_t;
 
 static int type_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
@@ -50,6 +59,7 @@ static int type_copy_callback(hashtab_ke
 	char *id, *new_id;
 	type_datum_t *type, *new_type;
 	expand_state_t *state;
+	scope_datum_t *scope;
 
 	id = (char *)key;
 	type = (type_datum_t *) datum;
@@ -60,11 +70,26 @@ static int type_copy_callback(hashtab_ke
 		/* aliases are handled later */
 		return 0;
 	}
-	if (!is_id_enabled(id, state->base, SYM_TYPES)) {
-		/* identifier's scope is not enabled */
+	if (!is_id_enabled(id, state->base, SYM_TYPES) && !state->copy_disabled) {
+		/* identifier's scope is not enabled and no checking is being done */
+		return 0;
+	}
+	new_type = hashtab_search(state->out->p_types.table, id);
+	if (new_type) {
+		/* already copied, move on */	
 		return 0;
 	}
 
+	scope = hashtab_search(state->base->scope[SYM_TYPES].table, id);
+	assert(scope);
+
+	if (scope->scope == SCOPE_DECL && state->expand_type == EXPAND_CHECK) {
+		if (sepol_symbol_add
+				(state->handle, type->flavor == TYPE_ATTRIB ? SEPOL_SEC_ATTRIBS : SEPOL_SEC_TYPES,
+				 id)) { 
+		return -1;
+		}
+	}
 	if (state->verbose)
 		INFO(state->handle, "copying type or attribute %s", id);
 
@@ -121,8 +146,8 @@ static int attr_convert_callback(hashtab
 	if (type->flavor != TYPE_ATTRIB)
 		return 0;
 
-	if (!is_id_enabled(id, state->base, SYM_TYPES)) {
-		/* identifier's scope is not enabled */
+	if (!is_id_enabled(id, state->base, SYM_TYPES) && !state->copy_disabled) {
+		/* identifier's scope is not enabled and checking isn't being done */
 		return 0;
 	}
 
@@ -139,10 +164,19 @@ static int attr_convert_callback(hashtab
 		return -1;
 	}
 
-	/* then union tmp_union onto &new_type->types */
-	if (ebitmap_union(&new_type->types, &tmp_union)) {
-		ERR(state->handle, "Out of memory!");
-		return -1;
+	/* XXX loop through bitmap and call access control hook here */
+
+	/* if this block is disabled we union into all_types, otherwise types */
+	if (state->block_disabled) {
+		if (ebitmap_union(&new_type->all_types, &tmp_union)) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+	} else {
+		if (ebitmap_union(&new_type->types, &tmp_union)) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
 	}
 	ebitmap_destroy(&tmp_union);
 
@@ -327,13 +361,22 @@ static int class_copy_callback(hashtab_k
 	class = (class_datum_t *) datum;
 	state = (expand_state_t *) data;
 
-	if (!is_id_enabled(id, state->base, SYM_CLASSES)) {
-		/* identifier's scope is not enabled */
+	if (!is_id_enabled(id, state->base, SYM_CLASSES) && !state->copy_disabled) {
+		/* identifier's scope is not enabled and checking not being done */
 		return 0;
 	}
 
 	if (state->verbose)
 		INFO(state->handle, "copying class %s", id);
+	new_class = hashtab_search(state->out->p_classes.table, id);
+	if (new_class) {
+		/* already copied, move on */	
+		return 0;
+	}
+
+	if (state->expand_type == EXPAND_CHECK)
+		if (sepol_symbol_add(state->handle, SEPOL_SEC_CLASSES, id))
+			return -1;
 
 	new_class = (class_datum_t *) malloc(sizeof(class_datum_t));
 	if (!new_class) {
@@ -450,6 +493,12 @@ static int alias_copy_callback(hashtab_k
 
 	if (state->verbose)
 		INFO(state->handle, "copying alias %s", id);
+	new_alias = hashtab_search(state->out->p_types.table, id);
+	if (new_alias) {
+		if (new_alias->flavor != TYPE_TYPE && new_alias->flavor != TYPE_ATTRIB)
+			return -1;
+		return 0;
+	}
 
 	new_id = strdup(id);
 	if (!new_id) {
@@ -495,6 +544,7 @@ static int role_copy_callback(hashtab_ke
 	role_datum_t *new_role;
 	expand_state_t *state;
 	ebitmap_t tmp_union_types;
+	scope_datum_t *scope;
 
 	id = key;
 	role = (role_datum_t *) datum;
@@ -503,16 +553,27 @@ static int role_copy_callback(hashtab_ke
 	if (strcmp(id, OBJECT_R) == 0)
 		return 0;
 
-	if (!is_id_enabled(id, state->base, SYM_ROLES)) {
-		/* identifier's scope is not enabled */
+	if (!is_id_enabled(id, state->base, SYM_ROLES) && !state->copy_disabled) {
+		/* identifier is not enabled and checking not being done */
 		return 0;
 	}
 
 	if (state->verbose)
 		INFO(state->handle, "copying role %s", id);
 
-	new_role =
-	    (role_datum_t *) hashtab_search(state->out->p_roles.table, id);
+	new_role = hashtab_search(state->out->p_roles.table, id);
+	if (new_role) {
+		return 0;
+	}
+
+	scope = hashtab_search(state->base->scope[SYM_ROLES].table, id);
+	assert(scope);
+
+	if (scope->scope == SCOPE_DECL && state->expand_type == EXPAND_CHECK) {
+		if (sepol_symbol_add(state->handle, SEPOL_SEC_ROLES, id))
+			return -1;
+	}
+
 	if (!new_role) {
 		new_role = (role_datum_t *) malloc(sizeof(role_datum_t));
 		if (!new_role) {
@@ -544,10 +605,21 @@ static int role_copy_callback(hashtab_ke
 	if (!(&new_role->dominates.node)) {
 		ebitmap_init(&new_role->dominates);
 	}
+	if (!(&new_role->all_doms.node)) {
+		ebitmap_init(&new_role->all_doms);
+	}
 
-	if (ebitmap_union(&new_role->dominates, &role->dominates)) {
-		ERR(state->handle, "Out of memory!");
-		return -1;
+	/* if this block is disabled union into all_doms, otherwise dominates */
+	if (state->block_disabled) {
+		if (ebitmap_union(&new_role->all_doms, &role->dominates)) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+	} else {
+		if (ebitmap_union(&new_role->dominates, &role->dominates)) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
 	}
 
 	ebitmap_init(&tmp_union_types);
@@ -563,11 +635,23 @@ static int role_copy_callback(hashtab_ke
 	if (!(&new_role->types.types.node)) {
 		ebitmap_init(&new_role->types.types);
 	}
+	if (!(&new_role->all_types.types.node)) {
+		ebitmap_init(&new_role->all_types.types);
+	}
 
-	if (ebitmap_union(&new_role->types.types, &tmp_union_types)) {
-		ERR(state->handle, "Out of memory!");
-		ebitmap_destroy(&tmp_union_types);
-		return -1;
+	/* if this block is disabled union into all_types, otherwise types*/
+	if (state->block_disabled) {
+		if (ebitmap_union(&new_role->all_types.types, &tmp_union_types)) {
+			ERR(state->handle, "Out of memory!");
+			ebitmap_destroy(&tmp_union_types);
+			return -1;
+		}
+	} else {
+		if (ebitmap_union(&new_role->types.types, &tmp_union_types)) {
+			ERR(state->handle, "Out of memory!");
+			ebitmap_destroy(&tmp_union_types);
+			return -1;
+		}
 	}
 	ebitmap_destroy(&tmp_union_types);
 
@@ -597,13 +681,21 @@ static int user_copy_callback(hashtab_ke
 	user = (user_datum_t *) datum;
 	state = (expand_state_t *) data;
 
-	if (!is_id_enabled(id, state->base, SYM_USERS)) {
-		/* identifier's scope is not enabled */
+	if (!is_id_enabled(id, state->base, SYM_USERS) && !state->copy_disabled) {
+		/* identifier is not enabled and checking not being done */
 		return 0;
 	}
 
 	if (state->verbose)
 		INFO(state->handle, "copying user %s", id);
+	new_user = hashtab_search(state->out->p_users.table, id);
+	if (new_user) {
+		return 0;
+	}
+
+	if (state->expand_type == EXPAND_CHECK)
+		if (sepol_symbol_add(state->handle, SEPOL_SEC_USERS, id))
+			return -1;
 
 	new_user =
 	    (user_datum_t *) hashtab_search(state->out->p_users.table, id);
@@ -658,11 +750,22 @@ static int user_copy_callback(hashtab_ke
 	if (!(&new_user->roles.roles.node)) {
 		ebitmap_init(&new_user->roles.roles);
 	}
+	if (!(&new_user->all_roles.roles.node)) {
+		ebitmap_init(&new_user->all_roles.roles);
+	}
 
-	if (ebitmap_union(&new_user->roles.roles, &tmp_union)) {
-		ERR(state->handle, "Out of memory!");
-		ebitmap_destroy(&tmp_union);
-		return -1;
+	if (state->block_disabled) {
+		  if (ebitmap_union(&new_user->all_roles.roles, &tmp_union)) {
+			    ERR(state->handle, "Out of memory!");
+			    ebitmap_destroy(&tmp_union);
+			    return -1;
+		  }
+	} else {
+		  if (ebitmap_union(&new_user->roles.roles, &tmp_union)) {
+			    ERR(state->handle, "Out of memory!");
+			    ebitmap_destroy(&tmp_union);
+			    return -1;
+		  }
 	}
 	ebitmap_destroy(&tmp_union);
 
@@ -681,13 +784,21 @@ static int bool_copy_callback(hashtab_ke
 	bool = (cond_bool_datum_t *) datum;
 	state = (expand_state_t *) data;
 
-	if (!is_id_enabled(id, state->base, SYM_BOOLS)) {
-		/* identifier's scope is not enabled */
+	if (!is_id_enabled(id, state->base, SYM_BOOLS) && !state->copy_disabled) {
+		/* identifier is not enabled and checking isn't being done */
 		return 0;
 	}
 
 	if (state->verbose)
 		INFO(state->handle, "copying boolean %s", id);
+	new_bool = hashtab_search(state->out->p_bools.table, id);
+	if (new_bool) {
+		return 0;
+	}
+
+	if (state->expand_type == EXPAND_CHECK)
+		if (sepol_symbol_add(state->handle, SEPOL_SEC_BOOLS, id))
+			return -1;
 
 	new_bool = (cond_bool_datum_t *) malloc(sizeof(cond_bool_datum_t));
 	if (!new_bool) {
@@ -727,13 +838,21 @@ static int sens_copy_callback(hashtab_ke
 	level_datum_t *level = (level_datum_t *) datum, *new_level = NULL;
 	char *id = (char *)key, *new_id = NULL;
 
-	if (!is_id_enabled(id, state->base, SYM_LEVELS)) {
-		/* identifier's scope is not enabled */
+	if (!is_id_enabled(id, state->base, SYM_LEVELS) && !state->copy_disabled) {
+		/* identifier is not enabled and checking isn't being done */
 		return 0;
 	}
 
 	if (state->verbose)
 		INFO(state->handle, "copying senitivity level %s", id);
+	new_level = hashtab_search(state->out->p_levels.table, id);
+	if (new_level) {
+		return 0;
+	}
+
+	if (state->expand_type == EXPAND_CHECK)
+		if (sepol_symbol_add(state->handle, SEPOL_SEC_LEVELS, id))
+			return -1;
 
 	if ((new_level =
 	     (level_datum_t *) calloc(1, sizeof(*new_level))) == NULL
@@ -774,13 +893,21 @@ static int cats_copy_callback(hashtab_ke
 	cat_datum_t *cat = (cat_datum_t *) datum, *new_cat = NULL;
 	char *id = (char *)key, *new_id = NULL;
 
-	if (!is_id_enabled(id, state->base, SYM_CATS)) {
-		/* identifier's scope is not enabled */
+	if (!is_id_enabled(id, state->base, SYM_CATS) && !state->copy_disabled) {
+		/* identifier is not enabled and checking isn't being done */
 		return 0;
 	}
 
 	if (state->verbose)
 		INFO(state->handle, "copying category attribute %s", id);
+	new_cat = hashtab_search(state->out->p_cats.table, id);
+	if (new_cat) {
+		return 0;
+	}
+
+	if (state->expand_type == EXPAND_CHECK)
+		if (sepol_symbol_add(state->handle, SEPOL_SEC_CATS, id))
+			return -1;
 
 	if ((new_cat = (cat_datum_t *) calloc(1, sizeof(*new_cat))) == NULL ||
 	    (new_id = strdup(id)) == NULL) {
@@ -834,6 +961,15 @@ static int copy_role_allows(expand_state
 			ebitmap_for_each_bit(&new_roles, tnode, j) {
 				if (!ebitmap_node_get_bit(tnode, j))
 					continue;
+				if (state->expand_type == EXPAND_CHECK)
+					if (sepol_role_allow_add_check(state->handle, state->out, i, j))
+						return -1;
+
+				/* now continue if this block is disabled unless EXPAND_ALL */
+				if (state->block_disabled && state->expand_type != EXPAND_ALL)  {
+					continue;
+				}
+
 				/* check for duplicates */
 				cur_allow = state->out->role_allow;
 				while (cur_allow) {
@@ -903,6 +1039,15 @@ static int copy_role_trans(expand_state_
 				if (!ebitmap_node_get_bit(tnode, j))
 					continue;
 
+				if (state->expand_type == EXPAND_CHECK)
+					if (sepol_role_trans_check(state->handle, state->out,
+								i, j, cur->new_role - 1))
+						return -1;
+
+				/* now continue if this block is disabled or EXPAND_ALL */
+				if (state->block_disabled && state->expand_type != EXPAND_ALL) 
+					continue;
+
 				cur_trans = state->out->role_tr;
 				while (cur_trans) {
 					if ((cur_trans->role == i + 1) &&
@@ -1007,12 +1152,12 @@ static avtab_ptr_t find_avtab_node(sepol
 	return node;
 }
 
-static int expand_terule_helper(sepol_handle_t * handle,
+static int expand_terule_helper(expand_state_t *state,
 				policydb_t * p, uint32_t * typemap,
 				uint32_t specified, cond_av_list_t ** cond,
 				cond_av_list_t ** other, uint32_t stype,
 				uint32_t ttype, class_perm_node_t * perms,
-				avtab_t * avtab, int enabled)
+				avtab_t * avtab, int enabled, cond_expr_t *expr)
 {
 	avtab_key_t avkey;
 	avtab_datum_t *avdatump;
@@ -1039,6 +1184,7 @@ static int expand_terule_helper(sepol_ha
 		avkey.target_type = ttype + 1;
 		avkey.target_class = cur->class;
 		avkey.specified = spec;
+		/* XXX terule hooks go here, no need to expand, it was already done */
 
 		conflict = 0;
 		/* check to see if the expanded TE already exists --
@@ -1148,7 +1294,66 @@ static int expand_avrule_helper(sepol_ha
 		avkey.target_class = cur->class;
 		avkey.specified = spec;
 
-		node = find_avtab_node(handle, avtab, &avkey, cond);
+		/* av rule hooks go here, must expand source_type and target_type
+		 * incase they are attributes */
+		if (state->expand_type == EXPAND_CHECK && state->handle->sec->avrule_add) {
+			if (state->out->type_val_to_struct[stype]->flavor == TYPE_ATTRIB) {
+				stypes = &state->out->type_val_to_struct[stype]->types;
+			} else {
+				/* we use alloca here so that we don't have to worry about
+				 * whether we allocated the ebitmap or just used the attrib
+				 * pointer and it will get freed on return */
+				stypes = alloca(sizeof(ebitmap_t));
+				if (!stypes) {
+					ERR(state->handle, "Out of memory");
+					return -1;
+				}
+				ebitmap_init(stypes);
+				if (ebitmap_set_bit(stypes, stype, 1)) {
+					ERR(state->handle, "Out of memory");
+					return -1;
+				}
+			}	
+
+			if (state->out->type_val_to_struct[ttype]->flavor == TYPE_ATTRIB) {
+				ttypes = &state->out->type_val_to_struct[ttype]->types;
+			} else {
+				/* we use alloca here so that we don't have to worry about
+				 * whether we allocated the ebitmap or just used the attrib
+				 * pointer and it will get freed on return */
+				ttypes = alloca(sizeof(ebitmap_t));
+				if (!ttypes) {
+					ERR(state->handle, "Out of memory");
+					return -1;
+				}
+				ebitmap_init(ttypes);
+				if (ebitmap_set_bit(ttypes, ttype, 1)) {
+					ERR(state->handle, "Out of memory");
+					return -1;
+				}
+			}
+	
+			ebitmap_for_each_bit(stypes, snode, i) {
+				if (!ebitmap_node_get_bit(snode, i))
+					continue;
+
+				ebitmap_for_each_bit(ttypes, tnode, j) {
+					if (!ebitmap_node_get_bit(tnode, j))
+						continue;
+						
+				if (sepol_avrule_add_check(state->handle, state->out,spec, i + 1, j + 1, cur->class, cur->data))
+					return -1;
+
+				}
+			}
+		}
+
+		if (state->expand_type == EXPAND_CHECK && state->block_disabled) {
+			/* continue without adding rule since we only want to check */
+			continue;
+		}
+
+		node = find_avtab_node(state->handle, avtab, &avkey, cond);
 		if (!node)
 			return -1;
 		if (enabled) {
@@ -1278,7 +1483,8 @@ static int convert_and_expand_rule(sepol
 
 	/* Force expansion for type rules and for self rules. */
 	alwaysexpand = ((source_rule->specified & AVRULE_TYPE) ||
-			(source_rule->flags & RULE_SELF));
+			(source_rule->flags & RULE_SELF) ||
+			(state->expand_type == EXPAND_ALL));
 
 	if (expand_convert_type_set
 	    (dest_pol, typemap, &source_rule->stypes, &stypes, alwaysexpand))
@@ -1340,16 +1546,26 @@ static int cond_node_copy(expand_state_t
 		return -1;
 	}
 
-	if (cond_avrule_list_copy
-	    (state->out, cn->avtrue_list, &state->out->te_cond_avtab,
-	     &new_cond->true_list, &new_cond->false_list, state->typemap,
-	     new_cond->cur_state, state))
-		return -1;
-	if (cond_avrule_list_copy
-	    (state->out, cn->avfalse_list, &state->out->te_cond_avtab,
-	     &new_cond->false_list, &new_cond->true_list, state->typemap,
-	     !new_cond->cur_state, state))
-		return -1;
+	/* must do both the true and false lists incase we are checking or expanding */
+	cur = cn->avtrue_list;
+	while (cur) {
+		if (convert_and_expand_rule(state, state->out,
+					    state->typemap, cur, &state->out->te_cond_avtab,
+					    &new_cond->true_list, &new_cond->false_list, 
+					    cn->cur_state, cn->expr) != 1) {
+			return -1;
+		}
+		cur = cur->next;
+	}
+	cur = cn->avfalse_list;
+	while (cur) {
+		if (convert_and_expand_rule(state, state->out,
+					    state->typemap, cur, &state->out->te_cond_avtab,
+					    &new_cond->false_list, &new_cond->true_list, !cn->cur_state, cn->expr) != 1) {
+			return -1;
+		}
+		cur = cur->next;
+	}
 
 	return 0;
 }
@@ -1371,6 +1587,8 @@ static int ocontext_copy(expand_state_t 
 	for (i = 0; i < OCON_NUM; i++) {
 		l = NULL;
 		for (c = state->base->ocontexts[i]; c; c = c->next) {
+			/* XXX ocontext enforcement hook goes here */
+
 			n = malloc(sizeof(ocontext_t));
 			if (!n) {
 				ERR(state->handle, "Out of memory!");
@@ -1443,6 +1661,8 @@ static int genfs_copy(expand_state_t * s
 
 	end = NULL;
 	for (genfs = state->base->genfs; genfs; genfs = genfs->next) {
+		/* XXX genfs enforcement hook goes here */
+
 		newgenfs = malloc(sizeof(genfs_t));
 		if (!newgenfs) {
 			ERR(state->handle, "Out of memory!");
@@ -1496,6 +1716,8 @@ static int range_trans_clone(expand_stat
 		INFO(state->handle, "copying range transitions");
 
 	while (range != NULL) {
+		/* XXX range trans enforcement hook goes here */
+
 		if ((new_range = malloc(sizeof(*new_range))) == NULL) {
 			goto out_of_mem;
 		}
@@ -1884,175 +2106,259 @@ static int copy_neverallow(policydb_t * 
 	return -1;
 }
 
-/* Linking should always be done before calling expand, even if
- * there is only a base since all optionals are dealt with at link time
- * the base passed in should be indexed and avrule blocks should be 
- * enabled.
- */
-int expand_module(sepol_handle_t * handle,
-		  policydb_t * base, policydb_t * out, int verbose, int check)
+int copy_symbols(expand_state_t *state, policydb_t *out, int verbose)
 {
-	int retval = -1;
-	unsigned int i;
-	expand_state_t state;
-	avrule_block_t *curblock;
-
-	state.verbose = verbose;
-	state.typemap = NULL;
-	state.base = base;
-	state.out = out;
-	state.handle = handle;
-
-	if (base->policy_type != POLICY_BASE) {
-		ERR(handle, "Target of expand was not a base policy.");
-		return -1;
-	}
-
-	state.out->policy_type = POLICY_KERN;
-	state.out->policyvers = POLICYDB_VERSION_MAX;
-
-	/* Copy mls state from base to out */
-	out->mls = base->mls;
-
-	if ((state.typemap =
-	     (uint32_t *) calloc(state.base->p_types.nprim,
-				 sizeof(uint32_t))) == NULL) {
-		ERR(handle, "Out of memory!");
-		goto cleanup;
-	}
-
-	/* order is important - types must be first */
-
 	/* copy types */
-	if (hashtab_map(state.base->p_types.table, type_copy_callback, &state)) {
+	if (hashtab_map(state->base->p_types.table, type_copy_callback, state)) {
 		goto cleanup;
 	}
 
 	/* convert attribute type sets */
 	if (hashtab_map
-	    (state.base->p_types.table, attr_convert_callback, &state)) {
+	    (state->base->p_types.table, attr_convert_callback, state)) {
 		goto cleanup;
 	}
 
 	/* copy commons */
 	if (hashtab_map
-	    (state.base->p_commons.table, common_copy_callback, &state)) {
+	    (state->base->p_commons.table, common_copy_callback, state)) {
 		goto cleanup;
 	}
 
 	/* copy classes, note, this does not copy constraints, constraints can't be
 	 * copied until after all the blocks have been processed and attributes are complete */
 	if (hashtab_map
-	    (state.base->p_classes.table, class_copy_callback, &state)) {
+	    (state->base->p_classes.table, class_copy_callback, state)) {
 		goto cleanup;
 	}
 
 	/* copy aliases */
-	if (hashtab_map(state.base->p_types.table, alias_copy_callback, &state))
+	if (hashtab_map(state->base->p_types.table, alias_copy_callback, state))
 		goto cleanup;
 
-	/* index here so that type indexes are available for role_copy_callback */
-	if (policydb_index_others(handle, out, verbose)) {
-		ERR(handle, "Error while indexing out symbols");
+	/* index types here for role_copy_callback, only types can be indexed since only
+	 * they are being remapped, in the access check case the other tables will be
+	 * in a possibly inconsistent state wrt values and nprim */
+	if (policydb_index_types(out)) {
+		ERR(state->handle, "Error while indexing types");
 		goto cleanup;
 	}
 
 	/* copy roles */
-	if (hashtab_map(state.base->p_roles.table, role_copy_callback, &state))
+	if (hashtab_map(state->base->p_roles.table, role_copy_callback, state))
 		goto cleanup;
 
 	/* copy users */
-	if (hashtab_map(state.base->p_users.table, user_copy_callback, &state))
+	if (hashtab_map(state->base->p_users.table, user_copy_callback, state))
 		goto cleanup;
 
 	/* copy bools */
-	if (hashtab_map(state.base->p_bools.table, bool_copy_callback, &state))
+	if (hashtab_map(state->base->p_bools.table, bool_copy_callback, state))
 		goto cleanup;
 
 	/* now copy MLS's sensitivity level and categories */
-	if (hashtab_map(state.base->p_levels.table, sens_copy_callback, &state)
-	    || hashtab_map(state.base->p_cats.table, cats_copy_callback,
-			   &state)) {
+	if (hashtab_map(state->base->p_levels.table, sens_copy_callback, state))
+		goto cleanup;
+	if (hashtab_map(state->base->p_cats.table, cats_copy_callback, state))
 		goto cleanup;
+
+
+	return 0;
+
+cleanup:
+	return -1;
+}
+
+
+static int disabled_sym_remove(hashtab_key_t key
+			    __attribute__ ((unused)), hashtab_datum_t datum,
+			    void *args)
+{
+	expand_state_t *state = (expand_state_t *)args;
+
+	if (!is_id_enabled((char *)key, state->base, state->sym_type)) {
+printf("removing disabled symbol type %d name %s\n",state->sym_type, key);
+		return 1;
+}
+	return 0;
+}				
+
+void remove_disabled_symbols(expand_state_t *state)
+{
+	int i;
+	
+	for (i = SYM_ROLES; i < SYM_NUM; i++) {
+		state->sym_type = i;
+		hashtab_map_remove_on_error(state->out->symtab[i].table,
+				disabled_sym_remove, destroy_f[i], state);
 	}
+}
 
-	if (policydb_index_classes(out)) {
-		ERR(handle, "Error while indexing out classes");
+/* Linking should always be done before calling expand, even if
+ * there is only a base since all optionals are dealt with at link time
+ * the base passed in should be indexed and avrule blocks should be 
+ * enabled. expand_type is used for access control checking, it uses 
+ * the EXPAND_* defines from expand.h. EXPAND_NORMAL is a standard expansion, 
+ * EXPAND_CHECK calls access control callbacks and EXPAND_ALL expands
+ * all enable and disabled blocks, and inserts them into the policy.
+ * EXPAND_ALL builds a potentially invalid policy and should never be 
+ * written to disk.
+ */
+int expand_module(sepol_handle_t * handle, policydb_t * base, policydb_t * out,
+			 int verbose, int check, int expand_type)
+{
+	int retval = -1;
+	unsigned int i;
+	expand_state_t state;
+	avrule_block_t *curblock;
+	avrule_decl_t *decl;
+	avrule_t *cur_avrule;
+
+	state.verbose = verbose;
+	state.typemap = NULL;
+	state.base = base;
+	state.out = out;
+	state.block_disabled = 0;
+	state.copy_disabled = 0;
+	state.expand_type = expand_type;
+
+	if (handle)
+		state.handle = handle;
+
+	if (expand_type == EXPAND_CHECK && (!handle || !handle->sec)) {
+		ERR(handle, "EXPAND_CHECK specified but no handle passed in");
+		return -1;
+	}
+
+	/* mark this policy invalid so it can't be written if EXPAND_ALL was used */
+	if (expand_type == EXPAND_ALL)
+		out->invalid = 1;
+
+	if (base->policy_type != POLICY_BASE) {
+		ERR(handle, "Target of expand was not a base policy.");
+		return -1;
+	}
+
+	state.out->policy_type = POLICY_KERN;
+	state.out->policyvers = POLICYDB_VERSION_MAX;
+
+	/* Copy mls state from base to out */
+	out->mls = base->mls;
+
+	if ((state.typemap =
+	     (uint32_t *) calloc(state.base->p_types.nprim,
+				 sizeof(uint32_t))) == NULL) {
+		ERR(handle, "Out of memory!");
 		goto cleanup;
 	}
+
+	/* first copy all the enabled symbols */
+	if (copy_symbols(&state, out, verbose))
+		goto cleanup;
+	/* next if we are doing a policy access check copy the rest of the symbols 
+	 * this is only done to push disabled symbols (only types at this time
+	 * since they are the only mapped symbols) to the end values so that they
+	 * can be removed later without creating holes in the hashtables */
+	if (expand_type == EXPAND_CHECK || expand_type == EXPAND_ALL) {
+		state.copy_disabled = 1;
+		if (copy_symbols(&state, out, verbose))
+			goto cleanup;
+	}
+
 	if (policydb_index_others(handle, out, verbose)) {
 		ERR(handle, "Error while indexing out symbols");
 		goto cleanup;
 	}
 
+	if (policydb_index_classes(out)) {
+		ERR(handle, "Error while indexing out classes");
+		goto cleanup;
+	}
+	if (expand_type == EXPAND_CHECK) {
+		if (sepol_security_create_maps(out, handle->sec)) {
+			ERR(handle, "Error while creating symbol maps");
+			goto cleanup;
+		}
+	}
+
 	/* loop through all decls and union attributes, roles, users */
 	for (curblock = state.base->global; curblock != NULL;
 	     curblock = curblock->next) {
 		avrule_decl_t *decl = curblock->enabled;
 
-		if (decl == NULL) {
-			/* nothing was enabled within this block */
-			continue;
-		}
+		/* We loop through all decl's incase we need to expand the disabled ones also */
+		for (decl = curblock->branch_list; decl != NULL; decl = decl->next) {
 
-		/* convert attribute type sets */
-		if (hashtab_map
-		    (decl->p_types.table, attr_convert_callback, &state)) {
-			goto cleanup;
-		}
+			if (!decl->enabled && expand_type == EXPAND_NORMAL) {
+				/* nothing was enabled within this block
+				 * or we are checking everything */
+				continue;
+			}
+			state.block_disabled = (decl->enabled)? 0:1;
 
-		/* copy roles */
-		if (hashtab_map
-		    (decl->p_roles.table, role_copy_callback, &state))
-			goto cleanup;
+			/* convert attribute type sets */
+			if (hashtab_map
+					(decl->p_types.table, attr_convert_callback, &state)) {
+				goto cleanup;
+			}
 
-		/* copy users */
-		if (hashtab_map
-		    (decl->p_users.table, user_copy_callback, &state))
-			goto cleanup;
+			/* copy roles */
+			if (hashtab_map
+					(decl->p_roles.table, role_copy_callback, &state))
+				goto cleanup;
+
+			/* copy users */
+			if (hashtab_map
+					(decl->p_users.table, user_copy_callback, &state))
+				goto cleanup;
 
+		}
 	}
 
-	/* then loop through delcs to copy and expand rules */
+	/* then loop through decls to copy and expand rules */
 	for (curblock = state.base->global; curblock != NULL;
 	     curblock = curblock->next) {
-		avrule_decl_t *decl = curblock->enabled;
-		avrule_t *cur_avrule;
-
-		if (decl == NULL) {
-			/* nothing was enabled within this block */
-			continue;
-		}
+		/* We loop through all decl's incase we need to expand the disabled ones also */
+		for (decl = curblock->branch_list; decl != NULL; decl = decl->next) {
 
-		/* copy role allows and role trans */
-		if (copy_role_allows(&state, decl->role_allow_rules) != 0 ||
-		    copy_role_trans(&state, decl->role_tr_rules) != 0) {
-			goto cleanup;
-		}
+			if (!decl->enabled && expand_type == EXPAND_NORMAL) {
+				/* nothing was enabled within this block
+				 * and we aren't checking everything */
+				continue;
+			}
+			state.block_disabled = (decl->enabled)? 0:1;
 
-		/* copy rules */
-		cur_avrule = decl->avrules;
-		while (cur_avrule != NULL) {
-			if (cur_avrule->specified & AVRULE_NEVERALLOW) {
-				/* copy this over directly so that assertions are checked later */
-				if (copy_neverallow
-				    (out, state.typemap, cur_avrule))
-					ERR(handle,
-					    "Error while copying neverallow.");
-			} else {
-				if (convert_and_expand_rule
-				    (state.handle, out, state.typemap,
-				     cur_avrule, &out->te_avtab, NULL, NULL,
-				     0) != 1) {
-					goto cleanup;
+			/* copy role allows and role trans */
+			if (copy_role_allows(&state, decl->role_allow_rules))
+				goto cleanup;
+
+			if (copy_role_trans(&state, decl->role_tr_rules)) {
+				goto cleanup;
+			}
+
+			/* copy rules */
+			cur_avrule = decl->avrules;
+			while (cur_avrule != NULL) {
+				if (cur_avrule->specified & AVRULE_NEVERALLOW) {
+					/* copy this over directly so that assertions are checked later */
+					if (copy_neverallow
+							(out, state.typemap, cur_avrule))
+						ERR(handle,
+								"Error while copying neverallow.");
+				} else {
+					if (convert_and_expand_rule
+							(&state, out, state.typemap,
+							 cur_avrule, &out->te_avtab, NULL, NULL,
+							 0, NULL) != 1) {
+						goto cleanup;
+					}
 				}
+				cur_avrule = cur_avrule->next;
 			}
-			cur_avrule = cur_avrule->next;
+			/* copy conditional rules */
+			if (cond_node_copy(&state, decl->cond_list))
+				goto cleanup;
 		}
-
-		/* copy conditional rules */
-		if (cond_node_copy(&state, decl->cond_list))
-			goto cleanup;
 	}
 
 	/* copy constraints */
@@ -2098,6 +2404,10 @@ int expand_module(sepol_handle_t * handl
 		goto cleanup;
 	hashtab_map_remove_on_error(state.out->p_types.table,
 				    type_attr_remove, type_destroy, state.out);
+	/* when checking policies all symbols get added so we remove disabled ones now */
+	if (expand_type == EXPAND_CHECK) 
+		remove_disabled_symbols(&state);
+
 	if (check) {
 		if (hierarchy_check_constraints(handle, state.out))
 			goto cleanup;
diff -pruN -xhooks.c trunk-old/libsepol/src/handle.c trunk/libsepol/src/handle.c
--- trunk-old/libsepol/src/handle.c	2006-08-01 07:27:29.000000000 -0400
+++ trunk/libsepol/src/handle.c	2006-08-01 07:23:41.000000000 -0400
@@ -1,6 +1,7 @@
 #include <stdlib.h>
 #include "handle.h"
 #include "debug.h"
+#include "hooks_internal.h"
 
 sepol_handle_t *sepol_handle_create(void)
 {
@@ -13,6 +14,12 @@ sepol_handle_t *sepol_handle_create(void
 	sh->msg_callback = sepol_msg_default_handler;
 	sh->msg_callback_arg = NULL;
 
+	sh->sec = malloc(sizeof(*sh->sec));
+	if (!sh->sec) {
+		free(sh);
+		return NULL;
+	}
+	sepol_init_security_ops(sh->sec);
 	return sh;
 }
 
diff -pruN -xhooks.c trunk-old/libsepol/src/handle.h trunk/libsepol/src/handle.h
--- trunk-old/libsepol/src/handle.h	2006-08-01 07:27:29.000000000 -0400
+++ trunk/libsepol/src/handle.h	2006-08-01 07:23:49.000000000 -0400
@@ -2,6 +2,7 @@
 #define _SEPOL_INTERNAL_HANDLE_H_
 
 #include <sepol/handle.h>
+#include <sepol/hooks.h>
 
 struct sepol_handle {
 	/* Error handling */
@@ -14,6 +15,7 @@ struct sepol_handle {
 	void (*msg_callback) (void *varg,
 			      sepol_handle_t * handle, const char *fmt, ...);
 	void *msg_callback_arg;
+	sepol_security_ops_t *sec;
 };
 
 #endif
diff -pruN -xhooks.c trunk-old/libsepol/src/write.c trunk/libsepol/src/write.c
--- trunk-old/libsepol/src/write.c	2006-07-03 10:42:01.000000000 -0400
+++ trunk/libsepol/src/write.c	2006-08-01 07:27:20.000000000 -0400
@@ -1414,6 +1414,9 @@ int policydb_write(policydb_t * p, struc
 	pd.fp = fp;
 	pd.p = p;
 
+	if (p->invalid)
+		return -1;
+
 	config = 0;
 	if (p->mls)
 		config |= POLICYDB_CONFIG_MLS;



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
