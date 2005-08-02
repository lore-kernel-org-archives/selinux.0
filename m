Subject: Re: [RFC][PATCH 0/3] Reduce number of avtab nodes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Morris <jmorris@redhat.com>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>,
   Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
In-Reply-To: <1122903665.6573.281.camel@moss-spartans.epoch.ncsc.mil>
References: <1122655799.6573.193.camel@moss-spartans.epoch.ncsc.mil>
	 <Lynx.SEL.4.62.0507311149080.22444@thoron.boston.redhat.com>
	 <1122903665.6573.281.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 12:43:06 -0400
Message-Id: <1123000986.11904.48.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-01 at 09:41 -0400, Stephen Smalley wrote:
> - We need to write compatibility code for writing out older binary
> policy versions from libsepol/checkpolicy for the latest change.  This
> is necessary even just to support loading version 19 policies,
> since /sbin/init and load_policy regenerate the binary policy image
> in-memory when adjusting them for local boolean and user definitions and
> thus need that support in policydb_write.

This patch, relative to the prior ones, adds this compatibility code.
It implements it by creating an in-memory attr->type map and then using
this map to expand the avtab and cond av lists when writing out an older
binary policy version.  The attr->type map has to be created by both the
expand_module code (where it is trivial to do so before we discard
attribute information) and by the policydb_read code, so that the
compatibility code works regardless of whether we are compiling an older
binary policy version (e.g. checkpolicy -c 19) or simply mutating an
in-memory policydb originally created from a kernel binary policy file
for local settings (e.g. /sbin/init and load_policy's use of
sepol_genusers/genbools).  This lets me boot an unpatched kernel with a
policy.19 and the new libsepol installed, without /sbin/init choking on
sepol_genusers/genbools.

It occurred to me that the simple checks of policyvers <
POLICYDB_VERSION_AVTAB might be breaking the module support, so I
started qualifying them with an additional policy_type == POLICY_KERN
test as well, but it looks like the same issue exists for other
policyvers checks, e.g. for MLS, VALIDATETRANS, etc.  Shouldn't all such
policy version checks be qualified with the policy_type as well on both
the read-side and write-side in libsepol?

It would also be good for someone to sanity check that these patches are
sane with respect to conditional policy, although they seem to be
correct.

diff -X /home/sds/dontdiff -rup libsepol.a/include/sepol/conditional.h libsepol/include/sepol/conditional.h
--- libsepol.a/include/sepol/conditional.h	2005-07-13 15:26:17.000000000 -0400
+++ libsepol/include/sepol/conditional.h	2005-08-01 16:31:40.000000000 -0400
@@ -107,6 +107,8 @@ extern int evaluate_conds(policydb_t *p)
 extern avtab_datum_t *cond_av_list_search(
 	avtab_key_t *key, cond_av_list_t *cond_list);
 
+extern void cond_av_list_destroy(cond_av_list_t *list);
+
 extern void cond_optimize_lists(cond_list_t *cl);
 
 extern int cond_policydb_init(policydb_t* p);
diff -X /home/sds/dontdiff -rup libsepol.a/include/sepol/expand.h libsepol/include/sepol/expand.h
--- libsepol.a/include/sepol/expand.h	2005-07-28 14:48:44.000000000 -0400
+++ libsepol/include/sepol/expand.h	2005-08-02 11:00:36.000000000 -0400
@@ -37,4 +37,9 @@ extern int expand_rule(policydb_t *sourc
                 cond_av_list_t **cond, cond_av_list_t **other,
                 int enabled, char **error_msg);
 
+extern int expand_avtab(policydb_t *p, avtab_t *a, avtab_t *expa);
+
+extern int expand_cond_av_list(policydb_t *p, cond_av_list_t *l,
+			       cond_av_list_t **newl, avtab_t *expa);
+
 #endif
diff -X /home/sds/dontdiff -rup libsepol.a/include/sepol/policydb.h libsepol/include/sepol/policydb.h
--- libsepol.a/include/sepol/policydb.h	2005-07-28 14:48:44.000000000 -0400
+++ libsepol/include/sepol/policydb.h	2005-08-01 13:15:30.000000000 -0400
@@ -433,6 +433,8 @@ typedef struct policydb {
 
 	ebitmap_t *type_attr_map;
 
+	ebitmap_t *attr_type_map; /* not saved in the binary policy */
+
 	unsigned policyvers;
 } policydb_t;
 
