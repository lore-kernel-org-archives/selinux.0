Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2SGIlun018236
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 12:18:47 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2SGIiCe024388
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 16:18:45 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2SGIi36026963
	for <selinux@tycho.nsa.gov>; Wed, 28 Mar 2007 12:18:44 -0400
Subject: [PATCH] map booleans during expansion
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: SELinux List <selinux@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>
Content-Type: text/plain
Date: Wed, 28 Mar 2007 12:16:37 -0400
Message-Id: <1175098597.2062.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently, the expander does not map booleans during expansion. However,
it is possible that booleans can be declared in an optional block
resulting in the need to map the booleans. This patch adds boolean
mappings to the expander. The same thing likely needs to be done for
roles and users - Josh, can you confirm?

Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>

diff -r 28578c216ea7 libsepol/include/sepol/policydb/conditional.h
--- a/libsepol/include/sepol/policydb/conditional.h	Wed Mar 21 16:37:37 2007 -0400
+++ b/libsepol/include/sepol/policydb/conditional.h	Wed Mar 28 12:11:15 2007 -0400
@@ -100,6 +100,8 @@ extern cond_node_t *cond_node_find(polic
 				   cond_node_t * needle, cond_node_t * haystack,
 				   int *was_created);
 
+extern cond_node_t *cond_node_create(policydb_t * p, cond_node_t * node);
+
 extern cond_node_t *cond_node_search(policydb_t * p, cond_node_t * list,
 				     cond_node_t * cn);
 
diff -r 28578c216ea7 libsepol/src/conditional.c
--- a/libsepol/src/conditional.c	Wed Mar 21 16:37:37 2007 -0400
+++ b/libsepol/src/conditional.c	Wed Mar 28 12:11:15 2007 -0400
@@ -26,9 +26,6 @@
 
 #include "private.h"
 
