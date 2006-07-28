Message-ID: <44CA298B.7080706@trustedcs.com>
Date: Fri, 28 Jul 2006 10:13:15 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: [PATCH 2/2] userland support for new range_transition statements
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch introduces support for kernel policy format version 21, base policy
format version 6, and policy module format 6.  These new formats allow for the
definition of range_transitions on security classes other than "process".  The
new module and base formats (both 6) also move expansion of the range_transition
statements from compile time to the actual expansion phase.  This change should
allow for using range_transitions in policy modules (with a bit more work in the
future) with another change in format.

The current range_transition statements are of the form:
    range_transition <source types> <target types> <new range>
These statements affect process transitions only.  The new supported format is:
    range_transition <source types> <target types>:<target classes> <new range>
With this format it is possible to to specify a new range for operations such
as file creation.  The old style statements are still allowed and they
implicitly refer to the "process" security class, thereby retaining the same
behavior as before.

The new kernel format now stores the security class on which the rule operates.
When dealing with older kernel policy formats, the "process" security class is
implicit.

The new module and base formats now store a representation of the rule just (the
new addition to the avrule_decl structure) and are expanded at the proper time.
The previous implementation expanded the rules at compilation time and could
produce an incomplete set of transitions if type attributes were used in the
statement.  

Here is how range_transition statements are handled for the various formats:
  for kernel policy version up to 18, there are no range_transition
  for kernel policy versions 19 and 20, a list of old-style (no class specified)
    range_trans structures are encoded
  for kernel policy versions 21 and up, a list of new-style (class specified)
    range_trans structures are encoded

  for base policy versions up to 5, there are no range_transitions
  for base policy version 5, a compile-time generated list of old-style (no
    class specified) range_trans structures are encoded as they are in kernel
    formats 19 and 20
  for base policy versions 6 and up, an expressive rule stating the intention
    of the statement is stored - that will be properly linked and expanded
    for further usage

  for module policy versions up to 6, there are no range_transitions
  for base policy versions 6 and up, an expressive rule stating the intention
    of the statement is stored jut like in base policy version 6 (of course we
    still need more work to get them in there, but the format is supportive).

 checkpolicy/module_compiler.c               |   12 ++
 checkpolicy/module_compiler.h               |    1
 checkpolicy/policy_parse.y                  |  155 ++++++++++++++--------------
 libsepol/include/sepol/policydb/mls_types.h |    6 +
 libsepol/include/sepol/policydb/policydb.h  |   24 +++-
 libsepol/src/avrule_block.c                 |    1
 libsepol/src/expand.c                       |  118 +++++++++++++++++++--
 libsepol/src/mls.c                          |   21 +--
 libsepol/src/policydb.c                     |  154 ++++++++++++++++++++++++++-
 libsepol/src/write.c                        |   74 ++++++++++++-
 10 files changed, 452 insertions(+), 114 deletions(-)

Index: libsepol/include/sepol/policydb/policydb.h
===================================================================
--- libsepol/include/sepol/policydb/policydb.h	(revision 38)
+++ libsepol/include/sepol/policydb/policydb.h	(working copy)
@@ -164,9 +164,10 @@
 } cat_datum_t;
 
 typedef struct range_trans {
-	uint32_t dom;		/* current process domain */
-	uint32_t type;		/* program executable type */
-	mls_range_t range;	/* new range */
+	uint32_t source_type;
+	uint32_t target_type;
+	uint32_t target_class;
+	mls_range_t target_range;
 	struct range_trans *next;
 } range_trans_t;
 
@@ -224,6 +225,14 @@
 	struct role_allow_rule *next;
 } role_allow_rule_t;
 
+typedef struct range_trans_rule {
+	type_set_t stypes;
+	type_set_t ttypes;
+	class_perm_node_t *classes;	/* only class is used */
+	mls_range_t trange;
+	struct range_trans_rule *next;
+} range_trans_rule_t;
+
 /*
  * The configuration data includes security contexts for 
  * initial SIDs, unlabeled file systems, TCP and UDP port numbers, 
@@ -321,6 +330,7 @@
 	avrule_t *avrules;
 	role_trans_rule_t *role_tr_rules;
 	role_allow_rule_t *role_allow_rules;
+	range_trans_rule_t *range_tr_rules;
 	scope_index_t required;	/* symbols needed to activate this block */
 	scope_index_t declared;	/* symbols declared within this block */
 