diff -X /home/sds/dontdiff -rup libsepol.a/src/conditional.c libsepol/src/conditional.c
--- libsepol.a/src/conditional.c	2005-07-28 14:44:43.000000000 -0400
+++ libsepol/src/conditional.c	2005-08-01 16:31:08.000000000 -0400
@@ -419,7 +419,7 @@ int cond_policydb_init(policydb_t *p)
 	return 0;
 }
 
-static void cond_av_list_destroy(cond_av_list_t *list)
+void cond_av_list_destroy(cond_av_list_t *list)
 {
 	cond_av_list_t *cur, *next;
 	for (cur = list; cur != NULL; cur = next) {
diff -X /home/sds/dontdiff -rup libsepol.a/src/expand.c libsepol/src/expand.c
--- libsepol.a/src/expand.c	2005-07-28 14:48:47.000000000 -0400
+++ libsepol/src/expand.c	2005-08-02 11:46:31.000000000 -0400
@@ -33,6 +33,8 @@
 #include <string.h>
 #include <assert.h>
 
+#include "debug.h"
+
 typedef struct expand_state {
 	int verbose;
 	uint32_t *typemap;
@@ -1407,12 +1409,19 @@ static int type_attr_map(hashtab_key_t k
 
 	type = (type_datum_t *) datum;
 	if (type->isattr) {
+		if (ebitmap_cpy(&p->attr_type_map[type->value-1],
+				&type->types)) {
+			write_error(state, "Out of memory!");
+			return -1;
+		}
 		for (i = ebitmap_startbit(&type->types); 
 		     i < ebitmap_length(&type->types); i++) 
 			if (ebitmap_get_bit(&type->types, i)) {
 				if (ebitmap_set_bit(&p->type_attr_map[i],
-						    type->value - 1, 1))
+						    type->value - 1, 1)) {
+					write_error(state, "Out of memory!");
 					return -1;
+				}
 			}
 	}
 	return 0;
@@ -1845,20 +1854,29 @@ int expand_module(policydb_t *base, poli
                 goto cleanup;
         }
 
-	/* Build the type->attribute reverse map and remove attributes. */
+	/* Build the type<->attribute maps and remove attributes. */
+	state.out->attr_type_map = malloc(state.out->p_types.nprim*
+					  sizeof(ebitmap_t));
 	state.out->type_attr_map = malloc(state.out->p_types.nprim*
 					  sizeof(ebitmap_t));
+	if (!state.out->attr_type_map || !state.out->type_attr_map) {
+		write_error(&state, "Out of memory!");
+		goto cleanup;
+	}
 	for (i = 0; i < state.out->p_types.nprim; i++) {
 		ebitmap_init(&state.out->type_attr_map[i]);
+		ebitmap_init(&state.out->attr_type_map[i]);
 		/* add the type itself as the degenerate case */
-		if (ebitmap_set_bit(&state.out->type_attr_map[i], i, 1))
-				goto cleanup;
+		if (ebitmap_set_bit(&state.out->type_attr_map[i], i, 1)) {
+			write_error(&state, "Out of memory!");
+			goto cleanup;
+		}
 	}
 	if (hashtab_map(state.out->p_types.table, type_attr_map, 
 			&state))
 		goto cleanup;
 	hashtab_map_remove_on_error(state.out->p_types.table, 
-                                    type_attr_remove, 0, 0);
+				    type_attr_remove, 0, 0);
 	
         retval = 0;
 
@@ -1866,3 +1884,273 @@ int expand_module(policydb_t *base, poli
         free (state.typemap);
         return retval;
 }
+
+static int expand_avtab_insert(avtab_t *a, avtab_key_t *k, avtab_datum_t *d)
+{
+	avtab_datum_t *avd;
+	int rc;
+
+	avd = avtab_search(a, k);
+	if (!avd) {
+		rc = avtab_insert(a, k, d);
+		if (rc)
+			DEBUG(__FUNCTION__, "Out of memory!\n");
+		return rc;
+	}
+	
+	switch (k->specified & ~AVTAB_ENABLED) {
+	case AVTAB_ALLOWED:
+	case AVTAB_AUDITALLOW:
+		avd->data |= d->data;
+		break;
+	case AVTAB_AUDITDENY:
+		avd->data &= d->data;
+		break;
+	default:
+		DEBUG(__FUNCTION__, "Type conflict!\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+struct expand_avtab_data {
+	avtab_t *expa;
+	policydb_t *p;
+  
+};
+
+static int expand_avtab_node(avtab_key_t *k, avtab_datum_t *d, void *args) 
+{
+	struct expand_avtab_data *ptr = args;
+	avtab_t *expa = ptr->expa;
+	policydb_t *p = ptr->p;
+	type_datum_t *stype = p->type_val_to_struct[k->source_type-1];
+	type_datum_t *ttype = p->type_val_to_struct[k->target_type-1];
+	ebitmap_t *sattr = &p->attr_type_map[k->source_type-1];
+	ebitmap_t *tattr = &p->attr_type_map[k->target_type-1];
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
+		for (j = ebitmap_startbit(tattr), 
+			     tnode = ebitmap_startnode(tattr); 
+		     j < ebitmap_length(tattr); 
+		     j = ebitmap_nextbit(tattr, &tnode, j)) {
+			if (!ebitmap_node_get_bit(tattr, tnode, j))
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
+		for (i = ebitmap_startbit(sattr), 
+			     snode = ebitmap_startnode(sattr);
+		     i < ebitmap_length(sattr); 
+		     i = ebitmap_nextbit(sattr, &snode, i)) {
+			if (!ebitmap_node_get_bit(sattr, snode, i))
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
+	for (i = ebitmap_startbit(sattr), 
+		     snode = ebitmap_startnode(sattr);
+	     i < ebitmap_length(sattr); 
+	     i = ebitmap_nextbit(sattr, &snode, i)) {
+		if (!ebitmap_node_get_bit(sattr, snode, i))
+			continue;
+		for (j = ebitmap_startbit(tattr), 
+			     tnode = ebitmap_startnode(tattr); 
+		     j < ebitmap_length(tattr); 
+		     j = ebitmap_nextbit(tattr, &tnode, j)) {
+			if (!ebitmap_node_get_bit(tattr, tnode, j))
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
+int expand_avtab(policydb_t *p, avtab_t *a, avtab_t *expa)
+{
+	struct expand_avtab_data data;
+
+	data.expa = expa;
+	data.p = p;
+	return avtab_map(a, expand_avtab_node, &data);
+}
+
+static int expand_cond_insert(cond_av_list_t **l, 
+			      avtab_t *expa,
+			      avtab_key_t *k, avtab_datum_t *d)
+{
+	avtab_ptr_t node;
+	avtab_datum_t *avd;
+	cond_av_list_t *nl;
+
+	node = avtab_search_node(expa, k);
+	if (!node) {
+		node = avtab_insert_nonunique(expa, k, d);
+		if (!node) {
+			DEBUG(__FUNCTION__, "Out of memory!\n");
+			return -1;
+		}
+		node->parse_context = (void*)1;
+		nl = (cond_av_list_t *) malloc(sizeof(*nl));
+		if (!nl) {
+			DEBUG(__FUNCTION__, "Out of memory!\n");
+			return -1;
+		}
+		memset(nl, 0, sizeof(*nl));
+		nl->node = node;
+		nl->next = *l;
+		*l = nl;
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
+		DEBUG(__FUNCTION__, "Type conflict!\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+
+int expand_cond_av_node(policydb_t *p, 
+			avtab_ptr_t node,
+			cond_av_list_t **newl,
+			avtab_t *expa)
+{
+	avtab_key_t *k = &node->key;
+	avtab_datum_t *d = &node->datum;
+	type_datum_t *stype = p->type_val_to_struct[k->source_type-1];
+	type_datum_t *ttype = p->type_val_to_struct[k->target_type-1];
+	ebitmap_t *sattr = &p->attr_type_map[k->source_type-1];
+	ebitmap_t *tattr = &p->attr_type_map[k->target_type-1];
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
+		return expand_cond_insert(newl, expa, k, d);
+	}
+
+	if (stype) {
+		/* Source is an individual type, target is an attribute. */
+		newkey.source_type = k->source_type;
+		for (j = ebitmap_startbit(tattr), 
+			     tnode = ebitmap_startnode(tattr); 
+		     j < ebitmap_length(tattr); 
+		     j = ebitmap_nextbit(tattr, &tnode, j)) {
+			if (!ebitmap_node_get_bit(tattr, tnode, j))
+				continue;
+			newkey.target_type = j + 1;
+			rc = expand_cond_insert(newl, expa, &newkey, d);
+			if (rc)
+				return -1;
+		}
+		return 0;
+	}
+
+	if (ttype) {
+		/* Target is an individual type, source is an attribute. */
+		newkey.target_type = k->target_type;
+		for (i = ebitmap_startbit(sattr), 
+			     snode = ebitmap_startnode(sattr);
+		     i < ebitmap_length(sattr); 
+		     i = ebitmap_nextbit(sattr, &snode, i)) {
+			if (!ebitmap_node_get_bit(sattr, snode, i))
+				continue;
+			newkey.source_type = i + 1;
+			rc = expand_cond_insert(newl, expa, &newkey, d);
+			if (rc)
+				return -1;
+		}
+		return 0;
+	}
+
+	/* Both source and target type are attributes. */
+	for (i = ebitmap_startbit(sattr), 
+		     snode = ebitmap_startnode(sattr);
+	     i < ebitmap_length(sattr); 
+	     i = ebitmap_nextbit(sattr, &snode, i)) {
+		if (!ebitmap_node_get_bit(sattr, snode, i))
+			continue;
+		for (j = ebitmap_startbit(tattr), 
+			     tnode = ebitmap_startnode(tattr); 
+		     j < ebitmap_length(tattr); 
+		     j = ebitmap_nextbit(tattr, &tnode, j)) {
+			if (!ebitmap_node_get_bit(tattr, tnode, j))
+				continue;
+			newkey.source_type = i + 1;
+			newkey.target_type = j + 1;
+			rc = expand_cond_insert(newl, expa, &newkey, d);
+			if (rc)
+				return -1;
+		}
+	}
+
+	return 0;
+}
+
+int expand_cond_av_list(policydb_t *p, cond_av_list_t *l,
+			cond_av_list_t **newl, avtab_t *expa)
+{
+	cond_av_list_t *cur;
+	avtab_ptr_t node;
+	int rc;
+
+	*newl = NULL;
+	for (cur = l; cur; cur = cur->next) {
+		node = cur->node;
+		rc = expand_cond_av_node(p, node, newl, expa);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
diff -X /home/sds/dontdiff -rup libsepol.a/src/policydb.c libsepol/src/policydb.c
--- libsepol.a/src/policydb.c	2005-07-28 14:48:44.000000000 -0400
+++ libsepol/src/policydb.c	2005-08-02 09:45:55.000000000 -0400
@@ -936,9 +936,12 @@ void policydb_destroy(policydb_t * p)
 	}
 	if (lrt) free(lrt);
 
-	for (i = 0; i < p->p_types.nprim; i++)
+	for (i = 0; i < p->p_types.nprim; i++) {
 		ebitmap_destroy(&p->type_attr_map[i]);
+		ebitmap_destroy(&p->attr_type_map[i]);
+	}
 	free(p->type_attr_map);
+	free(p->attr_type_map);
 
 	return;
 }
@@ -2585,13 +2588,24 @@ int policydb_read(policydb_t * p, struct
 	}
 
 	p->type_attr_map = malloc(p->p_types.nprim*sizeof(ebitmap_t));
-	if (!p->type_attr_map)
+	p->attr_type_map = malloc(p->p_types.nprim*sizeof(ebitmap_t));
+	if (!p->type_attr_map || !p->attr_type_map)
 		goto bad;
 	for (i = 0; i < p->p_types.nprim; i++) {
 		ebitmap_init(&p->type_attr_map[i]);
+		ebitmap_init(&p->attr_type_map[i]);
+	}
+	for (i = 0; i < p->p_types.nprim; i++) {
 		if (r_policyvers >= POLICYDB_VERSION_AVTAB) {
 			if (ebitmap_read(&p->type_attr_map[i], fp))
 				goto bad;
+			for (j = ebitmap_startbit(&p->type_attr_map[i]);
+			     j < ebitmap_length(&p->type_attr_map[i]); j++) {
+				if (!ebitmap_get_bit(&p->type_attr_map[i], j)) 
+					continue;
+				if (ebitmap_set_bit(&p->attr_type_map[j], i, 1))
+					goto bad;
+			}
 		}
 		/* add the type itself as the degenerate case */
 		if (ebitmap_set_bit(&p->type_attr_map[i], i, 1))
diff -X /home/sds/dontdiff -rup libsepol.a/src/write.c libsepol/src/write.c
--- libsepol.a/src/write.c	2005-07-29 10:36:33.000000000 -0400
+++ libsepol/src/write.c	2005-08-02 11:47:00.000000000 -0400
@@ -39,6 +39,7 @@
 #include <sepol/mls.h>
 #include <sepol/policydb.h>
 #include <sepol/conditional.h>
+#include <sepol/expand.h>
 
 #include "debug.h"
 #include "private.h"
@@ -148,9 +149,10 @@ static int avtab_write_item(avtab_ptr_t 
 	uint32_t buf32[10], lookup, val;
 	size_t items, items2;
 	unsigned set;
+	unsigned int oldvers = (policy_type == POLICY_KERN && policyvers < POLICYDB_VERSION_AVTAB);
 	int i;
 
-	if (policyvers < POLICYDB_VERSION_AVTAB) {
+	if (oldvers) {
 		/* Generate the old avtab format.
 		   Requires merging similar entries if uncond avtab. */
 		if (merge) {
@@ -273,25 +275,31 @@ static inline void avtab_reset_merged(av
 	}
 }
 
-static int avtab_write(avtab_t * a, struct policy_file * fp)
+static int avtab_write(struct policydb *p, 
+		       avtab_t * a, struct policy_file * fp)
 {
-	int i;
+	int i, rc;
+	avtab_t expa;
 	avtab_ptr_t cur;
 	uint32_t nel;
 	size_t items;
-	unsigned int oldvers = policyvers < POLICYDB_VERSION_AVTAB;
+	unsigned int oldvers = (policy_type == POLICY_KERN && policyvers < POLICYDB_VERSION_AVTAB);
 
 
 	if (oldvers) {
 		/* Old avtab format.
-		   Requires merging similar entries, so need to
-		   track merged ones and compute the final nel. */
+		   First, we need to expand attributes.  Then, we need to
+		   merge similar entries, so we need to track merged nodes 
+		   and compute the final nel. */
+		if (avtab_init(&expa))
+			return -1;
+		if (expand_avtab(p, a, &expa)) {
+			rc = -1;
+			goto out;
+		}
+		a = &expa;
 		avtab_reset_merged(a);
 		nel = a->nel;
-		/* XXX:  Need to expand the avtab to write out older policies. */ 
-		DEBUG(__FUNCTION__, "missing compatibility support for policy "
-			"version %d\n", policyvers);
-		return -1;
 	} else {
 		/* New avtab format.  nel is good to go. */
 		nel = cpu_to_le32(a->nel);
@@ -304,8 +312,10 @@ static int avtab_write(avtab_t * a, stru
 		for (cur = a->htable[i]; cur; cur = cur->next) {
 			/* If old format, compute final nel.
 			   If new format, write out the items. */
-			if (avtab_write_item(cur, fp, 1, !oldvers, &nel))
-			    return -1;
+			if (avtab_write_item(cur, fp, 1, !oldvers, &nel)) {
+				rc = -1;
+				goto out;
+			}
 		}	
 	}
 
@@ -314,18 +324,26 @@ static int avtab_write(avtab_t * a, stru
 		   Write the computed nel value, then write the items. */
 		nel = cpu_to_le32(nel);
 		items = put_entry(&nel, sizeof(uint32_t), 1, fp);
-		if (items != 1)
-			return -1;
+		if (items != 1) {
+			rc = -1;
+			goto out;
+		}
 		avtab_reset_merged(a);
 		for (i = 0; i < AVTAB_SIZE; i++) {
 			for (cur = a->htable[i]; cur; cur = cur->next) {
-				if (avtab_write_item(cur, fp, 1, 1, NULL))
-					return -1;
+				if (avtab_write_item(cur, fp, 1, 1, NULL)) {
+					rc = -1;
+					goto out;
+				}
 			}	
 		}
 	}
 
-	return 0;
+	rc = 0;
+out:
+	if (oldvers)
+		avtab_destroy(&expa);
+	return rc;
 }
 
 /*
@@ -549,11 +567,23 @@ static int cond_write_bool(hashtab_key_t
  * the conditional. This means that the avtab with the conditional
  * rules will not be saved but will be rebuilt on policy load.
  */
-static int cond_write_av_list(cond_av_list_t *list, struct policy_file *fp)
+static int cond_write_av_list(policydb_t *p,
+			      cond_av_list_t *list, struct policy_file *fp)
 {
 	uint32_t buf[4];
-	cond_av_list_t *cur_list;
+	cond_av_list_t *cur_list, *new_list = NULL;
+	avtab_t expa;
 	uint32_t len, items;
+	unsigned int oldvers = (policy_type == POLICY_KERN && policyvers < POLICYDB_VERSION_AVTAB);
+	int rc = -1;
+
+	if (oldvers) {
+		if (avtab_init(&expa))
+			return -1;
+		if (expand_cond_av_list(p, list, &new_list, &expa))
+			goto out;
+		list = new_list;
+	}
 
 	len = 0;
 	for (cur_list = list; cur_list != NULL; cur_list = cur_list->next) {
@@ -564,19 +594,30 @@ static int cond_write_av_list(cond_av_li
 	buf[0] = cpu_to_le32(len);
 	items = put_entry(buf, sizeof(uint32_t), 1, fp);
 	if (items != 1)
-		return -1;
-	if (items == 0)
-		return 0;
+		goto out;
+	if (items == 0) {
+		rc = 0;
+		goto out;
+	}
 
 	for (cur_list = list; cur_list != NULL; cur_list = cur_list->next) {
 		if (cur_list->node->parse_context)
 			if (avtab_write_item(cur_list->node, fp, 0, 1, NULL))
-				return -1;
+				goto out;
 	}
-	return 0;
+
+	rc = 0;
+out:
+	if (oldvers) {
+		cond_av_list_destroy(new_list);
+		avtab_destroy(&expa);
+	}
+
+	return rc;
 }
 
-static int cond_write_node(cond_node_t *node, struct policy_file *fp)
+static int cond_write_node(policydb_t *p, 
+			   cond_node_t *node, struct policy_file *fp)
 {
 	cond_expr_t *cur_expr;
 	uint32_t buf[2];
@@ -607,9 +648,9 @@ static int cond_write_node(cond_node_t *
 	}
 
         if (policy_type == POLICY_KERN) {
-		if (cond_write_av_list(node->true_list, fp) != 0)
+		if (cond_write_av_list(p, node->true_list, fp) != 0)
 			return -1;
-		if (cond_write_av_list(node->false_list, fp) != 0)
+		if (cond_write_av_list(p, node->false_list, fp) != 0)
 			return -1;
 	} else {
 		if (avrule_write_list(node->avtrue_list, fp))
@@ -621,9 +662,8 @@ static int cond_write_node(cond_node_t *
 	return 0;
 }
 
-static int cond_write_list(cond_list_t *list, struct policy_file *p)
+static int cond_write_list(policydb_t *p, cond_list_t *list, struct policy_file *fp)
 {
-	struct policy_file *fp = p;
 	cond_node_t *cur;
 	uint32_t len, items;
 	uint32_t buf[1];
@@ -637,7 +677,7 @@ static int cond_write_list(cond_list_t *
 		return -1;
 
 	for (cur = list; cur != NULL; cur = cur->next) {
-		if (cond_write_node(cur, p) != 0)
+		if (cond_write_node(p, cur, fp) != 0)
 			return -1;
 	}
 	return 0;
@@ -1275,7 +1315,7 @@ static int avrule_decl_write(avrule_decl
         if (put_entry(buf, sizeof(uint32_t), 2, fp) != 2) {
                 return -1;
         }
-        if (cond_write_list(decl->cond_list, fp) == -1 ||
+        if (cond_write_list(NULL, decl->cond_list, fp) == -1 ||
             avrule_write_list(decl->avrules, fp) == -1 ||
             role_trans_rule_write(decl->role_tr_rules, fp) == -1 ||
             role_allow_rule_write(decl->role_allow_rules, fp) == -1) {
@@ -1458,7 +1498,7 @@ int policydb_write(policydb_t * p, struc
 	}
 
 	if (p->policy_type == POLICY_KERN) {
-		if (avtab_write(&p->te_avtab, fp))
+		if (avtab_write(p, &p->te_avtab, fp))
 			return -1;
                 if (policyvers < POLICYDB_VERSION_BOOL) {
                         if (p->p_bools.nprim)
@@ -1466,7 +1506,7 @@ int policydb_write(policydb_t * p, struc
 					"booleans and conditional rules\n");
                 }
                 else {
-                        if (cond_write_list(p->cond_list, fp))
+                        if (cond_write_list(p, p->cond_list, fp))
                                 return -1;
                 }
                 if (role_trans_write(p->role_tr, fp))



  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