-#undef min
-#define min(a,b) (((a) < (b)) ? (a) : (b))
-
 /* move all type rules to top of t/f lists to help kernel on evaluation */
 static void cond_optimize(cond_av_list_t ** l)
 {
@@ -136,6 +133,38 @@ int cond_expr_equal(cond_node_t * a, con
 	return 1;
 }
 
+/* Create a new conditional node, optionally copying
+ * the conditional expression from an existing node.
+ * If node is NULL then a new node will be created
+ * with no conditional expression.
+ */
+cond_node_t *cond_node_create(policydb_t * p, cond_node_t * node)
+{
+	cond_node_t *new_node;
+	unsigned int i;
+
+	new_node = (cond_node_t *)malloc(sizeof(cond_node_t));
+	if (!new_node) {
+		return NULL;
+	}
+	memset(new_node, 0, sizeof(cond_node_t));
+
+	if (node) {
+		new_node->expr = cond_copy_expr(node->expr);
+		if (!new_node->expr) {
+			free(new_node);
+			return NULL;
+		}
+		new_node->cur_state = cond_evaluate_expr(p, new_node->expr);
+		new_node->nbools = node->nbools;
+		for (i = 0; i < min(node->nbools, COND_MAX_BOOLS); i++)
+			new_node->bool_ids[i] = node->bool_ids[i];
+		new_node->expr_pre_comp = node->expr_pre_comp;
+	}
+
+	return new_node;
+}
+
 /* Find a conditional (the needle) within a list of existing ones (the
  * haystack) that has a matching expression.  If found, return a
  * pointer to the existing node, setting 'was_created' to 0.
@@ -145,9 +174,6 @@ cond_node_t *cond_node_find(policydb_t *
 			    cond_node_t * needle, cond_node_t * haystack,
 			    int *was_created)
 {
-	cond_node_t *new_node;
-	unsigned int i;
-
 	while (haystack) {
 		if (cond_expr_equal(needle, haystack)) {
 			*was_created = 0;
@@ -156,26 +182,8 @@ cond_node_t *cond_node_find(policydb_t *
 		haystack = haystack->next;
 	}
 	*was_created = 1;
-	new_node = (cond_node_t *) malloc(sizeof(cond_node_t));
-	if (!new_node) {
-		return NULL;
-	}
-	memset(new_node, 0, sizeof(cond_node_t));
-	new_node->expr = cond_copy_expr(needle->expr);
-	if (!new_node->expr) {
-		free(new_node);
-		return NULL;
-	}
-	new_node->cur_state = cond_evaluate_expr(p, new_node->expr);
-	new_node->nbools = needle->nbools;
-	for (i = 0; i < min(needle->nbools, COND_MAX_BOOLS); i++)
-		new_node->bool_ids[i] = needle->bool_ids[i];
-	new_node->expr_pre_comp = needle->expr_pre_comp;
-	new_node->true_list = NULL;
-	new_node->false_list = NULL;
-	new_node->avtrue_list = NULL;
-	new_node->avfalse_list = NULL;
-	return new_node;
+
+	return cond_node_create(p, needle);
 }
 
 /* return either a pre-existing matching node or create a new node */
diff -r 28578c216ea7 libsepol/src/expand.c
--- a/libsepol/src/expand.c	Wed Mar 21 16:37:37 2007 -0400
+++ b/libsepol/src/expand.c	Wed Mar 28 12:11:15 2007 -0400
@@ -35,10 +35,12 @@
 #include <assert.h>
 
 #include "debug.h"
+#include "private.h"
 
 typedef struct expand_state {
 	int verbose;
 	uint32_t *typemap;
+	uint32_t *boolmap;
 	policydb_t *base;
 	policydb_t *out;
 	sepol_handle_t *handle;
@@ -791,8 +793,8 @@ static int bool_copy_callback(hashtab_ke
 		return -1;
 	}
 
-	new_bool->s.value = bool->s.value;
 	state->out->p_bools.nprim++;
+	new_bool->s.value = state->out->p_bools.nprim;
 
 	ret = hashtab_insert(state->out->p_bools.table,
 			     (hashtab_key_t) new_id,
@@ -803,6 +805,8 @@ static int bool_copy_callback(hashtab_ke
 		free(new_id);
 		return -1;
 	}
+
+	state->boolmap[bool->s.value - 1] = new_bool->s.value;
 
 	new_bool->state = bool->state;
 
@@ -1555,12 +1559,35 @@ static int cond_avrule_list_copy(policyd
 	return 0;
 }
 
+static int cond_node_map_bools(expand_state_t * state, cond_node_t * cn)
+{
+	cond_expr_t *cur;
+	unsigned int i;
+
+	cur = cn->expr;
+	while (cur) {
+		if (cur->bool)
+			cur->bool = state->boolmap[cur->bool - 1];
+		cur = cur->next;
+	}
+
+	for (i = 0; i < min(cn->nbools, COND_MAX_BOOLS); i++)
+		cn->bool_ids[i] = state->boolmap[cn->bool_ids[i] - 1];
+
+	if (cond_normalize_expr(state->out, cn)) {
+		ERR(state->handle, "Error while normalizing conditional");
+		return -1;
+	}
+
+	return 0;
+}
+
 /* copy the nodes in *reverse* order -- the result is that the last
  * given conditional appears first in the policy, so as to match the
  * behavior of the upstream compiler */
 static int cond_node_copy(expand_state_t * state, cond_node_t * cn)
 {
-	cond_node_t *new_cond;
+	cond_node_t *new_cond, *tmp;
 
 	if (cn == NULL) {
 		return 0;
@@ -1573,11 +1600,26 @@ static int cond_node_copy(expand_state_t
 		return -1;
 	}
 
-	new_cond = cond_node_search(state->out, state->out->cond_list, cn);
+	/* create a new temporary conditional node with the booleans
+	 * mapped */
+	tmp = cond_node_create(state->base, cn);
+	if (!tmp) {
+		ERR(state->handle, "Out of memory");
+		return -1;
+	}
+
+	if (cond_node_map_bools(state, tmp)) {
+		ERR(state->handle, "Error mapping booleans");
+		return -1;
+	}
+
+	new_cond = cond_node_search(state->out, state->out->cond_list, tmp);
 	if (!new_cond) {
+		cond_node_destroy(tmp);
 		ERR(state->handle, "Out of memory!");
 		return -1;
 	}
+	cond_node_destroy(tmp);
 
 	if (cond_avrule_list_copy
 	    (state->out, cn->avtrue_list, &state->out->te_cond_avtab,
@@ -2210,6 +2252,12 @@ int expand_module(sepol_handle_t * handl
 		goto cleanup;
 	}
 
+	state.boolmap = (uint32_t *)calloc(state.base->p_bools.nprim, sizeof(uint32_t));
+	if (!state.boolmap) {
+		ERR(handle, "Out of memory!");
+		goto cleanup;
+	}
+
 	/* order is important - types must be first */
 
 	/* copy types */
@@ -2364,6 +2412,7 @@ int expand_module(sepol_handle_t * handl
 
       cleanup:
 	free(state.typemap);
+	free(state.boolmap);
 	return retval;
 }
 
diff -r 28578c216ea7 libsepol/src/private.h
--- a/libsepol/src/private.h	Wed Mar 21 16:37:37 2007 -0400
+++ b/libsepol/src/private.h	Wed Mar 28 12:11:15 2007 -0400
@@ -23,6 +23,9 @@
 #define cpu_to_le64(x) bswap_64(x)
 #define le64_to_cpu(x) bswap_64(x)
 #endif
+
+#undef min
+#define min(a,b) (((a) < (b)) ? (a) : (b))
 
 /* Policy compatibility information. */
 struct policydb_compat_info {



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