@@ -506,6 +516,8 @@
 extern void role_allow_rule_init(role_allow_rule_t * x);
 extern void role_allow_rule_destroy(role_allow_rule_t * x);
 extern void role_allow_rule_list_destroy(role_allow_rule_t * x);
+extern void range_trans_rule_init(range_trans_rule_t *x);
+extern void range_trans_rule_list_destroy(range_trans_rule_t *x);
 extern void type_datum_init(type_datum_t * x);
 extern void type_datum_destroy(type_datum_t * x);
 extern void user_datum_init(user_datum_t * x);
@@ -555,18 +567,20 @@
 #define POLICYDB_VERSION_VALIDATETRANS	19
 #define POLICYDB_VERSION_MLS		19
 #define POLICYDB_VERSION_AVTAB		20
+#define POLICYDB_VERSION_RANGETRANS	21
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_AVTAB
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_RANGETRANS
 
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE	   4
 #define MOD_POLICYDB_VERSION_VALIDATETRANS 5
 #define MOD_POLICYDB_VERSION_MLS	   5
+#define MOD_POLICYDB_VERSION_RANGETRANS	   6
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_MLS
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_RANGETRANS
 
 #define POLICYDB_CONFIG_MLS    1
 
Index: libsepol/include/sepol/policydb/mls_types.h
===================================================================
--- libsepol/include/sepol/policydb/mls_types.h	(revision 38)
+++ libsepol/include/sepol/policydb/mls_types.h	(working copy)
@@ -107,4 +107,10 @@
 	return -1;
 }
 
+static inline int mls_range_eq(struct mls_range *r1, struct mls_range *r2)
+{
+	return (mls_level_eq(&r1->level[0], &r2->level[0]) &&
+	        mls_level_eq(&r1->level[1], &r2->level[1]));
+}
+
 #endif
Index: libsepol/src/policydb.c
===================================================================
--- libsepol/src/policydb.c	(revision 38)
+++ libsepol/src/policydb.c	(working copy)
@@ -48,6 +48,7 @@
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/avrule_block.h>
 #include <sepol/policydb/util.h>
+#include <sepol/policydb/flask.h>
 
 #include "private.h"
 #include "debug.h"
@@ -92,6 +93,12 @@
 	 .ocon_num = OCON_NODE6 + 1,
 	 },
 	{
+	 .type = POLICY_KERN,
+	 .version = POLICYDB_VERSION_RANGETRANS,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	 },
+	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
@@ -104,6 +111,12 @@
 	 .ocon_num = OCON_NODE6 + 1,
 	 },
 	{
+	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_RANGETRANS,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	 },
+	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
@@ -114,7 +127,13 @@
 	 .version = MOD_POLICYDB_VERSION_MLS,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = 0,
-	 }
+	 },
+	{
+	 .type = POLICY_MOD,
+	 .version = MOD_POLICYDB_VERSION_RANGETRANS,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = 0
+	 },
 };
 
 #if 0
@@ -307,6 +326,42 @@
 	}
 }
 
