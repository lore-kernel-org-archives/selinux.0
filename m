Message-ID: <44FD8A98.3050708@trustedcs.com>
Date: Tue, 05 Sep 2006 09:32:56 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Christopher PeBenito <cpebenito@tresys.com>
Subject: [PATCH 2/3 v3] semantic MLS representation for range_trans_rules
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here is a third take on this patch.  The changes are:
- properly convert values to LE for disk representation

---

Introduce a semantic representation for MLS levels and ranges to be used in
modular policy formats.  This will allow expansion of levels such as "s0:c1.c5"
to happen at module expansion time.  The range_trans_rules were updated to use
this new semantic format.

All range_transitions are now represented as range_trans_rules when in a modular
format (old range_trans structs are converted when the policy is read).  The
semantic rules are expanded along with other rules when the module is expanded.

The ebitmap used for classes in the range_trans_rules has also been fixed to use
the standard "value - 1" indexing.


Signed-off-by:  Darrel Goeddel <dgoeddel@trustedcs.com>
 checkpolicy/policy_parse.y                  |   77 ++++++++++--
 libsepol/include/sepol/policydb/expand.h    |    4
 libsepol/include/sepol/policydb/mls_types.h |   25 +++
 libsepol/include/sepol/policydb/policydb.h  |    2
 libsepol/src/expand.c                       |  163 ++++++++++++++-----------
 libsepol/src/mls.c                          |   91 ++++++++++++++
 libsepol/src/policydb.c                     |  177 +++++++++++++++++++++++++++-
 libsepol/src/write.c                        |   51 +++++++-
 8 files changed, 497 insertions(+), 93 deletions(-)


diff --exclude=.svn -ruNp selinux-list/checkpolicy/policy_parse.y selinux-rangetrans-3/checkpolicy/policy_parse.y
--- selinux-list/checkpolicy/policy_parse.y	2006-08-25 06:16:11.000000000 -0500
+++ selinux-rangetrans-3/checkpolicy/policy_parse.y	2006-09-01 11:58:25.000000000 -0500
@@ -3616,6 +3616,65 @@ parse_categories(char *id, level_datum_t
 	return 0;
 }
 
+static int
+parse_semantic_categories(char *id, level_datum_t * levdatum,
+                          mls_semantic_cat_t ** cats)
+{
+	cat_datum_t *cdatum;
+	mls_semantic_cat_t *newcat;
+	unsigned int range_start, range_end;
+
+	if (id_has_dot(id)) {
+		char *id_start = id;
+		char *id_end = strchr(id, '.');
+
+		*(id_end++) = '\0';
+
+		cdatum = (cat_datum_t *) hashtab_search(policydbp->p_cats.table,
+							(hashtab_key_t)
+							id_start);
+		if (!cdatum) {
+			sprintf(errormsg, "unknown category %s", id_start);
+			yyerror(errormsg);
+			return -1;
+		}
+		range_start = cdatum->s.value;
+
+		cdatum = (cat_datum_t *) hashtab_search(policydbp->p_cats.table,
+							(hashtab_key_t) id_end);
+		if (!cdatum) {
+			sprintf(errormsg, "unknown category %s", id_end);
+			yyerror(errormsg);
+			return -1;
+		}
+		range_end = cdatum->s.value;
+	} else {
+		cdatum = (cat_datum_t *) hashtab_search(policydbp->p_cats.table,
+							(hashtab_key_t) id);
+		if (!cdatum) {
+			sprintf(errormsg, "unknown category %s", id);
+			yyerror(errormsg);
+			return -1;
+		}
+		range_start = range_end = cdatum->s.value;
+	}
+
+	newcat = (mls_semantic_cat_t *) malloc(sizeof(mls_semantic_cat_t));
+	if (!newcat) {
+		yyerror("out of memory");
+		return -1;
+	}
+
+	mls_semantic_cat_init(newcat);
+	newcat->next = *cats;
+	newcat->low = range_start;
+	newcat->high = range_end;
+
+	*cats = newcat;
+
+	return 0;
+}
+
 static int define_user(void)
 {
 	char *id;
@@ -4541,7 +4600,7 @@ static int define_range_trans(int class_
 				goto out;
 			}
 
-			ebitmap_set_bit(&rule->tclasses, cladatum->s.value,
+			ebitmap_set_bit(&rule->tclasses, cladatum->s.value - 1,
 			                TRUE);
 			free(id);
 		}
@@ -4555,7 +4614,7 @@ static int define_range_trans(int class_
 			goto out;
 		}
 
-		ebitmap_set_bit(&rule->tclasses, cladatum->s.value, TRUE);
+		ebitmap_set_bit(&rule->tclasses, cladatum->s.value - 1, TRUE);
 	}
 
 	id = (char *)queue_remove(id_queue);
