Subject: [PATCH RETRY 3/3] Refactor expansion of avtab
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Content-Type: text/plain
Date: Wed, 26 Jul 2006 14:11:46 -0400
Message-Id: <1153937506.5393.7.camel@twoface>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The patch adds a new function called expand_module_avrules that creates
an expand_state object and expands the avrules (including the
neverallows).  This function permits external users of libsepol to
expand the avrules into the same policy.  We refactored and created a
static function called expand_avrule_decls since its functionality is
needed in the original expand_module and the new expand_module_avrules
functions. This has earlier suggestions incorporated.


diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' -x '*.svn*' -x '*.swp' trunk/libsepol/include/sepol/policydb/expand.h branch/setools_public-policydb-components/libsepol/include/sepol/policydb/expand.h
--- trunk/libsepol/include/sepol/policydb/expand.h	2006-07-13 10:19:14.000000000 -0400
+++ trunk/libsepol/include/sepol/policydb/expand.h	2006-07-26 11:51:39.000000000 -0400
@@ -29,6 +29,22 @@
 #include <sepol/handle.h>
 #include <sepol/policydb/conditional.h>
 
+/*
+ * Expand only the avrules for a module (optionally including
+ * neverallow rules). It is valid for this function to expand
+ * base into itself (i.e. base == out); the typemap for this
+ * special case should map type[i] to i+1. No assertion or 
+ * hierarchy checking is performed.
+ */
+extern int expand_module_avrules(sepol_handle_t * handle, policydb_t * base,
+				 policydb_t * out, uint32_t * typemap,
+				 int verbose, int expand_neverallow);
+/*
+ * Expand all parts of a module. Neverallow rules are not
+ * expanded (only copied). It is not valid to expand base
+ * into itself. If check is non-zero, performs hierarchy
+ * and assertion checking.
+ */
 extern int expand_module(sepol_handle_t * handle,
 			 policydb_t * base, policydb_t * out,
 			 int verbose, int check);
diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' -x '*.svn*' -x '*.swp' trunk/libsepol/trunk/libsepol/src/expand.c branch/setools_public-policydb-components/libsepol/trunk/libsepol/src/expand.c
--- trunk/libsepol/src/expand.c	2006-07-26 13:21:18.000000000 -0400
+++ trunk/libsepol/src/expand.c	2006-07-26 11:50:50.000000000 -0400
@@ -44,6 +44,11 @@ typedef struct expand_state {
 	int expand_neverallow;
 } expand_state_t;
 