+void range_trans_rule_init(range_trans_rule_t *x)
+{
+	memset(x, 0, sizeof(*x));
+	type_set_init(&x->stypes);
+	type_set_init(&x->ttypes);
+	mls_level_init(&x->trange.level[0]);
+	mls_level_init(&x->trange.level[1]);
+}
+
+static void range_trans_rule_destroy(range_trans_rule_t *x)
+{
+	class_perm_node_t *cur, *next;
+
+	type_set_destroy(&x->stypes);
+	type_set_destroy(&x->ttypes);
+	mls_level_destroy(&x->trange.level[0]);
+	mls_level_destroy(&x->trange.level[1]);
+
+	next = x->classes;
+	while (next) {
+		cur = next;
+		next = cur->next;
+		free(cur);
+	}
+}
+
+void range_trans_rule_list_destroy(range_trans_rule_t *x)
+{
+	while (x != NULL) {
+		range_trans_rule_t *next = x->next;
+		range_trans_rule_destroy(x);
+		free(x);
+		x = next;
+	}
+}
+
 void avrule_list_destroy(avrule_t * x)
 {
 	avrule_t *next, *cur;
@@ -954,15 +1009,15 @@
 
 	for (rt = p->range_tr; rt; rt = rt->next) {
 		if (lrt) {
-			ebitmap_destroy(&lrt->range.level[0].cat);
-			ebitmap_destroy(&lrt->range.level[1].cat);
+			ebitmap_destroy(&lrt->target_range.level[0].cat);
+			ebitmap_destroy(&lrt->target_range.level[1].cat);
 			free(lrt);
 		}
 		lrt = rt;
 	}
 	if (lrt) {
-		ebitmap_destroy(&lrt->range.level[0].cat);
-		ebitmap_destroy(&lrt->range.level[1].cat);
+		ebitmap_destroy(&lrt->target_range.level[0].cat);
+		ebitmap_destroy(&lrt->target_range.level[1].cat);
 		free(lrt);
 	}
 
@@ -2260,6 +2315,8 @@
 	uint32_t *buf, nel;
 	range_trans_t *rt, *lrt;
 	unsigned int i;
+	int new_rangetr = (p->policy_type == POLICY_KERN &&
+	                   p->policyvers >= POLICYDB_VERSION_RANGETRANS);
 
 	buf = next_entry(fp, sizeof(uint32_t));
 	if (!buf)
@@ -2277,9 +2334,16 @@
 		buf = next_entry(fp, (sizeof(uint32_t) * 2));
 		if (!buf)
 			return -1;
-		rt->dom = le32_to_cpu(buf[0]);
-		rt->type = le32_to_cpu(buf[1]);
-		if (mls_read_range_helper(&rt->range, fp))
+		rt->source_type = le32_to_cpu(buf[0]);
+		rt->target_type = le32_to_cpu(buf[1]);
+		if (new_rangetr) {
+			buf = next_entry(fp, (sizeof(uint32_t)));
+			if (!buf)
+				return -1;
+			rt->target_class = le32_to_cpu(buf[0]);
+		} else
+			rt->target_class = SECCLASS_PROCESS;
+		if (mls_read_range_helper(&rt->target_range, fp))
 			return -1;
 		lrt = rt;
 	}
@@ -2393,6 +2457,73 @@
 	return 0;
 }
 
+static int range_trans_rule_read(range_trans_rule_t **r, struct policy_file *fp)
+{
+	uint32_t *buf, nel, nclass;
+	unsigned int i, j;
+	range_trans_rule_t *rt, *lrt = NULL;
+	class_perm_node_t *cp, *lcp = NULL;
+
+	buf = next_entry(fp, sizeof(uint32_t));
+	if (!buf)
+		return -1;
+	nel = le32_to_cpu(buf[0]);
+	for (i = 0; i < nel; i++) {
+		rt = malloc(sizeof(range_trans_rule_t));
+		if (!rt) {
+			return -1;
+		}
+		range_trans_rule_init(rt);
+
+		if (type_set_read(&rt->stypes, fp))
+			return -1;
+
+		if (type_set_read(&rt->ttypes, fp))
+			return -1;
+
+		buf = next_entry(fp, sizeof(uint32_t));
+		if (!buf)
+			return -1;
+
+		nclass = le32_to_cpu(buf[0]);
+		rt->classes = NULL;
+		lcp = NULL;
+		for (j = 0; j < nclass; j++) {
+			cp = (class_perm_node_t *)malloc(
+			                             sizeof(class_perm_node_t));
+			if (!cp)
+				return -1;
+			class_perm_node_init(cp);
+
+			buf = next_entry(fp, sizeof(uint32_t));
+			if (!buf) {
+				free(cp);
+				return -1;
+			}
+
+			/* note that we care about the class, not the data */
+			cp->class = le32_to_cpu(buf[0]);
+
+			if (lcp)
+				lcp->next = cp;
+			else
+				rt->classes = cp;
+			lcp = cp;
+		}
+
+		if (mls_read_range_helper(&rt->trange, fp))
+			return -1;
+
+		if (lrt)
+			lrt->next = rt;
+		else
+			*r = rt;
+		lrt = rt;
+	}
+
+	return 0;
+}
+
 static int scope_index_read(scope_index_t * scope_index,
 			    unsigned int num_scope_syms, struct policy_file *fp)
 {
@@ -2440,6 +2571,10 @@
 	    role_allow_rule_read(&decl->role_allow_rules, fp) == -1) {
 		return -1;
 	}