@@ -4574,11 +4633,12 @@ static int define_range_trans(int class_
 			goto out;
 		}
 		free(id);
+
 		rule->trange.level[l].sens = levdatum->level->sens;
 
 		while ((id = queue_remove(id_queue))) {
-			if (parse_categories(id, levdatum,
-			                     &rule->trange.level[l].cat)) {
+			if (parse_semantic_categories(id, levdatum,
+			                          &rule->trange.level[l].cat)) {
 				free(id);
 				goto out;
 			}
@@ -4590,17 +4650,12 @@ static int define_range_trans(int class_
 			break;
 	}
 	if (l == 0) {
-		if (mls_level_cpy(&rule->trange.level[1],
-		                  &rule->trange.level[0])) {
+		if (mls_semantic_level_cpy(&rule->trange.level[1],
+		                           &rule->trange.level[0])) {
 			yyerror("out of memory");
 			goto out;
 		}
 	}
-	if (!mls_level_dom(&rule->trange.level[1], &rule->trange.level[0])) {
-		yyerror("range_transition high level does not dominate "
-		        "low level");
-		goto out;
-	}
 
 	append_range_trans(rule);
 	return 0;
diff --exclude=.svn -ruNp selinux-list/libsepol/include/sepol/policydb/expand.h selinux-rangetrans-3/libsepol/include/sepol/policydb/expand.h
--- selinux-list/libsepol/include/sepol/policydb/expand.h	2006-08-25 06:16:10.000000000 -0500
+++ selinux-rangetrans-3/libsepol/include/sepol/policydb/expand.h	2006-09-01 11:58:22.000000000 -0500
@@ -58,6 +58,10 @@ extern int expand_convert_type_set(polic
 extern int type_set_expand(type_set_t * set, ebitmap_t * t, policydb_t * p,
 			   unsigned char alwaysexpand);
 extern int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * p);
+extern int mls_semantic_level_expand(mls_semantic_level_t *sl, mls_level_t *l,
+                                     policydb_t *p, sepol_handle_t *h);
+extern int mls_semantic_range_expand(mls_semantic_range_t *sr, mls_range_t *r,
+                                     policydb_t *p, sepol_handle_t *h);
 extern int expand_rule(sepol_handle_t * handle,
 		       policydb_t * source_pol,
 		       avrule_t * source_rule, avtab_t * dest_avtab,
diff --exclude=.svn -ruNp selinux-list/libsepol/include/sepol/policydb/mls_types.h selinux-rangetrans-3/libsepol/include/sepol/policydb/mls_types.h
--- selinux-list/libsepol/include/sepol/policydb/mls_types.h	2006-08-25 06:16:10.000000000 -0500
+++ selinux-rangetrans-3/libsepol/include/sepol/policydb/mls_types.h	2006-09-01 11:58:22.000000000 -0500
@@ -32,6 +32,7 @@
 #define _SEPOL_POLICYDB_MLS_TYPES_H_
 
 #include <stdint.h>
+#include <stdlib.h>
 #include <sepol/policydb/ebitmap.h>
 #include <sepol/policydb/flask_types.h>
 
@@ -125,4 +126,28 @@ static inline int mls_range_eq(struct ml
 	        mls_level_eq(&r1->level[1], &r2->level[1]));
 }
 
+typedef struct mls_semantic_cat {
+	uint32_t low;	/* first bit this struct represents */
+	uint32_t high;	/* last bit represented - equals low for a single cat */
+	struct mls_semantic_cat *next;
+} mls_semantic_cat_t;
+
+typedef struct mls_semantic_level {
+	uint32_t sens;
+	mls_semantic_cat_t *cat;
+} mls_semantic_level_t;
+
+typedef struct mls_semantic_range {
+	mls_semantic_level_t level[2];
+} mls_semantic_range_t;
+
+extern void mls_semantic_cat_init(mls_semantic_cat_t *c);
+extern void mls_semantic_cat_destroy(mls_semantic_cat_t *c);
+extern void mls_semantic_level_init(mls_semantic_level_t *l);
+extern void mls_semantic_level_destroy(mls_semantic_level_t *l);
+extern int mls_semantic_level_cpy(mls_semantic_level_t *dst, mls_semantic_level_t *src);
+extern void mls_semantic_range_init(mls_semantic_range_t *r);
+extern void mls_semantic_range_destroy(mls_semantic_range_t *r);
+extern int mls_semantic_range_cpy(mls_semantic_range_t *dst, mls_semantic_range_t *src);
+
 #endif
diff --exclude=.svn -ruNp selinux-list/libsepol/include/sepol/policydb/policydb.h selinux-rangetrans-3/libsepol/include/sepol/policydb/policydb.h
--- selinux-list/libsepol/include/sepol/policydb/policydb.h	2006-08-25 06:16:10.000000000 -0500
+++ selinux-rangetrans-3/libsepol/include/sepol/policydb/policydb.h	2006-09-01 11:58:22.000000000 -0500
@@ -233,7 +233,7 @@ typedef struct range_trans_rule {
 	type_set_t stypes;
 	type_set_t ttypes;
 	ebitmap_t tclasses;
-	mls_range_t trange;
+	mls_semantic_range_t trange;
 	struct range_trans_rule *next;
 } range_trans_rule_t;
 
diff --exclude=.svn -ruNp selinux-list/libsepol/src/expand.c selinux-rangetrans-3/libsepol/src/expand.c
--- selinux-list/libsepol/src/expand.c	2006-08-25 06:16:43.000000000 -0500
+++ selinux-rangetrans-3/libsepol/src/expand.c	2006-09-01 11:58:23.000000000 -0500
@@ -580,12 +580,64 @@ static int role_copy_callback(hashtab_ke
 	return 0;
 }
 
-static int mls_level_clone(mls_level_t * dst, mls_level_t * src)
+int mls_semantic_level_expand(mls_semantic_level_t * sl, mls_level_t * l,
+			      policydb_t * p, sepol_handle_t * h)
 {
-	dst->sens = src->sens;
-	if (ebitmap_cpy(&dst->cat, &src->cat)) {
+	mls_semantic_cat_t *cat;
+	level_datum_t *levdatum;
+	unsigned int i;
+
+	mls_level_init(l);
+
+	if (!p->mls)
+		return 0;
+
+	l->sens = sl->sens;
+	levdatum = (level_datum_t *) hashtab_search(p->p_levels.table,
+						    p->p_sens_val_to_name[l->
+									  sens -
+									  1]);
+	for (cat = sl->cat; cat; cat = cat->next) {
+		if (cat->low > cat->high) {
+			ERR(h, "Category range is not valid %s.%s",
+			    p->p_cat_val_to_name[cat->low - 1],
+			    p->p_cat_val_to_name[cat->high - 1]);
+			return -1;
+		}
+		for (i = cat->low - 1; i < cat->high; i++) {
+			if (!ebitmap_get_bit(&levdatum->level->cat, i)) {
+				ERR(h, "Category %s can not be associate with "
+				    "level %s",
+				    p->p_cat_val_to_name[i],
+				    p->p_sens_val_to_name[l->sens - 1]);
+			}
+			if (ebitmap_set_bit(&l->cat, i, 1)) {
+				ERR(h, "Out of memory!");
+				return -1;
+			}
+		}
+	}
+
+	return 0;
+}
+
+int mls_semantic_range_expand(mls_semantic_range_t * sr, mls_range_t * r,
+			      policydb_t * p, sepol_handle_t * h)
+{
+	if (mls_semantic_level_expand(&sr->level[0], &r->level[0], p, h) < 0)
+		return -1;
+
+	if (mls_semantic_level_expand(&sr->level[1], &r->level[1], p, h) < 0) {
+		mls_semantic_level_destroy(&sr->level[0]);
+		return -1;
+	}
+
+	if (!mls_level_dom(&r->level[1], &r->level[0])) {
+		mls_range_destroy(r);
+		ERR(h, "MLS range high level does not dominate low level");
 		return -1;
 	}
+
 	return 0;
 }
 
@@ -641,12 +693,9 @@ static int user_copy_callback(hashtab_ke
 		}
 
 		/* clone MLS stuff */
-		if (mls_level_clone
-		    (&new_user->range.level[0], &user->range.level[0]) == -1
-		    || mls_level_clone(&new_user->range.level[1],
-				       &user->range.level[1]) == -1
-		    || mls_level_clone(&new_user->dfltlevel,
-				       &user->dfltlevel) == -1) {
+		if (mls_range_cpy(&new_user->range, &user->range) == -1
+		    || mls_level_cpy(&new_user->dfltlevel,
+				     &user->dfltlevel) == -1) {
 			ERR(state->handle, "Out of memory!");
 			return -1;
 		}
@@ -749,7 +798,7 @@ static int sens_copy_callback(hashtab_ke
 		goto out_of_mem;
 	}
 
-	if (mls_level_clone(new_level->level, level->level)) {
+	if (mls_level_cpy(new_level->level, level->level)) {
 		goto out_of_mem;
 	}
 	new_level->isalias = level->isalias;
@@ -965,16 +1014,23 @@ static int copy_role_trans(expand_state_
 }
 
 static int exp_rangetr_helper(uint32_t stype, uint32_t ttype, uint32_t tclass,
-			      mls_range_t * trange, expand_state_t * state)
+			      mls_semantic_range_t * trange,
+			      expand_state_t * state)
 {
 	range_trans_t *rt, *check_rt = state->out->range_tr;
+	mls_range_t exp_range;
+	int rc = -1;
+
+	if (mls_semantic_range_expand(trange, &exp_range, state->out,
+				      state->handle))
+		goto out;
 
 	/* check for duplicates/conflicts */
 	while (check_rt) {
 		if ((check_rt->source_type == stype) &&
 		    (check_rt->target_type == ttype) &&
 		    (check_rt->target_class == tclass)) {
-			if (mls_range_eq(&check_rt->target_range, trange)) {
+			if (mls_range_eq(&check_rt->target_range, &exp_range)) {
 				/* duplicate */
 				break;
 			} else {
@@ -983,19 +1039,23 @@ static int exp_rangetr_helper(uint32_t s
 				    "Conflicting range trans rule %s %s : %s",
 				    state->out->p_type_val_to_name[stype - 1],
 				    state->out->p_type_val_to_name[ttype - 1],
-				    state->out->p_class_val_to_name[tclass]);
-				return -1;
+				    state->out->p_class_val_to_name[tclass -
+								    1]);
+				goto out;
 			}
 		}
 		check_rt = check_rt->next;
 	}
-	if (check_rt)		/* this is a dup - skip */
-		return 0;
+	if (check_rt) {
+		/* this is a dup - skip */
+		rc = 0;
+		goto out;
+	}
 
 	rt = (range_trans_t *) calloc(1, sizeof(range_trans_t));
 	if (!rt) {
 		ERR(state->handle, "Out of memory!");
-		return -1;
+		goto out;
 	}
 
 	rt->next = state->out->range_tr;
@@ -1004,12 +1064,16 @@ static int exp_rangetr_helper(uint32_t s
 	rt->source_type = stype;
 	rt->target_type = ttype;
 	rt->target_class = tclass;
-	if (mls_range_cpy(&rt->target_range, trange)) {
+	if (mls_range_cpy(&rt->target_range, &exp_range)) {
 		ERR(state->handle, "Out of memory!");
-		return -1;
+		goto out;
 	}
 
-	return 0;
+	rc = 0;
+
+      out:
+	mls_range_destroy(&exp_range);
+	return rc;
 }
 
 static int expand_range_trans(expand_state_t * state,
@@ -1021,6 +1085,9 @@ static int expand_range_trans(expand_sta
 	ebitmap_t stypes, ttypes;
 	ebitmap_node_t *snode, *tnode, *cnode;
 
+	if (state->verbose)
+		INFO(state->handle, "expanding range transitions");
+
 	for (rule = rules; rule; rule = rule->next) {
 		ebitmap_init(&stypes);
 		ebitmap_init(&ttypes);
@@ -1053,7 +1120,7 @@ static int expand_range_trans(expand_sta
 
 					if (exp_rangetr_helper(i + 1,
 							       j + 1,
-							       k,
+							       k + 1,
 							       &rule->trange,
 							       state)) {
 						ebitmap_destroy(&stypes);
@@ -1615,52 +1682,6 @@ static int genfs_copy(expand_state_t * s
 	return 0;
 }
 
-static int range_trans_clone(expand_state_t * state)
-{
-	range_trans_t *range = state->base->range_tr, *last_new_range = NULL,
-	    *new_range = NULL;
-	state->out->range_tr = NULL;
-
-	if (state->verbose)
-		INFO(state->handle, "copying range transitions");
-
-	while (range != NULL) {
-		if ((new_range = malloc(sizeof(*new_range))) == NULL) {
-			goto out_of_mem;
-		}
-		memset(new_range, 0, sizeof(*new_range));
-		new_range->source_type = state->typemap[range->source_type - 1];
-		new_range->target_type = state->typemap[range->target_type - 1];
-		new_range->target_class = range->target_class;
-		if (mls_level_clone(&new_range->target_range.level[0],
-				    &range->target_range.level[0])) {
-			goto out_of_mem;
-		}
-		if (mls_level_clone(&new_range->target_range.level[1],
-				    &range->target_range.level[1])) {
-			goto out_of_mem;
-		}
-		new_range->next = NULL;
-		if (last_new_range == NULL) {
-			state->out->range_tr = last_new_range = new_range;
-		} else {
-			last_new_range->next = new_range;
-			last_new_range = new_range;
-		}
-		range = range->next;
-	}
-	return 0;
-
-      out_of_mem:
-	ERR(state->handle, "Out of memory!");
-	if (new_range) {
-		ebitmap_destroy(&new_range->target_range.level[0].cat);
-		ebitmap_destroy(&new_range->target_range.level[1].cat);
-		free(new_range);
-	}
-	return -1;
-}
-
 static int type_attr_map(hashtab_key_t key
 			 __attribute__ ((unused)), hashtab_datum_t datum,
 			 void *ptr)
@@ -2044,8 +2065,7 @@ static int copy_and_expand_avrule_block(
 		}
 
 		/* expand the range transition rules */
-		if ((base->policyvers >= MOD_POLICYDB_VERSION_RANGETRANS) &&
-		    expand_range_trans(state, decl->range_tr_rules))
+		if (expand_range_trans(state, decl->range_tr_rules))
 			goto cleanup;
 
 		/* copy rules */
@@ -2261,11 +2281,6 @@ int expand_module(sepol_handle_t * handl
 	if (genfs_copy(&state))
 		goto cleanup;
 
-	if ((base->policyvers < MOD_POLICYDB_VERSION_RANGETRANS) &&
-	    range_trans_clone(&state) == -1) {
-		goto cleanup;
-	}
-
 	/* Build the type<->attribute maps and remove attributes. */
 	state.out->attr_type_map = malloc(state.out->p_types.nprim *
 					  sizeof(ebitmap_t));
diff --exclude=.svn -ruNp selinux-list/libsepol/src/mls.c selinux-rangetrans-3/libsepol/src/mls.c
--- selinux-list/libsepol/src/mls.c	2006-08-25 06:16:43.000000000 -0500
+++ selinux-rangetrans-3/libsepol/src/mls.c	2006-09-01 11:58:23.000000000 -0500
@@ -705,3 +705,94 @@ int sepol_mls_check(sepol_handle_t * han
 	free(con);
 	return ret;
 }
+
+void mls_semantic_cat_init(mls_semantic_cat_t * c)
+{
+	memset(c, 0, sizeof(mls_semantic_cat_t));
+}
+
+void mls_semantic_cat_destroy(mls_semantic_cat_t * c __attribute__ ((unused)))
+{
+	/* it's currently a simple struct - really nothing to destroy */
+	return;
+}
+
+void mls_semantic_level_init(mls_semantic_level_t * l)
+{
+	memset(l, 0, sizeof(mls_semantic_level_t));
+}
+
+void mls_semantic_level_destroy(mls_semantic_level_t * l)
+{
+	mls_semantic_cat_t *cur, *next;
+
+	if (l == NULL)
+		return;
+
+	next = l->cat;
+	while (next) {
+		cur = next;
+		next = cur->next;
+		mls_semantic_cat_destroy(cur);
+		free(cur);
+	}
+}
+
+int mls_semantic_level_cpy(mls_semantic_level_t * dst,
+			   mls_semantic_level_t * src)
+{
+	mls_semantic_cat_t *cat, *newcat, *lnewcat = NULL;
+
+	mls_semantic_level_init(dst);
+	dst->sens = src->sens;
+	cat = src->cat;
+	while (cat) {
+		newcat =
+		    (mls_semantic_cat_t *) malloc(sizeof(mls_semantic_cat_t));
+		if (!newcat)
+			goto err;
+
+		mls_semantic_cat_init(newcat);
+		if (lnewcat)
+			lnewcat->next = newcat;
+		else
+			dst->cat = newcat;
+
+		newcat->low = cat->low;
+		newcat->high = cat->high;
+
+		lnewcat = newcat;
+		cat = cat->next;
+	}
+	return 0;
+
+      err:
+	mls_semantic_level_destroy(dst);
+	return -1;
+}
+
+void mls_semantic_range_init(mls_semantic_range_t * r)
+{
+	mls_semantic_level_init(&r->level[0]);
+	mls_semantic_level_init(&r->level[1]);
+}
+
+void mls_semantic_range_destroy(mls_semantic_range_t * r)
+{
+	mls_semantic_level_destroy(&r->level[0]);
+	mls_semantic_level_destroy(&r->level[1]);
+}
+
+int mls_semantic_range_cpy(mls_semantic_range_t * dst,
+			   mls_semantic_range_t * src)
+{
+	if (mls_semantic_level_cpy(&dst->level[0], &src->level[0]) < 0)
+		return -1;
+
+	if (mls_semantic_level_cpy(&dst->level[1], &src->level[1]) < 0) {
+		mls_semantic_level_destroy(&dst->level[0]);
+		return -1;
+	}
+
+	return 0;
+}
diff --exclude=.svn -ruNp selinux-list/libsepol/src/policydb.c selinux-rangetrans-3/libsepol/src/policydb.c
--- selinux-list/libsepol/src/policydb.c	2006-08-25 06:16:43.000000000 -0500
+++ selinux-rangetrans-3/libsepol/src/policydb.c	2006-09-01 11:58:23.000000000 -0500
@@ -233,6 +233,8 @@ void user_datum_init(user_datum_t * x)
 {
 	memset(x, 0, sizeof(user_datum_t));
 	role_set_init(&x->roles);
+	mls_range_init(&x->range);
+	mls_level_init(&x->dfltlevel);
 	ebitmap_init(&x->cache);
 }
 
@@ -240,9 +242,8 @@ void user_datum_destroy(user_datum_t * x
 {
 	if (x != NULL) {
 		role_set_destroy(&x->roles);
-		ebitmap_destroy(&x->range.level[0].cat);
-		ebitmap_destroy(&x->range.level[1].cat);
-		ebitmap_destroy(&x->dfltlevel.cat);
+		mls_range_destroy(&x->range);
+		mls_level_destroy(&x->dfltlevel);
 		ebitmap_destroy(&x->cache);
 	}
 }
@@ -330,7 +331,8 @@ void range_trans_rule_init(range_trans_r
 	type_set_init(&x->stypes);
 	type_set_init(&x->ttypes);
 	ebitmap_init(&x->tclasses);
-	mls_range_init(&x->trange);
+	mls_semantic_range_init(&x->trange);
+	x->next = NULL;
 }
 
 void range_trans_rule_destroy(range_trans_rule_t * x)
@@ -338,7 +340,7 @@ void range_trans_rule_destroy(range_tran
 	type_set_destroy(&x->stypes);
 	type_set_destroy(&x->ttypes);
 	ebitmap_destroy(&x->tclasses);
-	mls_range_destroy(&x->trange);
+	mls_semantic_range_destroy(&x->trange);
 }
 
 void range_trans_rule_list_destroy(range_trans_rule_t * x)
@@ -1348,6 +1350,116 @@ static int mls_read_range_helper(mls_ran
 }
 
 /*
+ * Read a semantic MLS level structure from a policydb binary 
+ * representation file.
+ */
+static int mls_read_semantic_level_helper(mls_semantic_level_t * l,
+					  struct policy_file *fp)
+{
+	uint32_t *buf, ncat;
+	unsigned int i;
+	mls_semantic_cat_t *cat;
+
+	mls_semantic_level_init(l);
+
+	buf = next_entry(fp, sizeof(uint32_t) * 2);
+	if (!buf) {
+		ERR(fp->handle, "truncated level");
+		goto bad;
+	}
+	l->sens = le32_to_cpu(buf[0]);
+
+	ncat = le32_to_cpu(buf[1]);
+	for (i = 0; i < ncat; i++) {
+		cat = (mls_semantic_cat_t *) malloc(sizeof(mls_semantic_cat_t));
+		if (!cat) {
+			ERR(fp->handle, "out of memory");
+			goto bad;
+		}
+
+		mls_semantic_cat_init(cat);
+		cat->next = l->cat;
+		l->cat = cat;
+
+		buf = next_entry(fp, sizeof(uint32_t) * 2);
+		if (!buf) {
+			ERR(fp->handle, "error reading level categories");
+			goto bad;
+		}
+		cat->low = le32_to_cpu(buf[0]);
+		cat->high = le32_to_cpu(buf[1]);
+	}
+
+	return 0;
+
+      bad:
+	return -EINVAL;
+}
+
+/*
+ * Read a semantic MLS range structure from a policydb binary 
+ * representation file.
+ */
+static int mls_read_semantic_range_helper(mls_semantic_range_t * r,
+					  struct policy_file *fp)
+{
+	int rc;
+
+	rc = mls_read_semantic_level_helper(&r->level[0], fp);
+	if (rc)
+		return rc;
+
+	rc = mls_read_semantic_level_helper(&r->level[1], fp);
+
+	return rc;
+}
+
+static int mls_level_to_semantic(mls_level_t * l, mls_semantic_level_t * sl)
+{
+	unsigned int i;
+	ebitmap_node_t *cnode;
+	mls_semantic_cat_t *open_cat = NULL;
+
+	mls_semantic_level_init(sl);
+	sl->sens = l->sens;
+	ebitmap_for_each_bit(&l->cat, cnode, i) {
+		if (ebitmap_node_get_bit(cnode, i)) {
+			if (open_cat)
+				continue;
+			open_cat = (mls_semantic_cat_t *)
+			    malloc(sizeof(mls_semantic_cat_t));
+			if (!open_cat)
+				return -1;
+
+			mls_semantic_cat_init(open_cat);
+			open_cat->low = i + 1;
+			open_cat->next = sl->cat;
+			sl->cat = open_cat;
+		} else {
+			if (!open_cat)
+				continue;
+			open_cat->high = i;
+			open_cat = NULL;
+		}
+	}
+	if (open_cat)
+		open_cat->high = i;
+
+	return 0;
+}
+
+static int mls_range_to_semantic(mls_range_t * r, mls_semantic_range_t * sr)
+{
+	if (mls_level_to_semantic(&r->level[0], &sr->level[0]))
+		return -1;
+
+	if (mls_level_to_semantic(&r->level[1], &sr->level[1]))
+		return -1;
+
+	return 0;
+}
+
+/*
  * Read and validate a security context structure
  * from a policydb binary representation file.
  */
@@ -2303,6 +2415,7 @@ static int range_read(policydb_t * p, st
 {
 	uint32_t *buf, nel;
 	range_trans_t *rt, *lrt;
+	range_trans_rule_t *rtr, *lrtr = NULL;
 	unsigned int i;
 	int new_rangetr = (p->policy_type == POLICY_KERN &&
 			   p->policyvers >= POLICYDB_VERSION_RANGETRANS);
@@ -2336,6 +2449,58 @@ static int range_read(policydb_t * p, st
 			return -1;
 		lrt = rt;
 	}
+
+	/* if this is a kernel policy, we are done - otherwise we need to
+	 * convert these structs to range_trans_rule_ts */
+	if (p->policy_type == POLICY_KERN)
+		return 0;
+
+	/* create range_trans_rules_ts that correspond to the range_trans_ts
+	 * that were just read in from an older policy */
+	for (rt = p->range_tr; rt; rt = rt->next) {
+		rtr = malloc(sizeof(range_trans_rule_t));
+		if (!rtr) {
+			return -1;
+		}
+		range_trans_rule_init(rtr);
+
+		if (lrtr)
+			lrtr->next = rtr;
+		else
+			p->global->enabled->range_tr_rules = rtr;
+
+		if (ebitmap_set_bit(&rtr->stypes.types, rt->source_type - 1, 1))
+			return -1;
+
+		if (ebitmap_set_bit(&rtr->ttypes.types, rt->target_type - 1, 1))
+			return -1;
+
+		if (ebitmap_set_bit(&rtr->tclasses, rt->target_class - 1, 1))
+			return -1;
+
+		if (mls_range_to_semantic(&rt->target_range, &rtr->trange))
+			return -1;
+
+		lrtr = rtr;
+	}
+
+	/* now destroy the range_trans_ts */
+	lrt = NULL;
+	for (rt = p->range_tr; rt; rt = rt->next) {
+		if (lrt) {
+			ebitmap_destroy(&lrt->target_range.level[0].cat);
+			ebitmap_destroy(&lrt->target_range.level[1].cat);
+			free(lrt);
+		}
+		lrt = rt;
+	}
+	if (lrt) {
+		ebitmap_destroy(&lrt->target_range.level[0].cat);
+		ebitmap_destroy(&lrt->target_range.level[1].cat);
+		free(lrt);
+	}
+	p->range_tr = NULL;
+
 	return 0;
 }
 
@@ -2478,7 +2643,7 @@ static int range_trans_rule_read(range_t
 		if (ebitmap_read(&rt->tclasses, fp))
 			return -1;
 
-		if (mls_read_range_helper(&rt->trange, fp))
+		if (mls_read_semantic_range_helper(&rt->trange, fp))
 			return -1;
 
 		lrt = rt;
diff --exclude=.svn -ruNp selinux-list/libsepol/src/write.c selinux-rangetrans-3/libsepol/src/write.c
--- selinux-list/libsepol/src/write.c	2006-08-25 06:16:43.000000000 -0500
+++ selinux-rangetrans-3/libsepol/src/write.c	2006-09-05 04:24:52.000000000 -0500
@@ -308,6 +308,55 @@ static int avtab_write(struct policydb *
 }
 
 /*
+ * Write a semantic MLS level structure to a policydb binary 
+ * representation file.
+ */
+static int mls_write_semantic_level_helper(mls_semantic_level_t * l,
+					   struct policy_file *fp)
+{
+	uint32_t buf[2], ncat = 0;
+	size_t items;
+	mls_semantic_cat_t *cat;
+
+	for (cat = l->cat; cat; cat = cat->next)
+		ncat++;
+
+	buf[0] = cpu_to_le32(l->sens);
+	buf[1] = cpu_to_le32(ncat);
+	items = put_entry(buf, sizeof(uint32_t), 2, fp);
+	if (items != 2)
+		return POLICYDB_ERROR;
+
+	for (cat = l->cat; cat; cat = cat->next) {
+		buf[0] = cpu_to_le32(cat->low);
+		buf[1] = cpu_to_le32(cat->high);
+		items = put_entry(buf, sizeof(uint32_t), 2, fp);
+		if (items != 2)
+			return POLICYDB_ERROR;
+	}
+
+	return POLICYDB_SUCCESS;
+}
+
+/*
+ * Read a semantic MLS range structure to a policydb binary 
+ * representation file.
+ */
+static int mls_write_semantic_range_helper(mls_semantic_range_t * r,
+					   struct policy_file *fp)
+{
+	int rc;
+
+	rc = mls_write_semantic_level_helper(&r->level[0], fp);
+	if (rc)
+		return rc;
+
+	rc = mls_write_semantic_level_helper(&r->level[1], fp);
+
+	return rc;
+}
+
+/*
  * Write a MLS level structure to a policydb binary 
  * representation file.
  */
@@ -1309,7 +1358,7 @@ static int range_trans_rule_write(range_
 			return POLICYDB_ERROR;
 		if (ebitmap_write(&rt->tclasses, fp))
 			return POLICYDB_ERROR;
-		if (mls_write_range_helper(&rt->trange, fp))
+		if (mls_write_semantic_range_helper(&rt->trange, fp))
 			return POLICYDB_ERROR;
 	}
 	return POLICYDB_SUCCESS;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
