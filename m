Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5BIQkGK029974
 for <selinux@tycho.nsa.gov>; Thu, 11 Jun 2015 14:26:46 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 04/10] libsepol: Refactored bounds (hierarchy) checking code
Date: Thu, 11 Jun 2015 14:26:41 -0400
Message-Id: <1434047207-25503-5-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1434047207-25503-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1434047207-25503-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The largest change to the user and role bounds checking was to put
them in their own functions, so they could be called independently.

The type bounds checking was changed to check one type bounds at
a time. An expanded avtab is still created, but now only the rules
of the parent type are expanded. If violations are discovered,
a list of avtab_ptr_t's provides details. This list is used to
display error messages for backwards compatibility and will be
used by CIL to provide a more detailed error message.

Memory usage is reduced from 9,355M to 126M and time is reduced
from 9 sec to 2 sec.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/include/sepol/policydb/hierarchy.h |   11 +
 libsepol/src/hierarchy.c                    | 1000 +++++++++++++++++----------
 2 files changed, 631 insertions(+), 380 deletions(-)

diff --git a/libsepol/include/sepol/policydb/hierarchy.h b/libsepol/include/sepol/policydb/hierarchy.h
index b4eb9bc..88bc02e 100644
--- a/libsepol/include/sepol/policydb/hierarchy.h
+++ b/libsepol/include/sepol/policydb/hierarchy.h
@@ -25,11 +25,22 @@
 #ifndef _SEPOL_POLICYDB_HIERARCHY_H_
 #define _SEPOL_POLICYDB_HIERARCHY_H_
 
+#include <sepol/policydb/avtab.h>
 #include <sepol/policydb/policydb.h>
 #include <sys/cdefs.h>
 
 __BEGIN_DECLS
 
+extern int hierarchy_add_bounds(sepol_handle_t *handle, policydb_t *p);
+
+extern void bounds_destroy_bad(avtab_ptr_t cur);
+extern int bounds_check_type(sepol_handle_t *handle, policydb_t *p, uint32_t child,
+			     uint32_t parent, avtab_ptr_t *bad, int *numbad);
+
+extern int bounds_check_users(sepol_handle_t *handle, policydb_t *p);
+extern int bounds_check_roles(sepol_handle_t *handle, policydb_t *p);
+extern int bounds_check_types(sepol_handle_t *handle, policydb_t *p);
+
 extern int hierarchy_check_constraints(sepol_handle_t * handle, policydb_t * p);
 
 __END_DECLS
diff --git a/libsepol/src/hierarchy.c b/libsepol/src/hierarchy.c
index d787a64..2436837 100644
--- a/libsepol/src/hierarchy.c
+++ b/libsepol/src/hierarchy.c
@@ -37,466 +37,706 @@
 
 #include "debug.h"
 
-typedef struct hierarchy_args {
-	policydb_t *p;
-	avtab_t *expa;		/* expanded avtab */
-	/* This tells check_avtab_hierarchy to check this list in addition to the unconditional avtab */
-	cond_av_list_t *opt_cond_list;
-	sepol_handle_t *handle;
-	int numerr;
-} hierarchy_args_t;
+#define BOUNDS_AVTAB_SIZE 1024
 