+	if (p->policyvers >= MOD_POLICYDB_VERSION_RANGETRANS &&
+	    range_trans_rule_read(&decl->range_tr_rules, fp) == -1) {
+		return -1;
+	}
 	if (scope_index_read(&decl->required, num_scope_syms, fp) == -1 ||
 	    scope_index_read(&decl->declared, num_scope_syms, fp) == -1) {
 		return -1;
@@ -2835,7 +2970,8 @@
 	if ((p->policy_type == POLICY_KERN
 	     && p->policyvers >= POLICYDB_VERSION_MLS)
 	    || (p->policy_type == POLICY_BASE
-		&& p->policyvers >= MOD_POLICYDB_VERSION_MLS)) {
+		&& p->policyvers >= MOD_POLICYDB_VERSION_MLS
+	        && p->policyvers < MOD_POLICYDB_VERSION_RANGETRANS)) {
 		if (range_read(p, fp)) {
 			goto bad;
 		}
Index: libsepol/src/mls.c
===================================================================
--- libsepol/src/mls.c	(revision 38)
+++ libsepol/src/mls.c	(working copy)
@@ -607,23 +607,20 @@
 		    sepol_security_class_t tclass,
 		    uint32_t specified, context_struct_t * newcontext)
 {
+	range_trans_t *rtr;
 	if (!policydb->mls)
 		return 0;
 
 	switch (specified) {
 	case AVTAB_TRANSITION:
-		if (tclass == SECCLASS_PROCESS) {
-			range_trans_t *rangetr;
-
-			/* Look for a range transition rule. */
-			for (rangetr = policydb->range_tr; rangetr;
-			     rangetr = rangetr->next) {
-				if (rangetr->dom == scontext->type &&
-				    rangetr->type == tcontext->type) {
-					/* Set the range from the rule */
-					return mls_range_set(newcontext,
-							     &rangetr->range);
-				}
+		/* Look for a range transition rule. */
+		for (rtr = policydb->range_tr; rtr; rtr = rtr->next) {
+			if (rtr->source_type == scontext->type &&
+			    rtr->target_type == tcontext->type &&
+			    rtr->target_class == tclass) {
+				/* Set the range from the rule */
+				return mls_range_set(newcontext,
+						     &rtr->target_range);
 			}
 		}
 		/* Fallthrough */
Index: libsepol/src/avrule_block.c
===================================================================
--- libsepol/src/avrule_block.c	(revision 38)
+++ libsepol/src/avrule_block.c	(working copy)
@@ -99,6 +99,7 @@
 	avrule_list_destroy(x->avrules);
 	role_trans_rule_list_destroy(x->role_tr_rules);
 	role_allow_rule_list_destroy(x->role_allow_rules);
+	range_trans_rule_list_destroy(x->range_tr_rules);
 	scope_index_destroy(&x->required);
 	scope_index_destroy(&x->declared);
 	symtabs_destroy(x->symtab);
Index: libsepol/src/expand.c
===================================================================
--- libsepol/src/expand.c	(revision 38)
+++ libsepol/src/expand.c	(working copy)
@@ -958,6 +958,99 @@
 	return 0;
 }
 
+static int expand_range_trans(expand_state_t *state, range_trans_rule_t *rules)
+{
+	unsigned int i, j;
+	range_trans_t *rt, *lrt, *cur_rt;
+	range_trans_rule_t *rule;
+	class_perm_node_t *cp;
+
+	ebitmap_t stypes, ttypes;
+	ebitmap_node_t *snode, *tnode;
+
+	/* start appending at the end of the current list */
+	for (lrt = state->out->range_tr; lrt && lrt->next; lrt = lrt->next)
+		;
+
+	for (rule = rules; rule; rule = rule->next) {
+		ebitmap_init(&stypes);
+		ebitmap_init(&ttypes);
+
+		/* expand the type sets */
+		if (expand_convert_type_set(state->out, state->typemap,
+		                            &rule->stypes, &stypes, 1)) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+		if (expand_convert_type_set(state->out, state->typemap,
+		                            &rule->ttypes, &ttypes, 1)) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+
+		/* loop on source type */
+		ebitmap_for_each_bit(&stypes, snode, i) {
+			if (!ebitmap_node_get_bit(snode, i))
+				continue;
+			/* loop on target type */
+			ebitmap_for_each_bit(&ttypes, tnode, j) {
+				if (!ebitmap_node_get_bit(tnode, j))
+					continue;
+				/* loop on target class */
+				for (cp = rule->classes; cp; cp = cp->next) {
+
+					/* check for duplicates/conflicts */
+					for (cur_rt = state->out->range_tr; cur_rt; cur_rt = cur_rt->next) {
+						if ((cur_rt->source_type == i + 1) &&
+						    (cur_rt->target_type == j + 1) &&
+						    (cur_rt->target_class == cp->class)) {
+							if (mls_range_eq(&cur_rt->target_range, &rule->trange)) {
+								/* duplicate */
+								break;
+							} else {
+								/* conflict */
+								ERR(state->handle,
+								    "Conflicting range trans rule %s %s : %s",
+								    state->out->p_type_val_to_name[i],
+								    state->out->p_type_val_to_name[j],
+								    state->out->p_class_val_to_name[cp->class]);
+								return -1;
+							}
+						}
+					}
+					if (cur_rt) /* this is a dup - skip */
+						continue;
+
+					rt = (range_trans_t *)malloc(sizeof(range_trans_t));
+					if (!rt) {
+						ERR(state->handle, "Out of memory!");
+						return -1;
+					}
+					memset(rt, 0, sizeof(range_trans_t));
+					rt->source_type = i + 1;
+					rt->target_type = j + 1;
+					rt->target_class = cp->class;
+					if (mls_range_cpy(&rt->target_range, &rule->trange)) {
+						ERR(state->handle, "Out of memory!");
+						return -1;
+					}
+					if (lrt) {
+						lrt->next = rt;
+					} else {
+						state->out->range_tr = rt;
+					}
+					lrt = rt;
+				}
+			}
+		}
+
+		ebitmap_destroy(&stypes);
+		ebitmap_destroy(&ttypes);
+	}
+
+	return 0;
+}
+
 /* Search for an AV tab node within a hash table with the given key.
  * If the node does not exist, create it and return it; otherwise
  * return the pre-existing one.
@@ -1500,12 +1593,13 @@
 			goto out_of_mem;
 		}
 		memset(new_range, 0, sizeof(*new_range));
-		new_range->dom = state->typemap[range->dom - 1];
-		new_range->type = state->typemap[range->type - 1];
-		if (mls_level_clone
-		    (&new_range->range.level[0], &range->range.level[0]) == -1
-		    || mls_level_clone(&new_range->range.level[1],
-				       &range->range.level[1])) {
+		new_range->source_type = state->typemap[range->source_type - 1];
+		new_range->target_type = state->typemap[range->target_type - 1];
+		new_range->target_class = range->target_class;
+		if (mls_level_clone(&new_range->target_range.level[0],
+		                    &range->target_range.level[0]) ||
+		    mls_level_clone(&new_range->target_range.level[1],
+		                    &range->target_range.level[1])) {
 			goto out_of_mem;
 		}
 		new_range->next = NULL;
@@ -1522,8 +1616,8 @@
       out_of_mem:
 	ERR(state->handle, "Out of memory!");
 	if (new_range) {
-		ebitmap_destroy(&new_range->range.level[0].cat);
-		ebitmap_destroy(&new_range->range.level[1].cat);
+		ebitmap_destroy(&new_range->target_range.level[0].cat);
+		ebitmap_destroy(&new_range->target_range.level[1].cat);
 		free(new_range);
 	}
 	return -1;
@@ -2030,6 +2124,11 @@
 			goto cleanup;
 		}
 
+		/* expand the range transition rules */
+		if ((base->policyvers >= MOD_POLICYDB_VERSION_RANGETRANS) &&
+		    expand_range_trans(&state, decl->range_tr_rules))
+			goto cleanup;
+
 		/* copy rules */
 		cur_avrule = decl->avrules;
 		while (cur_avrule != NULL) {
@@ -2072,7 +2171,8 @@
 	if (genfs_copy(&state))
 		goto cleanup;
 
-	if (range_trans_clone(&state) == -1) {
+	if ((base->policyvers < MOD_POLICYDB_VERSION_RANGETRANS) &&
+	    range_trans_clone(&state) == -1) {
 		goto cleanup;
 	}
 
Index: libsepol/src/write.c
===================================================================
--- libsepol/src/write.c	(revision 38)
+++ libsepol/src/write.c	(working copy)
@@ -39,6 +39,7 @@
 #include <sepol/policydb/policydb.h>
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/expand.h>
+#include <sepol/policydb/flask.h>
 
 #include "debug.h"
 #include "private.h"
@@ -1124,21 +1125,36 @@
 {
 	size_t nel, items;
 	struct range_trans *rt;
-	uint32_t buf[32];
+	uint32_t buf[2];
+	int new_rangetr = (p->policy_type == POLICY_KERN &&
+	                   p->policyvers >= POLICYDB_VERSION_RANGETRANS);
 	nel = 0;
-	for (rt = p->range_tr; rt; rt = rt->next)
-		nel++;
+	for (rt = p->range_tr; rt; rt = rt->next) {
+		/* all range_transitions are written for the new format, only
+		   process related range_transitions are written for the old
+		   format, so count accordingly */
+		if (new_rangetr || rt->target_class == SECCLASS_PROCESS)
+			nel++;
+	}
 	buf[0] = cpu_to_le32(nel);
 	items = put_entry(buf, sizeof(uint32_t), 1, fp);
 	if (items != 1)
 		return -1;
 	for (rt = p->range_tr; rt; rt = rt->next) {
-		buf[0] = cpu_to_le32(rt->dom);
-		buf[1] = cpu_to_le32(rt->type);
+		if (!new_rangetr && rt->target_class != SECCLASS_PROCESS)
+			continue;
+		buf[0] = cpu_to_le32(rt->source_type);
+		buf[1] = cpu_to_le32(rt->target_type);
 		items = put_entry(buf, sizeof(uint32_t), 2, fp);
 		if (items != 2)
 			return -1;
-		if (mls_write_range_helper(&rt->range, fp))
+		if (new_rangetr) {
+			buf[0] = cpu_to_le32(rt->target_class);
+			items = put_entry(buf, sizeof(uint32_t), 1, fp);
+			if (items != 1)
+				return -1;
+		}
+		if (mls_write_range_helper(&rt->target_range, fp))
 			return -1;
 	}
 	return 0;
@@ -1264,6 +1280,45 @@
 	return 0;
 }
 
+static int range_trans_rule_write(range_trans_rule_t *t, struct policy_file *fp)
+{
+	int nel = 0, nclass;
+	size_t items;
+	uint32_t buf[1];
+	range_trans_rule_t *rt;
+	class_perm_node_t *cp;
+
+	for (rt = t; rt; rt = rt->next)
+		nel++;
+	buf[0] = cpu_to_le32(nel);
+	items = put_entry(buf, sizeof(uint32_t), 1, fp);
+	if (items != 1)
+		return -1;
+	for (rt = t; rt; rt = rt->next) {
+		if (type_set_write(&rt->stypes, fp))
+			return -1;
+		if (type_set_write(&rt->ttypes, fp))
+			return -1;
+		nclass = 0;
+		for (cp = rt->classes; cp; cp = cp->next)
+			nclass++;
+		buf[0] = cpu_to_le32(nclass);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return -1;
+		for (cp = rt->classes; cp; cp = cp->next) {
+			/* note that we care about the class, not the data */
+			buf[0] = cpu_to_le32(cp->class);
+			items = put_entry(buf, sizeof(uint32_t), 1, fp);
+			if (items != 1)
+				return -1;
+		}
+		if (mls_write_range_helper(&rt->trange, fp))
+			return -1;
+	}
+	return 0;
+}
+
 static int scope_index_write(scope_index_t * scope_index,
 			     unsigned int num_scope_syms,
 			     struct policy_file *fp)
@@ -1304,6 +1359,10 @@
 	    role_allow_rule_write(decl->role_allow_rules, fp) == -1) {
 		return -1;
 	}
+	if (p->policyvers >= MOD_POLICYDB_VERSION_RANGETRANS &&
+	    range_trans_rule_write(decl->range_tr_rules, fp) == -1) {
+		return -1;
+	}
 	if (scope_index_write(&decl->required, num_scope_syms, fp) == -1 ||
 	    scope_index_write(&decl->declared, num_scope_syms, fp) == -1) {
 		return -1;
@@ -1525,7 +1584,8 @@
 	if ((p->policyvers >= POLICYDB_VERSION_MLS
 	     && p->policy_type == POLICY_KERN)
 	    || (p->policyvers >= MOD_POLICYDB_VERSION_MLS
-		&& p->policy_type == POLICY_BASE)) {
+	        && p->policyvers < MOD_POLICYDB_VERSION_MLS
+		&& p->policy_type == POLICY_BASE) ) {
 		if (range_write(p, fp)) {
 			return -1;
 		}
Index: checkpolicy/module_compiler.c
===================================================================
--- checkpolicy/module_compiler.c	(revision 38)
+++ checkpolicy/module_compiler.c	(working copy)
@@ -1105,6 +1105,18 @@
 	decl->role_allow_rules = role_allow_rules;
 }
 
+/* this doesn't actually append, but really prepends it */
+void append_range_trans(range_trans_rule_t * range_tr_rules)
+{
+	avrule_decl_t *decl = stack_top->decl;
+
+	/* range transitions are not allowed within conditionals */
+	assert(stack_top->type == 1);
+
+	range_tr_rules->next = decl->range_tr_rules;
+	decl->range_tr_rules = range_tr_rules;
+}
+
 int begin_optional(int pass)
 {
 	avrule_block_t *block = NULL;
Index: checkpolicy/policy_parse.y
===================================================================
--- checkpolicy/policy_parse.y	(revision 38)
+++ checkpolicy/policy_parse.y	(working copy)
@@ -101,7 +101,7 @@
 static role_datum_t *merge_roles_dom(role_datum_t *r1,role_datum_t *r2);
 static role_datum_t *define_role_dom(role_datum_t *r);
 static int define_role_trans(void);
-static int define_range_trans(void);
+static int define_range_trans(int class_specified);
 static int define_role_allow(void);
 static int define_constraint(constraint_expr_t *expr);
 static int define_validatetrans(constraint_expr_t *expr);
@@ -436,7 +436,9 @@
                         {if (define_compute_type(AVRULE_CHANGE)) return -1;}
     			;
 range_trans_def		: RANGE_TRANSITION names names mls_range_def ';'
-			{ if (define_range_trans()) return -1; }
+			{ if (define_range_trans(0)) return -1; }
+			| RANGE_TRANSITION names names ':' names mls_range_def ';'
+			{ if (define_range_trans(1)) return -1; }
 			;
 te_avtab_def		: allow_def
 			| auditallow_def
@@ -4472,15 +4474,15 @@
 	return define_genfs_context_helper(queue_remove(id_queue), has_type);
 }
 
-static int define_range_trans(void)
+static int define_range_trans(int class_specified)
 {
 	char *id;
 	level_datum_t *levdatum = 0;
-	mls_range_t range;
-	type_set_t doms, types;
-	ebitmap_node_t *snode, *tnode;
-	range_trans_t *rt = 0;
-	unsigned int i, j;
+	class_datum_t *cladatum;
+	class_perm_node_t *classes = NULL, *cp;
+	mls_range_t trange;
+	type_set_t stypes, ttypes;
+	range_trans_rule_t *rule;
 	int l, add = 1;
 
 	if (!mlspol) {
@@ -4493,6 +4495,9 @@
 			free(id);
 		while ((id = queue_remove(id_queue)))
 			free(id);
+		if (class_specified)
+			while ((id = queue_remove(id_queue)))
+				free(id);
 		id = queue_remove(id_queue);
 		free(id);
 		for (l = 0; l < 2; l++) {
@@ -4507,19 +4512,65 @@
 		return 0;
 	}
 
-	type_set_init(&doms);
-	type_set_init(&types);
+	type_set_init(&stypes);
+	type_set_init(&ttypes);
 
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&doms, id, &add, 0))
+		if (set_types(&stypes, id, &add, 0))
 			return -1;
 	}
 	add = 1;
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&types, id, &add, 0))
+		if (set_types(&ttypes, id, &add, 0))
 			return -1;
 	}
 