+static void expand_state_init(expand_state_t * state)
+{
+	memset(state, 0, sizeof(expand_state_t));
+}
+
 static int type_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			      void *data)
 {
@@ -1008,6 +1013,10 @@ static avtab_ptr_t find_avtab_node(sepol
 	return node;
 }
 
+#define EXPAND_RULE_SUCCESS   0
+#define EXPAND_RULE_CONFLICT  1
+#define EXPAND_RULE_ERROR    -1
+
 static int expand_terule_helper(sepol_handle_t * handle,
 				policydb_t * p, uint32_t * typemap,
 				uint32_t specified, cond_av_list_t ** cond,
@@ -1070,7 +1079,7 @@ static int expand_terule_helper(sepol_ha
 				 * or in same conditional then ignore it */
 				if ((conflict == 1 && cond == NULL)
 				    || node->parse_context == cond)
-					return 1;
+					return EXPAND_RULE_SUCCESS;
 				ERR(handle, "duplicate TE rule for %s %s:%s %s",
 				    p->p_type_val_to_name[avkey.source_type -
 							  1],
@@ -1079,7 +1088,7 @@ static int expand_terule_helper(sepol_ha
 				    p->p_class_val_to_name[avkey.target_class -
 							   1],
 				    p->p_type_val_to_name[oldtype - 1]);
-				return 0;
+				return EXPAND_RULE_CONFLICT;
 			}
 			ERR(handle,
 			    "conflicting TE rule for (%s, %s:%s):  old was %s, new is %s",
@@ -1088,7 +1097,7 @@ static int expand_terule_helper(sepol_ha
 			    p->p_class_val_to_name[avkey.target_class - 1],
 			    p->p_type_val_to_name[oldtype - 1],
 			    p->p_type_val_to_name[remapped_data - 1]);
-			return 0;
+			return EXPAND_RULE_CONFLICT;
 		}
 
 		node = find_avtab_node(handle, avtab, &avkey, cond);
@@ -1114,7 +1123,7 @@ static int expand_terule_helper(sepol_ha
 		cur = cur->next;
 	}
 
-	return 1;
+	return EXPAND_RULE_SUCCESS;
 }
 
 static int expand_avrule_helper(sepol_handle_t * handle,
@@ -1153,7 +1162,7 @@ static int expand_avrule_helper(sepol_ha
 
 		node = find_avtab_node(handle, avtab, &avkey, cond);
 		if (!node)
-			return -1;
+			return EXPAND_RULE_ERROR;
 		if (enabled) {
 			node->key.specified |= AVTAB_ENABLED;
 		} else {
@@ -1187,7 +1196,7 @@ static int expand_avrule_helper(sepol_ha
 
 		cur = cur->next;
 	}
-	return 1;
+	return EXPAND_RULE_SUCCESS;
 }
 
 static int expand_rule_helper(sepol_handle_t * handle,
@@ -1260,13 +1269,15 @@ static int expand_rule_helper(sepol_hand
 		}
 	}
 
-	return 1;
+	return EXPAND_RULE_SUCCESS;
 }
 
-/* Expand a rule into a given avtab - checking for conflicting type
- * rules in the destination policy.  Return 1 on success, 0 if the
- * rule conflicts with something (and hence was not added), or -1 on
- * error. */
+/*
+ * Expand a rule into a given avtab - checking for conflicting type
+ * rules in the destination policy.  Return EXPAND_RULE_SUCCESS on 
+ * success, EXPAND_RULE_CONFLICT if the rule conflicts with something
+ * (and hence was not added), or EXPAND_RULE_ERROR on error.
+ */
 static int convert_and_expand_rule(sepol_handle_t * handle,
 				   policydb_t * dest_pol, uint32_t * typemap,
 				   avrule_t * source_rule, avtab_t * dest_avtab,
@@ -1279,7 +1290,7 @@ static int convert_and_expand_rule(sepol
 	unsigned char alwaysexpand;
 
 	if (!do_neverallow && source_rule->specified & AVRULE_NEVERALLOW)
-		return 1;
+		return EXPAND_RULE_SUCCESS;
 
 	ebitmap_init(&stypes);
 	ebitmap_init(&ttypes);
@@ -1290,10 +1301,10 @@ static int convert_and_expand_rule(sepol
 
 	if (expand_convert_type_set
 	    (dest_pol, typemap, &source_rule->stypes, &stypes, alwaysexpand))
-		return -1;
+		return EXPAND_RULE_ERROR;
 	if (expand_convert_type_set
 	    (dest_pol, typemap, &source_rule->ttypes, &ttypes, alwaysexpand))
-		return -1;
+		return EXPAND_RULE_ERROR;
 
 	retval = expand_rule_helper(handle, dest_pol, typemap,
 				    source_rule, dest_avtab,
@@ -1314,7 +1325,8 @@ static int cond_avrule_list_copy(policyd
 	while (cur) {
 		if (convert_and_expand_rule(state->handle, dest_pol,
 					    typemap, cur, dest_avtab,
-					    list, other, enabled) != 1) {
+					    list, other, enabled,
+					    0) != EXPAND_RULE_SUCCESS) {
 			return -1;
 		}
 
@@ -1892,6 +1904,79 @@ static int copy_neverallow(policydb_t * 
 	return -1;
 }
 
+static int expand_avrule_decls(expand_state_t * state)
+{
+	avrule_block_t *curblock;
+	int retval = -1;
+
+	for (curblock = state->base->global; curblock != NULL;
+	     curblock = curblock->next) {
+		avrule_decl_t *decl = curblock->enabled;
+		avrule_t *cur_avrule;
+
+		if (decl == NULL) {
+			/* nothing was enabled within this block */
+			continue;
+		}
+
+		/* copy role allows and role trans */
+		if (copy_role_allows(state, decl->role_allow_rules) != 0 ||
+		    copy_role_trans(state, decl->role_tr_rules) != 0) {
+			goto cleanup;
+		}
+
+		/* copy rules */
+		cur_avrule = decl->avrules;
+		while (cur_avrule != NULL) {
+			if (!(state->expand_neverallow)
+			    && cur_avrule->specified & AVRULE_NEVERALLOW) {
+				/* copy this over directly so that assertions are checked later */
+				if (copy_neverallow
+				    (state->out, state->typemap, cur_avrule))
+					ERR(state->handle,
+					    "Error while copying neverallow.");
+			} else {
+				if (convert_and_expand_rule
+				    (state->handle, state->out, state->typemap,
+				     cur_avrule, &state->out->te_avtab, NULL,
+				     NULL, 0,
+				     state->expand_neverallow) !=
+				    EXPAND_RULE_SUCCESS) {
+					goto cleanup;
+				}
+			}
+			cur_avrule = cur_avrule->next;
+		}
+
+		/* copy conditional rules */
+		if (cond_node_copy(state, decl->cond_list))
+			goto cleanup;
+	}
+
+	retval = 0;
+
+      cleanup:
+	return retval;
+}
+
+int expand_module_avrules(sepol_handle_t * handle, policydb_t * base,
+			  policydb_t * out, uint32_t * typemap, int verbose,
+			  int expand_neverallow)
+{
+	expand_state_t state;
+
+	expand_state_init(&state);
+
+	state.base = base;
+	state.out = out;
+	state.typemap = typemap;
+	state.handle = handle;
+	state.verbose = verbose;
+	state.expand_neverallow = expand_neverallow;
+
+	return expand_avrule_decls(&state);
+}
+
 /* Linking should always be done before calling expand, even if
  * there is only a base since all optionals are dealt with at link time
  * the base passed in should be indexed and avrule blocks should be 
@@ -1905,6 +1990,8 @@ int expand_module(sepol_handle_t * handl
 	expand_state_t state;
 	avrule_block_t *curblock;
 
+	expand_state_init(&state);
+
 	state.verbose = verbose;
 	state.typemap = NULL;
 	state.base = base;
@@ -2021,47 +2108,9 @@ int expand_module(sepol_handle_t * handl
 
 	}
 
-	/* then loop through delcs to copy and expand rules */
-	for (curblock = state.base->global; curblock != NULL;
-	     curblock = curblock->next) {
-		avrule_decl_t *decl = curblock->enabled;
-		avrule_t *cur_avrule;
-
-		if (decl == NULL) {
-			/* nothing was enabled within this block */
-			continue;
-		}
-
-		/* copy role allows and role trans */
-		if (copy_role_allows(&state, decl->role_allow_rules) != 0 ||
-		    copy_role_trans(&state, decl->role_tr_rules) != 0) {
-			goto cleanup;
-		}
-
-		/* copy rules */
-		cur_avrule = decl->avrules;
-		while (cur_avrule != NULL) {
-			if (!(state->expand_neverallow)
-			    && cur_avrule->specified & AVRULE_NEVERALLOW) {
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
-				}
-			}
-			cur_avrule = cur_avrule->next;
-		}
-
-		/* copy conditional rules */
-		if (cond_node_copy(&state, decl->cond_list))
-			goto cleanup;
+	if (expand_avrule_decls(&state) < 0) {
+		ERR(handle, "Error during expand");
+		goto cleanup;
 	}
 
 	/* copy constraints */




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