-/*
- * find_parent_(type|role|user)
- *
- * This function returns the parent datum of given XXX_datum_t
- * object or NULL, if it doesn't exist.
- *
- * If the given datum has a valid bounds, this function merely
- * returns the indicated object. Otherwise, it looks up the
- * parent based on the based hierarchy.
- */
-#define find_parent_template(prefix)				\
-int find_parent_##prefix(hierarchy_args_t *a,			\
-			 prefix##_datum_t *datum,		\
-			 prefix##_datum_t **parent)		\
-{								\
-	char *parent_name, *datum_name, *tmp;			\
-								\
-	if (datum->bounds)						\
-		*parent = a->p->prefix##_val_to_struct[datum->bounds - 1]; \
-	else {								\
-		datum_name = a->p->p_##prefix##_val_to_name[datum->s.value - 1]; \
-									\
-		tmp = strrchr(datum_name, '.');				\
-		/* no '.' means it has no parent */			\
-		if (!tmp) {						\
-			*parent = NULL;					\
-			return 0;					\
-		}							\
-									\
-		parent_name = strdup(datum_name);			\
-		if (!parent_name)					\
-			return -1;					\
-		parent_name[tmp - datum_name] = '\0';			\
-									\
-		*parent = hashtab_search(a->p->p_##prefix##s.table, parent_name); \
-		if (!*parent) {						\
-			/* Orphan type/role/user */			\
-			ERR(a->handle,					\
-			    "%s doesn't exist, %s is an orphan",	\
-			    parent_name,				\
-			    a->p->p_##prefix##_val_to_name[datum->s.value - 1]); \
-			free(parent_name);				\
-			return -1;					\
-		}							\
-		free(parent_name);					\
-	}								\
-									\
-	return 0;							\
+static int bounds_insert_helper(sepol_handle_t *handle, avtab_t *avtab,
+				avtab_key_t *avtab_key, avtab_datum_t *datum)
+{
+	int rc = avtab_insert(avtab, avtab_key, datum);
+	if (rc) {
+		if (rc == SEPOL_ENOMEM)
+			ERR(handle, "Insufficient memory");
+		else
+			ERR(handle, "Unexpected error (%d)", rc);
+	}
+	return rc;
 }
 
-static find_parent_template(type)
-static find_parent_template(role)
-static find_parent_template(user)
 
-static void compute_avtab_datum(hierarchy_args_t *args,
-				avtab_key_t *key,
-				avtab_datum_t *result)
+static int bounds_insert_rule(sepol_handle_t *handle, avtab_t *avtab,
+			      avtab_t *global, avtab_t *other,
+			      avtab_key_t *avtab_key, avtab_datum_t *datum)
 {
-	avtab_datum_t *avdatp;
-	uint32_t av = 0;
-
-	avdatp = avtab_search(args->expa, key);
-	if (avdatp)
-		av = avdatp->data;
-	if (args->opt_cond_list) {
-		avdatp = cond_av_list_search(key, args->opt_cond_list);
-		if (avdatp)
-			av |= avdatp->data;
+	int rc = 0;
+	avtab_datum_t *dup = avtab_search(avtab, avtab_key);
+
+	if (!dup) {
+		rc = bounds_insert_helper(handle, avtab, avtab_key, datum);
+		if (rc) goto exit;
+	} else {
+		dup->data |= datum->data;
 	}
 
-	result->data = av;
+	if (other) {
+		/* Search the other conditional avtab for the key and
+		 * add any common permissions to the global avtab
+		 */
+		uint32_t data = 0;
+		dup = avtab_search(other, avtab_key);
+		if (dup) {
+			data = dup->data & datum->data;
+			if (data) {
+				dup = avtab_search(global, avtab_key);
+				if (!dup) {
+					avtab_datum_t d;
+					d.data = data;
+					rc = bounds_insert_helper(handle, global,
+								  avtab_key, &d);
+					if (rc) goto exit;
+				} else {
+					dup->data |= data;
+				}
+			}
+		}
+	}
+
+exit:
+	return rc;
 }
 
-/* This function verifies that the type passed in either has a parent or is in the 
- * root of the namespace, 0 on success, 1 on orphan and -1 on error
- */
-static int check_type_hierarchy_callback(hashtab_key_t k, hashtab_datum_t d,
-					 void *args)
+static int bounds_expand_rule(sepol_handle_t *handle, policydb_t *p,
+			      avtab_t *avtab, avtab_t *global, avtab_t *other,
+			      uint32_t parent, uint32_t src, uint32_t tgt,
+			      uint32_t class, uint32_t data)
 {
-	hierarchy_args_t *a;
-	type_datum_t *t, *tp;
-
-	a = (hierarchy_args_t *) args;
-	t = (type_datum_t *) d;
+	int rc = 0;
+	avtab_key_t avtab_key;
+	avtab_datum_t datum;
+	ebitmap_node_t *tnode;
+	unsigned int i;
+
+	avtab_key.specified = AVTAB_ALLOWED;
+	avtab_key.target_class = class;
+	datum.data = data;
+
+	if (ebitmap_get_bit(&p->attr_type_map[src - 1], parent - 1)) {
+		avtab_key.source_type = parent;
+		ebitmap_for_each_bit(&p->attr_type_map[tgt - 1], tnode, i) {
+			if (!ebitmap_node_get_bit(tnode, i))
+				continue;
+			avtab_key.target_type = i + 1;
+			rc = bounds_insert_rule(handle, avtab, global, other,
+						&avtab_key, &datum);
+			if (rc) goto exit;
+		}
+	}
 
-	if (t->flavor == TYPE_ATTRIB) {
-		/* It's an attribute, we don't care */
-		return 0;
+	if (ebitmap_get_bit(&p->attr_type_map[tgt - 1], parent - 1)) {
+		avtab_key.target_type = parent;
+		ebitmap_for_each_bit(&p->attr_type_map[src - 1], tnode, i) {
+			if (!ebitmap_node_get_bit(tnode, i))
+				continue;
+			avtab_key.source_type = i + 1;
+			rc = bounds_insert_rule(handle, avtab, global, other,
+						&avtab_key, &datum);
+			if (rc) goto exit;
+		}
 	}
-	if (find_parent_type(a, t, &tp) < 0)
-		return -1;
-
-	if (tp && tp->flavor == TYPE_ATTRIB) {
-		/* The parent is an attribute but the child isn't, not legal */
-		ERR(a->handle, "type %s is a child of an attribute %s",
-		    (char *) k, a->p->p_type_val_to_name[tp->s.value - 1]);
-		a->numerr++;
-		return -1;
+
+exit:
+	return rc;
+}
+
+static int bounds_expand_cond_rules(sepol_handle_t *handle, policydb_t *p,
+				    cond_av_list_t *cur, avtab_t *avtab,
+				    avtab_t *global, avtab_t *other,
+				    uint32_t parent)
+{
+	int rc = 0;
+
+	for (; cur; cur = cur->next) {
+		avtab_ptr_t n = cur->node;
+		rc = bounds_expand_rule(handle, p, avtab, global, other, parent,
+					n->key.source_type, n->key.target_type,
+					n->key.target_class, n->datum.data);
+		if (rc) goto exit;
 	}
-	return 0;
+
+exit:
+	return rc;
 }
 
-/* This function only verifies that the avtab node passed in does not violate any
- * hiearchy constraint via any relationship with other types in the avtab.
- * it should be called using avtab_map, returns 0 on success, 1 on violation and
- * -1 on error. opt_cond_list is an optional argument that tells this to check
- * a conditional list for the relationship as well as the unconditional avtab
- */
-static int check_avtab_hierarchy_callback(avtab_key_t * k, avtab_datum_t * d,
-					  void *args)
+struct bounds_expand_args {
+	sepol_handle_t *handle;
+	policydb_t *p;
+	avtab_t *avtab;
+	uint32_t parent;
+};
+
+static int bounds_expand_rule_callback(avtab_key_t *k, avtab_datum_t *d,
+				       void *args)
 {
-	avtab_key_t key;
-	hierarchy_args_t *a = (hierarchy_args_t *) args;
-	type_datum_t *s, *t1 = NULL, *t2 = NULL;
-	avtab_datum_t av;
+	struct bounds_expand_args *a = (struct bounds_expand_args *)args;
 
-	if (!(k->specified & AVTAB_ALLOWED)) {
-		/* This is not an allow rule, no checking done */
+	if (!(k->specified & AVTAB_ALLOWED))
 		return 0;
-	}
 
-	/* search for parent first */
-	s = a->p->type_val_to_struct[k->source_type - 1];
-	if (find_parent_type(a, s, &t1) < 0)
-		return -1;
-	if (t1) {
-		/*
-		 * search for access allowed between type 1's
-		 * parent and type 2.
-		 */
-		key.source_type = t1->s.value;
-		key.target_type = k->target_type;
-		key.target_class = k->target_class;
-		key.specified = AVTAB_ALLOWED;
-		compute_avtab_datum(a, &key, &av);
-
-		if ((av.data & d->data) == d->data)
-			return 0;
+	return bounds_expand_rule(a->handle, a->p, a->avtab, NULL, NULL,
+				  a->parent, k->source_type, k->target_type,
+				  k->target_class, d->data);
+}
+
+struct bounds_cond_info {
+	avtab_t true_avtab;
+	avtab_t false_avtab;
+	cond_list_t *cond_list;
+	struct bounds_cond_info *next;
+};
+
+static void bounds_destroy_cond_info(struct bounds_cond_info *cur)
+{
+	struct bounds_cond_info *next;
+
+	for (; cur; cur = next) {
+		next = cur->next;
+		avtab_destroy(&cur->true_avtab);
+		avtab_destroy(&cur->false_avtab);
+		cur->next = NULL;
+		free(cur);
 	}
+}
 
-	/* next we try type 1 and type 2's parent */
-	s = a->p->type_val_to_struct[k->target_type - 1];
-	if (find_parent_type(a, s, &t2) < 0)
-		return -1;
-	if (t2) {
-		/*
-		 * search for access allowed between type 1 and
-		 * type 2's parent.
-		 */
-		key.source_type = k->source_type;
-		key.target_type = t2->s.value;
-		key.target_class = k->target_class;
-		key.specified = AVTAB_ALLOWED;
-		compute_avtab_datum(a, &key, &av);
-
-		if ((av.data & d->data) == d->data)
-			return 0;
+static int bounds_expand_parent_rules(sepol_handle_t *handle, policydb_t *p,
+				      avtab_t *global_avtab,
+				      struct bounds_cond_info **cond_info,
+				      uint32_t child, uint32_t parent)
+{
+	int rc = 0;
+	struct bounds_expand_args args;
+	cond_list_t *cur;
+
+	avtab_init(global_avtab);
+	rc = avtab_alloc(global_avtab, BOUNDS_AVTAB_SIZE);
+	if (rc) goto oom;
+
+	args.handle = handle;
+	args.p = p;
+	args.avtab = global_avtab;
+	args.parent = parent;
+	rc = avtab_map(&p->te_avtab, bounds_expand_rule_callback, &args);
+	if (rc) goto exit;
+
+	*cond_info = NULL;
+	for (cur = p->cond_list; cur; cur = cur->next) {
+		struct bounds_cond_info *ci;
+		ci = malloc(sizeof(struct bounds_cond_info));
+		if (!ci) goto oom;
+		avtab_init(&ci->true_avtab);
+		avtab_init(&ci->false_avtab);
+		ci->cond_list = cur;
+		ci->next = *cond_info;
+		*cond_info = ci;
+		if (cur->true_list) {
+			rc = avtab_alloc(&ci->true_avtab, BOUNDS_AVTAB_SIZE);
+			if (rc) goto oom;
+			rc = bounds_expand_cond_rules(handle, p, cur->true_list,
+						      &ci->true_avtab, NULL,
+						      NULL, parent);
+			if (rc) goto exit;
+		}
+		if (cur->false_list) {
+			rc = avtab_alloc(&ci->false_avtab, BOUNDS_AVTAB_SIZE);
+			if (rc) goto oom;
+			rc = bounds_expand_cond_rules(handle, p, cur->false_list,
+						      &ci->false_avtab,
+						      global_avtab,
+						      &ci->true_avtab, parent);
+			if (rc) goto exit;
+		}
 	}
 
-	if (t1 && t2) {
-		/*
-                 * search for access allowed between type 1's parent
-                 * and type 2's parent.
-                 */
-		key.source_type = t1->s.value;
-		key.target_type = t2->s.value;
-		key.target_class = k->target_class;
-		key.specified = AVTAB_ALLOWED;
-		compute_avtab_datum(a, &key, &av);
-
-		if ((av.data & d->data) == d->data)
-			return 0;
+	return 0;
+
+oom:
+	ERR(handle, "Insufficient memory");
+
+exit:
+	ERR(handle,"Failed to expand parent rules\n");
+	avtab_destroy(global_avtab);
+	bounds_destroy_cond_info(*cond_info);
+	*cond_info = NULL;
+	return rc;
+}
+
+static int bounds_not_covered(policydb_t *p, avtab_t *global_avtab,
+			      avtab_t *cur_avtab, avtab_key_t *avtab_key,
+			      uint32_t data)
+{
+	avtab_datum_t *datum = avtab_search(cur_avtab, avtab_key);
+	if (datum)
+		data &= ~datum->data;
+	if (global_avtab && data) {
+		datum = avtab_search(global_avtab, avtab_key);
+		if (datum)
+			data &= ~datum->data;
 	}
 
-	/*
-	 * Neither one of these types have parents and 
-	 * therefore the hierarchical constraint does not apply
-	 */
-	if (!t1 && !t2)
-		return 0;
+	return data;
+}
+
+static int bounds_add_bad(sepol_handle_t *handle, uint32_t src, uint32_t tgt,
+			  uint32_t class, uint32_t data, avtab_ptr_t *bad)
+{
+	struct avtab_node *new = malloc(sizeof(struct avtab_node));
+	if (new == NULL) {
+		ERR(handle, "Insufficient memory");
+		return SEPOL_ENOMEM;
+	}
+	memset(new, 0, sizeof(struct avtab_node));
+	new->key.source_type = src;
+	new->key.target_type = tgt;
+	new->key.target_class = class;
+	new->datum.data = data;
+	new->next = *bad;
+	*bad = new;
 
-	/*
-	 * At this point there is a violation of the hierarchal
-	 * constraint, send error condition back
-	 */
-	ERR(a->handle,
-	    "hierarchy violation between types %s and %s : %s { %s }",
-	    a->p->p_type_val_to_name[k->source_type - 1],
-	    a->p->p_type_val_to_name[k->target_type - 1],
-	    a->p->p_class_val_to_name[k->target_class - 1],
-	    sepol_av_to_string(a->p, k->target_class, d->data & ~av.data));
-	a->numerr++;
 	return 0;
 }
 
-/*
- * If same permissions are allowed for same combination of
- * source and target, we can evaluate them as unconditional
- * one.
- * See the following example. A_t type is bounds of B_t type,
- * so B_t can never have wider permissions then A_t.
- * A_t has conditional permission on X_t, however, a part of
- * them (getattr and read) are unconditionaly allowed to A_t.
- *
- * Example)
- * typebounds A_t B_t;
- *
- * allow B_t X_t : file { getattr };
- * if (foo_bool) {
- *     allow A_t X_t : file { getattr read };
- * } else {
- *     allow A_t X_t : file { getattr read write };
- * }
- *
- * We have to pull up them as unconditional ones in this case,
- * because it seems to us B_t is violated to bounds constraints
- * during unconditional policy checking.
- */
-static int pullup_unconditional_perms(cond_list_t * cond_list,
-				      hierarchy_args_t * args)
+static int bounds_check_rule(sepol_handle_t *handle, policydb_t *p,
+			     avtab_t *global_avtab, avtab_t *cur_avtab,
+			     uint32_t child, uint32_t parent, uint32_t src,
+			     uint32_t tgt, uint32_t class, uint32_t data,
+			     avtab_ptr_t *bad, int *numbad)
 {
-	cond_list_t *cur_node;
-	cond_av_list_t *cur_av, *expl_true = NULL, *expl_false = NULL;
-	avtab_t expa_true, expa_false;
-	avtab_datum_t *avdatp;
-	avtab_datum_t avdat;
-	avtab_ptr_t avnode;
-
-	for (cur_node = cond_list; cur_node; cur_node = cur_node->next) {
-		if (avtab_init(&expa_true))
-			goto oom0;
-		if (avtab_init(&expa_false))
-			goto oom1;
-		if (expand_cond_av_list(args->p, cur_node->true_list,
-					&expl_true, &expa_true))
-			goto oom2;
-		if (expand_cond_av_list(args->p, cur_node->false_list,
-					&expl_false, &expa_false))
-			goto oom3;
-		for (cur_av = expl_true; cur_av; cur_av = cur_av->next) {
-			avdatp = avtab_search(&expa_false,
-					      &cur_av->node->key);
-			if (!avdatp)
+	int rc = 0;
+	avtab_key_t avtab_key;
+	type_datum_t *td;
+	ebitmap_node_t *tnode;
+	unsigned int i;
+	uint32_t d;
+
+	avtab_key.specified = AVTAB_ALLOWED;
+	avtab_key.target_class = class;
+
+	if (ebitmap_get_bit(&p->attr_type_map[src - 1], child - 1)) {
+		avtab_key.source_type = parent;
+		ebitmap_for_each_bit(&p->attr_type_map[tgt - 1], tnode, i) {
+			if (!ebitmap_node_get_bit(tnode, i))
 				continue;
-
-			avdat.data = (cur_av->node->datum.data
-				      & avdatp->data);
-			if (!avdat.data)
+			avtab_key.target_type = i + 1;
+			d = bounds_not_covered(p, global_avtab, cur_avtab,
+					       &avtab_key, data);
+			if (!d) continue;
+			td = p->type_val_to_struct[i];
+			if (td && td->bounds) {
+				avtab_key.target_type = td->bounds;
+				d = bounds_not_covered(p, global_avtab,
+						       cur_avtab, &avtab_key,
+						       data);
+				if (!d) continue;
+			}
+			(*numbad)++;
+			rc = bounds_add_bad(handle, child, i+1, class, d, bad);
+			if (rc) goto exit;
+		}
+	}
+	if (ebitmap_get_bit(&p->attr_type_map[tgt - 1], child - 1)) {
+		avtab_key.target_type = parent;
+		ebitmap_for_each_bit(&p->attr_type_map[src - 1], tnode, i) {
+			if (!ebitmap_node_get_bit(tnode, i))
 				continue;
-
-			avnode = avtab_search_node(args->expa,
-						   &cur_av->node->key);
-			if (avnode) {
-				avnode->datum.data |= avdat.data;
-			} else {
-				if (avtab_insert(args->expa,
-						 &cur_av->node->key,
-						 &avdat))
-					goto oom4;
+			avtab_key.source_type = i + 1;
+			if (avtab_key.source_type == child) {
+				/* Checked above */
+				continue;
+			}
+			d = bounds_not_covered(p, global_avtab, cur_avtab,
+					       &avtab_key, data);
+			if (!d) continue;
+			td = p->type_val_to_struct[i];
+			if (td && td->bounds) {
+				avtab_key.source_type = td->bounds;
+				d = bounds_not_covered(p, global_avtab,
+						       cur_avtab, &avtab_key,
+						       data);
+				if (!d) continue;
 			}
+			(*numbad)++;
+			rc = bounds_add_bad(handle, i+1, child, class, d, bad);
+			if (rc) goto exit;
 		}
-		cond_av_list_destroy(expl_false);
-		cond_av_list_destroy(expl_true);
-		avtab_destroy(&expa_false);
-		avtab_destroy(&expa_true);
 	}
-	return 0;
 
-oom4:
-	cond_av_list_destroy(expl_false);
-oom3:
-	cond_av_list_destroy(expl_true);
-oom2:
-	avtab_destroy(&expa_false);
-oom1:
-	avtab_destroy(&expa_true);
-oom0:
-	ERR(args->handle, "out of memory on conditional av list expansion");
-        return 1;
+exit:
+	return rc;
+}
+
+static int bounds_check_cond_rules(sepol_handle_t *handle, policydb_t *p,
+				   avtab_t *global_avtab, avtab_t *cond_avtab,
+				   cond_av_list_t *rules, uint32_t child,
+				   uint32_t parent, avtab_ptr_t *bad,
+				   int *numbad)
+{
+	int rc = 0;
+	cond_av_list_t *cur;
+
+	for (cur = rules; cur; cur = cur->next) {
+		avtab_ptr_t ap = cur->node;
+		avtab_key_t *key = &ap->key;
+		avtab_datum_t *datum = &ap->datum;
+		if (!(key->specified & AVTAB_ALLOWED))
+			continue;
+		rc = bounds_check_rule(handle, p, global_avtab, cond_avtab,
+				       child, parent, key->source_type,
+				       key->target_type, key->target_class,
+				       datum->data, bad, numbad);
+		if (rc) goto exit;
+	}
+
+exit:
+	return rc;
+}
+
+struct bounds_check_args {
+	sepol_handle_t *handle;
+	policydb_t *p;
+	avtab_t *cur_avtab;
+	uint32_t child;
+	uint32_t parent;
+	avtab_ptr_t bad;
+	int numbad;
+};
+
+static int bounds_check_rule_callback(avtab_key_t *k, avtab_datum_t *d,
+				      void *args)
+{
+	struct bounds_check_args *a = (struct bounds_check_args *)args;
+
+	if (!(k->specified & AVTAB_ALLOWED))
+		return 0;
+
+	return bounds_check_rule(a->handle, a->p, NULL, a->cur_avtab, a->child,
+				 a->parent, k->source_type, k->target_type,
+				 k->target_class, d->data, &a->bad, &a->numbad);
 }
 
-static int check_cond_avtab_hierarchy(cond_list_t * cond_list,
-				      hierarchy_args_t * args)
+static int bounds_check_child_rules(sepol_handle_t *handle, policydb_t *p,
+				    avtab_t *global_avtab,
+				    struct bounds_cond_info *cond_info,
+				    uint32_t child, uint32_t parent,
+				    avtab_ptr_t *bad, int *numbad)
 {
 	int rc;
-	cond_list_t *cur_node;
-	cond_av_list_t *cur_av, *expl = NULL;
-	avtab_t expa;
-	hierarchy_args_t *a = (hierarchy_args_t *) args;
-	avtab_datum_t avdat, *uncond;
-
-	for (cur_node = cond_list; cur_node; cur_node = cur_node->next) {
-		/*
-		 * Check true condition
-		 */
-		if (avtab_init(&expa))
-			goto oom;
-		if (expand_cond_av_list(args->p, cur_node->true_list,
-					&expl, &expa)) {
-			avtab_destroy(&expa);
-			goto oom;
-		}
-		args->opt_cond_list = expl;
-		for (cur_av = expl; cur_av; cur_av = cur_av->next) {
-			avdat.data = cur_av->node->datum.data;
-			uncond = avtab_search(a->expa, &cur_av->node->key);
-			if (uncond)
-				avdat.data |= uncond->data;
-			rc = check_avtab_hierarchy_callback(&cur_av->node->key,
-							    &avdat, args);
-			if (rc)
-				args->numerr++;
-		}
-		cond_av_list_destroy(expl);
-		avtab_destroy(&expa);
+	struct bounds_check_args args;
+	struct bounds_cond_info *cur;
 
-		/*
-		 * Check false condition
-		 */
-		if (avtab_init(&expa))
-			goto oom;
-		if (expand_cond_av_list(args->p, cur_node->false_list,
-					&expl, &expa)) {
-			avtab_destroy(&expa);
-			goto oom;
-		}
-		args->opt_cond_list = expl;
-		for (cur_av = expl; cur_av; cur_av = cur_av->next) {
-			avdat.data = cur_av->node->datum.data;
-			uncond = avtab_search(a->expa, &cur_av->node->key);
-			if (uncond)
-				avdat.data |= uncond->data;
-
-			rc = check_avtab_hierarchy_callback(&cur_av->node->key,
-							    &avdat, args);
-			if (rc)
-				a->numerr++;
+	args.handle = handle;
+	args.p = p;
+	args.cur_avtab = global_avtab;
+	args.child = child;
+	args.parent = parent;
+	args.bad = NULL;
+	args.numbad = 0;
+	rc = avtab_map(&p->te_avtab, bounds_check_rule_callback, &args);
+	if (rc) goto exit;
+
+	for (cur = cond_info; cur; cur = cur->next) {
+		cond_list_t *node = cur->cond_list;
+		rc = bounds_check_cond_rules(handle, p, global_avtab,
+					     &cur->true_avtab,
+					     node->true_list, child, parent,
+					     &args.bad, &args.numbad);
+		if (rc) goto exit;
+
+		rc = bounds_check_cond_rules(handle, p, global_avtab,
+					     &cur->false_avtab,
+					     node->false_list, child, parent,
+					     &args.bad, &args.numbad);
+		if (rc) goto exit;
+	}
+
+	*numbad += args.numbad;
+	*bad = args.bad;
+
+exit:
+	return rc;
+}
+
+int bounds_check_type(sepol_handle_t *handle, policydb_t *p, uint32_t child,
+		      uint32_t parent, avtab_ptr_t *bad, int *numbad)
+{
+	int rc = 0;
+	avtab_t global_avtab;
+	struct bounds_cond_info *cond_info = NULL;
+
+	rc = bounds_expand_parent_rules(handle, p, &global_avtab, &cond_info,
+					child, parent);
+	if (rc) goto exit;
+
+	rc = bounds_check_child_rules(handle, p, &global_avtab, cond_info,
+				      child, parent, bad, numbad);
+
+	bounds_destroy_cond_info(cond_info);
+	avtab_destroy(&global_avtab);
+
+exit:
+	return rc;
+}
+
+struct bounds_args {
+	sepol_handle_t *handle;
+	policydb_t *p;
+	int numbad;
+};
+
+static void bounds_report(sepol_handle_t *handle, policydb_t *p, uint32_t child,
+			  uint32_t parent, avtab_ptr_t cur)
+{
+	ERR(handle, "Child type %s exceeds bounds of parent %s in the following rules:",
+	    p->p_type_val_to_name[child - 1],
+	    p->p_type_val_to_name[parent - 1]);
+	for (; cur; cur = cur->next) {
+		ERR(handle, "    %s %s : %s { %s }",
+		    p->p_type_val_to_name[cur->key.source_type - 1],
+		    p->p_type_val_to_name[cur->key.target_type - 1],
+		    p->p_class_val_to_name[cur->key.target_class - 1],
+		    sepol_av_to_string(p, cur->key.target_class,
+				       cur->datum.data));
+	}
+}
+
+void bounds_destroy_bad(avtab_ptr_t cur)
+{
+	avtab_ptr_t next;
+
+	for (; cur; cur = next) {
+		next = cur->next;
+		cur->next = NULL;
+		free(cur);
+	}
+}
+
+static int bounds_check_type_callback(hashtab_key_t k, hashtab_datum_t d,
+				      void *args)
+{
+	int rc = 0;
+	struct bounds_args *a = (struct bounds_args *)args;
+	type_datum_t *t = (type_datum_t *)d;
+	avtab_ptr_t bad = NULL;
+
+	if (t->bounds) {
+		rc = bounds_check_type(a->handle, a->p, t->s.value, t->bounds,
+				       &bad, &a->numbad);
+		if (bad) {
+			bounds_report(a->handle, a->p, t->s.value, t->bounds,
+				      bad);
+			bounds_destroy_bad(bad);
 		}
-		cond_av_list_destroy(expl);
-		avtab_destroy(&expa);
 	}
 
-	return 0;
+	return rc;
+}
+
+int bounds_check_types(sepol_handle_t *handle, policydb_t *p)
+{
+	int rc;
+	struct bounds_args args;
+
+	args.handle = handle;
+	args.p = p;
+	args.numbad = 0;
+
+	rc = hashtab_map(p->p_types.table, bounds_check_type_callback, &args);
+	if (rc) goto exit;
+
+	if (args.numbad > 0) {
+		ERR(handle, "%d errors found during type bounds check",
+		    args.numbad);
+		rc = SEPOL_ERR;
+	}
 
-      oom:
-	ERR(args->handle, "out of memory on conditional av list expansion");
-	return 1;
+exit:
+	return rc;
 }
 
-/* The role hierarchy is defined as: a child role cannot have more types than it's parent.
- * This function should be called with hashtab_map, it will return 0 on success, 1 on 
- * constraint violation and -1 on error
+/* The role bounds is defined as: a child role cannot have a type that
+ * its parent doesn't have.
  */
-static int check_role_hierarchy_callback(hashtab_key_t k
-					 __attribute__ ((unused)),
-					 hashtab_datum_t d, void *args)
+static int bounds_check_role_callback(hashtab_key_t k __attribute__ ((unused)),
+				      hashtab_datum_t d, void *args)
 {
-	hierarchy_args_t *a;
-	role_datum_t *r, *rp;
+	struct bounds_args *a = (struct bounds_args *)args;
+	role_datum_t *r = (role_datum_t *) d;
+	role_datum_t *rp = NULL;
 
-	a = (hierarchy_args_t *) args;
-	r = (role_datum_t *) d;
+	if (!r->bounds)
+		return 0;
 
-	if (find_parent_role(a, r, &rp) < 0)
-		return -1;
+	rp = a->p->role_val_to_struct[r->bounds - 1];
 
 	if (rp && !ebitmap_contains(&rp->types.types, &r->types.types)) {
-		/* hierarchical constraint violation, return error */
-		ERR(a->handle, "Role hierarchy violation, %s exceeds %s",
-		    (char *) k, a->p->p_role_val_to_name[rp->s.value - 1]);
-		a->numerr++;
+		ERR(a->handle, "Role bounds violation, %s exceeds %s",
+		    (char *)k, a->p->p_role_val_to_name[rp->s.value - 1]);
+		a->numbad++;
+	}
+
+	return 0;
+}
+
+int bounds_check_roles(sepol_handle_t *handle, policydb_t *p)
+{
+	struct bounds_args args;
+
+	args.handle = handle;
+	args.p = p;
+	args.numbad = 0;
+
+	hashtab_map(p->p_roles.table, bounds_check_role_callback, &args);
+
+	if (args.numbad > 0) {
+		ERR(handle, "%d errors found during role bounds check",
+		    args.numbad);
+		return SEPOL_ERR;
 	}
+
 	return 0;
 }
 
-/* The user hierarchy is defined as: a child user cannot have a role that
- * its parent doesn't have.  This function should be called with hashtab_map,
- * it will return 0 on success, 1 on constraint violation and -1 on error.
+/* The user bounds is defined as: a child user cannot have a role that
+ * its parent doesn't have.
  */
-static int check_user_hierarchy_callback(hashtab_key_t k
-					 __attribute__ ((unused)),
-					 hashtab_datum_t d, void *args)
+static int bounds_check_user_callback(hashtab_key_t k __attribute__ ((unused)),
+				      hashtab_datum_t d, void *args)
 {
-	hierarchy_args_t *a;
-	user_datum_t *u, *up;
+	struct bounds_args *a = (struct bounds_args *)args;
+	user_datum_t *u = (user_datum_t *) d;
+	user_datum_t *up = NULL;
 
-	a = (hierarchy_args_t *) args;
-	u = (user_datum_t *) d;
+	if (!u->bounds)
+		return 0;
 
-	if (find_parent_user(a, u, &up) < 0)
-		return -1;
+	up = a->p->user_val_to_struct[u->bounds - 1];
 
 	if (up && !ebitmap_contains(&up->roles.roles, &u->roles.roles)) {
-		/* hierarchical constraint violation, return error */
-		ERR(a->handle, "User hierarchy violation, %s exceeds %s",
+		ERR(a->handle, "User bounds violation, %s exceeds %s",
 		    (char *) k, a->p->p_user_val_to_name[up->s.value - 1]);
-		a->numerr++;
+		a->numbad++;
 	}
+
 	return 0;
 }
 
-int hierarchy_check_constraints(sepol_handle_t * handle, policydb_t * p)
+int bounds_check_users(sepol_handle_t *handle, policydb_t *p)
 {
-	hierarchy_args_t args;
-	avtab_t expa;
-
-	if (avtab_init(&expa))
-		goto oom;
-	if (expand_avtab(p, &p->te_avtab, &expa)) {
-		avtab_destroy(&expa);
-		goto oom;
-	}
+	struct bounds_args args;
 
-	args.p = p;
-	args.expa = &expa;
-	args.opt_cond_list = NULL;
 	args.handle = handle;
-	args.numerr = 0;
+	args.p = p;
+	args.numbad = 0;
 
-	if (hashtab_map(p->p_types.table, check_type_hierarchy_callback, &args))
-		goto bad;
+	hashtab_map(p->p_users.table, bounds_check_user_callback, &args);
 
-	if (pullup_unconditional_perms(p->cond_list, &args))
-		return -1;
+	if (args.numbad > 0) {
+		ERR(handle, "%d errors found during user bounds check",
+		    args.numbad);
+		return SEPOL_ERR;
+	}
 
-	if (avtab_map(&expa, check_avtab_hierarchy_callback, &args))
-		goto bad;
+	return 0;
+}
 
-	if (check_cond_avtab_hierarchy(p->cond_list, &args))
-		goto bad;
+#define add_hierarchy_callback_template(prefix)				\
+	int hierarchy_add_##prefix##_callback(hashtab_key_t k __attribute__ ((unused)), \
+					    hashtab_datum_t d, void *args) \
+{								\
+	struct bounds_args *a = (struct bounds_args *)args;		\
+	sepol_handle_t *handle = a->handle;				\
+	policydb_t *p = a->p;						\
+	prefix##_datum_t *datum = (prefix##_datum_t *)d;		\
+	prefix##_datum_t *parent;					\
+	char *parent_name, *datum_name, *tmp;				\
+									\
+	if (!datum->bounds) {						\
+		datum_name = p->p_##prefix##_val_to_name[datum->s.value - 1]; \
+									\
+		tmp = strrchr(datum_name, '.');				\
+		/* no '.' means it has no parent */			\
+		if (!tmp) return 0;					\
+									\
+		parent_name = strdup(datum_name);			\
+		if (!parent_name) {					\
+			ERR(handle, "Insufficient memory");		\
+			return SEPOL_ENOMEM;				\
+		}							\
+		parent_name[tmp - datum_name] = '\0';			\
+									\
+		parent = hashtab_search(p->p_##prefix##s.table, parent_name); \
+		if (!parent) {						\
+			/* Orphan type/role/user */			\
+			ERR(handle, "%s doesn't exist, %s is an orphan",\
+			    parent_name,				\
+			    p->p_##prefix##_val_to_name[datum->s.value - 1]); \
+			free(parent_name);				\
+			a->numbad++;					\
+			return 0;					\
+		}							\
+		datum->bounds = parent->s.value;			\
+		free(parent_name);					\
+	}								\
+									\
+	return 0;							\
+}								\
+
+static add_hierarchy_callback_template(type)
+static add_hierarchy_callback_template(role)
+static add_hierarchy_callback_template(user)
 
-	if (hashtab_map(p->p_roles.table, check_role_hierarchy_callback, &args))
-		goto bad;
+int hierarchy_add_bounds(sepol_handle_t *handle, policydb_t *p)
+{
+	int rc = 0;
+	struct bounds_args args;
+
+	args.handle = handle;
+	args.p = p;
+	args.numbad = 0;
+
+	rc = hashtab_map(p->p_users.table, hierarchy_add_user_callback, &args);
+	if (rc) goto exit;
+
+	rc = hashtab_map(p->p_roles.table, hierarchy_add_role_callback, &args);
+	if (rc) goto exit;
 
-	if (hashtab_map(p->p_users.table, check_user_hierarchy_callback, &args))
-		goto bad;
+	rc = hashtab_map(p->p_types.table, hierarchy_add_type_callback, &args);
+	if (rc) goto exit;
 
-	if (args.numerr) {
-		ERR(handle, "%d total errors found during hierarchy check",
-		    args.numerr);
-		goto bad;
+	if (args.numbad > 0) {
+		ERR(handle, "%d errors found while adding hierarchies",
+		    args.numbad);
+		rc = SEPOL_ERR;
 	}
 
-	avtab_destroy(&expa);
-	return 0;
+exit:
+	return rc;
+}
+
+int hierarchy_check_constraints(sepol_handle_t * handle, policydb_t * p)
+{
+	int rc = 0;
+	int violation = 0;
+
+	rc = hierarchy_add_bounds(handle, p);
+	if (rc) goto exit;
+
+	rc = bounds_check_users(handle, p);
+	if (rc)
+		violation = 1;
+
+	rc = bounds_check_roles(handle, p);
+	if (rc)
+		violation = 1;
+
+	rc = bounds_check_types(handle, p);
+	if (rc) {
+		if (rc == SEPOL_ERR)
+			violation = 1;
+		else
+			goto exit;
+	}
 
-      bad:
-	avtab_destroy(&expa);
-	return -1;
+	if (violation)
+		rc = SEPOL_ERR;
 
-      oom:
-	ERR(handle, "Out of memory");
-	return -1;
+exit:
+	return rc;
 }
-- 
1.9.3