+	if (class_specified) {
+		while ((id = queue_remove(id_queue))) {
+			if (!is_id_in_scope(SYM_CLASSES, id)) {
+				yyerror2("class %s is not within scope", id);
+				free(id);
+				return -1;
+			}
+			cladatum = hashtab_search(policydbp->p_classes.table,
+			                          id);
+			if (!cladatum) {
+				sprintf(errormsg, "unknown class %s", id);
+				yyerror(errormsg);
+				return -1;
+			}
+
+			cp = malloc(sizeof(class_perm_node_t));
+			if (!cp) {
+				yyerror("out of memory");
+				return -1;
+			}
+			class_perm_node_init(cp);
+			cp->class = cladatum->value;
+			cp->next = classes;
+			classes = cp;
+		}
+	} else {
+		cladatum = hashtab_search(policydbp->p_classes.table,
+		                          "process");
+		if (!cladatum) {
+			sprintf(errormsg, "could not find process class for "
+			        "legacy range_transition statement\n");
+			yyerror(errormsg);
+			return -1;
+		}
+
+		cp = malloc(sizeof(class_perm_node_t));
+		if (!cp) {
+			yyerror("out of memory");
+			return -1;
+		}
+		class_perm_node_init(cp);
+		cp->class = cladatum->value;
+		cp->next = classes;
+		classes = cp;
+	}
+
 	id = (char *)queue_remove(id_queue);
 	if (!id) {
 		yyerror("no range in range_transition definition?");
@@ -4529,19 +4580,20 @@
 		levdatum = hashtab_search(policydbp->p_levels.table, id);
 		if (!levdatum) {
 			sprintf(errormsg,
-				"unknown level %s used in range_transition definition",
-				id);
+				"unknown level %s used in range_transition "
+			        "definition", id);
 			yyerror(errormsg);
 			free(id);
 			return -1;
 		}
 		free(id);
-		range.level[l].sens = levdatum->level->sens;
+		trange.level[l].sens = levdatum->level->sens;
 
-		ebitmap_init(&range.level[l].cat);
+		ebitmap_init(&trange.level[l].cat);
 
 		while ((id = queue_remove(id_queue))) {
-			if (parse_categories(id, levdatum, &range.level[l].cat)) {
+			if (parse_categories(id, levdatum,
+			                     &trange.level[l].cat)) {
 				free(id);
 				return -1;
 			}
@@ -4553,72 +4605,31 @@
 			break;
 	}
 	if (l == 0) {
-		range.level[1].sens = range.level[0].sens;
-		if (ebitmap_cpy(&range.level[1].cat, &range.level[0].cat)) {
+		if (mls_level_cpy(&trange.level[1], &trange.level[0])) {
 			yyerror("out of memory");
 			return -1;
 		}
 	}
-
-	if (!mls_level_dom(&range.level[1], &range.level[0])) {
+	if (!mls_level_dom(&trange.level[1], &trange.level[0])) {
 		yyerror
 		    ("range_transition high level does not dominate low level");
 		return -1;
 	}
 
-	/* FIXME: this expands type_sets at compile time which is inappropriate, the type_sets
-	 * should be stored which is a format change */
-	ebitmap_for_each_bit(&doms.types, snode, i) {
-		if (!ebitmap_node_get_bit(snode, i))
-			continue;
-		ebitmap_for_each_bit(&types.types, tnode, j) {
-			if (!ebitmap_node_get_bit(tnode, j))
-				continue;
+	rule = malloc(sizeof(struct range_trans_rule));
+	if (!rule) {
+		yyerror("out of memory");
+		return -1;
+	}
+	memset(rule, 0, sizeof(struct range_trans_rule));
+	rule->stypes = stypes;
+	rule->ttypes = ttypes;
+	rule->classes = classes;
+	if (mls_range_cpy(&rule->trange, &trange))
+		return -1;
 
-			for (rt = policydbp->range_tr; rt; rt = rt->next) {
-				if (rt->dom == (i + 1) && rt->type == (j + 1)) {
-					sprintf(errormsg,
-						"duplicate range_transition defined for (%s,%s)",
-						policydbp->
-						p_type_val_to_name[i],
-						policydbp->
-						p_type_val_to_name[j]);
-					yyerror(errormsg);
-					return -1;
-				}
-			}
+	append_range_trans(rule);
 
-			rt = malloc(sizeof(range_trans_t));
-			if (!rt) {
-				yyerror("out of memory");
-				return -1;
-			}
-			memset(rt, 0, sizeof(range_trans_t));
-			rt->dom = i + 1;
-			rt->type = j + 1;
-			rt->range.level[0].sens = range.level[0].sens;
-			if (ebitmap_cpy(&rt->range.level[0].cat,
-					&range.level[0].cat)) {
-				yyerror("out of memory");
-				free(rt);
-				return -1;
-			}
-			rt->range.level[1].sens = range.level[1].sens;
-			if (ebitmap_cpy(&rt->range.level[1].cat,
-					&range.level[1].cat)) {
-				yyerror("out of memory");
-				free(rt);
-				return -1;
-			}
-			rt->next = policydbp->range_tr;
-			policydbp->range_tr = rt;
-		}
-	}
-
-	type_set_destroy(&doms);
-	type_set_destroy(&types);
-	ebitmap_destroy(&range.level[0].cat);
-	ebitmap_destroy(&range.level[1].cat);
 	return 0;
 }
 
Index: checkpolicy/module_compiler.h
===================================================================
--- checkpolicy/module_compiler.h	(revision 38)
+++ checkpolicy/module_compiler.h	(working copy)
@@ -77,6 +77,7 @@
 void append_avrule(avrule_t * avrule);
 void append_role_trans(role_trans_rule_t * role_tr_rules);
 void append_role_allow(role_allow_rule_t * role_allow_rules);
+void append_range_trans(range_trans_rule_t * range_tr_rules);
 
 /* Create a new optional block and add it to the global policy.
  * During the second pass resolve the block's requirements.  Return 0

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
